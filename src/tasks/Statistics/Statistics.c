#include <stdio.h>
#include <stdlib.h> /* required for atoi */
#include <math.h>

// functions declaration - prototypes
int max(int array[], int arraySize);
int min(int array[], int arraySize);
int range(int array[], int arraySize);
float mean(int array[], int arraySize); 
float nquartile(int array[], int arraySize , int choiseValue);
float standard_deviation(int array[], int arraySize);
void z_test(int array[], int arraySize);

int main(void) {
	
	int c, d, swap;
	int i = 0;
	int counter = 0;
	int numbers[100];
	char line[100]; 
	FILE *file; 
	file = fopen("data.txt", "r"); 

	while(fgets(line, sizeof line, file)!=NULL) 
	{
		numbers[i]=atoi(line); /* convert string to int*/
		i++;
		counter ++;
	}
	fclose(file);

	// using bubble sort algorithm 
	for(c = 0; c < (counter - 1); c++)
	{
		for(d = 0; d < (counter - c - 1); d++)
		{
			if( numbers[d] > numbers[d+1])
			{
				swap = numbers[d];
				numbers[d] = numbers[d+1];
				numbers[d+1] = swap;
			}
		}
	}
	
	
	// print sorted array
	printf("Sorted list is ascending order: \n");
	for(c = 0; c < counter; c++)
	{
		printf("%d\n", numbers[c]);
	}
	
	printf("Maximum number in list: %d\n", max(numbers, counter));
	printf("Minimum number in list: %d\n", min(numbers, counter));
	printf("Range between numbers in list: %d\n", range(numbers, counter));
	printf("Average value in list: %.2f\n", mean(numbers, counter));

	printf("Median is : %.2f\n", nquartile(numbers, counter , 2));
	printf("First quartile  is : %.2f\n", nquartile(numbers, counter , 1));
	printf("Third quartile  is : %.2f\n", nquartile(numbers, counter , 3));
	printf("Standard Deviation is : %.2f\n", standard_deviation(numbers, counter));
	z_test(numbers, counter);
	
	return 0;
}

// maximum function
int max(int array[], int arraySize)
{
	int i;
	int max = array[0];
	for(i = 0; i < arraySize; i++)
	{
		if(array[i] > max)
		{
			max = array[i];
		}
	}
	return max;
}

// minimum function
int min(int array[], int arraySize)
{
	int i;
	int min = array[0];
	for(i = 0; i < arraySize; i++)
	{
		if(array[i] < min)
		{
			min = array[i];
		}
	}
	return min;
}

// range function
int range(int array[], int arraySize)
{
	int a = max(array, arraySize);
	int b = min(array, arraySize);
	int r = a - b;
	return r;
}

// Mean - Average function
float mean(int array[], int arraySize) // function definition
{	
	int i; // step 
	float average;
	float total = 0.00;
	for(i=0; i < arraySize; i++)
	{
		total = total + (float)array[i];
	}
	average = (float)(total /arraySize);
	return average;
}

// Calculate median, First, Third quartiles 
float nquartile(int array[], int arraySize , int choiseValue)
{
	int temp; 
	float median;
	float firstQuartile;
	float thirdQuartile;
	
	temp = arraySize / 2;
	
	if(choiseValue == 1)
	{
		if(arraySize % 2 == 0)
		{
			if( temp % 2 == 0)
			{
				firstQuartile = (float)(array[(temp / 2) -1] + array[temp / 2 ]) / 2 ;
				return firstQuartile;
			}
			else
			{
				firstQuartile = (float) array[temp / 2 ];
				return firstQuartile;
			}
		}
		else if (arraySize % 2 == 1)
		{
			if( temp % 2 == 0)
			{
				firstQuartile = (float) (array[(temp/2) - 1] + array[temp / 2]) / 2 ;
				return firstQuartile;
			}
			else
			{
				firstQuartile = (float) array[temp / 2];
				return firstQuartile;
			}
		}

	}
	else if(choiseValue == 2)
	{
		if(arraySize % 2 == 1 )
		{
			median = (float) array[arraySize / 2];
			return median ;
		}
		else
		{
			median = (float) (array[(arraySize / 2) - 1] + array[arraySize / 2]) / 2 ;
			return median;
		}
	}
	else if(choiseValue == 3)
	{
		if(arraySize % 2 == 0)
			{
				if(temp % 2 == 0 )
				{
					thirdQuartile = (float) (array[(3 * temp / 2) - 1 ] + array[(3 * temp) / 2 ]) / 2 ;
					return thirdQuartile;
				}
				else
				{
					thirdQuartile =(float) array[(3 * temp) /2];
					return thirdQuartile;
				}
			}
		else
			{
				if(temp % 2 == 0 )
					{
						thirdQuartile = (float) (array[(3 * temp) / 2] + array[((3 * temp) / 2) + 1]) / 2;
						return thirdQuartile;
					}
				else
					{
						thirdQuartile = (float) array[((3 * temp) / 2) + 1];
						return thirdQuartile;
					}	
			}

	}

}

// Standard Deviation Function
float standard_deviation(int array[], int arraySize)
{
    float sum_deviation=0.0;
	float mymean= mean(array, arraySize);
    int i;
	float stdev;
    for(i = 0; i < arraySize; ++i)
	{
		sum_deviation+=(array[i]-mymean)*(array[i]-mymean);
	}
	stdev = sqrt(sum_deviation/arraySize); 
    return stdev;          
}

void z_test(int array[], int arraySize)
{
	int temp = 0; /* counter*/
	int z_testArray[arraySize];
	float mymean = mean(array, arraySize);
	float mystdev = standard_deviation(array, arraySize);
	int i, j ;
	for(i = 0; i < arraySize; i++)
	{
		if((fabs(array[i] - mymean) / mystdev) > 3)
		{
			temp += 1;
		}
	}
	if( temp == 0)
	{
		printf("There are no outliers");
	}
	else{
		for(i = 0; i < arraySize; i++)
		{
			if((fabs(array[i] - mymean) / mystdev) > 3)
			{
				for( j = 0; j < temp; j++)
				{
					z_testArray[j] = array[i];
				}
			}
		}
		printf("Outliers: ");
		for( j = 0; j < temp; j++)
		{
			printf("%2d ,", z_testArray[j]);
		}
	}
}
		
		
		
		