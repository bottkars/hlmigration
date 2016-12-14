Get-MailboxDatabaseCopyStatus -Local | where {$_.ActiveCopy -match $false}



###path analysis

### get mailbox database path and extract partition info


$Domain = $env:USERDOMAIN
$PlainPassword = "Password123!"
$DomainUser = "$Domain\Administrator"
$SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $DomainUser, $SecurePassword
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$env:COMPUTERNAME/PowerShell/ -Authentication Kerberos -Credential $Credential
Import-PSSession $Session -AllowClobber
$myfiles = @()
$myfiles = Get-MailboxDatabase -Identity DB2 | Get-MailboxDatabaseCopyStatus | Select-Object DatabaseName -unique | foreach  {(Get-MailboxDatabase $_.databasename).EDBFilePath}

foreach ($myfile in $myfiles)
    {
    [System.IO.FileInfo]$myfile = $myfile
    $myfile
    
    Get-Partition | where {$_.AccessPaths -match  $myfile.Directory.Parent}
    }
    
