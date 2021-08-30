package com.teamProject.service;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.teamProject.DTO.boardDTO;
import com.teamProject.DTO.commentsDTO;
import com.teamProject.DTO.extractFileDTO;
import com.teamProject.DTO.followDTO;
import com.teamProject.DTO.likePostDTO;
import com.teamProject.DTO.memberDTO;
import com.teamProject.DTO.multiFileDTO;
import com.teamProject.DTO.postDTO;
import com.teamProject.DTO.recommendDTO;
import com.teamProject.DTO.storagePostDTO;
import com.teamProject.DTO.tagPostDTO;
import com.teamProject.mapper.boardMapper;
import com.teamProject.mapper.commentMapper;
import com.teamProject.mapper.followMapper;
import com.teamProject.mapper.memberMapper;



@Service
public class boardService {
	private ModelAndView mav;
	@Autowired
	private boardMapper boardMapper;
	

	
	@Autowired
	private memberMapper memberMapper;
	
	@Autowired
	private followMapper followMapper;
	
	@Autowired
	private commentMapper commentMapper;
	
	@Autowired
	HashMap<String, String> map;
	
	@Autowired
	private HttpSession session;
	
		public ModelAndView post(postDTO postdto, tagPostDTO tagdto) {
			mav = new ModelAndView();
			int insertResult = boardMapper.insertPost(postdto);
			if(insertResult>0) {
				System.out.println("post 테이블 입력 성공");
			}else {
				System.out.println("post 테이블 입력 실패");
			}
			
			
			Pattern p = Pattern.compile("\\#([0-9a-zA-Z가-힣]*)"); 
			  Matcher m =p.matcher(postdto.getPostContent());
			  ArrayList<String> tagList = new ArrayList<String>();
			  while(m.find()) {
				  String tag = m.group();
				  tagList.add(tag);
			  }
			  for (int i = 0; i < tagList.size(); i++) {
				  tagdto.setPostNum(postdto.getPostNum());
				  tagdto.setTagName(tagList.get(i));
				int insertResult2 = boardMapper.tagPost(tagdto);
			}
			  
				return mav;
		}
		
