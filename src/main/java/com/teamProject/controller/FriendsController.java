package com.teamProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.teamProject.DTO.followDTO;
import com.teamProject.DTO.memberDTO;
import com.teamProject.service.FriendsService;

@Controller
public class FriendsController {

	private ModelAndView mav;
	@Autowired
	private FriendsService FriendsService;
	
	@RequestMapping(value="/friends")
	   public ModelAndView friends(int checkNum) {
	      mav = FriendsService.friends(checkNum);
	      return mav;
	   }
	
	@RequestMapping(value="/getNickName",produces = "application/json; charset=utf8")
	public @ResponseBody ArrayList<followDTO> getNickName(@RequestParam("userId") String userId){
		
		ArrayList<followDTO> list = FriendsService.getNickName(userId);
		return list;
	}
	
	@RequestMapping(value="/getFollower",produces = "application/json; charset=utf8")
	public @ResponseBody ArrayList<followDTO> getFollower(@RequestParam("userId") String userId){	
		
		ArrayList<followDTO> list = FriendsService.getFollower(userId);
		return list;
	}
	
	@RequestMapping(value="/getFollowing",produces = "application/json; charset=utf8")
	public @ResponseBody ArrayList<followDTO> getFollowing(@RequestParam("userId") String userId){	
		
		ArrayList<followDTO> list = FriendsService.getFollowing(userId);
		return list;
	}
	
	@RequestMapping(value="/getReason",produces = "application/json; charset=utf8")
	public @ResponseBody String getReason(@RequestParam("yourId") String yourId,@RequestParam("myId") String myId){
		
		String list = FriendsService.getReason(yourId,myId);
		return list;
	}
	
	@RequestMapping(value="/getReasonCount",produces = "application/text; charset=utf8")
	public @ResponseBody String getReasonCount(@RequestParam("yourId") String yourId,@RequestParam("myId") String myId){
		
		String result = FriendsService.getReasonCount(yourId,myId);
		System.out.println(result);
		return result;
	}
	
	@RequestMapping(value="/getF4f",produces = "application/json; charset=utf8")
	public @ResponseBody ArrayList<followDTO> getF4f(@RequestParam("userId") String userId){
		
		ArrayList<followDTO> list = FriendsService.getF4f(userId);
		return list;
	}
	
	@RequestMapping(value="/getUnF4f",produces = "application/json; charset=utf8")
	public @ResponseBody ArrayList<followDTO> getUnF4f(@RequestParam("userId") String userId){
		
		ArrayList<followDTO> list = FriendsService.getUnF4f(userId);
		return list;
	}
	
	@RequestMapping(value="/unFollow",produces = "application/text; charset=utf8")
	public @ResponseBody String unFollow(@RequestParam("yourId") String yourId,@RequestParam("myId") String myId){
		
		String result = FriendsService.unFollow(yourId,myId);
		System.out.println(result);
		return result;
	}
	
	@RequestMapping(value="/follow",produces = "application/text; charset=utf8")
	public @ResponseBody String follow(@RequestParam("yourId") String yourId,@RequestParam("myId") String myId){
		
		String result = FriendsService.follow(yourId,myId);
		System.out.println(result);
		return result;
	}
	
	// 디엠창용
	@RequestMapping(value="/newgetFollower",produces = "application/json; charset=utf8")
	public @ResponseBody ArrayList<followDTO> newgetFollower(@RequestParam("userId") String userId){	
		
		ArrayList<followDTO> list = FriendsService.newgetFollower(userId);
		return list;
	}
	
	@RequestMapping(value="/getUserInfo")
	public @ResponseBody memberDTO getUserInfo(@RequestParam("userId") String userId) {
		memberDTO info = FriendsService.getUserInfo(userId);
		return info;
	}
	
}
