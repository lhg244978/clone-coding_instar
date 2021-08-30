package com.teamProject.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamProject.DTO.comment_CommentsDTO;
import com.teamProject.DTO.commentsDTO;
import com.teamProject.service.commentService;
import com.teamProject.service.memberService;

@Controller
public class commentController {

	@Autowired
	commentService service;
	
	@Autowired
	memberService memberService;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping (value = "/postComment")
	public @ResponseBody  ArrayList<commentsDTO> postComment (int postNum, @RequestParam(value= "page" ,defaultValue = "1")int page){
		System.out.println("postComment -----");

		ArrayList<commentsDTO> list = service.postComment(postNum,page);
	
		
		
		return list;
	}
	
	@RequestMapping (value = "/commentInsert")
	public @ResponseBody  String commentInsert (commentsDTO dto){
		System.out.println("commentInsert -----");
		
		String result = service.commentInsert(dto);
		
		
		
		return result;
	}
	
	@RequestMapping (value = "/insertComent_Comment")
	public @ResponseBody  ArrayList<comment_CommentsDTO> insertComent_Comment (comment_CommentsDTO dto){
		System.out.println("insertComent_Comment -----");
		
	ArrayList<comment_CommentsDTO> result = service.insertComent_Comment(dto);
		
		
		
		return result;
	}
	
	
	@RequestMapping (value = "/commentLike")
	public @ResponseBody String commentLike (int commentNum){
		System.out.println("commentLike -----");
		
		String result = service.commentLike(commentNum);
		
		
		
		return result;
	}
	
	// 모달창 댓글쓰기
		@RequestMapping(value = "/commentWrite")
		public @ResponseBody String commentWrite(int postNum, String commentContent, int commentSec) {
			commentsDTO commentsDTO = new commentsDTO();

			String loginId = (String) session.getAttribute("loginId");
			
			int maxCommentNum = service.maxCommentNum() + 1;
			commentsDTO.setCommentNum(maxCommentNum);
			commentsDTO.setPostNum(postNum);
			commentsDTO.setCommentWriter(loginId);
			commentsDTO.setCommentContent(commentContent.replace("\r\n","<br/>"));

			commentsDTO.setCommentSec(commentSec);
			System.out.println("댓글입력정보:" + commentsDTO);
			String result = service.commentWrite(commentsDTO);
			return result;
		}
		
		//모달창 댓글지우기
		@RequestMapping(value = "/commentDelete")
		public @ResponseBody String commentDelete(int commentNum) {
			String result = service.commentDelete(commentNum);
			return result;
		}
		
		// 모달창 대댓글 띄우기
		@RequestMapping(value ="/showCC")
		public @ResponseBody ArrayList<comment_CommentsDTO> showCC(int commentNum){
			ArrayList<comment_CommentsDTO> showCC = service.showCC(commentNum);
			for(int i = 0; i < showCC.size(); i++) {
				showCC.get(i).setComment_CommentNickName(memberService.idToNick(showCC.get(i).getComment_CommentWriter()));
			}

			return showCC;
		}
		
		// 모달창 대댓글 입력
		@RequestMapping(value="/insertCCCon")
		public @ResponseBody String insertCCCon(String comment_CommentContent,int commentNum) {
			String loginId = (String) session.getAttribute("loginId");
			int maxCCommentNum = service.maxCCommentNum() + 1;
			comment_CommentsDTO comment_CommentsDTO = new comment_CommentsDTO();
			comment_CommentsDTO.setCommentNum(commentNum);
			comment_CommentsDTO.setComment_CommentNum(maxCCommentNum);
			comment_CommentsDTO.setComment_CommentWriter(loginId);
			comment_CommentsDTO.setComment_CommentContent(comment_CommentContent);
			String result = service.insertCCCon(comment_CommentsDTO);
			return result;
		}
		
		@RequestMapping(value="/deleteCCCon")
		public @ResponseBody String deleteCCCon(int comment_CommentNum) {
			String result = service.deleteCCCon(comment_CommentNum);
			return result;
		}
}

