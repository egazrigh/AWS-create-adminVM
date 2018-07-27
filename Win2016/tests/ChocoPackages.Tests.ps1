Describe  'Chocolatey Packages' {

    $requested_packages = $env:choco_packages.Split(" ") 
    $Installed_packages = & choco list --local-only
    $Installed_packages = $Installed_packages  | Select-Object -SkipLast 1 | ConvertFrom-String

    It 'Verify Installed Chocolatey Packages' {
        ForEach ($mod in $requested_packages) {
            Write-Host "Verifying package $mod"
            ($Installed_packages | Where-Object P1 -contains "$mod" | Measure-Object).Count | should -BeGreaterOrEqual 1
        }
    }


}


