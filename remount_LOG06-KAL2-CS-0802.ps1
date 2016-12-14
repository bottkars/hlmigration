$My_logvol = mountvol "E:\mnt\logs\LOG06-KAL2-CS-0802" /L
$My_logvol = $My_logvol -replace " "
mountvol "E:\mnt\logs\LOG06-KAL2-CS-0802" /D
mountvol "E:\mnt_old\logs\LOG06-KAL2-CS-0802" $My_logvol
