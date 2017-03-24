function BuildSQLInsertCommandText {

    #This function uses the VMQ output object to create the values string used in the SQL insert statement
    #It takes an input object and converts it to a string
    #This isn't generic and so it's rubbish. Need to find a way to build the SQL Command object without caring about the input object
    #Should be able to make this cater for insert/update and maybe delete?
    
    [CmdletBinding()]
    Param 
    (
        $InputObject
    )
    
    $SQLCommand = @()

    Write-Verbose "Starting the for loop to create the SQL values"
    $InputObject | ForEach-Object {
        $Properties = @{'CommandText' = "'$($_.ComputerName)', `
                                         '$($_.AdapterName)', `
                                         '$($_.AdapterStatus)', `
                                         '$($_.VMQRegSetting)', `
                                         '$($_.VMQEnabledDriver)', `
                                         '$($_.VMQEnabledOS)', `
                                         '$($_.VMQNumReceiveQueues)', `
                                         '$($_.VMQMaxProcessors)'"}
        $SQLCommand += New-Object -TypeName PSObject -Property $Properties
    }

    $SQLCommand
}

$CommandToInsertIntoDB = BuildSQLInsertCommandText -InputObject $JobResults -Verbose