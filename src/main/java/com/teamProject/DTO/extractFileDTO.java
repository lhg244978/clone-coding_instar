package com.teamProject.DTO;

import java.util.ArrayList;

public class extractFileDTO {

	private ArrayList<String> postFileImg;
	private ArrayList<String> postType;
	public ArrayList<String> getPostFileImg() {
		return postFileImg;
	}
	public void setPostFileImg(ArrayList<String> postFileImg) {
		this.postFileImg = postFileImg;
	}
	public ArrayList<String> getPostType() {
		return postType;
	}
	public void setPostType(ArrayList<String> postType) {
		this.postType = postType;
	}
	@Override
	public String toString() {
		return "extractFileDTO [postFileImg=" + postFileImg + ", postType=" + postType + "]";
	}
	
}
