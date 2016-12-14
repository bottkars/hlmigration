$line = "-----------------------------------------------------------------------------"
$Serverprefix1 = "-KAL2-CS-0802"
$Serverprefix2 = "-FA27-CS-0801"
$logoffset = 43
$dboffset = 63
$mastercontent = @()
foreach ($DBcount in (1..10))
    {
    $DBNUM = "{0:D2}" -f $DBcount
    $LOG = "LOG$DBNUM$Serverprefix1"
    $DB = "DB$DBNUM$Serverprefix1"
    $logdisk = $logoffset
    $dbdisk = $dboffset
    Write-Host "$LOG $logdisk "
    Write-Host "$DB $dbdisk"
    ##### create dispart file
    $diskpart_content_db = @()
    $diskpart_content_db += "sel dis $dbdisk"
    $diskpart_content_db += "online dis"
    $diskpart_content_db += "attrib dis clear readonly"
    $diskpart_content_db += "cre par pri"
    $diskpart_content_db += "assign mount=E:\mnt\dbs\$DB"
    $diskpart_content_db += "FORMA FS=NTFS LABEL=$DB(VNX) UNIT=64k QUICK"
    $diskpart_content_db | Set-Content -Path ".\dbdisk$dbdisk.txt"

    ##### create dispart file
    $diskpart_content_log = @()
    $diskpart_content_log += "sel dis $logdisk"
    $diskpart_content_log += "online dis"
    $diskpart_content_log += "attrib dis clear readonly"
    $diskpart_content_log += "cre par pri"
    $diskpart_content_log += "assign mount=E:\mnt\logs\$LOG"
    $diskpart_content_log += "FORMA FS=NTFS LABEL=$LOG(VNX) UNIT=64k QUICK"
    $diskpart_content_log | Set-Content -Path ".\logdisk$logdisk.txt"
    
    
     $log_mountvol_content = @()
    ###  create unmount scripts
     $log_mountvol_content += "`$My_logvol = mountvol `"E:\mnt\logs\$LOG`" /L"
     $log_mountvol_content += "`$My_logvol = `$My_logvol -replace `" `""
     $log_mountvol_content += "mountvol `"E:\mnt\logs\$LOG`" /D"
     $log_mountvol_content += "mountvol `"E:\mnt_old\logs\$LOG`" `$My_logvol"
     $log_mountvol_content  | set-content ".\remount_$log.ps1"
    
    $db_mountvol_content = @()
    ###  create unmount scripts
     $db_mountvol_content += "`$My_dbvol = mountvol `"E:\mnt\dbs\$db`" /L"
     $db_mountvol_content += "`$My_dbvol = `$My_dbvol -replace `" `""
     $db_mountvol_content += "mountvol `"E:\mnt\dbs\$db`" /D"
     $db_mountvol_content += "mountvol `"E:\mnt_old\dbs\$db`" `$My_dbvol"
     $db_mountvol_content  | set-content ".\remount_$db.ps1"
    
    $mastercontent += $line
    $mastercontent += " ** Instructions for Database $db ***"
    $mastercontent += " "
    $mastercontent += "############Step 1 for $db ( remount old log and db Volumes) "
    $mastercontent += " "
    $mastercontent += $db_mountvol_content
    $mastercontent += $log_mountvol_content
    $mastercontent += " "
    $mastercontent += "############Step 2 Diskpart for log and database"
    $mastercontent += " "
    $mastercontent += $diskpart_content_db
    $mastercontent += " "
    $mastercontent += $diskpart_content_log
    $mastercontent += " "
    $mastercontent += "############Step 3 copy $db ( copy db and log files) "
    $mastercontent += " "    
    $mastercontent += "copy-item -Path E:\mnt_old\dbs\$db\*  E:\mnt\dbs\$db\ -verbose -recurse"
    $mastercontent += "copy-item -Path E:\mnt_old\logs\$LOG\*  E:\mnt\logs\$LOG\ -verbose -recurse"
    $mastercontent += " "
    $dboffset ++
    $logoffset ++
    }


    $mastercontent | Set-Content "Instructions for $Serverprefix1.txt"


