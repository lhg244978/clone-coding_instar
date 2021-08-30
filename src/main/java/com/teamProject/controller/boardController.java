package com.teamProject.controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamProject.DTO.boardDTO;
import com.teamProject.DTO.commentsDTO;
import com.teamProject.DTO.extractFileDTO;
import com.teamProject.DTO.likePostDTO;
import com.teamProject.DTO.memberDTO;
import com.teamProject.DTO.postDTO;
import com.teamProject.DTO.storagePostDTO;
import com.teamProject.DTO.tagPostDTO;
import com.teamProject.mapper.boardMapper;
import com.teamProject.service.boardService;
import com.teamProject.service.commentService;
import com.teamProject.service.memberService;





@Controller
public class boardController {
	private ModelAndView mav;
	@Autowired
	private HttpSession session; 
	@Autowired
	private boardMapper boardMapper;
	@Autowired
	private boardService service;
	@Autowired
	private commentService commentService;
	@Autowired
	private memberService memberService;
	
@RequestMapping(value="boardWriteForm")
public String boardWriteForm() {
	System.out.println("boardWriteForm");
	return "/board/boardWriteForm";
	
}

@RequestMapping(value = "boardWriteFile")
public ModelAndView boardWriteFile(
		@RequestParam("postContent")String postContent,
		postDTO postdto, tagPostDTO tagdto,MultipartHttpServletRequest mtfRequest,
		RedirectAttributes ra) {
	mav = new ModelAndView();
	String loginId= (String) session.getAttribute("loginId");
	UUID uuid = UUID.randomUUID();
    List<MultipartFile> fileList = mtfRequest.getFiles("file");
    String path = "C:\\Users\\wish\\Documents\\workspace-spring-tool-suite-4-4.8.1.RELEASE\\teamProject\\src\\main\\webapp\\resources\\fileUpload\\";
    
//multiFile 테이블 번호 저장
    int postNum = boardMapper.getMaxPostnum()+1;
    System.out.println("postNum:"+postNum);
    postdto.setPostNum(postNum);
    postdto.setPostWriter(loginId);
    postdto.setPostContent(postContent);
    
    mav = service.post(postdto,tagdto);
   
    for (MultipartFile mf : fileList) {
    	
        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
        
        String fileName= uuid.toString()+"_" + originFileName;

        postdto.setFileName(fileName);
        
        int insertResult = boardMapper.multiFile(postdto);
      
        String safeFile = path +uuid.toString()+"_"+ originFileName;
        
        try {
			mf.transferTo(new File(safeFile));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	  mav.setViewName("redirect:/boardList");
	  
    return mav;
}

@RequestMapping (value = "/boardList")
public ModelAndView boardList() {
	System.out.println("boardList");
	mav= service.boardList();
	return mav;
	}
@RequestMapping(value="/boardModifyForm")
public ModelAndView boardModifyForm(int postNum,postDTO postdto) {
	System.out.println("/boardModifyForm");
	mav = service.boardModifyForm(postNum,postdto);
	return mav;
	
}

@RequestMapping(value="/boardModify")
public ModelAndView boardModify(@RequestParam("postNum") int postNum,
		@RequestParam("postContent") String postContent,
		postDTO postdto, tagPostDTO tagdto,MultipartHttpServletRequest mtfRequest) {
	mav = new ModelAndView();
	System.out.println("/boardModify");
	UUID uuid = UUID.randomUUID();
    List<MultipartFile> fileList = mtfRequest.getFiles("file");
    String path = "C:\\Users\\wish\\Documents\\workspace-spring-tool-suite-4-4.8.1.RELEASE\\teamProject\\src\\main\\webapp\\resources\\fileUpload\\";
	 postdto.setPostNum(postNum);
	    postdto.setPostContent(postContent);
	mav = service.boardModify(postdto,tagdto);
for (MultipartFile mf : fileList) {
        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
        
        String fileName= uuid.toString()+"_" + originFileName;

        postdto.setFileName(fileName);
        
        int insertResult = boardMapper.multiFile(postdto);
        if(insertResult>0) {
        	System.out.println("multiFile 테이블 삽입 성공");
        }else {
        	System.out.println("multiFile 테이블 삽입 실패");
        	
        }
        String safeFile = path +uuid.toString()+"_"+ originFileName;
        
        try {
			mf.transferTo(new File(safeFile));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	  mav.setViewName("redirect:/boardList");
	  
    return mav;
}
@RequestMapping (value = "/boardListPage")
public @ResponseBody ArrayList<boardDTO> boardListPage(int page) {
	System.out.println("boardListPage");
	ArrayList<boardDTO> result = service.boardListPage(page);
	return result;
}
@RequestMapping (value = "/likeUsers")
public @ResponseBody String likeUsers(int postNum) {
	System.out.println("likeUsers");
	
	String result = service.likeUsers(postNum);

	
	return result;
}

@RequestMapping (value = "/bookmark")
public @ResponseBody String bookmark(int postNum) {
System.out.println("bookmark");

String result = service.bookmark(postNum);


return result;
}

@RequestMapping (value = "/likeVal")
public @ResponseBody String likeVal(int postNum) {
	System.out.println("likeVal");
	
	String result = service.likeVal(postNum);
	return result;
}


@RequestMapping (value = "/following")
public @ResponseBody String following(String following) {
System.out.println("following");
System.out.println(following);
String result = service.following(following);

return result;
}
@RequestMapping (value = "/unFollowing")
public @ResponseBody String unFollowing(String following) {
System.out.println("unFollowing");
System.out.println(following);
String result = service.unFollowing(following);

return result;
}

@RequestMapping (value = "/unFollowingModal")
public @ResponseBody String unFollowingModal(int postNum) {
System.out.println("unFollowingModal");
System.out.println(postNum);
String result = service.unFollowingModal(postNum);


return result;
}


@RequestMapping (value = "/boardView")
public ModelAndView boardView(int postNum) {
System.out.println("boardList");
mav= service.boardView(postNum);
return mav;
}
@RequestMapping(value="/boardDelete")
public @ResponseBody String boardDelete(int postNum) {
	System.out.println("/boardDelete");
	String result = service.boardDelete(postNum);
	return result;
}



@RequestMapping(value = "/searchUser")
public @ResponseBody ArrayList<memberDTO> searchUser(String searchUser) {
	ArrayList<memberDTO> usersList = service.searchUser(searchUser);
	for (int i = 0; i < usersList.size(); i++) {
		if (usersList.get(i).getUserIntro() == null) {
			usersList.get(i).setUserIntro("자기소개가 없습니다.");
		}
		else if (usersList.get(i).getUserIntro().length() > 11) {
			     usersList.get(i).setUserIntro(usersList.get(i).getUserIntro().substring(0, 10) + "...");
		}
	}

	return usersList;
}

@RequestMapping(value = "/searchPost") // 헤더 태그 찾기
public @ResponseBody ArrayList<tagPostDTO> searchPost(String searchPost) {
   ArrayList<tagPostDTO> postList = service.searchPost(searchPost);
   for(int i = 0; i < postList.size(); i++) {
      int checkCount = postList.get(i).getCountPost();
      String errorCode = postList.get(i).getTagName();
      if (checkCount == 0) {
         postList.remove(i);
      } else if (errorCode == "#") {
    	  postList.remove(i);
      }
   }
   return postList;
}


@RequestMapping(value = "/searchPostList")
public ModelAndView searchPostList(@RequestParam(value = "tagName") String tagName) {
	mav = service.searchPostList("#" + tagName);
	return mav;
}

//인기게시글 페이지이동
@RequestMapping(value = "/popList")
public ModelAndView postList() {
	String loginId = (String) session.getAttribute("loginId");
	System.out.println("로그인닉네임" + loginId);
	mav = service.postList(loginId);

	return mav;
}

//모달창 파일가져오기

@RequestMapping(value = "/getFiles")
public @ResponseBody extractFileDTO getFiles(int postNum) {
	extractFileDTO getFiles = service.getFiles(postNum);
	return getFiles;
}

//모달창 글쓴이 정보
@RequestMapping(value = "/getUser")
public @ResponseBody memberDTO getUser(int postNum) {
	memberDTO getUser = memberService.getUser(postNum);
	return getUser;
}

//모달창 게시글 정보
@RequestMapping(value = "/getPost")
public @ResponseBody postDTO getPost(int postNum) {
	postDTO getPost = service.getPost(postNum);
	getPost.setPostProfile(service.getProfile(getPost.getPostWriter()));

	Pattern p = Pattern.compile("\\#([0-9a-zA-ㅔㅁZ가-힣]*)");
	Matcher m = p.matcher(getPost.getPostContent());
	String extractHashTag = null;

	while (m.find()) {
		extractHashTag = sepcialCharacter_replace(m.group());

		if (extractHashTag != null) {
			System.out.println("최종 추출 해시태그 :: " + extractHashTag);
		}
	}

	return getPost;
}

//모달창 댓글 정보
@RequestMapping(value = "/getComments")
public @ResponseBody ArrayList<commentsDTO> getComments(int postNum) {
	ArrayList<commentsDTO> getComments = commentService.getComments(postNum);
	System.out.println("겟코멘츠" + getComments);
	for (int i = 0; i < getComments.size(); i++) {
		getComments.get(i).setCommentProfile(service.getProfile(getComments.get(i).getCommentWriter()));
	
		getComments.get(i).setCommentNickname(memberService.idToNick(getComments.get(i).getCommentWriter()));
		
		getComments.get(i).setPostJuin(memberService.postJuin(getComments.get(i).getPostNum()));
		
	}
	return getComments;
}

@RequestMapping(value = "/getLike")
public @ResponseBody int getLike(int postNum) {
	int getLike = service.getLike(postNum);
	return getLike;
}

@RequestMapping(value = "/getLeftIcon")
public @ResponseBody String getLeftIcon(int postNum) {
	String loginId = (String) session.getAttribute("loginId");
	likePostDTO likePostDTO = new likePostDTO();
	likePostDTO.setPostNum(postNum);
	likePostDTO.setUserId(loginId);
	String result = service.getLeftIcon(likePostDTO);
	return result;
}

@RequestMapping(value = "/getRightIcon")
public @ResponseBody String getRightIcon(int postNum) {
	String loginId = (String) session.getAttribute("loginId");
	storagePostDTO storagePostDTO = new storagePostDTO();
	storagePostDTO.setPostNum(postNum);
	storagePostDTO.setUserId(loginId);
	String result = service.getRightIcon(storagePostDTO);
	return result;
}


@RequestMapping(value = "/likeCancel")
public @ResponseBody String likeCancel(int postNum) {
	String loginId = (String) session.getAttribute("loginId");
	likePostDTO likePostDTO = new likePostDTO();
	likePostDTO.setPostNum(postNum);
	likePostDTO.setUserId(loginId);
	String result = service.likeCancel(likePostDTO);
	return result;

}

@RequestMapping(value = "/like")
public @ResponseBody String like(int postNum) {
	String loginId = (String) session.getAttribute("loginId");
	likePostDTO likePostDTO = new likePostDTO();
	likePostDTO.setPostNum(postNum);
	likePostDTO.setUserId(loginId);
	String result = service.like(likePostDTO);
	return result;

}

@RequestMapping(value = "/storageCancel")
public @ResponseBody String storageCancel(int postNum) {
	String loginId = (String) session.getAttribute("loginId");
	storagePostDTO storagePostDTO = new storagePostDTO();
	storagePostDTO.setPostNum(postNum);
	storagePostDTO.setUserId(loginId);
	String result = service.storageCancel(storagePostDTO);
	return result;

}

@RequestMapping(value = "/storage")
public @ResponseBody String storage(int postNum) {
	String loginId = (String) session.getAttribute("loginId");
	storagePostDTO storagePostDTO = new storagePostDTO();
	storagePostDTO.setPostNum(postNum);
	storagePostDTO.setUserId(loginId);
	String result = service.storage(storagePostDTO);
	return result;
}

public String sepcialCharacter_replace(String str) {
	str = StringUtils.replace(str, "-_+=!@#$%^&*()[]{}|\\;:'\"<>,.?/~`） ", "");

	if (str.length() < 1) {
		return null;
	}

	return str;
}

@RequestMapping(value = "/alreadyFol")
public @ResponseBody String alreadyFol(int postNum) {
   String result = service.alreadyFol(postNum); 
   return result;
}

@RequestMapping(value = "/otherPage2")
public ModelAndView otherPage2(@RequestParam("postNum") int postNum) {
   String loginId = (String) session.getAttribute("loginId");
   String userid = service.getUserId(postNum);
   System.out.println("otherPage2");
   mav = memberService.otherPage(userid,loginId);
   return mav;
}

@RequestMapping(value = "/goMessage")
public ModelAndView goMessage(int postNum) {
   String loginId = (String) session.getAttribute("loginId");
   mav = service.goMessage(loginId,postNum);
   return mav;
   
}

}




