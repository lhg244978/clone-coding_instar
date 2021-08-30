package com.teamProject.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamProject.DTO.boardDTO;
import com.teamProject.DTO.followDTO;
import com.teamProject.DTO.memberDTO;
import com.teamProject.DTO.multiFileDTO;
import com.teamProject.DTO.pageDTO;
import com.teamProject.DTO.postDTO;
import com.teamProject.DTO.storagePostDTO;
import com.teamProject.mapper.memberMapper;
import com.teamProject.mapper.boardMapper;
import com.teamProject.mapper.followMapper;
import com.teamProject.mapper.friendsMapper;
import com.teamProject.mapper.multifileMapper;
import com.teamProject.mapper.storagepostMapper;
@Service
public class memberService {
	
	@Autowired
	private memberMapper memberMapper;
	
	@Autowired
	private boardMapper boardMapper;
	
	@Autowired
	private multifileMapper multifileMapper;
	
	@Autowired
	private friendsMapper friendsMapper;
	
	@Autowired
	private storagepostMapper storagepostMapper;
	
	@Autowired
	private followMapper followMapper;
	
	private ModelAndView mav;
	
	@Autowired
	private HttpSession session;

	public ModelAndView memberJoin(memberDTO memberdto, RedirectAttributes ra) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		
		memberdto.setUserPhone(memberdto.getUserPhone1() + memberdto.getUserPhone2() + memberdto.getUserPhone3());
		memberdto.setUserAddr("(" + memberdto.getuAddr1() + ")" + memberdto.getuAddr2() + 
				memberdto.getuAddr3() + memberdto.getuAddr4() + memberdto.getuAddr5());
		System.out.println("getUser::::"+memberdto.getUserProfile());
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		
		MultipartFile userProfile = memberdto.getUserProfile();
		// 저장 경로 설정, 파일 저장
		String userProfileName = uuid.toString() + "_" + userProfile.getOriginalFilename();
		String savePath = "C:\\Users\\wish\\Documents\\workspace-spring-tool-suite-4-4.8.1.RELEASE\\teamProject\\src\\main\\webapp\\resources\\profileImg\\";
		
		// 프로필 이미지 파일 저장
		if(!userProfile.isEmpty()) {
			userProfileName = uuid.toString() + "_" + userProfile.getOriginalFilename();
			userProfile.transferTo(new File(savePath + userProfileName));
		}else {
				userProfileName = "defaultImg.png";
		}
		memberdto.setUserProfileName(userProfileName);
		
		int insertResult = memberMapper.memberJoin(memberdto);
		if(insertResult > 0) {
			ra.addFlashAttribute("joinMsg",memberdto.getNickName() + "님 가입되었습니다.");
		} else {
			ra.addFlashAttribute("joinMsg","0");
		}
		
		System.out.println("insertResult::" + insertResult);
		
