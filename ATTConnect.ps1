$ie = New-Object -ComObject 'internetExplorer.Application'
$ie.visible = $true

$ie.Navigate('html')
while ($ie.ReadyState -ne 4) {start-sleep -m 500} 

if ($ie.document.url -Match "invalidcert") {
    "Bypassing SSL Certificate Error Page";
    $sslbypass = $ie.Document.getElementById("overridelink");
    $sslbypass.click();
    "sleep while final page loads";
    start-sleep -m 2000;
};
($ie.document.getElementsByName("username") | select -first 1).value = ""
($ie.document.getElementsByName("password") | select -first 1).value = "" 

($ie.document.getElementsByName("Login") | select -first 1).click()
start-sleep -m 100;
while ($ie.ReadyState -ne 4) {start-sleep -m 500} 

if ($ie.document.getElementsByName("logout")) {
    $ie.close()
}


