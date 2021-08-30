package com.teamProject.DTO;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class memberDTO {
	
	private String userName;
	private String userId;
	private String userPw;
	private String newUserPw;
	
	private Date userBirth;
	
	private String userPhone;
	private String userPhone1;
	private String userPhone2;
	private String userPhone3;
	
	private String userAddr;
	private String userAddr1;
	private String uAddr1;
	private String uAddr2;
	private String uAddr3;
	private String uAddr4;
	private String uAddr5;
	
	private String userSex;
	
	private MultipartFile userProfile;
	private String userProfileName;
	private String userNullProfile;
	
	private String nickName;
	private String userIntro;
	private int userShow;
	private int admin;
	
	public String getUserName() {
		return userName;
	}
	public String getUserId() {
		return userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public String getNewUserPw() {
		return newUserPw;
	}
	public Date getUserBirth() {
		return userBirth;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public String getUserPhone1() {
		return userPhone1;
	}
	public String getUserPhone2() {
		return userPhone2;
	}
	public String getUserPhone3() {
		return userPhone3;
	}
	public String getUserAddr() {
		return userAddr;
	}
	public String getUserAddr1() {
		return userAddr1;
	}
	public String getuAddr1() {
		return uAddr1;
	}
	public String getuAddr2() {
		return uAddr2;
	}
	public String getuAddr3() {
		return uAddr3;
	}
	public String getuAddr4() {
		return uAddr4;
	}
	public String getuAddr5() {
		return uAddr5;
	}
	public String getUserSex() {
		return userSex;
	}
	public MultipartFile getUserProfile() {
		return userProfile;
	}
	public String getUserProfileName() {
		return userProfileName;
	}
	public String getUserNullProfile() {
		return userNullProfile;
	}
	public String getNickName() {
		return nickName;
		
	}
	public String getUserIntro() {
		return userIntro;
	}
	public int getUserShow() {
		return userShow;
	}
	public int getAdmin() {
		return admin;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public void setNewUserPw(String newUserPw) {
		this.newUserPw = newUserPw;
	}
	public void setUserBirth(Date userBirth) {
		this.userBirth = userBirth;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public void setUserPhone1(String userPhone1) {
		this.userPhone1 = userPhone1;
	}
	public void setUserPhone2(String userPhone2) {
		this.userPhone2 = userPhone2;
	}
	public void setUserPhone3(String userPhone3) {
		this.userPhone3 = userPhone3;
	}
	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	public void setUserAddr1(String userAddr1) {
		this.userAddr1 = userAddr1;
	}
	public void setuAddr1(String uAddr1) {
		this.uAddr1 = uAddr1;
	}
	public void setuAddr2(String uAddr2) {
		this.uAddr2 = uAddr2;
	}
	public void setuAddr3(String uAddr3) {
		this.uAddr3 = uAddr3;
	}
	public void setuAddr4(String uAddr4) {
		this.uAddr4 = uAddr4;
	}
	public void setuAddr5(String uAddr5) {
		this.uAddr5 = uAddr5;
	}
	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}
	public void setUserProfile(MultipartFile userProfile) {
		this.userProfile = userProfile;
	}
	public void setUserProfileName(String userProfileName) {
		this.userProfileName = userProfileName;
	}
	public void setUserNullProfile(String userNullProfile) {
		this.userNullProfile = userNullProfile;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public void setUserIntro(String userIntro) {
		this.userIntro = userIntro;
	}
	public void setUserShow(int userShow) {
		this.userShow = userShow;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	
	@Override
	public String toString() {
		return "usersDTO [userName=" + userName + ", userId=" + userId + ", userPw=" + userPw + ", newUserPw="
				+ newUserPw + ", userBirth=" + userBirth + ", userPhone=" + userPhone + ", userPhone1=" + userPhone1
				+ ", userPhone2=" + userPhone2 + ", userPhone3=" + userPhone3 + ", userAddr=" + userAddr
				+ ", userAddr1=" + userAddr1 + ", uAddr1=" + uAddr1 + ", uAddr2=" + uAddr2 + ", uAddr3=" + uAddr3
				+ ", uAddr4=" + uAddr4 + ", uAddr5=" + uAddr5 + ", userSex=" + userSex + ", userProfile=" + userProfile
				+ ", userProfileName=" + userProfileName + ", userNullProfile=" + userNullProfile + ", nickName="
				+ nickName + ", userIntro=" + userIntro + ", userShow=" + userShow + ", admin=" + admin + "]";
	}
	
}
