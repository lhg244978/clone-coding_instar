package com.teamProject.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Select;

import com.teamProject.DTO.followDTO;
import com.teamProject.DTO.memberDTO;

public interface friendsMapper {

	ArrayList<followDTO> getNickName(String userId);

	ArrayList<followDTO> getReason(HashMap<String, String> map);

	int getReasonCount(HashMap<String, String> map);

	ArrayList<followDTO> getFollower(String userId);

	ArrayList<followDTO> getFollowing(String userId);

	ArrayList<followDTO> getF4f(String userid);

	ArrayList<followDTO> getUnF4f(String userid);

	int unFollow(HashMap<String, String> map);
	
	int Follow(HashMap<String, String> map);

	ArrayList<followDTO> newgetFollower(String userId);
	
	@Select("SELECT COUNT(*) FROM FOLLOW WHERE FOLLOWING=#{userid}")
	int fwCount(String userid);
	
	@Select("SELECT COUNT(*) FROM FOLLOW WHERE FOLLOWER=#{userid}")
	int fCount(String userid);

	memberDTO getUserInfo(String userId);

	String name(String following);


	
	
	
}
