Describe  'Verify WebServer configuration' {

    $service = get-service -name w3svc

    It 'Service Startup Type is automatic' {
        $service.StartType | should -Be "Automatic"
    }

    It 'Index page contains required content' {
        (Invoke-WebRequest -Uri localhost).Content -match "IIS is running on AWS Admin VM" | should -Be $True
    }


}


