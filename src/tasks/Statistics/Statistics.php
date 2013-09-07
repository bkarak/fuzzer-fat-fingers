<DOCTYPE html>
<html>
<head>
	<title>Statistics</title>
</head>
<body>

<?php
	$data_array = array();
	$file_content = fopen("data.txt", "r");
	while(!feof($file_content)){
	$line = fgets($file_content);
	array_push($data_array,(int)$line);
	}
	
	//array length
	$array_length = count($data_array);
	
	sort($data_array);
	
	foreach($data_array as $d){
	print $d . "<br />";
	}
	//return minimum value of numbers
	function minimum($data){
		return min($data);
	}
	//return maximum value of numbers
	function maximum($data){
		return max($data);
	}
	// returns the range of numbers
	function range_n($data){
		$range = max($data) - min($data);
		return $range;
	}
	// returns average (mean)
	function mean($data, $length){
		$mean;
		$sum;
		foreach($data as $i){
		$sum = $sum + $i;
		}
		$mean = $sum / $length;
		
		return round($mean, 2);
	}
	
	// calculate quartiles
	function quartiles($data, $length, $quartile){
		$median;
		$quartile_1;
		$quartile_3;
		$temp = $length / 2;
		
		if($quartile == 1){
			if($length % 2 == 0){
				if($temp % 2 == 0){
					$quartile_1 = ($data[($temp/2) - 1] + $data[$temp / 2]) / 2;
					return $quartile_1;
				}
				else{
					$quartile_1 = $data[$temp / 2];
					return $quartile_1;
				}
			}
			elseif($length % 2 == 1){
				if($temp % 2 == 0){
					$quartile_1 = ($data[($temp/2) - 1] + $data[$temp / 2]) / 2;
					return $quartile_1;
				}
				else{
					$quartile_1 = $data[$temp / 2];
					return $quartile_1;
				}
			}
		}
		elseif($quartile == 2){
			if($length % 2 == 1){
				$median = $data[$length / 2];
				return $median;
			}
			else{
				$median = ($data[($length / 2) -1 ] + $data[$length / 2]) / 2;
				return $median;
			}
		}
		elseif($quartile == 3){
			if($length % 2 == 0){
				if($temp % 2 == 0){
					$quartile_3 = ($data[(3 * $temp/2) - 1] + $data[(3 * $temp) / 2]) / 2;
					return $quartile_3;
				}
				else{
					$quartile_3 = $data[(3 * $temp) / 2];
					return $quartile_3;
				}
			}
			elseif($length % 2 == 1){
				if($temp % 2 == 0){
					$quartile_3 = ($data[(3 * $temp) / 2] + $data[((3 * $temp) / 2) + 1]) / 2;
					return $quartile_3;
				}
				else{
					$quartile_3 = $data[((3 * $temp) / 2) + 1];
					return $quartile_3;
				}
			}
		}
	}
	
	// calculate Standard Deviation
	function stand_dev($data, $length){
		$sum;
		$mean = mean($data, $length);
		foreach($data as $i){
			$sum += ($i - $mean) * ($i - $mean);
		}
		$stdev = sqrt($sum / $length);
		return round($stdev, 3);
	}
	
	// Find numbers out of boundaries
	function z_test($data, $length){
	
		$temp = 0;
		$z_array = array();
		$mean = mean($data, $length);
		$stdev = stand_dev($data, $length);
		//calculate numbers out of boundaries
		foreach($data as $i){
			if((abs($i - $mean) / $stdev) > 3){
				$temp +=1;
			}
		}
		
		if($temp == 0 ){
			echo "There are outliers";
		}
		else{
			// fill array with numbers out of boundaries
			foreach($data as $i){
				if((abs($i - $mean) / $stdev) > 3){
					for( $j = 0; $j < $temp; $j++){
					array_push($z_array, $i);
					}
				}
			}	
			
			// print numbers out of boundaries
			echo "Outliers: ";
			foreach($z_array as $k){
				echo $k . ", ";
			}
			echo "<br />";
		}
	}
	
	echo "Minimum value is " . minimum($data_array) . "<br />";
	echo "Maximum value is " . maximum($data_array) . "<br />";
	echo "Range between numbers is " . range_n($data_array) . "<br />";
	echo "The average is " . mean($data_array, $array_length) . "<br />";
	echo "First quartile is : " . quartiles($data_array, $array_length, 1) . "<br />";
	echo "Median  is : " . quartiles($data_array, $array_length, 2) . "<br />";
	echo "Third quartile is : " . quartiles($data_array, $array_length, 3) . "<br />";
	echo "Standard Deviation is: " . stand_dev($data_array, $array_length) . "<br />";
	echo  z_test($data_array, $array_length) . "<br />";
	
	
	fclose($file_content);
?>

</body>
</html>