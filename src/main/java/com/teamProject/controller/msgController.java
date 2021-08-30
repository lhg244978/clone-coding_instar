package com.teamProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamProject.DTO.messageDTO;
import com.teamProject.DTO.msgListDTO;
import com.teamProject.service.msgService;

@Controller
public class msgController {
	@Autowired
	private msgService msgService;
	
	
	@RequestMapping(value="/directmsg")
	public String directmsg() {
		
		return "/msg/directmsg";
	}
	@RequestMapping(value="/getMsg")
	public @ResponseBody ArrayList<messageDTO> getMsg(@RequestParam("send") String send,@RequestParam("recive") String recive){
		System.out.println("getMsg send : "+send+"recive : "+recive);
		ArrayList<messageDTO> list = msgService.getMsg(send,recive);

		if(list.size()==0) {
			return null;
		}else {
			return list;			
		}
	}
	
	@RequestMapping(value="/saveMsg")
	public @ResponseBody String saveMsg(messageDTO msg) {
		
		String result = msgService.saveMsg(msg);
		return result;
	}
	
	@RequestMapping(value="/saveMsg_admin")
	public @ResponseBody String saveMsg_admin(messageDTO msg) {
		
		String result = msgService.saveMsg_admin(msg);
		return result;
	}
	
	@RequestMapping(value="/get_ChatRoom")
	public @ResponseBody ArrayList<msgListDTO> get_ChatRoom(@RequestParam("loginId") String loginId){
		
		ArrayList<msgListDTO> chatRoomList = msgService.get_ChatRoom(loginId);
		return chatRoomList;
	}

	
	/*
	 * @RequestMapping(value="/getMsgCount") public @ResponseBody int
	 * getMsgCount(messageDTO msg){ System.out.println("getMsgCount"); int getCount
	 * = msgService.getMsgCount(msg); return getCount; }
	 */
	
	
	
	
	
}
