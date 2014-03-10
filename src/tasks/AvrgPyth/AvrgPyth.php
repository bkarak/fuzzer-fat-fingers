<?php
 $myArray= array(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0);
 $arithmetic = round(arithmeticMean($myArray), 6);
 $geometric = round(geometricMean($myArray), 6);
 $harmonic = round(harmonicMean($myArray), 6);
 echo('A = '.$arithmetic.' G = '.$geometric.' H = '.$harmonic);
 printf("A >= G is %s, G >= H is %s",($arithmetic >= $geometric ? 'true' : 'false'),($geometric >= $harmonic ? 'true' : 'false'));
 
 function arithmeticMean($numbers=array()) 
 	{
        if (empty($numbers))
		{
			return null;
		}
        $mean = 0.0;
        foreach ($numbers as $number) {
            $mean += $number;
        }
        return $mean / count($numbers);
    }
 
    function geometricMean($numbers=array()) 
	{
        if (empty($numbers))
		{
			return null;
		}
        $mean = 1.0;
        foreach ($numbers as $number) 
		{
            $mean *= $number;
        }
        return pow($mean, 1.0 / count($numbers));
    }
 
    function harmonicMean($numbers=array()) 
	{
        if (empty($numbers) || in_array(0.0,$numbers))
		{
			return null;
		}
        $mean = 0.0;
        foreach ($numbers as $number) 
		{
            $mean += (1.0 / $number);
        }
        return count($numbers) / $mean;
    }
?>
