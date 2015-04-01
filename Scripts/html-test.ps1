$path = "$env:temp\report.hta"
$beginning = {
 @'
    <html>
    <head>
    <title>Report</title>
    <STYLE type="text/css">
        h1 {font-family:SegoeUI, sans-serif; font-size:20} 
        th {font-family:SegoeUI, sans-serif; font-size:15} 
        td {font-family:Consolas, sans-serif; font-size:12} 
 
    </STYLE>
 
    </head>
    <image src="http://www.yourcompany.com/yourlogo.gif" />
    <h1>System Report</h1>
    <table>
    <tr><th>Status</th><th>Name</th></tr>
'@ 
}
$process = {
    $status = $_.Status
    $name = $_.DisplayName
    if ($status -eq 'Running')
    {
        '<tr>'
        '<td bgcolor="#00FF00">{0}</td>' -f $status
        '<td bgcolor="#00FF00">{0}</td>' -f $name
        '</tr>' 
    }
    else
    {
        '<tr>'
        '<td bgcolor="#FF0000">{0}</td>' -f $status
        '<td bgcolor="#FF0000">{0}</td>' -f $name
        '</tr>'
    }
}

$end = { 
@'
    </table>
    </html>
    </body>
'@ 

}

Get-Service |
  ForEach-Object -Begin $beginning -Process $process -End $end |
  Out-File -FilePath $path -Encoding utf8
Invoke-Item -Path $path 
