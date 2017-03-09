import-module au

$releases = 'https://github.com/eslint/eslint/releases'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    #v3.9.1.zip
    $re  = "(.*).zip"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $file = $url -split 'v' | select -last 1

    $version = [IO.Path]::GetFileNameWithoutExtension($file)

    $Latest = @{ Version = $version }
    return $Latest
}

update -ChecksumFor none
