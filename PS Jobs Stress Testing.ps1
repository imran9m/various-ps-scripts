$cmd = {
param($lines)
$endPoint = "uri";
foreach($line in $lines)
{
$soapReq = "soapxml";
Try
{
$Result = Invoke-WebRequest -Uri $endPoint -Method Post -ContentType "text/xml" -Body $soapReq;
}
Catch
{
$line+"~:~"+$_.Exception.Message | Out-File "D:\mimran\"+$line+".txt" -Append;
}
}
}

[string[]]$lines = Get-Content "C:\temp.txt";
$lstArray = New-Object 'System.Collections.Generic.List[System.String]';
$lstArray.AddRange($lines)
$count = 0
$delta = 350
while($count+$delta -le $lstArray.Count)
{
[string[]]$batch = $lstArray.GetRange($count,$delta)
$count = $count+$delta;
$count
if($batch.Count -gt 0)
{
Start-Job -ScriptBlock $cmd -ArgumentList (,$batch)
}
}