		//게시글 수정
		public ModelAndView boardModify(postDTO postdto, tagPostDTO tagdto) {
			mav = new ModelAndView();
			int postModify = boardMapper.postModify(postdto);
			if(postModify>0) {
				System.out.println("post 테이블 수정 성공");
			}else {
				System.out.println("post 테이블 수정 실패");
			}
			int tagPostDelete = boardMapper.tagPostDelete(postdto);
			if(tagPostDelete>0) {
				System.out.println("tagPost 테이블 삭제 성공");
			}else {
				System.out.println("tagPost 테이블 삭제 실패");
			}
			int multiFileDelete = boardMapper.multiFileDelete(postdto);
			if(multiFileDelete>0) {
				System.out.println("multiFile 테이블 삭제 성공");
			}else {
				System.out.println("multiFile 테이블 삭제 실패");
			}
			Pattern p = Pattern.compile("\\#([0-9a-zA-Z가-힣]*)"); 
			  Matcher m =p.matcher(postdto.getPostContent());
			  ArrayList<String> tagList = new ArrayList<String>();
			  while(m.find()) {
				  String tag = m.group();
				  tagList.add(tag);
			  }
			  for (int i = 0; i < tagList.size(); i++) {

				  tagdto.setPostNum(postdto.getPostNum());
				  tagdto.setTagName(tagList.get(i));
				int insertResult = boardMapper.tagPost(tagdto);
			}
				return mav;
		}

		
		   public ModelAndView boardList() {
		         // TODO Auto-generated method stub
		         mav= new ModelAndView();
		         String loginId= (String) session.getAttribute("loginId");
		         
		         //
		         System.out.println("★loginId:"+loginId);
		         if(loginId==null) {
		       
		        	 mav.setViewName("redirect:/");
		        	 return mav;
		         }
		         
		         
		         memberDTO member = memberMapper.memberInfo(loginId); 
		         ArrayList<boardDTO> boardList = new ArrayList<boardDTO>();

		         ArrayList<boardDTO> boardDTO = boardMapper.boardList(loginId);

		         System.out.println(boardDTO);
		      
		         for (int i = 0; i < boardDTO.size(); i++) {
		            String postWriter=boardDTO.get(i).getPostWriter();
  
		            //이미지 불러오는 거
		            boardDTO.get(i).setPostFileImg(boardMapper.setPostFileImg(boardDTO.get(i).getPostNum()));

		            
		            // 세션 아이디의 좋아요 여부(확인시 세션값과 같은지 확인)
		            likePostDTO likePostDTO = new likePostDTO();
		            likePostDTO.setPostNum(boardDTO.get(i).getPostNum());
		            likePostDTO.setUserId(loginId);
		            boardDTO.get(i).setPostLike(boardMapper.likeChk(likePostDTO));

		            
		            // 세션 아이디의 저장 여부
		            storagePostDTO storagePostDTO = new storagePostDTO();
		            storagePostDTO.setPostNum(boardDTO.get(i).getPostNum());
		            storagePostDTO.setUserId(loginId);
		            boardDTO.get(i).setPostBookmark(boardMapper.bookmark(storagePostDTO));
		            
		            // 이미지인지 영상인지
		            ArrayList<String> typeList = new ArrayList<String>();;
		            for (int j = 0; j < boardDTO.get(i).getPostFileImg().size(); j++) {
		               Pattern p = Pattern.compile("\\.([0-9a-zA-Z가-힣]*)");
		               Matcher m = p.matcher(boardDTO.get(i).getPostFileImg().get(j));
		               String extractHashTag = "";
		               while(m.find()) {
		                  extractHashTag = (m.group());
		                  extractHashTag= extractHashTag.replace(".", "");
		                  if(extractHashTag.equals("jpeg") ||extractHashTag.equals("png") || extractHashTag.equals("gif") ||extractHashTag.equals("JPG")||extractHashTag.equals("jpg")||extractHashTag.equals("PNG" )|| extractHashTag.equals("bmp")
		                		  ||extractHashTag.equals("mp4")  ||extractHashTag.equals("ogg")  ||extractHashTag.equals("webm") ) {
								typeList.add(extractHashTag);
							 }
		            }   
		            }
		            boardDTO.get(i).setPostType(typeList);

		           

		            // 좋아요 갯수
		            boardDTO.get(i).setLikeComments(boardMapper.likeComments(boardDTO.get(i).getPostNum()));
		            boardDTO.get(i).setCommentCount(boardMapper.commentCount(boardDTO.get(i).getPostNum()));
		            
		            
		            //작성자의 프로필
		            boardDTO.get(i).setPostWriterProfile(boardMapper.postWriterProfile(postWriter));

		            //작성자의 주소
		            boardDTO.get(i).setPostWriterAddr(boardMapper.postWriterAddr(postWriter));
		            //작성자의 닉네임
		            boardDTO.get(i).setNickName(boardMapper.postNickname(postWriter));

		            //시작 5개
		            if(boardDTO.get(i).getRn()>=1 && boardDTO.get(i).getRn()<6) {
		               String getPostWriter=boardDTO.get(i).getPostWriter();   
		               int userShow = memberMapper.userShow(getPostWriter);
		               if (userShow == 2) {
		                  followDTO followDTO = new followDTO();
		                  followDTO chkFollowDTO ;
		                  followDTO.setFollower(loginId);
		                  followDTO.setFollowing(getPostWriter);   
		                   chkFollowDTO = followMapper.checkFol(followDTO);
		                   if(chkFollowDTO != null) {
		                      followDTO.setFollowing(loginId);
		                      followDTO.setFollower(getPostWriter);   
		                      chkFollowDTO = followMapper.checkFol(followDTO);

		                      if(chkFollowDTO != null) {
		                         boardList.add(boardDTO.get(i));
		                         
		                      }
		                      
		                   }
		                  
		               }
		            else {
		                  boardList.add(boardDTO.get(i));
		               }
		               
		            }
		         }
		      
		            
		         // 친구추천
		         ArrayList<recommendDTO> recommend = new ArrayList<recommendDTO>();
		         ArrayList<recommendDTO> re = new ArrayList<recommendDTO>();
		         ArrayList<String> yourIds= boardMapper.getRecommendId(loginId);
		         for (int k = 0; k < yourIds.size(); k++) {
		            String yourId = yourIds.get(k);
		            recommendDTO reDTO = new recommendDTO();

		            reDTO.setMyId(loginId);
		            reDTO.setYourId(yourId);   
		            memberDTO recommendMember = memberMapper.memberInfo(yourId); 
		            reDTO.setYourNickName(recommendMember.getNickName());
		            reDTO.setYourIdProfile(recommendMember.getUserProfileName());
		            reDTO.setYourId(recommendMember.getUserId());
		            reDTO.setFriendConunt(memberMapper.getReasonCount(reDTO));
		            re.add(reDTO);

		         }
		         if(re.size()>5) {
		         for (int i = 0; i < 5; i++) {
		            recommend.add(re.get(i));   
		         }

		         }else {
		            for (int i = 0; i < re.size(); i++) {
		               recommend.add(re.get(i));   
		            }
		            
		         }
		         
		        System.out.println("::::::::::::::::::::"+boardList.size());
		         mav.addObject("recommend",recommend);
		         mav.addObject("postList",boardList);
		         mav.addObject("user", member);
		         mav.setViewName("/board/boardList");
		         return mav;
		      }


