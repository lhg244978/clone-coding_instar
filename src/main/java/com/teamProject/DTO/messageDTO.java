package com.teamProject.DTO;

import java.util.Date;

public class messageDTO {
	private String msgtype;
	private int msgnum;
	private String msgsender;
	private String msgsenderNick;
	private String msgrecipient;
	private String msgrecipientNick;
	private String msgcontent;
	private Date msgtime;
	private int msgcheck;
	private String msgtimeSet;

	
	
	public String getMsgtype() {
		return msgtype;
	}
	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}
	public int getMsgnum() {
		return msgnum;
	}
	public void setMsgnum(int msgnum) {
		this.msgnum = msgnum;
	}
	public String getMsgsender() {
		return msgsender;
	}
	public void setMsgsender(String msgsender) {
		this.msgsender = msgsender;
	}
	public String getMsgrecipient() {
		return msgrecipient;
	}
	public void setMsgrecipient(String msgrecipient) {
		this.msgrecipient = msgrecipient;
	}
	public String getMsgcontent() {
		return msgcontent;
	}
	public void setMsgcontent(String msgcontent) {
		this.msgcontent = msgcontent;
	}
	public Date getMsgtime() {
		return msgtime;
	}
	public void setMsgtime(Date msgtime) {
		this.msgtime = msgtime;
	}
	public int getMsgcheck() {
		return msgcheck;
	}
	public void setMsgcheck(int msgcheck) {
		this.msgcheck = msgcheck;
	}
	
	public String getMsgtimeSet() {
		return msgtimeSet;
	}
	public void setMsgtimeSet(String msgtimeSet) {
		this.msgtimeSet = msgtimeSet;
	}
	@Override
	public String toString() {
		return "messageDTO [msgnum=" + msgnum + ", msgsender=" + msgsender + ", msgrecipient=" + msgrecipient
				+ ", msgcontent=" + msgcontent + ", msgtime=" + msgtime + ", msgcheck=" + msgcheck + "]";
	}
	public String getMsgsenderNick() {
		return msgsenderNick;
	}
	public void setMsgsenderNick(String msgsenderNick) {
		this.msgsenderNick = msgsenderNick;
	}
	public String getMsgrecipientNick() {
		return msgrecipientNick;
	}
	public void setMsgrecipientNick(String msgrecipientNick) {
		this.msgrecipientNick = msgrecipientNick;
	}
	
}
