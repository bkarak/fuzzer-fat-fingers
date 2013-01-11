<?php
 
session_start();
 
if(isset($_SESSION['number']))
{
   $number = $_SESSION['number'];
}
else
{
   $_SESSION['number'] = rand(1,10);
}
 
 
if($_POST["guess"]){
    $guess  = htmlspecialchars($_POST['guess']);
 
	echo $guess . "<br />";
    if ($guess != $number)
	{ 
        echo "Your guess is not correct";
    }
	elseif($guess == $number)
	{
        echo "You got the correct number!";
    }
 
}
?>