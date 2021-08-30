package com.teamProject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.teamProject.DTO.reportDTO;
import com.teamProject.mapper.reportMapper;

@Service
public class reportService {

	@Autowired 
	reportMapper mapper; 
	
	ModelAndView mav;
	
	public ModelAndView report(reportDTO report) {
		// TODO Auto-generated method stub
		mav= new ModelAndView();
		//신고테이블에 추가
		mapper.insertReport(report);
		
		//post 테이블에 신고수 추가
		mapper.updateReport(report);
		
		mav.setViewName("redirect:boardList");
		
		return mav;
	}
	
	public String reporting(reportDTO report) {
		String reportResult = null;
		//신고테이블에 추가
		int insertResult = mapper.insertReport(report);
		
		//post 테이블에 신고수 추가
		mapper.updateReport(report);
		if(insertResult > 0) {
			reportResult = "OK";
		} else {
			reportResult = "NO";
		}
		return reportResult;
	}
	

	public ArrayList<reportDTO> reportReason(int postNum) {
		ArrayList<reportDTO> reportList = mapper.reportList(postNum);
		return reportList;
	}

	

	
	
}
