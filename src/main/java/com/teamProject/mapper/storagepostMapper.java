package com.teamProject.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Select;

import com.teamProject.DTO.storagePostDTO;


public interface storagepostMapper {
	@Select ("SELECT * FROM STORAGEPOST WHERE USERID=#{nickname} ORDER BY SAVETIME ASC")
	ArrayList<storagePostDTO> savepostList(String nickname);

}
