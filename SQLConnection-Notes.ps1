#HERE FOLLOWS MY NOTES ON SETTING UP A SQL CONNECTION AND INSERTING/SELECTING


#The following runs a select query and stores it in $Results
#Running a select statement requires the ExecuteReader method of the SqlCommand object

$Conn.Open()
$Results = New-Object System.Data.DataTable
$Command = New-Object System.Data.SqlClient.SqlCommand
$Command.Connection = $Conn
$Command.CommandText = "Select top 100 * from win_HBAInfo"
$Query = $Command.ExecuteReader()
$Results.Load($Query)
$Conn.Close()

$Results | ft -AutoSize


#The following uses the ExecuteNonQuery method (again of the SqlCommand object)
#to insert data into a table

$Conn.Open()

$VMQOutput | ForEach-Object {
    $CommandText = "'$($_.ComputerName)', '$($_.AdapterName)', '$($_.AdapterStatus)', '$($_.VMQRegSetting)', '$($_.VMQEnabledDriver)', '$($_.VMQEnabledOS)', '$($_.VMQNumReceiveQueues)', '$($_.VMQMaxProcessors)'"

    $Command = New-Object System.Data.SqlClient.SqlCommand
    $Command.Connection = $Conn
    $Command.CommandText = "insert win_hv_VMQ values ($CommandText)"
    $Command.ExecuteNonQuery()
}

$Conn.Close()
