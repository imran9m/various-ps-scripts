﻿$AliasName = "SQLAlias"
 
#This is the name of your SQL server (the actual name!)
$ServerName = "ServerName"
 
#These are the two Registry locations for the SQL Alias locations
$x86 = "HKLM:\Software\Microsoft\MSSQLServer\Client\ConnectTo"
$x64 = "HKLM:\Software\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo"
 
#We're going to see if the ConnectTo key already exists, and create it if it doesn't.
if ((test-path -path $x86) -ne $True) {
    write-host "$x86 doesn't exist"
    New-Item $x86
}
if ((test-path -path $x64) -ne $True) {
    write-host "$x64 doesn't exist"
    New-Item $x64
}
 
#Adding the extra "fluff" to tell the machine what type of alias it is
$TCPAlias = "DBMSSOCN," + $ServerName
$NamedPipesAlias = "DBNMPNTW,\\" + $ServerName + "\pipe\sql\query"
 
#Creating our TCP/IP Aliases
New-ItemProperty -Path $x86 -Name $AliasName -PropertyType String -Value $TCPAlias
New-ItemProperty -Path $x64 -Name $AliasName -PropertyType String -Value $TCPAlias

#Update our TCP/IP Aliases
#Set-ItemProperty -Path $x86 -Name $AliasName -Type String -Value $TCPAlias
#Set-ItemProperty -Path $x64 -Name $AliasName -Type String -Value $TCPAlias