		 public ArrayList<boardDTO> boardListPage(int page) {
	         
	         // TODO Auto-generated method stub
	         String loginId= (String) session.getAttribute("loginId");
	      
	         ArrayList<boardDTO> boardList = new ArrayList<boardDTO>();

	         ArrayList<boardDTO> boardDTO = boardMapper.boardList(loginId);
	         System.out.println("dto::"+boardDTO);

	         int i ;
	         for (i = 0; i < boardDTO.size(); i++) {
	            
	            String postWriter=boardDTO.get(i).getPostWriter();

	            
	            // 이미지
	            boardDTO.get(i).setPostFileImg(boardMapper.setPostFileImg(boardDTO.get(i).getPostNum()));

	            
	            // 세션 아이디의 좋아요 여부(확인시 세션값과 같은지 확인)
	            likePostDTO likePostDTO = new likePostDTO();
	            likePostDTO.setPostNum(boardDTO.get(i).getPostNum());
	            likePostDTO.setUserId(loginId);
	            boardDTO.get(i).setPostLike(boardMapper.likeChk(likePostDTO));
	         
	            
	            // 이미지인지 영상인지
	            ArrayList<String> typeList = new ArrayList<String>();;
	            for (int j = 0; j < boardDTO.get(i).getPostFileImg().size(); j++) {
	               Pattern p = Pattern.compile("\\.([0-9a-zA-Z가-힣]*)");
	               Matcher m = p.matcher(boardDTO.get(i).getPostFileImg().get(j));
	            
	               String extractHashTag = "";
	               while(m.find()) {
	                  extractHashTag = (m.group());
	                  extractHashTag= extractHashTag.replace(".", "");
	                  if(extractHashTag.equals("jpeg") ||extractHashTag.equals("png") || extractHashTag.equals("gif") ||extractHashTag.equals("JPG")||extractHashTag.equals("jpg")||extractHashTag.equals("PNG" )|| extractHashTag.equals("bmp")
	                		  ||extractHashTag.equals("mp4")  ||extractHashTag.equals("ogg")  ||extractHashTag.equals("webm") ) {
							typeList.add(extractHashTag);
						 }
	               }   
	            }
	            boardDTO.get(i).setPostType(typeList);
  
	            
	            // 세션 아이디의 저장 여부
	            storagePostDTO storagePostDTO = new storagePostDTO();
	            storagePostDTO.setPostNum(boardDTO.get(i).getPostNum());
	            storagePostDTO.setUserId(loginId);
	            boardDTO.get(i).setPostBookmark(boardMapper.bookmark(storagePostDTO));
	            
	            // 좋아요 갯수
	            boardDTO.get(i).setLikeComments(boardMapper.likeComments(boardDTO.get(i).getPostNum()));
	            // 댓글 갯수
	            boardDTO.get(i).setCommentCount(boardMapper.commentCount(boardDTO.get(i).getPostNum()));
	            
	            //작성자정보
	            boardDTO.get(i).setPostWriterProfile(boardMapper.postWriterProfile(postWriter));
	            boardDTO.get(i).setPostWriterAddr(boardMapper.postWriterAddr(postWriter));
	            boardDTO.get(i).setNickName(boardMapper.postNickname(postWriter));   
	            // 5개씩
	            if(boardDTO.get(i).getRn()>=page && boardDTO.get(i).getRn()<page+5) {
	               String getPostWriter=boardDTO.get(i).getPostWriter();   
	               int userShow = memberMapper.userShow(getPostWriter);
	               if (userShow == 2) {
	                  followDTO followDTO = new followDTO();
	                  followDTO chkFollowDTO ;
	                  followDTO.setFollower(loginId);
	                  followDTO.setFollowing(getPostWriter);   
	                   chkFollowDTO = followMapper.checkFol(followDTO);
	                   if(chkFollowDTO != null) {
	                      followDTO.setFollowing(loginId);
	                      followDTO.setFollower(getPostWriter);   
	                      chkFollowDTO = followMapper.checkFol(followDTO);

	                      if(chkFollowDTO != null) {
	                         boardList.add(boardDTO.get(i));
	                         
	                      }
	                      
	                   }
	                  
	               }
	            else {
	                  boardList.add(boardDTO.get(i));
	               }            
	            
	            }
	         }


	      
	         
	         return boardList;
	      }

