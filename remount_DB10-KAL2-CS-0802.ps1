$My_dbvol = mountvol "E:\mnt\dbs\DB10-KAL2-CS-0802" /L
$My_dbvol = $My_dbvol -replace " "
mountvol "E:\mnt\dbs\DB10-KAL2-CS-0802" /D
mountvol "E:\mnt_old\dbs\DB10-KAL2-CS-0802" $My_dbvol