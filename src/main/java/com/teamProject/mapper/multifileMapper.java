package com.teamProject.mapper;
	
import java.util.ArrayList;

import org.apache.ibatis.annotations.Select;

import com.teamProject.DTO.multiFileDTO;


public interface multifileMapper {
	@Select("SELECT * FROM MULTIFILE WHERE POSTNUM=#{postnum} ")
	ArrayList<multiFileDTO> getThumbnail(int postnum);
	
	

	@Select("SELECT * FROM MULTIFILE WHERE POSTNUM=#{postnum} ")
	ArrayList<multiFileDTO> saveThumbnail(int postnum);
	

}
