package com.teamProject.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.teamProject.DTO.reportDTO;

public interface reportMapper {


	@Insert ("insert into REPORTPOST values(#{postNum},#{reason})")
	public int insertReport(reportDTO report);

	@Update("UPDATE POST SET POSTREPORT = POSTREPORT + 1 WHERE POSTNUM = #{postNum}")
	void updateReport(reportDTO report);
	
	@Select("SELECT * FROM REPORTPOST WHERE POSTNUMBER = #{postNum}")
	ArrayList<reportDTO> reportList(int postNum);

}
