package com.zyiot.test;

public class Random {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int[] person = new int[10];
		int[] onDuty = new int[20];
		for(int i=0;i<person.length;i++){
			person[i] = i+1;
		}
		for(int i=0;i<onDuty.length;i++){
			onDuty[i] = i+1;
		}
		 int[] aaa = randomCommon(1,21,18);
		 System.out.println();
		 for(int i=0;i<aaa.length;i++){
				System.out.print(aaa[i]+",");
		}
	}
	
	public static int[] randomCommon(int min, int max, int n){  
	    if (n > (max - min + 1) || max < min) {  
	           return null;  
	       }  
	    int[] result = new int[n];  
	    int count = 0;  
	    while(count < n) {  
	        int num = (int) (Math.random() * (max - min)) + min;  
	        boolean flag = true;  
	        for (int j = 0; j < n; j++) {  
	            if(num == result[j]){  
	                flag = false;  
	                break;  
	            }  
	        }  
	        if(flag){  
	            result[count] = num;  
	            count++;  
	        }  
	    }  
	    return result;  
	}  

}
