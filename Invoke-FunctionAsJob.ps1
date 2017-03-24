function InvokeFunctionAsJobThrottled {
    #Maybe think about making the max threads parameter optional? Or upping the default thread count?

    [CmdletBinding()]
    Param (
        [string[]]$Computers,
        [scriptblock]$FunctionToRun,
        $MaxThreads = 10
    )

    Write-Verbose ('Running function defined in $FunctionToRun, with a maximum of ' + "$MaxThreads" + ' job threads')

    $Computers | ForEach-Object {

        While (@(Get-Job | Where-Object {$_.state -eq 'Running'}).Count -ge $MaxThreads) 
        {
            Write-Verbose "Max jobs reached, maximum threads is $MaxThreads"
            Start-Sleep -Seconds 3
        }

        Invoke-Command -ComputerName $_ -ScriptBlock $FunctionToRun -AsJob
        
    }
}


function GetProcessorInfo {
    Get-WmiObject win32_processor
}


$FunctionToRun = 'GetProcessorInfo'
Invoke-Command -ComputerName testserver01 -ScriptBlock ${Function:$FunctionToRun}


${Function:$FunctionToRun}

$HVHosts = "testserver01","testserver02"

InvokeFunctionAsJobThrottled -Computers $HVHosts -FunctionToRun $Function:GetProcessorInfo -MaxThreads 10 -Verbose




Write-Verbose ("$TestNumber" + "$TestWord") -Verbose