		public String likeUsers(int postNum) {
			// TODO Auto-generated method stub
			String loginId= (String) session.getAttribute("loginId");
			System.out.println(loginId);
			String result = "";
			likePostDTO likePostDTO = new likePostDTO();
			likePostDTO.setPostNum(postNum);
			likePostDTO.setUserId(loginId);
			String chk = boardMapper.likeChk(likePostDTO);
			System.out.println(chk);
			if(chk ==null) {
				chk = "";
			}
			if(chk.equals(loginId)) {
			
			result = "N";			
			boardMapper.deleteLick(likePostDTO);
			}else{
				boardMapper.insertLick(likePostDTO);
				result = "OK"	;			
			}
			
			
			
			return result;
		}

		public String likeVal(int postNum) {
			// TODO Auto-generated method stub
		int num = boardMapper.likeComments(postNum);
		String result = num+"";
			
			return result;
		}

		public String bookmark(int postNum) {
			// TODO Auto-generated method stub
			String loginId= (String) session.getAttribute("loginId");
			System.out.println(loginId);
			String result = "";
			storagePostDTO storagePostDTO = new storagePostDTO();
			storagePostDTO.setPostNum(postNum);
			storagePostDTO.setUserId(loginId);
			String chk = boardMapper.bookmark(storagePostDTO);

			if(chk == null) {
				chk = "";
			}
			if(chk.equals(loginId)) {
			result = "N";			
			boardMapper.deleteBookMark(storagePostDTO);
			}else{
				boardMapper.insertBookMark(storagePostDTO);
				result = "OK"	;			
			}
			
			
			return result;
		}

		public String following(String following) {
			// TODO Auto-generated method stub
			String result = "";
			String loginId= (String)session.getAttribute("loginId");
			String idSelect = memberMapper.idSelect(following);
			followDTO followDTO= new followDTO();
			followDTO.setFollower(loginId);
			followDTO.setFollowing(idSelect);
			

			int chkFollow= followMapper.following(followDTO);		
			if (chkFollow>0) {
				result="OK";
			}else {
				result="No";		
			}
			
			return result;
		}

		public String unFollowing(String following) {
			String result = "";
			String loginId= (String)session.getAttribute("loginId");
			String idSelect = memberMapper.idSelect(following);
			followDTO followDTO= new followDTO();
			followDTO.setFollower(loginId);
			followDTO.setFollowing(idSelect);
			

			int chkFollow= followMapper.unFollowing(followDTO);		
			if (chkFollow>0) {
				result="OK";
			}else {
				result="No";		
			}
			
			return result;
		}

		public String unFollowingModal(int postNum) {
			String result = "";
			String loginId= (String)session.getAttribute("loginId");
			String following = boardMapper.getFollowing(postNum);
			
			
			
			followDTO followDTO= new followDTO();
			followDTO.setFollower(loginId);
			followDTO.setFollowing(following);
			
			
			int chkFollow= followMapper.unFollowing(followDTO);		
			if (chkFollow>0) {
				result="OK";
			}else {
				result="No";		
			}
			
			return result;

		}

