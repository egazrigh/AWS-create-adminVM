Describe  'Windows Features' {

    $requested = $env:windowsfeatures.Split(",")
    $Installed = get-WindowsFeature | Where-Object Installed -eq $true


    It 'Verify Installed Windows Feature' {
        ForEach ($elem in $requested) {
            Write-Host "Verifying Feature $elem"
            ($Installed | Where-Object name -eq "$elem" | Measure-Object).Count | should -Be 1
        }
    }


}

