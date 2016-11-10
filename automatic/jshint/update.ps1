import-module au

$releases = 'https://github.com/jshint/jshint/releases'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    #2.9.4.zip
    $re  = "(.*).zip"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version = [IO.Path]::GetFileNameWithoutExtension($url)

    $Latest = @{ Version = $version }
    return $Latest
}

update -ChecksumFor none
