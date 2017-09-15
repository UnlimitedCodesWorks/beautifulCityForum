package com.forum.page;

public class PointChange {
	public String handle(int points){
		String title = null;
		if(points<5){
			title="山清水秀";
		}else if(points>=5&&points<15){
			title="湖光山色";
		}else if(points>=15&&points<30){
			title="沂水春风";
		}else if(points>=30&&points<50){
			title="渊渟岳峙";
		}else if(points>=50&&points<100){
			title="钟灵毓秀";
		}else if(points>=100&&points<200){
			title="高山流水";
		}else if(points>=200&&points<500){
			title="空谷幽兰";
		}else if(points>=500&&points<1000){
			title="高山仰止";
		}else if(points>=1000){
			title="陌上花开";
		}
			
		return title;
	}
}
