package com.teamProject.mapper;


import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.teamProject.DTO.boardDTO;
import com.teamProject.DTO.commentsDTO;
import com.teamProject.DTO.likePostDTO;
import com.teamProject.DTO.memberDTO;
import com.teamProject.DTO.multiFileDTO;
import com.teamProject.DTO.pageDTO;
import com.teamProject.DTO.postDTO;
import com.teamProject.DTO.storagePostDTO;
import com.teamProject.DTO.tagPostDTO;



public interface boardMapper {
	@Select("SELECT NVL(MAX(POSTNUM),0) FROM POST")
	public int getMaxPostnum();
	
	@Insert("INSERT INTO MULTIFILE(POSTNUM,FILES) VALUES(#{postNum},#{fileName})")
	public int multiFile(postDTO postdto);
	
	@Insert("INSERT INTO POST(POSTNUM,POSTWRITER,POSTCONTENT,POSTTIME,POSTREPORT) VALUES(#{postNum},#{postWriter},#{postContent},SYSDATE,0)")
	public int insertPost(postDTO postdto);
	
	@Insert("INSERT INTO TAGPOST(POSTNUM,TAGNAME) VALUES(#{postNum},#{tagName})")
	public int tagPost(tagPostDTO tagdto);
	
	@Update("UPDATE MULTIFILE SET Files = #{fileName} WHERE POSTNUM = #{postNum}")
	public int fileModify(postDTO postdto);
	
	@Update("UPDATE POST SET POSTCONTENT = #{postContent} WHERE POSTNUM = #{postNum}")
	public int postModify(postDTO postdto);
	
	@Delete("DELETE FROM TAGPOST WHERE POSTNUM=#{postNum}")
	public int tagPostDelete(postDTO postdto);
	
	@Delete("DELETE FROM MULTIFILE WHERE POSTNUM = #{postNum}")
	public int multiFileDelete(postDTO postdto);
	
	@Select("SELECT POSTWRITER FROM POST WHERE POSTNUM=#{postNum}")
	public String boardModifyForm1(int postNum);
	
	@Select("SELECT POSTCONTENT FROM POST WHERE POSTNUM=#{postNum}")
	public String boardModifyForm2(int postNum);
	
//현근
	@Select ("select post.*,ROW_NUMBER() OVER (order by posttime DESC)rn , TRUNC(((SYSDATE-TO_DATE(TO_CHAR(POSTTIME,'yy-mm-dd hh24:mi:ss'),'yy-mm-dd hh24:mi:ss'))*24),0)postTimeSet from post where postwriter in (SELECT following from follow where follower = #{loginId}) order by posttime DESC")
	ArrayList<boardDTO> boardList(String loginId);
	
	@Select ("select userProfileName from users where userId = #{postWriter}")
	String postWriterProfile(String postWriter);

	@Select ("select userAddr from users where userId = #{postWriter}")
	String postWriterAddr(String postWriter);

	@Select ("select nickname from users where userId = #{postWriter}")
	String postNickname(String postWriter);

	@Select ("select files from multifile where postnum = #{postNum}")
	ArrayList<String> setPostFileImg(int postNum);
		
	@Select ("select userId from LIKEPOST where postnum = #{postNum} and userId = #{userId}")
	String likeChk(likePostDTO likePostDTO);
	
	@Insert ("insert into likePost values(#{userId},#{postNum})")
	void insertLick(likePostDTO likePostDTO);

	@Delete ("delete from likePost where userid=#{userId} and postnum=#{postNum}	")
	void deleteLick(likePostDTO likePostDTO);
	
	@Select ("select count(*) from LIKEPOST where postNum = #{postNum}")
	int likeComments(int postNum);
	
	@Select ("select count(*) from comments where postNum = #{postNum}")
	int commentCount(int postNum);
	
	@Select ("select userId from storagepost where postnum = #{postNum} and userId = #{userId}")
	String bookmark(storagePostDTO storagePostDTO);

