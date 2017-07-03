$base64EncodedString = Get-Content temp.txt
$bytes = [System.Convert]::FromBase64String($base64EncodedString)
[IO.File]::WriteAllBytes("C:\temp\temp.pdf", $bytes)
