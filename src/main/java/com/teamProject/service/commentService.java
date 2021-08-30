package com.teamProject.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamProject.DTO.comment_CommentsDTO;
import com.teamProject.DTO.commentsDTO;
import com.teamProject.DTO.likeCommentsDTO;
import com.teamProject.DTO.likePostDTO;
import com.teamProject.mapper.boardMapper;
import com.teamProject.mapper.commentMapper;
import com.teamProject.mapper.memberMapper;

@Service
public class commentService {
	@Autowired
	commentMapper commentMapper;
	
	@Autowired
	boardMapper boardMapper;
	
	@Autowired
	HttpSession session;
	
	public ArrayList<commentsDTO> postComment(int postNum, int page)  {
		// TODO Auto-generated method stub
		String commentChk = commentMapper.commentChk(postNum);
		System.out.println("commentChk:::::"+commentChk);
		ArrayList<commentsDTO> list = new ArrayList<commentsDTO>() ;
		String logId = (String)session.getAttribute("loginId");
		
		System.out.println("page:::"+page);
		
		if(!commentChk.equals("0")) {
			if(page == 1) {
				list = commentMapper.postComment(postNum);
			}else if(page == 2) {				
				list = commentMapper.postCommentLike(postNum);
			}
		System.out.println(list.get(0).getCommentTimeSet());
		
		for (int i = 0; i < list.size(); i++) {
			String writer = list.get(i).getCommentWriter();
			int commentNum = list.get(i).getCommentNum();
			String profile = boardMapper.postWriterProfile(writer);
			list.get(i).setCommentNickname(commentMapper.commentNickName(writer));
			list.get(i).setCommentWriterProfile(profile);
			
			likeCommentsDTO likeCommentsDTO = new likeCommentsDTO();
			likeCommentsDTO.setCommentNum(list.get(i).getCommentNum());
			likeCommentsDTO.setUserId(logId);
			list.get(i).setLikeComments(commentMapper.likeCommentChk(likeCommentsDTO));
			list.get(i).setLikeCommentCount(commentMapper.commentLikeCount(list.get(i).getCommentNum()));
			
			String contentHr = list.get(i).getCommentContent();
			contentHr=contentHr.replaceAll("\n", "<br>");
			list.get(i).setCommentContent(contentHr);
			

			String comment_CommentChk = commentMapper.comment_CommentChk(commentNum);
			if(!comment_CommentChk.equals("0")){
			ArrayList<comment_CommentsDTO> comment_comment = commentMapper.comment_Comments(commentNum);
			for (int j = 0; j < comment_comment.size(); j++) {
				String c_CWriter = comment_comment.get(j).getComment_CommentWriter();
				comment_comment.get(j).setComment_CommentNickName(commentMapper.commentNickName(c_CWriter));		
				list.get(i).setComment_comment(comment_comment);				
			}

			}
			
		}
		
		
		}
	


		
		
		
		return list;
	}


	public String commentInsert(commentsDTO dto) {
		// TODO Auto-generated method stub
		String result = "";
		dto.setCommentNum(commentMapper.maxCommentNum()+1);
		dto.setCommentWriter((String)session.getAttribute("loginId"));
		int insert = commentMapper.commentInsert(dto);
		System.out.println(insert);
		if (insert>0) {
			result="ok";
		}else {
			result = "no";
		}
		
		return result;
	}


	public ArrayList<comment_CommentsDTO> insertComent_Comment(comment_CommentsDTO dto) {
		// TODO Auto-generated method stub
	
		int comment_CommentNum = commentMapper.maxCCommentNum();
	
		String comment_CommentWriter = (String) session.getAttribute("loginId");
		
		dto.setComment_CommentNum(comment_CommentNum);
		
		dto.setComment_CommentWriter(comment_CommentWriter);
		System.out.println(dto.toString());
		System.out.println("11111");
		
		int insert = commentMapper.insertComent_Comment(dto);
		
		
		ArrayList<comment_CommentsDTO> result = null ;
		if(insert > 0 ) {
		result= commentMapper.comment_Comments(dto.getComment_CommentNum());
		for (int i = 0; i < result.size(); i++) {
			String contentHr = result.get(i).getComment_CommentContent();
			contentHr=contentHr.replaceAll("\n", "<br>");
			result.get(i).setComment_CommentContent(contentHr);
		}
		}
		
		
		
		return result;
	}


	public String commentLike(int commentNum) {
		String loginId= (String) session.getAttribute("loginId");
		System.out.println(loginId);
		String result = "";
		likeCommentsDTO likeComments = new likeCommentsDTO();
		likeComments.setCommentNum(commentNum);
		likeComments.setUserId(loginId);
		String chk = commentMapper.likeCommentChk(likeComments);
		System.out.println("chk::::::::"+chk);
		if(chk == null) {
			chk = "";
		}
		if(chk.equals(loginId)) {
		
		result = "N";			
		commentMapper.deleteLick(likeComments);
		}else{
			commentMapper.insertLick(likeComments);
			result = "OK"	;			
		}
		
		
		
		return result;
	}
	
	public String commentWrite(commentsDTO commentsDTO) {
		String result = "NO";
		int Iresult = commentMapper.commentWrite(commentsDTO);
		if(Iresult > 0) {
			result = "OK";
		}
		return result;
	}
	
	public String commentDelete(int commentNum) {
		String result = "NO";
		String userId = commentMapper.commentUserId(commentNum);
		commentMapper.comment_CommentDelete(commentNum);
		int Iresult = commentMapper.commentDelete(commentNum);
		if(userId != null) {
			likeCommentsDTO likeComments = new likeCommentsDTO();
			likeComments.setCommentNum(commentNum);
			likeComments.setUserId(userId);			
			commentMapper.deleteLick(likeComments);
		}
		if(Iresult > 0) {
			result = "OK";
		}
		return result;
	}

	public int maxCommentNum() {
		int result = commentMapper.maxCommentNum();
		return result;
	}

	public int maxCCommentNum() {
		int result = commentMapper.maxCCommentNum();
		return result;
	}

	public ArrayList<comment_CommentsDTO> showCC(int commentNum) {
		ArrayList<comment_CommentsDTO> showCC = commentMapper.showCC(commentNum);		
		System.out.println("대댓글 리스트" + showCC);
		return showCC;
	}


	public String insertCCCon(comment_CommentsDTO comment_CommentsDTO) {
		String result = "NO";
		int insertResult = commentMapper.insertCCCon(comment_CommentsDTO);
		if(insertResult > 0) {
			result = "OK";
		}
		return result;
	}
	
	public ArrayList<commentsDTO> getComments(int postNum) {
		ArrayList<commentsDTO> getComments = commentMapper.getComments(postNum);
		System.out.println("이 게시글의 댓글정보" + getComments); 
		return getComments;
	}
	
	public String deleteCCCon(int comment_CommentNum) {
		String result = "NO";
		int Iresult = commentMapper.deleteCCCon(comment_CommentNum);
		if(Iresult > 0) {
			result = "OK";
		}
		return result;
	}




}
