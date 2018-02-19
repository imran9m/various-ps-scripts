$cmd = {
    param([string]$jobId)
    #$jobId = 1
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
    [int]$i = 1;
    $lines = Get-Content "Ids.txt";
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]";
    $headers.Add("Authorization", 'Bearer xxx');
    while ($i -ne 2) {
        foreach ($line in $lines) {
            $uri = "https://api.com" + $line;
            $Start = Get-Date;
            $rootId ="NULL";
            $ex = "NULL";
            try {
                $data = Invoke-WebRequest -Uri $uri -Headers $headers;
            }
            catch {
               $ex = $_.Exception.Message
            }
            $tt =  ((Get-Date) - $Start).TotalMilliseconds
            [string]$fileSuffix = $jobId.ToString()+"_"+$i.ToString();
            [string]$fileName = "C:\temp\Result_"+$fileSuffix+".txt";
            $line.ToString()+","+$rootId.ToString()+","+$ex.ToString()+","+$tt.ToString() | Out-File $fileName -Append;
        } 
        $i++;
    }
}

[string]$scriptRun = 1;
[int]$i = 1
while ($i -ne 6) {
    Start-Job -ScriptBlock $cmd -Arg ($scriptRun.ToString()+$i.ToString());
    $i++;
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
$lines = Get-Content "Ids.txt";
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]";
$headers.Add("Authorization", 'Bearer xxx');
foreach ($line in $lines) {
    $uri = "https://api.com" + $line;
    $line
    $timeTaken = Measure-Command -Expression {
        $data = Invoke-WebRequest -Uri $uri -Headers $headers;
    }
    $timeTaken.TotalMilliseconds
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
$lines = Get-Content "Ids.txt";
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]";
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
foreach ($line in $lines) {
    $uri = "https://api.com" + $line;
    $line
    $timeTaken = Measure-Command -Expression {
        $data = Invoke-WebRequest -Uri $uri -Headers $headers;
    }
    $timeTaken.TotalMilliseconds
}