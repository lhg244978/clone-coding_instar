package com.teamProject.util;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamProject.DTO.followDTO;
import com.teamProject.DTO.messageDTO;
import com.teamProject.mapper.friendsMapper;
import com.teamProject.mapper.msgMapper;

public class directMsgHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	@Autowired
	private friendsMapper friendsMapper;
	@Autowired
	private msgMapper msgMapper;
	
	@Override // 입장
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
			
		
		sessionList.add(session);
		Map<String,Object> map = session.getAttributes();
		String loginId = (String)map.get("loginId");
		if(loginId==null) {
			System.out.println("아이디 널 ");
			sessionList.remove(session);
		}

		//loginId를 팔로우 하고 있는 친구들한테는 메세지를 날려야해. online이라고
		ArrayList<followDTO> onlineMessageList = friendsMapper.getFollower(loginId);
		 for (WebSocketSession sess : sessionList) {
			 Map<String,Object> sessionMap = sess.getAttributes();
			 String userId = (String)sessionMap.get("loginId");
			 System.out.println("현재 접속중인 세션 :"+userId);
			 for (int i = 0; i < onlineMessageList.size(); i++) {
				if(onlineMessageList.get(i).getFollower().equals(userId)) {
					

					String checkType ="online";
					String onlineId = onlineMessageList.get(i).getFollower();
					String chatData = checkType+"/"+loginId+"/"+onlineId; //online//deckk1//리스트
					sess.sendMessage(new TextMessage(chatData));
					//deckk1님이 팔로우를 하신 deckk2 님이 online 중입니다.
					
					}
					
			 	}
		 	}
		}
	

	
	
	@Override // 채팅
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 나의 정보 이름,채팅룸세션
		System.out.println("웹소켓 메세지 처리장치");
		/*
		 * Map<String,Object> map = session.getAttributes();// 나의 세션값
		 * 
		 * @SuppressWarnings("unchecked") //채팅방 리스트 세션 ArrayList<msgListDTO> chatRoom =
		 * (ArrayList<msgListDTO>) map.get("chatRoom"); for (int i = 0; i <
		 * chatRoom.size(); i++) { System.out.println((chatRoom.get(i).getRoomName()));
		 * }
		 */
		//메세지정보
		ObjectMapper mapper = new ObjectMapper();
		messageDTO msg = mapper.readValue(message.getPayload(), messageDTO.class);
		String checkType = msg.getMsgtype(); //alse_online
		String sendder = msg.getMsgsender(); //deckk2
		String recipient = msg.getMsgrecipient();//deckk1
		String content = msg.getMsgcontent();
		int check = msgMapper.getMsgCount(msg);
		/*채팅시간처리부분*/
		String sendMsgTime = msg.getMsgtimeSet();
		/*알람시간처리부분*/
		int time=0,cal=0;
		String str = "";
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("yournick", recipient);
		map.put("mynick", sendder);
		String getTime = msgMapper.getHistoryTime(map);
		if(getTime !=null) {
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
		}
		
		
		/*보낼 채팅메세지*/
		String chatData = checkType+"/"+sendder+"/"+recipient+"/"+content+"/"+check+"/"+sendMsgTime+"/"+str; //보낼데이터

		
		if(checkType.equals("chat")) {//deckk1
			for (WebSocketSession sess : sessionList) {//접속자의 모든세션정보
				Map<String,Object> newMap = sess.getAttributes(); //모든정보를 newMap에 저장.
				if(recipient.equals((String)newMap.get("loginId"))) {// 				

					sess.sendMessage(new TextMessage(chatData));
				}						
			}
		}else if(checkType.equals("alse_online")) {
			for (WebSocketSession sess : sessionList) {//접속자의 모든세션정보
				Map<String,Object> newMap = sess.getAttributes(); //모든정보를 newMap에 저장.
				System.out.println(recipient+" ★" +(String)newMap.get("loginId"));
				if(recipient.equals((String)newMap.get("loginId"))) {// 

					sess.sendMessage(new TextMessage(chatData));
				}						
			}
		}

	}
	

	@Override // 종료
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String,Object> map = session.getAttributes();
		String loginId = (String)map.get("loginId");

		//loginId를 팔로우 하고 있는 친구들한테는 메세지를 날려야해. online이라고
		ArrayList<followDTO> offlineMessge = friendsMapper.getFollower(loginId);
		 for (WebSocketSession sess : sessionList) {
			 Map<String,Object> sessionMap = sess.getAttributes();
			 String userId = (String)sessionMap.get("loginId");
			 for (int i = 0; i < offlineMessge.size(); i++) {
				 if(offlineMessge.get(i).getFollower().equals(userId)) {

					String checkType ="offline";
					String offlineId = offlineMessge.get(i).getFollower();
					String chatData = checkType+"/"+loginId+"/"+offlineId;
					sess.sendMessage(new TextMessage(chatData));
					
				}
					
			}
		 }
		sessionList.remove(session);
	}

}

