<?php

use function PHPSTORM_META\elementType;

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
$dir="C:\\Users\Deepu\Downloads";

$locdir=$dir;

$files=scandir($locdir);

echo $files[1];

$con=mysqli_connect('localhost','root','','moviewatcher');



$arrtoBeinserted;
$flag=0;


for($i=2;$i<sizeof($files);$i++)
{
    $result=mysqli_query($con,"select movieName from movies");

    if(sizeof(explode(".", $files[$i]))==1 )
    {
        continue;
    }

    $length=sizeof(explode(".", $files[$i]));

if(explode(".", $files[$i])[ $length-1]=="mkv"||explode(".", $files[$i])[$length-1]=="mp4" )
{
                $flag=0;
            while($row=mysqli_fetch_assoc($result))
            {
                echo"l ---  ";
                if($files[$i]==$row['movieName'])
                {
                    echo"hh----";
                    $flag=1;
                    break;
                    
                }
            }

            if($flag!=1)
            {
                mysqli_query($con," insert into movies (movieName,movieGenre,movieLanguage,movieLink) values('$files[$i]','null','null','http://localhost/$files[$i]') ");
            }

        }
}






$result=mysqli_query($con,"select movieName from movies");


while($row=mysqli_fetch_assoc($result))
{
    $flag=0;
    for($i=2;$i<sizeof($files);$i++)
    {
        if($files[$i]==$row['movieName'])
        {
           echo"hh----";
           $flag=1;
            break;
            
        }
        
    }

    if($flag!=1)
    {
        mysqli_query($con,"delete from movies where movieName='".$row['movieName']."'");
    }
    echo"l ---  ";
    
}











?>