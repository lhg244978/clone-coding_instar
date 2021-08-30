package com.teamProject.controller;



import java.io.IOException;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamProject.DTO.memberDTO;
import com.teamProject.mapper.memberMapper;
import com.teamProject.service.memberService;



@Controller
public class memberController {
	@Autowired
	private HttpSession session;
	private ModelAndView mav;
	@Inject
	private JavaMailSender mailSender;
	@Autowired
	private memberMapper membermapper;
	
	
	@Autowired
	private memberService service;
	
	
	@Autowired
	private memberService memberService;
@RequestMapping(value = "/memberJoinForm")
public String memberJoinForm() {
	System.out.println("memberJoinForm");
	return "/member/memberJoin";
}

@RequestMapping (value = "/memberLoginForm")
public String memberLoginForm() {
	System.out.println("memberLoginForm");
	return "/member/memberLogin";
}
@RequestMapping(value = "/memberLogin")
public ModelAndView memberLogin(memberDTO memberdto,RedirectAttributes ra) {
	System.out.println("/memberLogin");
	mav = service.memberLogin(memberdto,ra);
	return mav;
}

@RequestMapping(value="/memberLogout")
public String memberLogout() {
	session.invalidate();
	return "/member/logout";
}

@RequestMapping(value = "/memberJoin")
public ModelAndView memberJoin(memberDTO memberdto, RedirectAttributes ra) throws IllegalStateException, IOException {
	System.out.println("/memberJoin");
	System.out.println(memberdto);
	mav = service.memberJoin(memberdto,ra);
	return mav;
}

@RequestMapping(value = "/joinMailSending")
public @ResponseBody String joinMailSending(HttpServletRequest request) {
   String setFrom = "team.geunstargram@gmail.com"; // 보내는사람(생략하면 정상작동x)
   String userId = request.getParameter("userId"); // 받는 사람 이메일
   String title = "[근스타그램] 회원가입 인증번호가 발송되었습니다."; // 제목
   String checkNum = (int) ((Math.random() * 999999) + 100000) + "";
   String content = "인증번호는 [ " + checkNum + " ]입니다. 회원가입을 위해 인증번호를 정확히 입력해 주시기 바랍니다."; // 내용

   System.out.println("인증번호입니다" + checkNum);
   try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

      messageHelper.setFrom(setFrom); // 보내는사람 생략하거나 하면 정상작동을 안함
      messageHelper.setTo(userId); // 받는사람 이메일
      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
      messageHelper.setText(content); // 메일 내용

      mailSender.send(message);
   } catch (Exception e) {
      System.out.println(e);
   }

   return checkNum;

}


@RequestMapping(value="/memberPwSearch")
public String memberPwSearch(){
	System.out.println("/memberPwSearch");
	return "/member/memberPwSearch";
}
@RequestMapping(value="/pwSearch1")
	public ModelAndView pwSearch1(@RequestParam("nickName")String nickName) {
	mav = new ModelAndView();
	memberDTO memberdto = new memberDTO();
	memberdto.setNickName(nickName);
	String emailValue = membermapper.userIdSearch(memberdto);
	System.out.println("emailValue:"+emailValue);
	memberdto.setUserId(emailValue);
	mav.addObject("memberdto",memberdto);
	mav.setViewName("member/pwSearch1");
	return mav;
}
@RequestMapping(value = "/mailSending")
public @ResponseBody String mailSending(HttpServletRequest request) {
   String setFrom = "team.geunstargram@gmail.com"; // 보내는사람(생략하면 정상작동x)
   String userId = request.getParameter("userId"); // 받는 사람 이메일
   System.out.println("userId:"+userId);
   String title = "[근스타그램] 비밀번호 찾기 인증번호가 발송되었습니다."; // 제목
   String checkNum = (int) ((Math.random() * 999999) + 100000) + "";
   String content = "인증번호는 [ " + checkNum + " ]입니다. 인증번호 입력후 비밀번호를 찾으시길 바랍니다."; // 내용

   System.out.println("인증번호입니다" + checkNum);
   try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

      messageHelper.setFrom(setFrom); // 보내는사람 생략하거나 하면 정상작동을 안함
      messageHelper.setTo(userId); // 받는사람 이메일
      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
      messageHelper.setText(content); // 메일 내용

      mailSender.send(message);
   } catch (Exception e) {
      System.out.println(e);
   }

   return checkNum;

}
@RequestMapping(value="/pwSearch2")
public ModelAndView pwSearch2(@RequestParam("userId")String userId) {
	System.out.println("pwSearch2");
	System.out.println("userId:"+userId);
	mav = new ModelAndView();
	memberDTO memberdto = new memberDTO();
	memberdto.setUserId(userId);
	String selectResult = membermapper.pwSearch(memberdto);
	System.out.println("selectResult:"+selectResult);
	memberdto.setUserPw(selectResult);
	System.out.println("memberdto:"+memberdto);
	mav.addObject("memberdto",memberdto);
	mav.setViewName("member/pwSearch2");
	return mav;
}

