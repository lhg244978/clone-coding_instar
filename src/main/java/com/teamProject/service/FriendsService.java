package com.teamProject.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.teamProject.DTO.followDTO;
import com.teamProject.DTO.memberDTO;
import com.teamProject.mapper.friendsMapper;

@Service
public class FriendsService {

	private ModelAndView mav;
	@Autowired
	private friendsMapper friendsMapper;
	
	public ArrayList<followDTO> getNickName(String userId) {
		
		ArrayList<followDTO> list = friendsMapper.getNickName(userId);

		return list;
	}

	public ArrayList<followDTO> getFollower(String userId) {
		
		ArrayList<followDTO> list = friendsMapper.getFollower(userId);
		

		return list;
		
	}
	
	
	public ArrayList<followDTO> getFollowing(String userId) {
		
		ArrayList<followDTO> list = friendsMapper.getFollowing(userId);
		

		return list;
	}

	public String getReason(String yourId, String myId) {
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("yourId", yourId);
		map.put("myId", myId);
		ArrayList<followDTO> list = friendsMapper.getReason(map);
		String name = friendsMapper.name(list.get(0).getFollowing());
		String result ="님이 팔로우 합니다.";
		int count = friendsMapper.getReasonCount(map);
		count = count-1;
		if(count>=1) { 
			result = name+"님 외"+count+"명이 팔로우 중 입니다.";
		}else {
			result = name+"님이 팔로우 중 입니다.";
		}
		
		return result;
	}


	public String getReasonCount(String yourId, String myId) {
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("yourId", yourId);
		map.put("myId", myId);
		String result ="님이 팔로우 합니다.";
		int count = friendsMapper.getReasonCount(map);
		count = count-1;
		if(count>1) { 
			result = "님 외"+count+"명이 팔로우합니다.";
		}
		return result;
	}

	public ArrayList<followDTO> getF4f(String userid) {
		
		ArrayList<followDTO> list = friendsMapper.getF4f(userid);

		return list;
	}

	public ArrayList<followDTO> getUnF4f(String userid) {
		
		ArrayList<followDTO> list = friendsMapper.getUnF4f(userid);

		return list;
	}

	
	public String unFollow(String yourId, String myId) {
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("yourId", yourId);
		map.put("myId", myId);
		String list ="NO";
		int result = friendsMapper.unFollow(map);
		if(result>0) {
			list = "OK";
		}
		
		return list;
	}

	public String follow(String yourId, String myId) {
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("yourId", yourId);
		map.put("myId", myId);
		String list ="NO";
		int result = friendsMapper.Follow(map);
		if(result>0) {
			list = "OK";
		}
		return list;
	}
	
	public ArrayList<followDTO> newgetFollower(String userId) {
		
		ArrayList<followDTO> list = friendsMapper.newgetFollower(userId);
		

		return list;
	}

	public ModelAndView friends(int checkNum) {
		mav = new ModelAndView();
	      
	    mav.addObject("checkNum", checkNum);
	    mav.setViewName("/friends/friends");
	    return mav;
	}

	public memberDTO getUserInfo(String userId) {
		memberDTO info = friendsMapper.getUserInfo(userId);
		
		return info;
	}



}
