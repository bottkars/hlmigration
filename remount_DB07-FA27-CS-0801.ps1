$My_dbvol = mountvol "E:\mnt\dbs\DB07-FA27-CS-0801" /L
$My_dbvol = $My_dbvol -replace " "
mountvol "E:\mnt\dbs\DB07-FA27-CS-0801" /D
mountvol "E:\mnt_old\dbs\DB07-FA27-CS-0801" $My_dbvol