@RequestMapping(value ="/getUserNickName",produces = "application/text; charset=utf8")
public @ResponseBody String getUserNickName(memberDTO memberDTO) {

	String result = memberService.getUserNickName(memberDTO);
	return result;
}

@RequestMapping(value ="/getUserName",produces = "application/text; charset=utf8")
public @ResponseBody String getUserName(memberDTO memberDTO) {

	String result = memberService.getUserName(memberDTO);
	return result;
}

@RequestMapping(value ="/getUserProfile",produces = "application/text; charset=utf8")
public @ResponseBody String getUserProfile(memberDTO memberDTO) {

	String result = memberService.getUserProfile(memberDTO);
	return result;
}

@RequestMapping(value = "/goAdminPage")
public ModelAndView goAdminPage(@RequestParam("nickName") String nickName,@RequestParam(value = "page", defaultValue = "1") int page) {

	mav = service.goAdminPage(nickName,page);
	return mav;
}

@RequestMapping(value = "/personalReport")
public ModelAndView personalReport(@RequestParam("postWriter") String postWriter, @RequestParam("nickName") String nickName, @RequestParam(value = "page",defaultValue = "1") int page) {

	mav = service.personalReport(postWriter,nickName,page);
	return mav;
}

@RequestMapping(value = "/memberModify")
public ModelAndView memberModify(@RequestParam("nickName") String nickName) {
	System.out.println("/memberModify");

	mav = service.memberModify(nickName);
	return mav;
}


@RequestMapping(value = "/memberModifyProcess")
public ModelAndView memberModifyProcess(memberDTO memberdto) throws IllegalStateException, IOException {
	System.out.println("/memberModifyProcess");
	System.out.println(memberdto);
	mav = service.memberModifyProcess(memberdto);
	return mav;
}

@RequestMapping(value = "/memberPwModify")
public ModelAndView memberPwModify(@RequestParam("nickName") String nickName) {
	System.out.println("/memberPwModify");
	mav = service.memberPwModify(nickName);
	return mav;
}

@RequestMapping(value = "memberPwModifyProcess")
public ModelAndView memberPwModifyProcess(memberDTO memberdto) {
	System.out.println("/memberPwModifyProcess");
	mav = service.memberPwModifyProcess(memberdto);
	return mav;
}

@RequestMapping(value = "/changeMailSending")
public @ResponseBody String changeMailSending(HttpServletRequest request) {
   String setFrom = "team.geunstargram@gmail.com"; // 보내는사람(생략하면 정상작동x)
   String userId = request.getParameter("userId"); // 받는 사람 이메일
   System.out.println("userId:"+userId);
   String title = "[근스타그램] 아이디 변경 인증번호가 발송되었습니다."; // 제목
   String checkNum = (int) ((Math.random() * 999999) + 100000) + "";
   String content = "인증번호는 [ " + checkNum + " ]입니다. 인증번호 입력후 아이디를 변경하시기 바랍니다."; // 내용

   System.out.println("인증번호입니다" + checkNum);
   try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

      messageHelper.setFrom(setFrom); // 보내는사람 생략하거나 하면 정상작동을 안함
      messageHelper.setTo(userId); // 받는사람 이메일
      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
      messageHelper.setText(content); // 메일 내용

      mailSender.send(message);
   } catch (Exception e) {
      System.out.println(e);
   }

   return checkNum;

}
@RequestMapping(value = "/myPage")
public ModelAndView myPage(@RequestParam("userId") String userid) {
	System.out.println("myPage");
	mav = service.myPage(userid);
	
	return mav;	
}

@RequestMapping(value = "/otherPage")
public ModelAndView otherPage(@RequestParam("userId") String userid) {
	String loginId = (String) session.getAttribute("loginId");
	System.out.println("otherPage");
	mav = service.otherPage(userid,loginId);
	return mav;
}
	@RequestMapping(value = "/idCheck")
	public @ResponseBody String idCheck(String userId) {
		String result = service.idCheck(userId);
		return result;
	}

	@RequestMapping(value = "/nickNameCheck")
	public @ResponseBody String nickNameCheck(String nickName) {
		String result = service.nickNameCheck(nickName);
		return result;
	}



}