		public ModelAndView boardView(int postNum) {
			// TODO Auto-generated method stub
			mav = new  ModelAndView();
			String loginId= (String) session.getAttribute("loginId");
			int result = boardMapper.selectPostNum(postNum);
			if(result>0) {
			
			boardDTO boardList = boardMapper.boardView(postNum);
			
				String postWriter=boardList.getPostWriter();
	
				//이미지 불러오는 거
				boardList.setPostFileImg(boardMapper.setPostFileImg(boardList.getPostNum()));

				
				// 세션 아이디의 좋아요 여부(확인시 세션값과 같은지 확인)
				likePostDTO likePostDTO = new likePostDTO();
				likePostDTO.setPostNum(boardList.getPostNum());
				likePostDTO.setUserId(loginId);
				boardList.setPostLike(boardMapper.likeChk(likePostDTO));

				
				// 세션 아이디의 저장 여부
				storagePostDTO storagePostDTO = new storagePostDTO();
				storagePostDTO.setPostNum(boardList.getPostNum());
				storagePostDTO.setUserId(loginId);
				boardList.setPostBookmark(boardMapper.bookmark(storagePostDTO));
				
				// 이미지인지 영상인지
				ArrayList<String> typeList = new ArrayList<String>();;
				for (int j = 0; j < boardList.getPostFileImg().size(); j++) {
					Pattern p = Pattern.compile("\\.([0-9a-zA-Z가-힣]*)");
					Matcher m = p.matcher(boardList.getPostFileImg().get(j));
					System.out.println("img::::"+boardList.getPostFileImg().get(j));
					
					String extractHashTag = "";
					while(m.find()) {
						extractHashTag = (m.group());
						extractHashTag= extractHashTag.replace(".", "");
						System.out.println("extractHashTag:"+extractHashTag);
						if(extractHashTag.equals("jpeg") ||extractHashTag.equals("png") || extractHashTag.equals("gif") ||extractHashTag.equals("JPG")||extractHashTag.equals("jpg")||extractHashTag.equals("PNG" )|| extractHashTag.equals("bmp")
								||extractHashTag.equals("mp4")  ||extractHashTag.equals("ogg")  ||extractHashTag.equals("webm") ) {
							typeList.add(extractHashTag);
						 }
					}	
				}
				boardList.setPostType(typeList);

		     

				// 좋아요 갯수
				boardList.setLikeComments(boardMapper.likeComments(boardList.getPostNum()));
			
				//작성자의 프로필
				boardList.setPostWriterProfile(boardMapper.postWriterProfile(boardList.getPostWriter()));
				//작성자의 주소
				boardList.setPostWriterAddr(boardMapper.postWriterAddr(boardList.getPostWriter()));
				//작성자의 닉네임
				boardList.setNickName(boardMapper.postNickname(boardList.getPostWriter()));
				   int admin = memberMapper.loginIdAdmin(loginId);
			         mav.addObject("admin", admin);
			mav.addObject("postView", boardList);
			mav.setViewName("board/boardView");
			} else {
				int admin = memberMapper.loginIdAdmin(loginId);
		        mav.addObject("admin", admin);
		        mav.addObject("error","error");
		        mav.setViewName("board/boardView");
			}
			
			return mav;
		}

		public ModelAndView boardModifyForm(int postNum,postDTO postdto) {
			mav = new ModelAndView();
			ArrayList<String> fileDelete = boardMapper.getImgFileDelete(postNum);
			for (int i = 0; i < fileDelete.size(); i++) {
			    String path = "C:\\Users\\wish\\Documents\\workspace-spring-tool-suite-4-4.8.1.RELEASE\\teamProject\\src\\main\\webapp\\resources\\fileUpload\\";
				File file = new File(path+fileDelete.get(i));
				file.delete();
			}
			String postWriter = boardMapper.boardModifyForm1(postNum);
			String postContent = boardMapper.boardModifyForm2(postNum);
			String nickName = boardMapper.boardNickName(postWriter);

			postdto.setPostNum(postNum);
			postdto.setPostWriter(postWriter);
			postdto.setPostContent(postContent);
			postdto.setNickName(nickName);
			mav.addObject("postdto", postdto);
			mav.setViewName("board/boardModifyForm");
			return mav;
		}

		public String boardDelete(int postNum) {
			ArrayList<String> fileDelete = boardMapper.getImgFileDelete(postNum);
			for (int i = 0; i < fileDelete.size(); i++) {
			    String path = "C:\\Users\\wish\\Documents\\workspace-spring-tool-suite-4-4.8.1.RELEASE\\teamProject\\src\\main\\webapp\\resources\\fileUpload\\";
				File file = new File(path+fileDelete.get(i));
				file.delete();
			}
			
			
			String result = "";
			int postDelete= boardMapper.postDelete(postNum);		
			ArrayList<commentsDTO> commentsdto = boardMapper.commentsSelect(postNum);
			 System.out.println("commentsdto:"+commentsdto);
			int commentsDelete= boardMapper.commentsDelete(postNum);		
			int likePostDelete= boardMapper.likePostDelete(postNum);	
			for(int i=0; i<commentsdto.size();i++ ) {
				int commentNum = commentsdto.get(i).getCommentNum();
			int likeCommentsDelete= boardMapper.likeCommentsDelete(commentNum);
			int commentComments= boardMapper.commentCommentsDelete(commentNum);
			}
			int storagePostDelete= boardMapper.storagePostDelete(postNum);
			int reportPostDelete= boardMapper.reportPostDelete(postNum);		
			int tagPostDelete= boardMapper.tagpostDelete(postNum);		
			int multiFileDelete= boardMapper.multifileDelete(postNum);		
			
			if (postDelete>0) {
				result="OK";
			}else {
				result="No";		
			}
			
			return result;
		}
		
