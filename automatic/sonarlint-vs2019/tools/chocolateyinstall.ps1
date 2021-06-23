$ErrorActionPreference = 'Stop';

$toolsPath   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\SonarLint.VSIX-4.17.0.14702-2019.vsix"

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  VsixUrl     = 'file://' + $filePath.Replace('\', '/')
}

Install-VisualStudioVsixExtension @packageArgs