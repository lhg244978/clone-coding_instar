package com.teamProject.DTO;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class postDTO {
	
private int postNum;
private String postWriter;
private String postContent;
private Date postTime;
private MultipartFile file;
private String fileName;
private int postTimeSet;
private String postProfile;
private int postReport;
private String nickName;

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
public MultipartFile getFile() {
	return file;
}
public void setFile(MultipartFile file) {
	this.file = file;
}
public String getFileName() {
	return fileName;
}
public void setFileName(String fileName) {
	this.fileName = fileName;
}
public int getPostTimeSet() {
	return postTimeSet;
}
public void setPostTimeSet(int postTimeSet) {
	this.postTimeSet = postTimeSet;
}
public String getPostProfile() {
	return postProfile;
}
public void setPostProfile(String postProfile) {
	this.postProfile = postProfile;
}

public int getPostReport() {
	return postReport;
}
public void setPostReport(int postReport) {
	this.postReport = postReport;
}
public String getNickName() {
	return nickName;
}
public void setNickName(String nickName) {
	this.nickName = nickName;
}

@Override
public String toString() {
	return "postDTO [postNum=" + postNum + ", postWriter=" + postWriter + ", postContent=" + postContent + ", postTime="
			+ postTime + ", file=" + file + ", fileName=" + fileName + ", postTimeSet=" + postTimeSet + ", postProfile="
			+ postProfile + ", postReport=" + postReport + ", nickName=" + nickName + "]";
}



}
