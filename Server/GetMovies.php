
<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");


$con=mysqli_connect('localhost','root','','moviewatcher');

$result=mysqli_query($con,"Select * from movies ");

$arr=array();
$json=array();
$i=0;
while($row=mysqli_fetch_assoc($result))
{
  
 $arr['movieId']=$row['movieId'];
 $arr['movieName']=$row['movieName'];
 $arr['movieGenre']=$row['movieGenre'];
 $arr['movieLanguage']=$row['movieLanguage'];
 $link= substr_replace($row['movieLink'],$_SERVER['SERVER_ADDR'],7,9);
 $arr['movieLink']=$link;


 $json[$i++]=$arr;

}



echo json_encode($json);





?>

