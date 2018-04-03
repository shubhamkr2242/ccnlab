echo FILE MANAGEMENT SYSTEM
echo give a path of folder which contain some files:
cd /
read a
cd $a
echo enter 1 to List files stored along with their sizes.
echo enter 2 to Create files 
echo enter 3 to Allow changes to files 
echo enter 4 to Delete files
echo enter 5 to store information of files
echo enter 6 to move files between the directories
read n
case "$n" in


1) ls -s;;
2) echo enter file_name and write in file
   read f
   cat> $f;;
3) echo give path of folder to make changes in the files
   read c
   cd /
   cd $c
   echo folder contain files:-
   ls 
   echo give the name of file you want to make changes
   read d
   echo "enter 1 for read,write,execute to user group and others"
   echo "enter 2 for read and write to users and group"
   echo "enter 3 for read write and execute to only users"
   read m
   case "$m" in
   1) chmod 777 $d;;
   2) chmod 660 $d;;
   3) chmod 700 $d;;
   esac
   echo changes happened:-
   ls -l;;
4) echo files are:- 
   ls
   echo enter no. of files you want to delete
   read countt
   for(( i=1 ; i<=$countt ; i++ ))
   do
   echo give filename to delete
   read e
   rm -r $e
   echo file $e is deleted 
   echo now files are:- 
   ls
   done;;


5) echo files are:-
   ls
   echo enter name of file you want to see the information and store it in status file.
   read g
   echo information of file is:
   stat $g
   touch status
   stat $g>>status
   echo information of file is stored in file name status and its path is $a/status;;


6) echo enter the path of source directory from where you want to copy the files:
   read p
   echo enter the path of destination directory to where you want to move the files:
   read q
   cd /
   cd $p
   echo files of source dir are:-
   ls
   
   echo enter no. of files you want to move.
   read count
   for(( i=1 ; i<=$count ; i++ ))
   do
   cd /
   cd $p
   echo files of source dir are:-
   ls
   echo enter the name of file you want to move
   read name
   mv /$p/$name  /$q
   cd /
   cd $q
   echo content of destination dir $q now are:
   ls 
   done ;;
   
esac
