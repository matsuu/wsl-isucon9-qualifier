Param(
  [parameter(mandatory=$true)][string]$Distro,
  [parameter(mandatory=$true)][string]$InstallLocation
)

$ErrorActionPreference = "Stop"

$uri = "http://cdimage.ubuntu.com/ubuntu-base/releases/18.04.4/release/ubuntu-base-18.04.4-base-amd64.tar.gz"
$sha256sum = "152C256B093D8C420BE443BA01E1BAB18A9F56A49A26ABCAC492D08F3B8C92E6"
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