		//검색 서비스
		public ArrayList<memberDTO> searchUser(String nickName) {
			ArrayList<memberDTO> searchUser = boardMapper.searchUser(nickName);
			return searchUser;
		}

		public ArrayList<tagPostDTO> searchPost(String tagName) {
	         String loginId = (String)session.getAttribute("loginId");
	         ArrayList<tagPostDTO> searchPost = boardMapper.searchPost(tagName); // [#프론트,0] [#시도,0]
	         System.out.println("태그네임리스트부분" + searchPost);
	         for(int i = 0; i < searchPost.size(); i++) {
	            ArrayList<tagPostDTO> postNum = boardMapper.getTagPostNum(searchPost.get(i).getTagName());

	            int count = 0;
	            
	            
	            
	            for(int j = 0; j < postNum.size(); j++) {
	               String postWriter = boardMapper.boardModifyForm1(postNum.get(j).getPostNum());
	               System.out.println("게시글쓴이" + postWriter);
	               System.out.println("j::"+j);
	               if(loginId.equals(postWriter)) {
	                  count += 1;
	               } else {
	                  int checkShow = memberMapper.checkShow(postWriter); //
	                  if(checkShow == 0) {
	                      count += 1;
	                  } else if (checkShow == 1) {
	                     int num1 = memberMapper.onlyFollower(loginId,postWriter);
	                     if (num1 == 1) {
	                        count += 1;
	                     }
	                  } else if (checkShow == 2) {
	                     int num2 = memberMapper.checkMatFol(loginId,postWriter);
	                     if (num2 == 2) {
	                        count += 1;
	                     }
	                  }
	               }
	            }
	            
	            
	            
	            System.out.println("게시글 수 " + count);
	            searchPost.get(i).setCountPost(count);
	         }
	         
	         
	         return searchPost;
	      }

		

