Import-Module ActiveDirectory
$User = Get-ADUser -Identity id -Properties *;
($user.memberof | % { (Get-ADGroup $_).Name; } | Sort-Object)

Get-ADGroupMember -identity "groupid" | foreach{get-aduser $_} | select name