package com.forum.page;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FloorTimeHandle {
	public String handle(String time){
		Date now=new Date();
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String output = null;
		try {
			Date before=dateFormat.parse(time);
			String nowTime=dateFormat.format(now);
			String endTime=dateFormat.format(before);
			Date start=dateFormat.parse(endTime);
			Date end=dateFormat.parse(nowTime);
			long interval=end.getTime()-start.getTime();
			double second=interval*1.0/1000;
			double minute=interval*1.0/(1000*60);
			double hour=interval*1.0/(1000*60*60);
			if(second<60){
				output=""+(int)second+"秒前";
			}else if(minute<60){
				output=""+(int)minute+"分钟前";
			}else if(hour<24){
				output=""+(int)hour+"小时前";
			}else{
				output=endTime;
			}
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return output;
	}
}