	@Delete ("delete from storagepost where userid=#{userId} and postnum=#{postNum}	")
	void deleteBookMark(storagePostDTO storagePostDTO);

	@Insert ("insert into storagepost values(#{userId},#{postNum},sysdate)")
	void insertBookMark(storagePostDTO storagePostDTO);

	@Select ("SELECT distinct FOLLOWING AS FOLLOWING FROM FOLLOW WHERE FOLLOWER IN (SELECT FOLLOWING FROM FOLLOW WHERE FOLLOWER = #{loginId}) AND FOLLOWING NOT IN (SELECT FOLLOWING FROM FOLLOW WHERE FOLLOWER =#{loginId}) AND FOLLOWING != #{loginId}")
	ArrayList<String> getRecommendId(String loginId);
 
	@Select("select POSTWRITER from post where postNum= #{postNum}")
	String getFollowing(int postNum);

	@Select ("select post.*, trunc(((SYSDATE-TO_DATE(TO_CHAR(POSTTIME,'yy-mm-dd hh24:mi:ss'),'yy-mm-dd hh24:mi:ss'))*24),0) postTimeSet from post where postNum =  #{postNum}")
	boardDTO boardView(int postNum);


	@Delete("DELETE FROM POST WHERE POSTNUM = #{postNum}")
	public int postDelete(int postNum);
	
	@Delete("DELETE FROM COMMENTS WHERE POSTNUM = #{postNum}")
	public int commentsDelete(int postNum);
	
	@Delete("DELETE FROM LIKEPOST WHERE POSTNUM = #{postNum}")
	public int likePostDelete(int postNum);
	
	@Delete("DELETE FROM LIKECOMMENTS WHERE COMMENTNUM = #{commentNum}")
	public int likeCommentsDelete(int commentNum);
	
	@Delete("DELETE FROM STORAGEPOST WHERE POSTNUM = #{postNum}")
	public int storagePostDelete(int postNum);
	
	@Delete("DELETE FROM REPORTPOST WHERE POSTNUMBER = #{postNum}")
	public int reportPostDelete(int postNum);
	
	@Delete("DELETE FROM TAGPOST WHERE POSTNUM = #{postNum}")
	public int tagpostDelete(int postNum);
	
	@Delete("DELETE FROM MULTIFILE WHERE POSTNUM = #{postNum}")
	public int multifileDelete(int postNum);
	
	@Delete("DELETE FROM COMMENT_COMMENTS WHERE COMMENTNUM = #{commentNum}")
	public int commentCommentsDelete(int commentNum);
	
	@Select("SELECT COMMENTNUM FROM COMMENTS WHERE POSTNUM =#{postNum}")
	public ArrayList<commentsDTO> commentsSelect(int postNum);
	
	@Select("SELECT COUNT(*) FROM POST WHERE POSTWRITER=#{userid} ")
	int pCount(String userid);
	
	@Select("SELECT * FROM POST WHERE POSTWRITER=#{nickname}")
	ArrayList<boardDTO> pList(String nickname);

	@Select("SELECT * FROM USERS WHERE NICKNAME LIKE '%'||#{nickName}||'%'")
	public ArrayList<memberDTO> searchUser(String nickName);

	@Select("SELECT DISTINCT(TAGNAME) FROM TAGPOST WHERE TAGNAME LIKE '%'||#{tagName}||'%'")
	public ArrayList<tagPostDTO> searchPost(String tagName);
	
	@Select("SELECT DISTINCT(TAGNAME) FROM TAGPOST WHERE TAGNAME = #{tagName}")
	public ArrayList<tagPostDTO> searchPost2(String tagName);
	
	@Select("SELECT COUNT(DISTINCT(POSTNUM)) FROM TAGPOST WHERE TAGNAME= #{tagName}")
	public int countPost(String tagName);
	
	@Select("SELECT DISTINCT(POSTNUM) FROM TAGPOST WHERE TAGNAME= #{tagName}")
	public ArrayList<tagPostDTO> getTagPostNum(String tagName);
	
