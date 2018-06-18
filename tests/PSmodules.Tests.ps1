Describe  'Powershell modules' {

    $requested_modules = $env:powershell_psgallery_modules.Split(",")
    $Installed_modules = get-module -ListAvailable


    It 'Verify Installed Powershell modules' {
        ForEach ($mod in $requested_modules) {
            Write-Host "Verifying module $mod"
            ($Installed_modules | Where-Object name -eq "$mod" | Measure-Object).Count | should -BeGreaterOrEqual 1
        }
    }


}

