
$Serverprefix1 = "-KAL2-CS-0802"
$Serverprefix2 = "-FA27-CS-0802"

$counter = 1 
foreach ($DBcount in (1..10))
    {
    $logoffset = 42
    $dboffset = 62
    $DBNUM = "{0:D2}" -f $DBcount
    $LOG = "LOG$DBNUM$Serverprefix1"
    $DB = "DB$DBNUM$Serverprefix1"
    $logdisk = $logoffset + $counter
    $dbdisk = $dboffset + $counter
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
    $counter ++
    

    ###  create unmount scripts
     $My_logvol = mountvol 



    }