	@Select("SELECT * FROM MULTIFILE WHERE POSTNUM = #{postNum}")
	public ArrayList<multiFileDTO> postList(int postNum);

	@Select("SELECT POSTNUM FROM LIKEPOST GROUP BY POSTNUM ORDER BY COUNT(USERID) DESC")
	public ArrayList<likePostDTO> popPost();
	
	@Select("SELECT * FROM POST WHERE POSTNUM = #{postNum} AND POSTWRITER != #{postWriter}")
	public postDTO getPostNum(postDTO postDTO);
	
	@Select("SELECT POSTNUM FROM POST WHERE POSTNUM NOT IN (SELECT POSTNUM FROM LIKEPOST) AND POSTWRITER != #{postWriter}")
	public ArrayList<postDTO> zeroLikePost(String postWriter);
	
	@Select("SELECT * FROM MULTIFILE WHERE POSTNUM = #{postNum}")
	public ArrayList<multiFileDTO> getFiles(int postNum);
	
	@Select ("SELECT POST.*,TRUNC(((SYSDATE-TO_DATE(TO_CHAR(POSTTIME,'YY-MM-DD HH24:MI:SS'),'YY-MM-DD HH24:MI:SS'))*24),0) POSTTIMESET FROM POST WHERE POSTNUM = #{postNum}")
	public postDTO getPost(int postNum);
	
	@Select ("SELECT COUNT(*) FROM LIKEPOST WHERE USERID = #{userId} AND POSTNUM = #{postNum}")
	public int getLeftIcon(likePostDTO likePostDTO);
	
	@Select ("SELECT COUNT(*) FROM LiKEPOST WHERE POSTNUM = #{postNum}")
	public int getLike(int postNum);
	
	@Delete ("DELETE FROM LIKEPOST WHERE USERID = #{userId} AND POSTNUM = #{postNum}")
	public int likeCancel(likePostDTO likePostDTO);
	
	@Insert ("INSERT INTO LIKEPOST VALUES (#{userId},#{postNum})")
	public int like(likePostDTO likePostDTO);
	
	@Select ("SELECT COUNT(*) FROM STORAGEPOST WHERE USERID = #{userId} AND POSTNUM = #{postNum}")
	public int getRightIcon(storagePostDTO storagePostDTO);
	
	@Delete ("DELETE FROM STORAGEPOST WHERE USERID = #{userId} AND POSTNUM = #{postNum}")
	public int storageCancel(storagePostDTO storagePostDTO);
	
	@Insert ("INSERT INTO STORAGEPOST VALUES(#{userId},#{postNum},sysdate)")
	public int storage(storagePostDTO storagePostDTO);

	@Select("SELECT * FROM (SELECT ROWNUM RN,POST.* FROM (SELECT ROWNUM RN1,POST.* FROM POST ORDER BY POSTREPORT DESC) POST) WHERE RN BETWEEN #{startRow} AND #{endRow}")
	public ArrayList<postDTO> adminPostList(pageDTO pageDTO);

	@Select("SELECT COUNT(*) FROM POST")
	public int getPostListCnt();

	@Select("SELECT * FROM (SELECT ROWNUM RN,POST.* FROM (SELECT ROWNUM RN1, POST.* FROM POST WHERE POSTWRITER = #{postWriter} ORDER BY POSTREPORT DESC) POST) WHERE RN BETWEEN #{startRow} AND #{endRow} ")
	public ArrayList<postDTO> personalReport(HashMap<String, Object> map);

	@Select("SELECT COUNT(*) FROM POST WHERE POSTWRITER = #{postWriter}")
	public int getPersonalReportCnt(String postWriter);

	@Select("SELECT files FROM multifile WHERE postNum=#{postNum}")
	public ArrayList<String> getImgFileDelete(int postNum);
	@Select("SELECT NICKNAME FROM USERS WHERE USERID=#{postWriter}")
	public String boardNickName(String postWriter);

	@Select("SELECT count(*) FROM POST where POSTNUM = #{postNum}")
	public int selectPostNum(int postNum);

	

	


}
