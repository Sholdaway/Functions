function ReceiveJobOutputAndRemove {
    [CmdletBinding()]
    Param ()
    
    #Would like to see a begin, process, end construct here with job cleanup in the finally block

    While (@(Get-Job | Where-Object {$_.state -eq 'Running'}).Count -ne 0)
    {
        Write-Verbose ('Jobs are still running. Number of jobs still to complete is ' + ((Get-Job | Where-Object {$_.state -eq 'Running'}).Count))
        Start-Sleep -Seconds 3
    }

    $JobOutput = Get-Job | Receive-Job | Select-Object * -ExcludeProperty pscomputername,runspaceid

    Get-Job | Remove-Job

    $JobOutput
}

$JobResults = ReceiveJobOutputAndRemove -Verbose