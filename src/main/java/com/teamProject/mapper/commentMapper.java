package com.teamProject.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.teamProject.DTO.comment_CommentsDTO;
import com.teamProject.DTO.commentsDTO;
import com.teamProject.DTO.likeCommentsDTO;

public interface commentMapper {
	@Select ("select comments.*, trunc(((SYSDATE-TO_DATE(TO_CHAR(commenttime,'yy-mm-dd hh24:mi:ss'),'yy-mm-dd hh24:mi:ss'))*24),0) commentTimeSet from comments where postNum =  #{postNum} order by commenttime DESC")
	ArrayList<commentsDTO> postComment(int postNum);


	@Select ("select count(*) from comments where postnum = #{postNum}")
	String commentChk(int postNum);
	
	@Insert ("insert into comments values (#{commentNum},#{postNum},#{commentWriter},#{commentContent},sysdate,#{commentSec})")
	int commentInsert(commentsDTO dto);
	
	@Select ("select COMMENT_COMMENTS.*, TRUNC(((SYSDATE-TO_DATE(TO_CHAR(COMMENT_COMMENTTIME,'yy-mm-dd hh24:mi:ss'),'yy-mm-dd hh24:mi:ss'))*24),0) COMMENT_COMMENTIMESET from COMMENT_COMMENTS where COMMENTNUM = #{commentNum} order by COMMENT_COMMENTTIME DESC")
	ArrayList<comment_CommentsDTO> comment_Comments(int commentNum);
	
	@Select("select nickname from users where userId= #{c_CWriter}")
	String commentNickName(String c_CWriter);

	@Select ("select count(*) from comment_comments where commentnum = #{commentNum}")
	String comment_CommentChk(int commentNum);



	@Insert ("insert into comment_comments values (#{commentNum},#{comment_CommentNum},#{comment_CommentWriter},#{comment_CommentContent},sysdate)")
	int insertComent_Comment(comment_CommentsDTO dto);




	@Select ("select userId from likecomments where userId= #{userId} and commentnum=#{commentNum}")
	String likeCommentChk(likeCommentsDTO likeCommentsDTO);

	@Delete ("delete from likecomments where userId = #{userId} and commentnum = #{commentNum}")
	void deleteLick(likeCommentsDTO likeComments);

	@Insert ("insert into likecomments values( #{userId}, #{commentNum})")
	void insertLick(likeCommentsDTO likeComments);

	@Select ("select comments.*, trunc(((SYSDATE-TO_DATE(TO_CHAR(commenttime,'yy-mm-dd hh24:mi:ss'),'yy-mm-dd hh24:mi:ss'))*24),0) commentTimeSet , (select count(*) from likecomments WHERE likecomments.commentnum = comments.commentnum) counts from comments WHERE comments.postnum = #{postNum} ORDER by counts DESC")
	ArrayList<commentsDTO> postCommentLike(int postNum);

	
	@Select ("select count(*) from likecomments where commentnum = #{commentNum}")
	int commentLikeCount(int commentNum);

	@Insert ("INSERT INTO COMMENTS VALUES(#{commentNum},#{postNum},#{commentWriter},#{commentContent},SYSDATE,#{commentSec})")
	public int commentWrite(commentsDTO commentsDTO);
	
	@Delete ("DELETE FROM COMMENTS WHERE COMMENTNUM = #{commentNum}")
	public int commentDelete(int commentNum);
	
	@Select ("SELECT NVL(MAX(COMMENTNUM),0) FROM COMMENTS")
	public int maxCommentNum();
	
	@Select ("SELECT * FROM COMMENT_COMMENTS WHERE COMMENTNUM = #{commentNum} ORDER BY COMMENT_COMMENTTIME")
	public ArrayList<comment_CommentsDTO> showCC(int commnetNum);
	
	@Insert ("INSERT INTO COMMENT_COMMENTS VALUES(#{commentNum},#{comment_CommentNum},#{comment_CommentWriter},#{comment_CommentContent},SYSDATE)")
	public int insertCCCon(comment_CommentsDTO comment_CommentsDTO);
	
	@Delete ("DELETE FROM COMMENT_COMMENTS WHERE COMMENTNUM=#{commentNum}")
	public void comment_CommentDelete(int commentNum);
	
	@Select ("SELECT NVL(MAX(COMMENT_COMMENTNUM),0) FROM COMMENT_COMMENTS")
	public int maxCCommentNum();

	@Select ("SELECT COMMENTS.*,TRUNC(((SYSDATE-TO_DATE(TO_CHAR(COMMENTTIME,'YY-MM-DD HH24:MI:SS'),'YY-MM-DD HH24:MI:SS'))*24),0) COMMENTTIMESET FROM COMMENTS WHERE POSTNUM = #{postNum} ORDER BY COMMENTTIME ASC" )
	public ArrayList<commentsDTO> getComments(int postNum);
	
	
	@Delete ("DELETE FROM COMMENT_COMMENTS WHERE COMMENT_COMMENTNUM = #{comment_CommentNum}")
	public int deleteCCCon(int comment_CommentNum);

	@Select ("select userid from LIKECOMMENTS where commentNum = #{commentNum}")
	String commentUserId(int commentNum);
}
