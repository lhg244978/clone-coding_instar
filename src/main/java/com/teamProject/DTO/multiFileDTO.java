package com.teamProject.DTO;

public class multiFileDTO {

	private int postNum;
	private String files;
	private String fileType;
	
	
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	@Override
	public String toString() {
		return "multiFileDTO [postNum=" + postNum + ", files=" + files + ", fileType=" + fileType + "]";
	}

	
	
}

