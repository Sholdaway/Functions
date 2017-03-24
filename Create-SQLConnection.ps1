#This simply generates a SQL connection object and assigns it a connection string. No connections to the DB are opened here

function CreateSQLConnection {
    [CmdletBinding()]
    Param 
    (
        [string]$SQLServer,
        [string]$Instance,
        [string]$DatabaseName
    )
    
    Write-Verbose "Creating (but not opening!) a connection to $DatabaseName on $SQLServer\$Instance"
    $Conn = New-Object System.Data.SqlClient.SqlConnection
    $Conn.ConnectionString = "Data Source=$SQLServer\$Instance; Initial Catalog=$DatabaseName; Integrated Security=SSPI"
    $Conn
}

$Conn = CreateSQLConnection -SQLServer server01 -Instance instance01 -DatabaseName testdb -Verbose