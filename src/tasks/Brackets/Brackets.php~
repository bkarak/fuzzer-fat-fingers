<?php		
	$tests = array("", "[]", "][", "[][]", "][][", "[[][]]", "[]][[]");
   for($i = 0; $i <= 16; $i+=2)
	{
	   $bracks = generate($i);
      echo($bracks.": ".checkBrackets($bracks)."<br />");
   } 
  	foreach($tests as $test)
	{
		echo($test.": ".checkBrackets($test)."<br />");
   }

	function checkBrackets($str='')
	{
   	$mismatchedBrackets = 0;
      foreach(str_split($str) as $ch)
		{
      	if($ch == '[')
			{
         	$mismatchedBrackets++;
         }
			elseif($ch == ']')
			{
         	$mismatchedBrackets--;
         }
			else
			{
         	return 'false'; //non-bracket chars
         }
         if($mismatchedBrackets < 0){ //close bracket before open bracket
         	return 'false';
        	}
		}
     	return $mismatchedBrackets == 0 ? 'true' : 'false';
    }
 
	function generate($n)
	{
   	if($n % 2 == 1)
		{ //if n is odd we can't match brackets
     		return null;
      }
      $ans = "";
      $openBracketsLeft = $n / 2;
      $unclosed = 0;
      while(strlen($ans) < $n)
		{
      	if(rand(0.0, 1.0) >= 0.5 && $openBracketsLeft > 0 || $unclosed == 0)
			{
         	$ans .= '[';
            $openBracketsLeft--;
            $unclosed++;
         }
			else
			{
            $ans .= ']';
            $unclosed--;
         }
		}
     	return $ans;
    }
?>