		mav.setViewName("redirect:/memberLoginForm");
		return mav;
	}
	
	public ModelAndView memberLogin(memberDTO memberdto, RedirectAttributes ra) {
		mav = new ModelAndView();
		String nickName = memberMapper.memberLogin(memberdto);
		System.out.println("nickName::" + nickName);
		System.out.println("loginId::" + memberdto.getUserId());
		session.setAttribute("loginId", memberdto.getUserId());
		session.setAttribute("nickName", nickName);
		if(nickName == null) {
			ra.addFlashAttribute("loginMsg", 0);
			mav.setViewName("redirect:/memberLoginForm");
		} else {
			int admin = memberMapper.adminCheck(memberdto);
			if(admin == 0) {
				session.setAttribute("sessionNickName",nickName);
				ra.addFlashAttribute("loginMsg", nickName + "님 로그인 되었습니다.");
				mav.setViewName("redirect:/boardList");
			} else {
				session.setAttribute("sessionNickName",nickName);
				session.setAttribute("admin", admin);
				ra.addFlashAttribute("loginMsg", "관리자 " + nickName + "님 로그인 되었습니다.");
				mav.setViewName("redirect:/boardList");
			}
		}
		return mav;
	}
	
	public memberDTO getUser(int postNum) {
		memberDTO getUser = memberMapper.getUser(postNum);
		System.out.println("이 게시글의 유저정보" + getUser);
		return getUser;
	}
	
	public String getUserNickName(memberDTO memberDTO) {

		String result = memberMapper.getUserNickName(memberDTO);
		return result;
	}

	public String getUserName(memberDTO memberDTO) {

		String result = memberMapper.getUserName(memberDTO);
		return result;
	}


	public String getUserProfile(memberDTO memberDTO) {

		String result = memberMapper.getUserProfile(memberDTO);
		return result;
	}

	
	public ModelAndView goAdminPage(String nickName, int page) {
		mav = new ModelAndView();
		memberDTO memberdto = memberMapper.memberView(nickName);
		System.out.println("memberdto111::"+memberdto);
		
		//페이징
				int pageLimit = 5; // 한페이지에 보여줄 글의 갯수
				int pageNumLimit = 3; // 한페이지에 보여줄 페이지 번호 갯수
				
				int startRow = (page - 1) * pageLimit + 1;
				int endRow = page * pageLimit;
				
				pageDTO pageDTO = new pageDTO();
				pageDTO.setStartRow(startRow);
				pageDTO.setEndRow(endRow);
				ArrayList<postDTO> adminPostList = boardMapper.adminPostList(pageDTO);
				System.out.println("adminPostList22::"+adminPostList);
				
				//작성자를 닉네임으로 출력
				for(int i = 0; i < adminPostList.size(); i++) {
					String postWriter = adminPostList.get(i).getPostWriter();

					String getNickName = boardMapper.postNickname(postWriter);

					adminPostList.get(i).setNickName(getNickName);
				}
				
				
				int postListCnt = boardMapper.getPostListCnt();
				int maxPage = (int)(Math.ceil((double)postListCnt/pageLimit));
				int startPage = ((int)(Math.ceil((double)page/pageNumLimit)) - 1) * pageNumLimit + 1;
				int endPage = startPage + pageNumLimit - 1;
				
				if(endPage > maxPage) {
					endPage = maxPage;
				}
				pageDTO.setPage(page);
				pageDTO.setStartPage(startPage);
				pageDTO.setEndPage(endPage);
				pageDTO.setMaxPage(maxPage);
				

				
				mav.addObject("memberDTO", memberdto);
				mav.addObject("postList", adminPostList);
				mav.addObject("pageDTO", pageDTO);
				mav.setViewName("member/adminPage");
				return mav;
	}
	
	public ModelAndView personalReport(String postWriter, String nickName, int page) {
		mav = new ModelAndView();
		memberDTO memberDTO = memberMapper.memberView(nickName);
		
		//페이징
		int pageLimit = 5; // 한페이지에 보여줄 글의 갯수
		int pageNumLimit = 3; // 한페이지에 보여줄 페이지 번호 갯수
		
		int startRow = (page - 1) * pageLimit + 1;
		int endRow = page * pageLimit;
		
		pageDTO pageDTO = new pageDTO();
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("postWriter", postWriter);
		map.put("startRow", pageDTO.getStartRow());
		map.put("endRow", pageDTO.getEndRow());
		
		ArrayList<postDTO> personalReportPostList = boardMapper.personalReport(map);
		//작성자를 닉네임으로 출력
		for(int i = 0; i < personalReportPostList.size(); i++) {
			String getPostWriter = personalReportPostList.get(i).getPostWriter();

			String getNickName = boardMapper.postNickname(getPostWriter);

			personalReportPostList.get(i).setNickName(getNickName);
		}
		
		int postListCnt = boardMapper.getPersonalReportCnt(postWriter);
		int maxPage = (int)(Math.ceil((double)postListCnt/pageLimit));
		int startPage = ((int)(Math.ceil((double)page/pageNumLimit)) - 1) * pageNumLimit + 1;
		int endPage = startPage + pageNumLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		pageDTO.setPage(page);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setMaxPage(maxPage);
		
		System.out.println(personalReportPostList);
		
		mav.addObject("memberDTO", memberDTO);
		mav.addObject("postList", personalReportPostList);
		mav.addObject("pageDTO", pageDTO);
		mav.addObject("postWriter", postWriter);
		mav.setViewName("member/personalReportPage");
		return mav;
	}

	public ModelAndView memberModify(String nickName) {
		mav = new ModelAndView();
		memberDTO memberdto = memberMapper.memberView(nickName);
		
		mav.addObject("memberDTO",memberdto);
		mav.setViewName("member/memberModifyForm");
		return mav;
	}

	public ModelAndView memberModifyProcess(memberDTO memberdto) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		System.out.println("서비스넘어옴?");
		if(memberdto.getUserAddr().equals(memberdto.getUserAddr1())) {
			memberdto.setUserAddr(memberdto.getUserAddr1());
		} else {
			memberdto.setUserAddr("(" + memberdto.getuAddr1() + ")" + memberdto.getuAddr2() + memberdto.getuAddr3()
			+ memberdto.getuAddr4() + memberdto.getuAddr5());
		}
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		
		MultipartFile userProfile = memberdto.getUserProfile();
		// 저장 경로 설정, 파일 저장
		String userProfileName = uuid.toString() + "_" + userProfile.getOriginalFilename();
		String savePath = "C:\\Users\\wish\\Documents\\workspace-spring-tool-suite-4-4.8.1.RELEASE\\teamProject\\src\\main\\webapp\\resources\\profileImg\\";
		
		if (!userProfile.isEmpty()) {
			// 기존에 있던 프로필 이미지 파일 삭제
				
			String oldFileName = memberMapper.getProfile(memberdto.getUserId());
			if (!oldFileName.equals("defaultImg.png")) {
			System.out.println("oldFileName::::::"+oldFileName);
			File file = new File(savePath + oldFileName);
			file.delete();
			}

			// 새로운 프로필 이미지 파일 저장

			userProfileName = uuid.toString() + "_" + userProfile.getOriginalFilename();
			userProfile.transferTo(new File(savePath + userProfileName));
			memberdto.setUserProfileName(userProfileName);
		} else {
			memberdto.setUserProfileName(memberdto.getUserNullProfile());
		}
		
		
		int updateResult = memberMapper.memberModifyProcess(memberdto);
		System.out.println("updateResult : " + updateResult);
		mav.setViewName("redirect:/myPage?userId=" + memberdto.getUserId());
		return mav;
	}

	public ModelAndView memberPwModify(String nickName) {
		mav = new ModelAndView();
		memberDTO memberdto = memberMapper.memberView(nickName);
		mav.addObject("memberDTO", memberdto);
		mav.setViewName("member/memberPwModifyForm");
		return mav;
	}

	public ModelAndView memberPwModifyProcess(memberDTO memberdto) {
		mav = new ModelAndView();
		memberdto.setUserPw(memberdto.getNewUserPw());
		int updateResult = memberMapper.memberPwModifyProcess(memberdto);
		String loginId= (String) session.getAttribute("loginId");
		mav.setViewName("redirect:/myPage?userId=" + loginId);
		return mav;
	}

	public ModelAndView otherPage(String userid,String loginId) {
        mav = new ModelAndView();
        System.out.println("otherPage");
        memberDTO userMypage =memberMapper.myPage(userid);
        int postCount = boardMapper.pCount(userid);
        
        String nickname = memberMapper.nickname(userid);
        System.out.println("nickname"+ nickname);
        
        ArrayList<boardDTO> postList = boardMapper.pList(userid);      
        for (int i = 0; i < postList.size(); i++) {
           boardDTO post = postList.get(i);         
           ArrayList<multiFileDTO> getThumbnail = multifileMapper.getThumbnail(postList.get(i).getPostNum());
           String fileName = getThumbnail.get(0).getFiles(); // 파일 이미지이름
           post.setThumbnail(fileName);
           postList.set(i, post);

        }
        
        String userShow = memberMapper.userShow_other(userid);
        System.out.println("userShow:::"+userShow);
        
        String checkFollower = memberMapper.checkFollower(loginId,userid);
        if(checkFollower == null) {
           checkFollower= "";
        }
        
        String eachFollow = memberMapper.checkFollower(userid,loginId);
        if(eachFollow == null) {
           eachFollow= "";
        }
        
        System.out.println("checkFollower:::"+checkFollower);
        System.out.println("eachFollow:::"+eachFollow);
        
        if(userShow.equals("0")) {
           mav.addObject("postList",postList);
           
        }else if(userShow.equals("1")) {
           System.out.println(checkFollower+"::"+userid);
           if(checkFollower.equals(userid)) {
              mav.addObject("postList",postList);
           }
        }else if(userShow.equals("2")) {
           System.out.println(eachFollow+"::"+loginId);
           if(checkFollower.equals(userid) && eachFollow.equals(loginId)) {
              mav.addObject("postList",postList);
           }
        }
        
        
        ArrayList<storagePostDTO> savepostList = storagepostMapper.savepostList(userid);
        
        for (int i = 0; i < savepostList.size(); i++) {
           storagePostDTO storage = savepostList.get(i);         
           ArrayList<multiFileDTO> saveThumbnail = multifileMapper.saveThumbnail(savepostList.get(i).getPostNum());
           String fileName = saveThumbnail.get(0).getFiles();
           storage.setThumbnail(fileName);
           savepostList.set(i, storage);

           
        }
        if(userShow.equals("0")) {
           mav.addObject("savepostList",savepostList);
           
        }else if(userShow.equals("1")) {
           System.out.println(checkFollower+"::"+userid);
           if(checkFollower.equals(userid)) {
              mav.addObject("savepostList",savepostList);
           }
        }else if(userShow.equals("2")) {
           System.out.println(eachFollow+"::"+loginId);
           if(checkFollower.equals(userid) && eachFollow.equals(loginId)) {
              mav.addObject("savepostList",savepostList);
           }
        }
        String checkFol = "NO";
        followDTO test = new followDTO();
        test.setFollower(loginId);
        test.setFollowing(userid);
        followDTO followDTO = followMapper.checkFol(test);
        if(followDTO != null) {
           checkFol = "OK";
        }
        
        int followerCount = friendsMapper.fwCount(userid);
        
        int followCount = friendsMapper.fCount(userid);
        
        
        mav.addObject("userMypage",userMypage);
        mav.addObject("postCount",postCount);
        

        
        
        mav.addObject("followerCount",followerCount);
        mav.addObject("followCount",followCount);
        mav.addObject("checkFol",checkFol);
        mav.setViewName("/member/otherPage");
        return mav;
     }
	
	public ModelAndView myPage(String userid) {
		mav = new ModelAndView();
		
		System.out.println("myPageUserId:"+userid);
		memberDTO userMypage =memberMapper.myPage(userid);
		int postCount = boardMapper.pCount(userid);
		
		String nickname = memberMapper.nickname(userid);
		System.out.println("nickname"+ nickname);
		
		ArrayList<boardDTO> postList = boardMapper.pList(userid);		
		for (int i = 0; i < postList.size(); i++) {
			boardDTO post = postList.get(i);			
			ArrayList<multiFileDTO> getThumbnail = multifileMapper.getThumbnail(postList.get(i).getPostNum());
			String fileName = getThumbnail.get(0).getFiles(); // 파일 이미지이름
			post.setThumbnail(fileName);
			postList.set(i, post);

		}
		
		ArrayList<storagePostDTO> savepostList = storagepostMapper.savepostList(userid);
		
		for (int i = 0; i < savepostList.size(); i++) {
			storagePostDTO storage = savepostList.get(i);			
			ArrayList<multiFileDTO> saveThumbnail = multifileMapper.saveThumbnail(savepostList.get(i).getPostNum());
			String fileName = saveThumbnail.get(0).getFiles();
			storage.setThumbnail(fileName);
			savepostList.set(i, storage);

			
		}
		
		
		
		
		int followerCount = friendsMapper.fwCount(userid);
		int followCount = friendsMapper.fCount(userid);
		
		
		
		mav.addObject("userMypage",userMypage);
		mav.addObject("postCount",postCount);
		mav.addObject("postList",postList);
		mav.addObject("savepostList",savepostList);
		mav.addObject("followerCount",followerCount);
		mav.addObject("followCount",followCount);
		
		mav.setViewName("/member/newmyPage");
		return mav;
	}

	public ModelAndView memberModifyForm(String loginId) {
		mav = new ModelAndView();
		memberDTO memberDTO = memberMapper.membermodifyForm(loginId);
		
		mav.addObject("memberDTO", memberDTO);
		mav.setViewName("/member/memberModifyForm");
		return mav;
	}

	public String idToNick(String userid) {
		String nickName = memberMapper.nickname(userid);
		return nickName;
	}

	public String postJuin(int postNum) {
		String postJuin = boardMapper.boardModifyForm1(postNum);
		return postJuin;
	}
	
	public String idCheck(String userId) {
		String idCheck = memberMapper.idCheck(userId);
		String checkResult = null;
		if(idCheck == null) {
			checkResult = "OK";
		} else {
			checkResult = "NO";
		}
		return checkResult;
	}

	public String nickNameCheck(String nickName) {
		String nickNameCheck = memberMapper.nickNameCheck(nickName);
		String checkResult = null;
		if(nickNameCheck == null) {
			checkResult = "OK";
		} else {
			checkResult = "NO";
		}
		return checkResult;
	}

	
	

	

}
