package com.forum.page;

public class LevelHandle {
	public int handle(int points){
		int level=1;
		if(points<5){
			level=1;
		}else if(points>=5&&points<15){
			level=2;
		}else if(points>=15&&points<30){
			level=3;
		}else if(points>=30&&points<50){
			level=4;
		}else if(points>=50&&points<100){
			level=5;
		}else if(points>=100&&points<200){
			level=6;
		}else if(points>=200&&points<500){
			level=7;
		}else if(points>=500&&points<1000){
			level=8;
		}else if(points>=1000){
			level=9;
		}
			return level;
	
	}
}