		public ModelAndView searchPostList(String tagName) { //#사진
	         mav = new ModelAndView();
	         tagPostDTO tagPostDTO = new tagPostDTO();
	         tagPostDTO.setTagName(tagName); //#사진
	         
	         ArrayList<tagPostDTO> getTagPostNum = new ArrayList<tagPostDTO>();
	         //
	         
	         String loginId = (String)session.getAttribute("loginId");
	         ArrayList<tagPostDTO> searchPost = boardMapper.searchPost2(tagName); // [#프론트,0] [#시도,0]
	         System.out.println("태그네임리스트부분" + searchPost);
	         for(int i = 0; i < searchPost.size(); i++) {
	            ArrayList<tagPostDTO> postNum = boardMapper.getTagPostNum(searchPost.get(i).getTagName());

	            int count = 0;
	            
	            
	            
	            for(int j = 0; j < postNum.size(); j++) {
	               String postWriter = boardMapper.boardModifyForm1(postNum.get(j).getPostNum());

	               if(loginId.equals(postWriter)) {
	            	  getTagPostNum.add(postNum.get(j));
	                  count += 1;
	               } else {
	                  int checkShow = memberMapper.checkShow(postWriter); //
	                  if(checkShow == 0) {
	                      getTagPostNum.add(postNum.get(j));
	                      count += 1;
	                  } else if (checkShow == 1) {
	                     int num1 = memberMapper.onlyFollower(loginId,postWriter);
	                     if (num1 == 1) {
	                        getTagPostNum.add(postNum.get(j));
	                        count += 1;
	                     }
	                  } else if (checkShow == 2) {
	                     int num2 = memberMapper.checkMatFol(loginId,postWriter);
	                     if (num2 == 2) {
	                        getTagPostNum.add(postNum.get(j));
	                        count += 1;
	                     }
	                  }
	               }
	            }
	            
	            
	            
	            
	            tagPostDTO.setCountPost(count);
	         }
	         
	         
	         
	         
	         
	         
	         
	         
	         
	         
	         
	         // getTagPostNum은 
	         // 최종적으로 넣는곳 thumbNail
	         ArrayList<multiFileDTO> thumbNail = new ArrayList<multiFileDTO>(); 
	         for(int i = 0; i < getTagPostNum.size(); i++) {
	            ArrayList<multiFileDTO> postList = boardMapper.postList(getTagPostNum.get(i).getPostNum()); // [1,'aaa.jpg'] [1,'bbb.jpg'] [1,'ccc.jpg']
	            if( thumbNail.size() != 0) {
	            for(int z = 0; z < thumbNail.size(); z++) {
	         
	            	if(thumbNail.get(z).getFiles().equals(postList.get(0).getFiles())) {
	            	      break;	
	            	}
	            	if(z == thumbNail.size()-1 ) {
	            		thumbNail.add(postList.get(0));            		            		
	            	}
	            	
	            }
	            }else {
            		thumbNail.add(postList.get(0));            	
	            }
	         }      
	         
	         for (int j = 0; j < thumbNail.size(); j++) {
	            Pattern p = Pattern.compile("\\.([0-9a-zA-Z가-힣]*)");
	            Matcher m = p.matcher(thumbNail.get(j).getFiles());
	            String extractHashTag = "";
	            while(m.find()) {
	               extractHashTag = (m.group());
	               extractHashTag= extractHashTag.replace(".", "");
	               if(extractHashTag.equals("jpeg") ||extractHashTag.equals("png") || extractHashTag.equals("gif") ||extractHashTag.equals("JPG")||extractHashTag.equals("jpg")||extractHashTag.equals("PNG" )|| extractHashTag.equals("bmp")
	                		  ||extractHashTag.equals("mp4")  ||extractHashTag.equals("ogg")  ||extractHashTag.equals("webm") ) {
	            	   thumbNail.get(j).setFileType(extractHashTag);
						 }
	         }   
	      
	      }
	         mav.addObject("multiFile", thumbNail);
	         mav.addObject("tagPostView",tagPostDTO);
	         mav.setViewName("board/findTag");
	         
	         return mav; 


	      }
		
		//인기게시글 페이지이동
				public ModelAndView postList(String postWriter) {
					mav = new ModelAndView();
					ArrayList<postDTO> getPostNum = new ArrayList<postDTO>();
					ArrayList<likePostDTO> popPost = boardMapper.popPost();
					for(int i = 0; i < popPost.size(); i++) {
						postDTO postDTO = new postDTO();
						postDTO.setPostNum(popPost.get(i).getPostNum());
						postDTO.setPostWriter(postWriter);
						
						postDTO popList = boardMapper.getPostNum(postDTO);
						
						if(popList != null) {
						int checkShow = memberMapper.checkShow(popList.getPostWriter()); //
						if(checkShow == 0) {
							 getPostNum.add(popList);
						} else if (checkShow == 1) {
							int num1 = memberMapper.onlyFollower(popList.getPostWriter(),postWriter);
							if (num1 == 1) {
								getPostNum.add(popList);
							}
						} else if (checkShow == 2) {
							int num2 = memberMapper.checkMatFol(popList.getPostWriter(),postWriter);
							if (num2 == 2) {
								getPostNum.add(popList);
							}
						}
						}
					}
				
					
					ArrayList<multiFileDTO> thumbNail = new ArrayList<multiFileDTO>();
					for(int i = 0; i < getPostNum.size(); i++) {
						ArrayList<multiFileDTO> postList = boardMapper.postList(getPostNum.get(i).getPostNum());
						thumbNail.add(postList.get(0));
					}
					for(int j = 0; j < thumbNail.size(); j++) {
						Pattern p = Pattern.compile("\\.([0-9a-zA-Z가-힣]*)");
						Matcher m = p.matcher(thumbNail.get(j).getFiles());
						String extractFileType = "";
						while(m.find()) {
							extractFileType = (m.group());
							extractFileType = extractFileType.replace(".","");
							 if(extractFileType.equals("jpeg") ||extractFileType.equals("png") || extractFileType.equals("gif") ||extractFileType.equals("JPG")||extractFileType.equals("jpg")||extractFileType.equals("PNG" )|| extractFileType.equals("bmp")
			                		  ||extractFileType.equals("mp4")  ||extractFileType.equals("ogg")  ||extractFileType.equals("webm") ) {
								 thumbNail.get(j).setFileType(extractFileType);
								 }
						}
					}

					
					
					mav.addObject("multiFile", thumbNail);
					mav.setViewName("board/popList");
					
					return mav;
				}
				
