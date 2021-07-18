Param(
  [parameter(mandatory=$true)][string]$Distro,
  [parameter(mandatory=$true)][string]$InstallLocation
)

$ErrorActionPreference = "Stop"

$uri = "http://cdimage.ubuntu.com/ubuntu-base/releases/18.04.5/release/ubuntu-base-18.04.5-base-amd64.tar.gz"
$sha256sum = "8FF20B47BB123E4271DA81B77EE56E6B5AEB85EAF7D9B1B5F6F3FBC7F11D07EA"
$tarball = Join-Path $PSScriptRoot ([System.IO.Path]::GetFileName($uri))

If (![System.IO.File]::Exists($tarball)) {
  Invoke-WebRequest -Uri $uri -OutFile $tarball
}

$hash = (Get-FileHash $tarball -Algorithm SHA256).Hash
If ($hash -ne $sha256sum) {
  Write-Error "checksum failed"
}

wsl.exe --import $Distro $InstallLocation $tarball

$scriptsdir = Join-Path $PSScriptRoot "scripts"
Get-ChildItem $scriptsdir -Filter *.sh | Foreach-Object {
  Get-Content $_.FullName -Raw | wsl.exe -d $Distro /bin/sh -l
}

wsl.exe -t $Distro

Remove-Item $tarball
