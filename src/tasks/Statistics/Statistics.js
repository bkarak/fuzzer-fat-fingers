<script>
	function loadFile(uri) {
		var r = new XMLHttpRequest();
		r.open('GET', uri, true);
		r.send(null);
		r.onreadystatechange = function() {
			if (r.readyState == 4) {
				processFile(r.responseText);
			}
		}
	}
	
	function processFile(fileContent) {
		var numbers = new Array();
		var lines = fileContent.split('\n');
		numbers = fileContent.split('\n');
		numbers.sort(function(a,b){return a-b});
		//alert(numbers); // sorted 
		for(var i=0; i < numbers.length; i++)
		{
			numbers[i] = parseInt(numbers[i]);
		}
		
		//Min
		var min = minimum(numbers);
		//Max
		var max = maximum(numbers);
		//Range
		var range = max - min;
		//Mean - Average
		var average = mymean(numbers);
		
		var quartile1 = quartiles(numbers, numbers.length, 1);
		var quartile2 = quartiles(numbers, numbers.length, 2);
		var quartile3 = quartiles(numbers, numbers.length, 3);
		
		var standardDev = stand_dev(numbers, numbers.length);
		var zTest = z_test(numbers, numbers.length);
		
		document.write('<p>Minimum value is : ' + min + '</p>' );
		document.write('<p>Maximum value is : ' + max + '</p>');
		document.write('<p>Range between values is : ' + range + '</p>');
		document.write('<p>Average value is : ' + average + '</p>');
		document.write('<p>First quartile is : ' + quartile1 + '</p>');
		document.write('<p>Median is : ' + quartile2 + '</p>');
		document.write('<p>Third quartile is : ' + quartile3 + '</p>');
		document.write('<p>The standard deviation is : ' + standardDev + '</p>');
		if (zTest.length > 0)
		{
			document.write('<p>Outliers are : ' + zTest + '</p>');
		}
		else
		{
			document.write('<p>No outliers'+ '</p>');
		}
		
		
	}
	
	function minimum(varArray)
	{
		var min =  Math.min.apply(Math,varArray);	
		return min;
	}
	
	function maximum(varArray)
	{
		var max =  Math.max.apply(Math,varArray);	
		return max;
	}
	
	function mymean(varArray)
	{
		var count_elements = varArray.length;
		var total_value = 0;
		for(var i=0; i < count_elements; i++)
		{
			total_value += varArray[i];
		}
		var average = parseFloat(total_value / count_elements);
		average = Number((average).toFixed(2));
		return average;
	}
	
	function quartiles(varArray, length, quartile){
		var median;
		var quartile_1;
		var quartile_3;
		var temp = length / 2;
		
		if(quartile == 1){
			if(length % 2 == 0){
				if(temp % 2 == 0){
					var numb = parseInt(temp / 2);
					var sum = varArray[numb - 1] + varArray[numb];
					quartile_1 = parseFloat(sum / 2);
					return quartile_1;
				}
				else{
					var numb = parseInt(temp / 2);
					quartile_1 = varArray[numb];
					return quartile_1;
				}
			}
			else if(length % 2 == 1){
				if(temp % 2 == 0){
					var numb = parseInt(temp / 2);
					var sum = varArray[numb - 1] + varArray[numb]
					quartile_1 = parseFloat(sum/2);
					return quartile_1;
				}
				else{
					var numb = parseInt(temp / 2);
					quartile_1 = varArray[numb];
					return quartile_1;
				}
			}
		}
		else if(quartile == 2){
			if(length % 2 == 1){
				var numb = parseInt(length / 2);
				median = varArray[numb];
				return median;
			}
			else{
				var numb = parseInt(length / 2);
				var element1 = varArray[numb -1 ];
				var element2 = varArray[numb];
				var sum = element1 + element2;
				median = parseFloat(sum/2);
				return median;
			}
		}
		else if(quartile == 3){
			if(length % 2 == 0){
				if(temp % 2 == 0){
					var numb = parseInt(temp / 2);
					var element1 = varArray[(3 * numb) - 1];
					var numb2 = parseInt((3 * temp) / 2);
					var element2 = varArray[numb2];
					var sum = element1 + element2;
					quartile_3 =  (sum/ 2);
					return quartile_3;
				}
				else{
					var numb = parseInt((3 * temp) / 2) ;
					quartile_3 = varArray[numb];
					return quartile_3;
				}
			}
			else if(length % 2 == 1){
				if(temp % 2 == 0){
					var numb = parseInt(temp / 2);
					var numb2 = parseInt((3 * temp) / 2);
					var numb3 = parseInt(((3 * temp) / 2) + 1);
					var sum = varArray[numb2] + varArray[numb3];
					quartile_3 = parseFloat(sum / 2);
					return quartile_3;
				}
				else{
					var numb = parseInt(temp / 2);
					var numb2 = parseInt(((3 * temp) / 2) + 1);
					quartile_3 = varArray[numb2];
					return quartile_3;
				}
			}
		}
	}
	
	function stand_dev(varArray, length){
		var sum = 0;
		var average = mymean(varArray, length);
		for(var i=0; i < length; i++)
		{
			var numb = parseFloat(varArray[i]- average);
			//numb = Math.abs(numb);
			var test = Math.pow(numb,2);
			sum +=  Math.pow(numb,2);
		}
		var squareRoot = parseFloat(sum / length);
		stdev = Math.sqrt(squareRoot);
		var result = Number((stdev).toFixed(3));
		return result;
	}

	function z_test(varArray, length){
	
		var temp = 0;
		var z_array = new Array();
		var average = mymean(varArray, length);
		var stdev = stand_dev(varArray, length);
		//calculate numbers out of boundaries
		for(var i=0; i < length; i++)
		{
			var numb = Math.abs(varArray[i] - average);
			var gin = parseFloat(numb / stdev );
			if( gin > 3)
			{
				temp += 1;
			}
		}
		
		if( temp == 0 ){
			return 0;
		}
		else{
			// fill array with numbers out of boundaries
			for(var j=0; j < length; j++){
				var numb2 = Math.abs(varArray[j] - average);
				var gin2 = parseFloat(numb2 / stdev );
				
				if(gin2 > 3){
					for( var k = 0;  k < temp; k++){
					//alert(varArray[k]);
					z_array.push(varArray[j]);
					}
				}
			}	
			return z_array;
		}
	}

	loadFile('http://localhost/Statistics/data.txt');
	</script>