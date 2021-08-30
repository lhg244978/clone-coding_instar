package com.teamProject.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.teamProject.DTO.memberDTO;
import com.teamProject.DTO.recommendDTO;

public interface memberMapper {
	//진수
	@Select("SELECT USERID FROM USERS WHERE NICKNAME=#{nickName}")
	public String userIdSearch(memberDTO memberdto);
	@Select("SELECT USERPW FROM USERS WHERE USERID=#{userId}")
	public String pwSearch(memberDTO memberdto);

//현근
@Select	("select * from users where userId = #{loginId} ")
memberDTO memberInfo(String loginId);

@Select ("select following from follow where follower = #{loginId} ")
ArrayList<String> memberFollwing(String loginId);

@Select	("select nickName, userProfile,useraddr from users where userId = #{loginId} ")
memberDTO postInfo(String string);

@Select ("SELECT COUNT(*) FROM FOLLOW WHERE FOLLOWING IN (SELECT FOLLOWER FROM FOLLOW WHERE FOLLOWING =#{yourId}) AND FOLLOWER = #{myId}")
int getReasonCount(recommendDTO reDTO);


//준우형
@Insert("INSERT INTO USERS(USERNAME,USERID,USERPW,USERBIRTH,USERPHONE,USERADDR,USERSEX,USERPROFILENAME,NICKNAME,USERINTRO,USERSHOW,ADMIN) VALUES(#{userName},#{userId},#{userPw},#{userBirth},#{userPhone},#{userAddr},#{userSex},#{userProfileName},#{nickName},#{userIntro},0,#{admin})")
public int memberJoin(memberDTO memberdto);

@Select("SELECT NICKNAME FROM USERS WHERE USERID = #{userId} AND USERPW = #{userPw}")
public String memberLogin(memberDTO memberdto);

@Select("SELECT ADMIN FROM USERS WHERE USERID = #{userId} AND USERPW = #{userPw}")
public int adminCheck(memberDTO memberdto);

@Select("SELECT * FROM USERS WHERE NICKNAME = #{nickName}")
public memberDTO memberView(String nickName);


@Update("UPDATE USERS SET USERNAME=#{userName},USERID=#{userId},USERPHONE=#{userPhone},USERADDR=#{userAddr},USERSEX=#{userSex},USERPROFILENAME=#{userProfileName},USERINTRO=#{userIntro},USERSHOW=#{userShow} WHERE NICKNAME = #{nickName}")
public int memberModifyProcess(memberDTO memberdto);

@Update("UPDATE USERS SET USERPW = #{userPw} WHERE NICKNAME = #{nickName}")
public int memberPwModifyProcess(memberDTO memberdto);



@Select ("SELECT * FROM USERS WHERE USERID = (SELECT POSTWRITER FROM POST WHERE POSTNUM = #{postNum})")
public memberDTO getUser(int postNum);

@Select ("SELECT USERPROFILENAME FROM USERS WHERE USERID = #{userId}")
public String getProfile(String userId);

public String getUserNickName(memberDTO memberDTO);
public String getUserName(memberDTO memberDTO);
public String getUserProfile(memberDTO memberDTO);

@Select ("SELECT * FROM USERS WHERE USERID=#{userid} ")
public memberDTO myPage(String userid);

@Select("SELECT NICKNAME FROM USERS WHERE USERID=#{userid} ")
public String nickname(String userid);

@Select("SELECT * FROM USERS WHERE USERID = #{loginId}")
public memberDTO membermodifyForm(String loginId);
@Select("SELECT userShow FROM USERS WHERE USERID = #{getPostWriter}")
public int userShow(String getPostWriter);

@Select("SELECT USERSHOW FROM USERS WHERE USERID=#{userid}")
public String userShow_other(String userid);

@Select("SELECT FOLLOWING FROM FOLLOW WHERE FOLLOWER=#{loginId} AND FOLLOWING=#{userid}")
public String checkFollower(@Param("loginId") String loginId, @Param("userid") String userid);

@Select("SELECT admin FROM USERS WHERE USERID=#{loginId}")
public int loginIdAdmin(String loginId);

@Select("SELECT USERSHOW FROM USERS WHERE USERID = #{userId}")
public int checkShow(String userId);


@Select("SELECT userid FROM USERS WHERE nickname=#{following}")
public String idSelect(String following);

@Select("SELECT COUNT(*) FROM FOLLOW WHERE FOLLOWER = #{postWriter} AND FOLLOWING = #{postWriter2}")
public int onlyFollower(@Param("postWriter") String postWriter, @Param("postWriter2") String postWriter2);

@Select("SELECT COUNT(*) FROM FOLLOW WHERE (FOLLOWER = #{postWriter} AND FOLLOWING = #{postWriter2}) OR (FOLLOWER = #{postWriter2} AND FOLLOWING = #{postWriter})")
public int checkMatFol(@Param("postWriter") String postWriter, @Param("postWriter2") String postWriter2);

@Select("SELECT USERID FROM USERS WHERE USERID = #{userId}")
public String idCheck(String userId);

@Select("SELECT NICKNAME FROM USERS WHERE NICKNAME = #{nickName}")
public String nickNameCheck(String nickName);
}