$mastercontent = @()
foreach ($DBcount in (1..10))
    {
    $DBNUM = "{0:D2}" -f $DBcount
    $LOG = "LOG$DBNUM$Serverprefix2"
    $DB = "DB$DBNUM$Serverprefix2"
    $logdisk = $logoffset
    $dbdisk = $dboffset
    Write-Host "$LOG $logdisk "
    Write-Host "$DB $dbdisk"
    ##### create dispart file
    $diskpart_content_db = @()
    $diskpart_content_db += "sel dis $dbdisk"
    $diskpart_content_db += "online dis"
    $diskpart_content_db += "attrib dis clear readonly"
    $diskpart_content_db += "cre par pri"
    $diskpart_content_db += "assign mount=E:\mnt\dbs\$DB"
    $diskpart_content_db += "FORMA FS=NTFS LABEL=$DB(VNX) UNIT=64k QUICK"
    $diskpart_content_db | Set-Content -Path ".\dbdisk$dbdisk.txt"

    ##### create dispart file
    $diskpart_content_log = @()
    $diskpart_content_log += "sel dis $logdisk"
    $diskpart_content_log += "online dis"
    $diskpart_content_log += "attrib dis clear readonly"
    $diskpart_content_log += "cre par pri"
    $diskpart_content_log += "assign mount=E:\mnt\logs\$LOG"
    $diskpart_content_log += "FORMA FS=NTFS LABEL=$LOG(VNX) UNIT=64k QUICK"
    $diskpart_content_log | Set-Content -Path ".\logdisk$logdisk.txt"
    
    
     $log_mountvol_content = @()
    ###  create unmount scripts
     $log_mountvol_content += "`$My_logvol = mountvol `"E:\mnt\logs\$LOG`" /L"
     $log_mountvol_content += "`$My_logvol = `$My_logvol -replace `" `""
     $log_mountvol_content += "mountvol `"E:\mnt\logs\$LOG`" /D"
     $log_mountvol_content += "mountvol `"E:\mnt_old\logs\$LOG`" `$My_logvol"
     $log_mountvol_content  | set-content ".\remount_$log.ps1"
    
    $db_mountvol_content = @()
    ###  create unmount scripts
     $db_mountvol_content += "`$My_dbvol = mountvol `"E:\mnt\dbs\$db`" /L"
     $db_mountvol_content += "`$My_dbvol = `$My_dbvol -replace `" `""
     $db_mountvol_content += "mountvol `"E:\mnt\dbs\$db`" /D"
     $db_mountvol_content += "mountvol `"E:\mnt_old\dbs\$db`" `$My_dbvol"
     $db_mountvol_content  | set-content ".\remount_$db.ps1"
    
    $mastercontent += $line
    $mastercontent += " ** Instructions for Database $db ***"
    $mastercontent += " "
    $mastercontent += "############Step 1 for $db ( remount old log and db Volumes) "
    $mastercontent += " "
    $mastercontent += $db_mountvol_content
    $mastercontent += $log_mountvol_content
    $mastercontent += " "
    $mastercontent += "############Step 2 Diskpart for log and database"
    $mastercontent += " "
    $mastercontent += $diskpart_content_db
    $mastercontent += " "
    $mastercontent += $diskpart_content_log
    $mastercontent += " "
    $mastercontent += "############Step 3 copy $db ( copy db and log files) "
    $mastercontent += " "    
    $mastercontent += "copy-item -Path E:\mnt_old\dbs\$db\*  E:\mnt\dbs\$db\ -verbose -recurse"
    $mastercontent += "copy-item -Path E:\mnt_old\logs\$LOG\*  E:\mnt\logs\$LOG\ -verbose -recurse"
    $mastercontent += " "
    $dboffset ++
    $logoffset ++
    }
    $mastercontent | Set-Content "Instructions for $Serverprefix2.txt"