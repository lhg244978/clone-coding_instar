package com.teamProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.teamProject.DTO.reportDTO;
import com.teamProject.service.reportService;



@Controller
public class reportController {
	
	@Autowired
	reportService service;
	
	ModelAndView mav;
	
	@RequestMapping(value = "/report" )
	ModelAndView report(reportDTO report) {
		System.out.println("report");
		mav = service.report(report);
		return mav;
	}
	
	@RequestMapping(value = "/reporting" )
	public @ResponseBody String reporting(String reason, int postNum) {
		reportDTO report = new reportDTO();
		report.setPostNum(postNum);
		report.setReason(reason);
		System.out.println("report");
		String reportResult = service.reporting(report);
		return reportResult;
	}
	
	@RequestMapping(value = "/reportReason")
	public @ResponseBody ArrayList<reportDTO> reportReason(int postNum){
		System.out.println("/reportReason");
		ArrayList<reportDTO> reportList = service.reportReason(postNum);
		System.out.println("reportList : " + reportList);
		return reportList;
	}
	
}
