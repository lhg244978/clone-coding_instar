package com.teamProject.DTO;

import java.sql.Date;
import java.util.ArrayList;

public class boardDTO {
	//게시물 번호
	private int postNum;
	// 게시물 작성자
	private String postWriter;
	// 작성자 프로필
	private String postWriterProfile;
	// 작성자 주소
	private String postWriterAddr;
	// 작성자 닉네임
	private String nickName;
	// 게시물 컨텐츠
	private String postContent;
	// 이미지 리스트
	private ArrayList<String> postFileImg;
	// 파일 타입
	private ArrayList<String> postType;
	private Date postTime;
	private int postTimeSet;
	private int likeComments;
	private int commentCount;
	private String postLike;
	private String postBookmark;
	private int rn;
	private String thumbnail;
	
	
	

	public ArrayList<String> getPostType() {
		return postType;
	}
	public void setPostType(ArrayList<String> postType) {
		this.postType = postType;
	}
	public String getPostBookmark() {
		return postBookmark;
	}
	public void setPostBookmark(String postBookmark) {
		this.postBookmark = postBookmark;
	}
	public String getPostLike() {
		return postLike;
	}
	public void setPostLike(String postLike) {
		this.postLike = postLike;
	}
	public ArrayList<String> getPostFileImg() {
		return postFileImg;
	}
	public void setPostFileImg(ArrayList<String> postFileImg) {
		this.postFileImg = postFileImg;
	}
	public int getPostTimeSet() {
		return postTimeSet;
	}
	public void setPostTimeSet(int postTimeSet) {
		this.postTimeSet = postTimeSet;
	}
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getPostWriter() {
		return postWriter;
	}
	public void setPostWriter(String postWriter) {
		this.postWriter = postWriter;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public Date getPostTime() {
		return postTime;
	}
	public void setPostTime(Date postTime) {
		this.postTime = postTime;
	}
	public String getPostWriterProfile() {
		return postWriterProfile;
	}
	public void setPostWriterProfile(String postWriterProfile) {
		this.postWriterProfile = postWriterProfile;
	}

	public String getPostWriterAddr() {
		return postWriterAddr;
	}
	public void setPostWriterAddr(String postWriterAddr) {
		this.postWriterAddr = postWriterAddr;
	}
	public int getLikeComments() {
		return likeComments;
	}
	public void setLikeComments(int likeComments) {
		this.likeComments = likeComments;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	

	
	
	
	
}
