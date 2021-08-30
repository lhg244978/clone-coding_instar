package com.teamProject.DTO;

import java.sql.Date;

public class comment_CommentsDTO {
	private int commentNum;
	private int comment_CommentNum;
	private String comment_CommentWriter;
	private String comment_CommentContent;
	private Date comment_CommentTime;
	private String comment_CommentTimeSet;
	private String comment_CommentNickName;
	
	
	
	
	public String getComment_CommentNickName() {
		return comment_CommentNickName;
	}
	public void setComment_CommentNickName(String comment_CommentNickName) {
		this.comment_CommentNickName = comment_CommentNickName;
	}
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public int getComment_CommentNum() {
		return comment_CommentNum;
	}
	public void setComment_CommentNum(int comment_CommentNum) {
		this.comment_CommentNum = comment_CommentNum;
	}
	public String getComment_CommentWriter() {
		return comment_CommentWriter;
	}
	public void setComment_CommentWriter(String comment_CommentWriter) {
		this.comment_CommentWriter = comment_CommentWriter;
	}
	public String getComment_CommentContent() {
		return comment_CommentContent;
	}
	public void setComment_CommentContent(String comment_CommentContent) {
		this.comment_CommentContent = comment_CommentContent;
	}
	public Date getComment_CommentTime() {
		return comment_CommentTime;
	}
	public void setComment_CommentTime(Date comment_CommentTime) {
		this.comment_CommentTime = comment_CommentTime;
	}
	public String getComment_CommentTimeSet() {
		return comment_CommentTimeSet;
	}
	public void setComment_CommentTimeSet(String comment_CommentTimeSet) {
		this.comment_CommentTimeSet = comment_CommentTimeSet;
	}
	@Override
	public String toString() {
		return "comment_CommentsDTO [commentNum=" + commentNum + ", comment_CommentNum=" + comment_CommentNum
				+ ", comment_CommentWriter=" + comment_CommentWriter + ", comment_CommentContent="
				+ comment_CommentContent + ", comment_CommentTime=" + comment_CommentTime + ", comment_CommentTimeSet="
				+ comment_CommentTimeSet + ", comment_CommentNickName=" + comment_CommentNickName + "]";
	}
	
	
	
	
	
	
}
