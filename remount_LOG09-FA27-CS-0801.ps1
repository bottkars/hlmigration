$My_logvol = mountvol "E:\mnt\logs\LOG09-FA27-CS-0801" /L
$My_logvol = $My_logvol -replace " "
mountvol "E:\mnt\logs\LOG09-FA27-CS-0801" /D
mountvol "E:\mnt_old\logs\LOG09-FA27-CS-0801" $My_logvol
