package com.teamProject.DTO;

public class msgListDTO {
	private String mynick;
	private String yournick;
	private String roomName;
	private int checkCount;
	private String historyTime;
	
	public int getCheckCount() {
		return checkCount;
	}
	public void setCheckCount(int checkCount) {
		this.checkCount = checkCount;
	}
	public String getMynick() {
		return mynick;
	}
	public void setMynick(String mynick) {
		this.mynick = mynick;
	}
	public String getYournick() {
		return yournick;
	}
	public void setYournick(String yournick) {
		this.yournick = yournick;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getHistoryTime() {
		return historyTime;
	}
	public void setHistoryTime(String historyTime) {
		this.historyTime = historyTime;
	}
	
}
