Describe  'Dev Tools installation' {
    It 'installs git' {
        { Get-Command "git" -ErrorAction Stop } | Should Not Throw
    }
}