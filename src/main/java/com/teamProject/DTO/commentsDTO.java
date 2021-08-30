package com.teamProject.DTO;

import java.sql.Date;
import java.util.ArrayList;

public class commentsDTO {
	private int commentNum; 
	private int postNum; 
	private String postJuin;
	private String commentWriter; 
	private String commentWriterProfile; 
	private String commentNickname; 
	private String commentContent; 
	private Date commentTime;
	private int commentSec;
	private int commentTimeSet;
	private ArrayList<comment_CommentsDTO> comment_comment;
	private String likeComments; 
	private int likeCommentCount; 
	private String commentProfile;
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getPostJuin() {
		return postJuin;
	}
	public void setPostJuin(String postJuin) {
		this.postJuin = postJuin;
	}
	public String getCommentWriter() {
		return commentWriter;
	}
	public void setCommentWriter(String commentWriter) {
		this.commentWriter = commentWriter;
	}
	public String getCommentWriterProfile() {
		return commentWriterProfile;
	}
	public void setCommentWriterProfile(String commentWriterProfile) {
		this.commentWriterProfile = commentWriterProfile;
	}
	public String getCommentNickname() {
		return commentNickname;
	}
	public void setCommentNickname(String commentNickname) {
		this.commentNickname = commentNickname;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}
	public int getCommentSec() {
		return commentSec;
	}
	public void setCommentSec(int commentSec) {
		this.commentSec = commentSec;
	}
	public int getCommentTimeSet() {
		return commentTimeSet;
	}
	public void setCommentTimeSet(int commentTimeSet) {
		this.commentTimeSet = commentTimeSet;
	}
	public ArrayList<comment_CommentsDTO> getComment_comment() {
		return comment_comment;
	}
	public void setComment_comment(ArrayList<comment_CommentsDTO> comment_comment) {
		this.comment_comment = comment_comment;
	}
	public String getLikeComments() {
		return likeComments;
	}
	public void setLikeComments(String likeComments) {
		this.likeComments = likeComments;
	}
	public int getLikeCommentCount() {
		return likeCommentCount;
	}
	public void setLikeCommentCount(int likeCommentCount) {
		this.likeCommentCount = likeCommentCount;
	}
	public String getCommentProfile() {
		return commentProfile;
	}
	public void setCommentProfile(String commentProfile) {
		this.commentProfile = commentProfile;
	}
	@Override
	public String toString() {
		return "commentsDTO [commentNum=" + commentNum + ", postNum=" + postNum + ", postJuin=" + postJuin
				+ ", commentWriter=" + commentWriter + ", commentWriterProfile=" + commentWriterProfile
				+ ", commentNickname=" + commentNickname + ", commentContent=" + commentContent + ", commentTime="
				+ commentTime + ", commentSec=" + commentSec + ", commentTimeSet=" + commentTimeSet
				+ ", comment_comment=" + comment_comment + ", likeComments=" + likeComments + ", likeCommentCount="
				+ likeCommentCount + ", commentProfile=" + commentProfile + "]";
	}
	
	
	

	

	
	
	
}
