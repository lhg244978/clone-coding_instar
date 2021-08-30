package com.teamProject.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.teamProject.DTO.messageDTO;
import com.teamProject.DTO.msgListDTO;

public interface msgMapper {

	String roomCheck_send(HashMap<String, String> map);

	String roomCheck_recive(HashMap<String, String> map);

	int creatChatRoom_send(HashMap<String, String> map);

	int creatChatRoom_recive(HashMap<String, String> map);

	ArrayList<messageDTO> getMsg(HashMap<String, String> map);

	int saveMsg_getNum();

	int saveMsg(messageDTO msg);

	ArrayList<msgListDTO> setChatRoom(String loginId);
	
	void chkMsg(HashMap<String, String> map);

	int getMsgCount(messageDTO msg);


	int getMsgCount2(msgListDTO msgList);

	String getTime(messageDTO msg);

	String getHistoryTime(msgListDTO msgList);

	String getHistoryTime(HashMap<String, String> map);

	



}
