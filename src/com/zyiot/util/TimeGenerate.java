package com.zyiot.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class TimeGenerate {
	public static String generator(){
		 Calendar now = Calendar.getInstance(); 
		String year= now.get(Calendar.YEAR)+"";
		String month=(now.get(Calendar.MONTH) + 1)<10?"0"+(now.get(Calendar.MONTH) + 1):(now.get(Calendar.MONTH) + 1)+"";
		String day=now.get(Calendar.DAY_OF_MONTH)<10?"0"+now.get(Calendar.DAY_OF_MONTH):now.get(Calendar.DAY_OF_MONTH)+"";
		String hour=now.get(Calendar.HOUR_OF_DAY)<10?"0"+now.get(Calendar.HOUR_OF_DAY):now.get(Calendar.HOUR_OF_DAY)+"";
		String minute=now.get(Calendar.MINUTE)<10?"0"+now.get(Calendar.MINUTE):now.get(Calendar.MINUTE)+"";
		String second=now.get(Calendar.SECOND)<10?"0"+now.get(Calendar.SECOND):now.get(Calendar.SECOND)+"";
		return year+month+day+hour+minute+second+randomNum();
	}
	public static String  generator1(){
	    Date d = new Date();  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
        String dateNowStr = sdf.format(d);  
        return dateNowStr;
}	
	public static String  generator2(){
    Date d = new Date();  
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    String dateNowStr = sdf.format(d);  
    return dateNowStr;
}
	public static int randomNum(){
		return (int)(Math.random()*9000+1000);
	}
	public static void main(String[] args) {
		System.out.println(generator2());
	
	}
}