				//모달창 파일가져오기
				public extractFileDTO getFiles(int postNum) {
					ArrayList<multiFileDTO> getFiles = boardMapper.getFiles(postNum);
					extractFileDTO extractFiles = new extractFileDTO();
					ArrayList<String> postFileImg = new ArrayList<String>();
					ArrayList<String> postType = new ArrayList<String>();
					for(int i = 0; i < getFiles.size(); i++) {
						postFileImg.add(getFiles.get(i).getFiles());
						Pattern p = Pattern.compile("\\.([0-9a-zA-Z가-힣]*)");
						Matcher m = p.matcher(getFiles.get(i).getFiles());
						String extractHashTag = "";
						while(m.find()) {
							extractHashTag = (m.group());
							extractHashTag = extractHashTag.replace(".","");
							 if(extractHashTag.equals("jpeg") ||extractHashTag.equals("png") || extractHashTag.equals("gif") ||extractHashTag.equals("JPG")||extractHashTag.equals("jpg")||extractHashTag.equals("PNG" )|| extractHashTag.equals("bmp")
			                		  ||extractHashTag.equals("mp4")  ||extractHashTag.equals("ogg")  ||extractHashTag.equals("webm") ) {
								 postType.add(extractHashTag);
								 }
							
						}
						
						}
					extractFiles.setPostFileImg(postFileImg);
					extractFiles.setPostType(postType);

					return extractFiles;
				}
				

				

				public postDTO getPost(int postNum) {
					postDTO getPost = boardMapper.getPost(postNum);
					System.out.println("이 게시글의 내용정보" + getPost);
					return getPost;
				}
				
				public int getLike(int postNum) {
					int getLike = boardMapper.getLike(postNum);
					System.out.println("이 게시글의 좋아요갯수" + getLike);
					return getLike;
				}
				
				public String getLeftIcon(likePostDTO likePostDTO) {
					String result = "NO";
					int Sresult = boardMapper.getLeftIcon(likePostDTO);
					if(Sresult > 0) {
						result = "YES";
					}
					return result;
				}

				public String getRightIcon(storagePostDTO storagePostDTO) {
					String result = "NO";
					int Sresult = boardMapper.getRightIcon(storagePostDTO);
					if(Sresult > 0) {
						result = "YES";
					}
					return result;
				}

				public String likeCancel(likePostDTO likePostDTO) {
					String result = "NO";
					int CancelResult = boardMapper.likeCancel(likePostDTO);
					if(CancelResult > 0) {
						result = "OK";
					}
					return result;
				}
				
				public String like(likePostDTO likePostDTO) {
					String result = "NO";
					int likeResult = boardMapper.like(likePostDTO);
					if(likeResult > 0) {
						result = "OK";
					}
					return result;
				}

				public String storageCancel(storagePostDTO storagePostDTO) {
					String result = "NO";
					int CancelResult = boardMapper.storageCancel(storagePostDTO);
					if(CancelResult > 0) {
						result = "OK";
					}
					return result;
				}
				
				public String storage(storagePostDTO storagePostDTO) {
					String result = "NO";
					int storageResult = boardMapper.storage(storagePostDTO);
					if(storageResult > 0) {
						result = "OK";
					}
					return result;
				}

				public String getProfile(String userId) {
					String getProfile = memberMapper.getProfile(userId);
					return getProfile;
				}
				
				public String alreadyFol(int postNum) {
		               String loginId = (String) session.getAttribute("loginId");
		               String postWriter = boardMapper.boardModifyForm1(postNum);
		               String result = null;
		               if(loginId == postWriter) {
		                  result = "ME";
		               } else {
		                  
		                  int Cresult = memberMapper.onlyFollower(loginId, postWriter);
		                  if(Cresult == 1) {
		                     result = "OK";
		                  } else {
		                     result = "NO";
		                  }
		               }
		               return result;
		            }

		            public String getUserId(int postNum) {
		               String userId = boardMapper.boardModifyForm1(postNum);
		               return userId;
		            }

		            public ModelAndView goMessage(String loginId, int postNum) {
		               mav = new ModelAndView();
		               
		               String partner = boardMapper.boardModifyForm1(postNum);
		               
		               mav.addObject("partner", partner);
		               mav.setViewName("/msg/directmsg");
		               
		               return mav;
		            }
				

				
				
}
		
	
	
		
