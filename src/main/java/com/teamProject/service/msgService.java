package com.teamProject.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamProject.DTO.messageDTO;
import com.teamProject.DTO.msgListDTO;
import com.teamProject.mapper.msgMapper;
@Service
public class msgService {
	@Autowired
	private msgMapper msgMapper;
	@Autowired
	private HttpSession session;
	
	@SuppressWarnings("unchecked")
	public ArrayList<messageDTO> getMsg(String send, String recive) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mynick",send);
		map.put("yournick",recive);
		

		if(send==recive) {
			return null;
		}else {
			String roomCheck_send = msgMapper.roomCheck_send(map);
			
			String roomCheck_recive = msgMapper.roomCheck_recive(map);
			
			if(roomCheck_send==null) {
				int creatChatRoom_send =msgMapper.creatChatRoom_send(map);
				System.out.println("creatChatRoom_send:"+creatChatRoom_send);
		}		
			
			if(roomCheck_recive==null) {
				int creatChatRoom_recive =msgMapper.creatChatRoom_recive(map);
				System.out.println("creatChatRoom_recive:"+creatChatRoom_recive);
		}	
			System.out.println("error3:");
			//채팅방의 내용을 가져오는 것,
			ArrayList<messageDTO> list = msgMapper.getMsg(map);
			/*
			 * private String msgsenderNick;
			 * private String msgrecipientNick;
			 */
			
			msgMapper.chkMsg(map);
			return list;	
		}			
	}
	public String saveMsg(messageDTO msg) {
		
		String result = "NO";
		msg.setMsgnum(msgMapper.saveMsg_getNum()+1);
		int check = msgMapper.saveMsg(msg);
		if(check>0) {		
			result = msgMapper.getTime(msg);			
		}
		return result;
	}
		
	public ArrayList<msgListDTO> get_ChatRoom(String loginId) {
		
		ArrayList<msgListDTO> chatRoom =msgMapper.setChatRoom(loginId);
		for (int i = 0; i < chatRoom.size(); i++) {
			int time=0;
			String str = "";
			int cal;
			msgListDTO msgList= chatRoom.get(i);
			msgList.setMynick(loginId);
			msgList.setCheckCount(msgMapper.getMsgCount2(msgList));
			HashMap<String, String> map = new HashMap<String,String>();
			map.put("yournick", msgList.getYournick());
			map.put("mynick", loginId);
			String getTime = msgMapper.getHistoryTime(map);
			if(getTime ==null) {
				msgList.setHistoryTime(str);
			}else {
				time = Integer.parseInt(getTime);
				if(time>=10080) {
					cal = time/10080;
					str = cal+"주전";
				}else if(time>=1440) {
					cal = time/1440;
					str = cal+"일전";
				}else if(time>=60) {
					cal = time/60;
					str = cal+"시간전";
				}else if(time>=1) {
					cal = time/1;
					str = cal+"분전";
				}else if(time==0) {
					str="방금전";
				}
				msgList.setHistoryTime(str);
			}
			
			
			
			chatRoom.set(i, msgList);			
		}
		
		return chatRoom;
	}
	public String saveMsg_admin(messageDTO msg) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		String send = msg.getMsgsender();
		String recive = msg.getMsgrecipient();
		
		map.put("mynick",send);
		map.put("yournick",recive);
		

		if(send==recive) {
			return null;
		}else {
			String roomCheck_send = msgMapper.roomCheck_send(map);
			
			String roomCheck_recive = msgMapper.roomCheck_recive(map);
			
			if(roomCheck_send==null) {
				int creatChatRoom_send =msgMapper.creatChatRoom_send(map);
				System.out.println("creatChatRoom_send:"+creatChatRoom_send);
		}		
			
			if(roomCheck_recive==null) {
				int creatChatRoom_recive =msgMapper.creatChatRoom_recive(map);
				System.out.println("creatChatRoom_recive:"+creatChatRoom_recive);
		}	
		
		String result = "NO";
		msg.setMsgnum(msgMapper.saveMsg_getNum()+1);
		int check = msgMapper.saveMsg(msg);
		if(check>0) {		
			result = msgMapper.getTime(msg);			
		}
		return result;
	}
	
	
	
	/*
	 * public int getMsgCount(messageDTO msg) {
	 * System.out.println("getMsgCountService"); int result =
	 * msgMapper.getMsgCount(msg); return result; }
	 */

	}
}
