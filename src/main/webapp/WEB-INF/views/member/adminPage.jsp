<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>geunstagram</title>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/profile.css">
    <link rel="stylesheet" href="resources/css1/detail-page.css">
    <link rel="shortcut icon" href="resources/imgs/instagram.png">
    <!-- 페이지네이션 바 -->
    
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    
    <!-- 슬라이드관련 -->
	<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
	<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
	<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
    
    
<style>
	table{
		width:100%;
		font-size:15px;
	}
	table,tr,th{
		padding:10px;
	}
	.waring_btn{
		background: #3897f0;
    	border-color: #3897f0;
    	color: #fff;
    	border-radius: 3px;
    	border-style: solid;
    	border-width: 1px;
    	font-size: 14px;
    	font-weight: 600;
    	line-height: 28px;
    	outline: none;
    	width: 100%;
    	padding: 0;
    	margin-top: 10px;
	}
	.pagination>.active>a{
		background: #3897f0;
    	border-color: #3897f0;
    	color: #fff;
	}
	.detail .about>a{
		height: 25px;
 	    display: flex;
	    justify-content: center;
	    align-items: center;
	    width: 120px;
	    border: 1px solid #dbdbdb;
	    border-radius: 3px;
	    color: #262626;
	    padding: 3px 20px;
	    font-weight: 600;
	    vertical-align: text-bottom;
	    text-decoration: none;
	    box-sizing: border-box;
	}

	/* 모달 관련 */
	.modal {
        text-align: center;
	}
	@media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
    	   }
	}
	.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
	}

	textarea:focus {
		outline : none;
	}
</style>

</head>
<body>


<section id="container">

    <div id="main_container">

        <section class="b_inner">

            <div class="hori_cont">
                <div class="profile_wrap">
                    <div class="profile_img">
                        <img src="resources/profileImg/${memberDTO.userProfileName }">
                    </div>
                </div>

                <div class="detail">
                    <div class="top">
                        <div class="user_name" style="width:150px;">관리자 ${memberDTO.nickName }</div>
                    </div>
               
                </div>
            </div>

            <div class="mylist_contents contents_container active">
                <table>
                	<thead>
                		<tr>
                			<th>글번호</th>
                			<th>작성자</th>
                			<th>작성시간</th>
                			<th>신고횟수</th>
                			<th></th>
                		</tr>
                	</thead>
                	<tfoot>
                		<tr>
                			<th>글번호</th>
                			<th>작성자</th>
                			<th>작성시간</th>
                			<th>신고횟수</th>
                			<th></th>
                		</tr>
                	</tfoot>
                	<tbody>
                	<c:forEach var="pList" items="${postList}">
                		<tr>
							<th>${pList.postNum }</th>
							<th>
								<div class="dropdown no-arrow mb-0">
                                        <a class="dropdown-toggle" href="#"
                                            id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            ${pList.nickName}
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item" href="otherPage?userId=${pList.postWriter}">회원정보</a>
                                            <a class="dropdown-item" href="#" onclick="postView('${pList.postNum}')">게시글 보기</a>
                                            <a class="dropdown-item" href="#" onclick="sendDanger('${pList.postWriter}','${pList.postNum}')">경고 메세지 보내기</a>
                                            <a class="dropdown-item" href="personalReport?postWriter=${pList.postWriter}&&nickName=${memberDTO.nickName}">이 사람의 게시글 보기</a>
                                        </div>
                                    </div>
							</th>
							<th>${pList.postTime }</th>
							<th>
							<c:choose>
								<c:when test="${pList.postReport > 0 }">
								<div class="dropdown no-arrow mb-0">
                            		<a class="dropdown-toggle" href="#" id="dropdownMenuButton" data-toggle="dropdown" 
                            		aria-haspopup="true" aria-expanded="false">
                             		${pList.postReport }
                               		</a>
                           			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            			<a class="dropdown-item" href="#" onclick="reportReason('${pList.postNum}')">신고 사유</a>
                            		</div>
                            	</div>
                            	</c:when>
                            	<c:otherwise>
                            		${pList.postReport }
                            	</c:otherwise>
                            </c:choose>
							</th>
                			<th>
                			<button class="waring_btn" style="cursor:pointer;" onclick="deletePostModal('${pList.postNum }','${pList.postWriter}')">삭제</button>
                			</th>
                		</tr>
                	</c:forEach>
                	</tbody>
                </table>
            </div>
            
            <div style="float:right">
            	<ul class="pagination">
            	
            	<c:choose>
							<c:when test="${pageDTO.page <= 1 }">
								<li class="paginate_button page-item previous disabled">
									<a href="#" class="page-link">이전</a>
								</li>
							</c:when>
							<c:when test="${pageDTO.page > 1 }">
								<li class="paginate_button page-item previous">
									<a href="goAdminPage?page=${pageDTO.page-1}&&nickName=${memberDTO.nickName}" class="page-link">이전</a>
								</li>
							</c:when>
						</c:choose>
						
						<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1" var="pageNum">
							<c:choose>
								<c:when test="${pageDTO.page == pageNum }">
									<li class="paginate_button page-item active">
										<a href="#"	class="page-link">${pageNum}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="paginate_button page-item">
										<a href="goAdminPage?page=${pageNum}&&nickName=${memberDTO.nickName}" class="page-link">${pageNum}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>	
							
						<c:choose>
							<c:when test="${pageDTO.page < pageDTO.maxPage }">
								<li class="paginate_button page-item next">
									<a href="goAdminPage?page=${pageDTO.page + 1}&&nickName=${memberDTO.nickName}" class="page-link">다음</a>
								</li>
							</c:when>
							<c:when test="${pageDTO.page >= pageDTO.maxPage }">
								<li class="paginate_button page-item next disabled">
									<a href="#" class="page-link">다음</a>
								</li>
							</c:when>
						</c:choose>
            	
            	</ul>
            </div>

        </section>
    </div>
    
    <!-- reportModal -->
<div class="modal fade" id="reportReasonModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content" style="width:300px;">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">게시글 신고사유</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<span id="reportPostNum"></span> 번 게시글 신고사유<br>
				<div style="height:200px;overflow:auto;">
				<table id="reportReasons" style="text-align:center;">
				</table>
				</div>
			</div>
			<div class="modal-footer">
			</div>
		</div>
	</div>
</div>

<!-- deleteModal -->
<div class="modal fade" id="deletePostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">게시글 삭제</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<span id="deletePostNum"></span> 번 게시글을 정말 삭제하겠습니까?
				<input type="hidden" id="deletePostWriter">
			</div>
			<div class="modal-footer">
				<button class="waring_btn" type="button" style="cursor:pointer;" onclick="deletePost(value,value)">삭제하기</button>
				<button class="waring_btn" type="button" style="cursor:pointer;" onclick="cancelDelete()">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 게시글 보기 -->
<!-- 모달내용 시작 -->

	<div class="modal fade" id="boardViewModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document" style="margin-right:420px;">
			<div class="modal-content" style="width:936px;">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="text-align: center; padding: 0"
					id="basicModal">

					<!-- 모달 안의 내용 -->
					<div class="contents_box" style="height:625px;">

						<article class="contents cont01" style="height:625px;">

							<div class="img_section" style="width:598px;">
								<div class="trans_inner">
									<div>
										
									</div>
								</div>
							</div>


							<div class="detail--right_box">

								<header class="top" id="showUser">
									
									<!-- 게시글쓴이 정보 -->
									<div class="user_container">
										<div class="profile_img">
											
										</div>
										<div class="user_name">
											<div class="nick_name">KindTiger</div>
											<div class="country">Seoul, South Korea</div>
										</div>
									</div>
									<div class="sprite_more_icon" data-name="more">
										<ul class="more_detail">
											<li>팔로우</li>
											<li>수정</li>
											<li>삭제</li>
										</ul>
									</div>
									<!-- 게시글쓴이 정보 끝 -->
								
								</header>

								<section class="scroll_section box1" style="border-bottom:solid 0.1px lightgray; height:300px;">

									<!-- 댓글들 -->
									<div id="showComments" style="text-align:left;">
									<div class="user_container-detail">
										<div class="user">
											
										</div>
										<div class="comment">
											<span class="user_id">in0.lee</span>너무귀엽네요 ㅎㅎㅎ맞팔해요~!
											<div class="time">
												2시간 <span class="try_comment">답글 달기</span>
											</div>
											
										</div>
									</div>
									</div>	
									<!-- 댓글이 끝나는 부분 -->

								</section>

                        <div class="bottom_icons">
                            <div class="left_icons" id="showLeftIcon">
                                <div class="heart_btn">
                                    <div class="sprite_heart_icon_outline" data-name="heartbeat"></div>
                                </div>
                                <div>
                                    <div class="sprite_bubble_icon"></div>
                                </div>
                                <div>
                                    <div class="sprite_share_icon" data-name="share"></div>
                                </div>
                            </div>

                            <div class="right_icon" id="showRightIcon">
                                <div class="sprite_bookmark_outline" data-name="book-mark"></div>
                            </div>
                        </div>
								<div class="admin_container" id="showPost" style="height:60px; overflow:auto;">
										<!-- 글쓴이의 게시글 내용 -->
										
										<div class="comment">
											<span class="user_id">Kindtiger</span>강아지가 많이 힘든가보다ㅜㅜㅜㅜㅜ조금만힘내
										</div>
										
										<!-- 글쓴이의 게시글 내용끝 -->
									</div>
								
								<!-- 좋아요랑 댓글다는 부분  -->
								<div id="showLike">
								<div class="count_likes">
									좋아요 <span class="count">2,351</span> 개
								</div>
								<div class="timer">2시간</div>

								<div class="commit_field">
									<input type="text" placeholder="댓글달기..">

									<div class="upload_btn">게시</div>
								</div>
								</div>
								<!-- 좋&댓 끝나는 부분 -->

							</div>

						</article>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 모달내용 끝 -->


</section>

<script type="text/javascript">

	function reportReason(postNum){
		console.log("reportReason()실행");
		console.log("postNum::" + postNum);
		$("#reportPostNum").text(postNum);

		$.ajax({
			type : "post",
			url : "reportReason",
			data : {
					"postNum" : postNum
				},
			dataType : "json",
			success : function(result){
				console.log(result);
				reportList(result,postNum);
			},
			error : function(){
				alert("실패");
			}
					
		});
		$("#reportReasonModal").modal("show");
	}

	function reportList(result,postNum){
		console.log("reportList");
		console.log("result::"+result+"+ postNum::" + postNum);

		var output = '';

		for( var i in result){
			var reason = result[i].reason;
	        console.log("reason:"+reason);
	        var num = parseInt(i)+1;
	        console.log(i);
	        console.log(num);

	        output += "<tr>";
	        output += "<th>"+ num +"</th>";
	        output += "<th>"+ reason +"</th>";
	        output += "</tr>";
	    }
	    $("#reportReasons").html(output);
	}
	   
	function deletePostModal(postNum,postWriter){
		console.log("deletePostModal() 실행");
		console.log("postNum::" + postNum);
		console.log("postWriter::" + postWriter);
		$("#deletePostNum").text(postNum);
		$("#deletePostWriter").text(postWriter);
		$("#deletePostModal").modal("show");
	}

	function deletePost(postNum,postWriter){
		var postNum = $("#deletePostNum").text();
		var postWriter = $("#deletePostWriter").text();
		console.log("deletePost(" + postNum + ") 실행");
		console.log("postNum::" + postNum);
		console.log(postWriter);
		sendDeleteMsg(postNum,postWriter);
		$.ajax({
			type : "get",
			url : "boardDelete",
			data: { "postNum": postNum},  
			dataType: "text",                    
			success: function(result){
				if(result == "OK"){
					alert("게시물을 삭제하셨습니다.");
					location.reload();
				} else {
					alert("게시글 삭제 실패");
					location.reload();	
				}
			},
			error: function(){
				alert("연결실패");
			}

		});
	}

	function cancelDelete(){
		$("#deletePostModal").modal("hide");
	}

	/* 모달창관련 */
	
	/* 게시글에 등록한 이미지,비디오 */
	function getFiles(postNum) {
		$.ajax({
			type : "post",
			url : "getFiles",
			data : {
				"postNum" : postNum
			},
			dataType : "json",
			success : function(result) {
				insertFiles(result); 
			},
			error : function() {

			}

		});
	}

	function insertFiles(result) {
		var output = '';
		var postFileImg = result.postFileImg;
		var postType = result.postType;
		for ( var j in postFileImg) {
			var img = postFileImg[j]
			var imgType = postType[j]
			if (imgType == "jpg" || imgType == "png" || imgType == "gif" || imgType == "jpeg" || imgType == "JPG" || imgType == "PNG" || imgType == "GIF" || imgType == "JEPG") {
				output += " <div><img src='resources/fileUpload/"+img+"' style='width: 614px;height: 527px;'alt=''></div>";
			} else if (imgType == "mp4" || imgType == "ogg" || imgType == "webm" || imgType == "MP4" || imgType == "OGG" || imgType == "WEBM") {
				output += " <div><video controls autoplay loop muted style='width: 614px;height: 527px;'> <source src='resources/fileUpload/"+img+"' type='video/"+imgType+"'>";
				output += " </video></div>";
			}
		}
		$(".trans_inner").html(output);
		console.log(output);
		/* slick();  */// 원래 여기였어

	}
	/* 게시글쓴사람의 정보 */
	function getUser(postNum) {
		$.ajax({
			type : "post",
			url : "getUser",
			data : {
				"postNum" : postNum
			},
			dataType : "json",
			success : function(result) {
				insertUser(result, postNum);
			},
			error : function() {

			}

		});
	}

	function insertUser(result, postNum) {
		var output = '';
		var userId = result.userId;
		var userProfileName = result.userProfileName;
		var nickName = result.nickName;

		output += "<div class='user_container'>";
		output += "<div class='profile_img'>";
		output += "<img src='resources/profileImg/"+userProfileName+"' alt=''>";
		output += "</div>";
		output += "<div class='user_name'>";
		output += "<div class='nick_name'><a href='myPage?userId="+userId+"' style='color:black;'>" + nickName + "</a></div>";
		output += "</div>";
		output += "</div>";
		output += "<div>";
		output += "<span style='color: red; font-size:14px;' onclick='postReport("+ postNum + ")'>신고</span>";
		output += "</div>";
		output += "</div>";

		$("#showUser").html(output);
	}

	/* 게시글 정보 */
	function getPost(postNum) {
		$.ajax({
			type : "post",
			url : "getPost",
			data : {
				"postNum" : postNum
			},
			dataType : "json",
			success : function(result) {
				console.log(result);
				insertPost(result);
			},
			error : function() {

			}

		});
	}

	function insertPost(result) {
		var output = '';
		var postProfile = result.postProfile;
		var postWriter = result.postWriter;
		var postContent = result.postContent;
		var postTimeSet = result.postTimeSet;
		var splitedArray = postContent.split(' ');
		var linkedContent = '';
		for(var word in splitedArray){
			word = splitedArray[word];
			if(word.indexOf('#') == 0) // # 문자를 찾는다.
			   {
				  var newWord = word.substr(1);
			      word = "<a href='searchPostList?tagName="+newWord+"'>"+word+"</a>"; 
			   }
			else if(word.indexOf('@') == 0)
			   {
				  var newWord = word.substr(1);
				  word = "<a href='searchUser?searchUser="+newWord+"'>"+word+"</a>"; 
			   }
			   linkedContent += word+' ';
			}
			postContent = linkedContent;
			

		output += "<div class='admin'>";
		output += "</div>";
		output += "<div class='comment' style='text-align:left;'>";
		output += "<span class='user_id'></span>"+postContent;
		output += "<div class='time'>" + postTimeSet + "시간전</div>";
		output += "</div>";

		$("#showPost").html(output);
	}

	/* 댓글정보 */
	function getComments(postNum) {
		$.ajax({
			type : "post",
			url : "getComments",
			data : {
				"postNum" : postNum
			},
			dataType : "json",
			success : function(result) {
				insertComments(result,postNum);
			},
			error : function() {

			}

		});
	}

	function insertComments(result,postNum) {
		var output = '';
		var loginNickName = '${sessionScope.nickName}';
		for ( var i in result) {
			var commentNum = result[i].commentNum;
			var commentProfile = result[i].commentProfile;
			var commentWriter = result[i].commentWriter;
			var commentContent = result[i].commentContent;
			var commentSec = result[i].commentSec;
			var commentNickName = result[i].commentNickname;
			var commentTimeSet = result[i].commentTimeSet;
			var postJuin = result[i].postJuin;
			var splitedArray = commentContent.split(' ');
			var linkedContent = '';
			for(var word in splitedArray){
				word = splitedArray[word];
				if(word.indexOf('#') == 0) // # 문자를 찾는다.
				   {
					  var newWord = word.substr(1);
				      word = "<a href='searchPostList?tagName="+newWord+"'>"+word+"</a>"; 
				   }
				else if(word.indexOf('@') == 0)
				   {
					  var newWord = word.substr(1);
					  word = "<a href='searchUser?searchUser="+newWord+"'>"+word+"</a>"; 
				   }
				   linkedContent += word+' ';
				}
				commentContent = linkedContent;

			output += "<div class='user_container-detail'>";
			output += "<div class='user'>";
			output += "<img src='resources/profileImg/"+commentProfile+"' alt=''>";
			output += "</div>";
			output += "<div class='comment'>";
			// 공개댓글
			if(commentSec == 0){
				output += "<span class='user_id'><a href='searchUser?searchUser="+commentNickName+"' style='color:black;'>" + commentNickName + "</a></span>";
				output += "<div style='border: none; overflow: hidden; resize:none; padding-top:7px; width:240px; height:auto; word-break:break-all;word-wrap:break-word;'>"+commentContent+"</div>";
				output += "<div class='time'>"+commentTimeSet+"시간전";
				if(commentNickName == loginNickName){
					output += "<span onclick='commentDelete("+commentNum+","+postNum+")' style='color:red; font-size : 12px;'>삭제</span>";
				}
				output += "</div>";
				output += "<button id='seeArea"+commentNum+"' onclick='showCC("+commentNum+")' style='color:lightgray; border:0; outline0; background-color:white; font-size : 12px; padding-left:0px;'>답글보기</button>";	
				output += "<div id='showCC"+commentNum+"'>";
				output += "</div>";
			}
			// 비밀댓글
			else {
				if(postJuin == loginId){
					output += "<span class='user_id'><a href='searchUser?searchUser="+commentNickName+"' style='color:black;'>" + commentNickName + "</a></span>";
					output += "<div style='border: none; overflow: hidden; resize:none; padding-top:7px; width:240px; height:auto; word-break:break-all;word-wrap:break-word;'>"+commentContent+"</div>";
					output += "<div class='time'>"+commentTimeSet+"시간전";
					if(commentNickName == loginNickName){
						output += "<span onclick='commentDelete("+commentNum+","+postNum+")' style='color:red; font-size : 12px;'>삭제</span>";
					}
					output += "</div>";
					output += "<button id='seeArea"+commentNum+"' onclick='showCC("+commentNum+")' style='color:lightgray; border:0; outline0; background-color:white; font-size : 12px; padding-left:0px;'>답글보기</button>";	
					output += "<div id='showCC"+commentNum+"'>";
					output += "</div>";
				} else {
					if(commentNickName == loginNickName){
						output += "<span class='user_id'><a href='searchUser?searchUser="+commentNickName+"' style='color:black;'>" + commentNickName + "</a></span>";
						output += "<div style='border: none; overflow: hidden; resize:none; padding-top:7px; width:240px; height:auto; word-break:break-all;word-wrap:break-word;'>"+commentContent+"</div>";
						output += "<div class='time'>"+commentTimeSet+"시간전";
						output += "<span onclick='commentDelete("+commentNum+","+postNum+")' style='color:red; font-size : 12px;'>삭제</span>";
						output += "</div>";
						output += "<button id='seeArea"+commentNum+"' onclick='showCC("+commentNum+")' style='color:lightgray; border:0; outline0; background-color:white; font-size : 12px; padding-left:0px;'>답글보기</button>";	
						output += "<div id='showCC"+commentNum+"'>";
						output += "</div>";
					} else{
					output += "<span class='user_id'>" + commentNickName + "</span> <span style='color:lightgray;'>비밀댓글입니다.</span>";
					output += "<div class='time'>"+commentTimeSet+"시간전</div>";
					}
				}
			}
			
			output += "</div>";
			output += "</div>";
		}
		$("#showComments").html(output);

	}
	/* 좋아요 아이콘 */
	function getLeftIcon(postNum){
		$.ajax({
			type : "post",
			url : "getLeftIcon",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result) {
				insertLeftIcon(result,postNum);
			},
			error : function() {

			}
		});
	}
	
	function insertLeftIcon(result,postNum) {
		var output='';
		
		output += "<div class='left_icons'>";
		output += "<div class='heart_btn'>";
		if (result == "YES"){
			output += "<div class='sprite_heart_icon' data-name='heartbeat' onclick='likeCancel("+postNum+")'></div>";
		} else {
			output += "<div class='sprite_heart_icon_outline' data-name='heartbeat' onclick='like("+postNum+")'></div>";
		}
		output += "</div>";
		output += "<div>";
		output += "<div class='sprite_dm'></div>";
		output += "</div>";
		
		$("#showLeftIcon").html(output);
	}
	
	/* 좋아요 취소 */
	function likeCancel(postNum){
		$.ajax({
			type : "post",
			url : "likeCancel",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result){
				if(result == "OK"){
					getLeftIcon(postNum);
					getLike(postNum);
				}
			},
			error : function(){
				
			}
		});
	}
	/* 좋아요 */
	function like(postNum){
		$.ajax({
			type : "post",
			url : "like",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result){
				if(result == "OK"){
					getLeftIcon(postNum);
					getLike(postNum);
				}
			},
			error : function(){
				
			}
		});
	}
	
	/* 저장 아이콘 */
	function getRightIcon(postNum){
		$.ajax({
			type : "post",
			url : "getRightIcon",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result) {
				insertRightIcon(result,postNum);
			},
			error : function() {

			}

		});
		
		
	}
	
	function insertRightIcon(result,postNum) {
		var output='';
		
		output += "<div class='right_icon'>";
		if (result == "YES"){
			output += "<div class='sprite_bookmark' data-name='book-mark' onclick='storageCancel("+postNum+")'></div>";
		} else {
			output += "<div class='sprite_bookmark_outline' data-name='book-mark' onclick='storage("+postNum+")'></div>";
		}
		output += "</div>";
		
		$("#showRightIcon").html(output);
	}
	
	/* 저장 취소 */
	function storageCancel(postNum){
		$.ajax({
			type : "post",
			url : "storageCancel",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result){
				if(result == "OK"){
					getRightIcon(postNum);
				}
			},
			error : function(){
				
			}
		});
	}
	/* 저장하기 */
	function storage(postNum){
		$.ajax({
			type : "post",
			url : "storage",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result){
				if(result == "OK"){
					getRightIcon(postNum);
				}
			},
			error : function(){
				
			}
		});
	}
	
	/* 좋아요 갯수 */
	function getLike(postNum) {
		$.ajax({
			type : "post",
			url : "getLike",
			data : {
				"postNum" : postNum
			},
			dataType : "text",
			success : function(result) {
				insertLike(result,postNum);
			},
			error : function() {

			}

		});
	}
	
	function insertLike(result,postNum) {
		var output = '';
		output += "<div class='count_likes' style='text-align:left;'>";
		output += "좋아요<span class='count'>" + result + "</span>개";
		output += "</div>";
		output += "<div class='commit_field'>";
		output += "<textarea id='commentContent' cols='25' rows='2' wrap='hard' style='float:left; border: none; overflow: hidden; resize:none; padding-top:7px;'></textarea>";
		/* output += "<input type='text' id='commentContent' placeholder='댓글달기...'>"; */
		output += "<div class='upload_btn' onclick='commentWrite("+postNum+")' style='cursor:pointer;'>게시</div>";
		output += "<div><label><span style='vertical-align:23px;'>비밀댓글</span><input type='checkbox' id='commentSec' style='width:10px;'></label></div>";
		output += "</div>";
		$("#showLike").html(output);
	}

	/* 모달창에서 댓글달기 */
	function commentWrite(postNum) {
		var commentContent = $("#commentContent").val();
		commentContent = commentContent.replace(/(?:\r\n|\r|\n)/g, '<br />');
		if($("input:checkbox[id='commentSec']").is(":checked")){
			var commentSec = 1;
		} else {
			var commentSec = 0;
		}
		if (commentContent == "" || commentContent == null) {
			alert("댓글내용을 입력해주세요.");
			$("#commentContent").focus();
			return;
		}
		console.log(postNum + commentContent);
		$.ajax({
			type : "post",
			url : "commentWrite",
			data : {
				"postNum" : postNum,
				"commentContent" : commentContent,
				"commentSec" : commentSec
			},
			dataType : "text",
			success : function(result) {
				if (result == "OK") {
					getComments(postNum);
					$("#commentContent").val("");
				}
			},
			error : function() {

			}
		});
	}
	
	/* 모달창 댓글삭제 */
	function commentDelete(commentNum,postNum){
		$.ajax({
			type : "post",
			url : "commentDelete",
			data :{
				"commentNum" : commentNum
			},
			dataType : "text",
			success : function(result){
				if(result == "OK"){
					getComments(postNum);
				}
			},
			error : function(){
				
			}
		});
	}

	/* 모달창 대댓글 확인 */
	function showCC(commentNum){
		var seeArea = $("#showCC"+commentNum).html();
		if(seeArea==''){
		$.ajax({
			type: "post",
			url : "showCC",
			data : {
				"commentNum" : commentNum
			},
			dataType : "json",
			success : function(result){
					
				insertCC(result,commentNum);
				$("#seeArea"+commentNum).text('답글닫기');
				
			},
			error : function(){

			}
		});
		} else{
			$("#seeArea"+commentNum).text('답글보기');
			$("#showCC"+commentNum).html('');
		}
	}

function showCC22(commentNum){
		
		$.ajax({
			type: "post",
			url : "showCC",
			data : {
				"commentNum" : commentNum
			},
			dataType : "json",
			success : function(result){
					
				insertCC(result,commentNum);
				$("#seeArea"+commentNum).text('답글닫기');
				
			},
			error : function(){

			}
		});
		
	}

	function insertCC(result,commentNum){
		var output = '';
		var loginNickName = '${sessionScope.nickName}';
		for(var i in result){
			var comment_commentNum = result[i].comment_CommentNum;
			var comment_commentWriter = result[i].comment_CommentWriter;
			var comment_commentContent = result[i].comment_CommentContent;
			var comment_commentNickName = result[i].comment_CommentNickName;
			
			output += "<span class='user_id'>"+comment_commentNickName+"</span>"+comment_commentContent;
			if(loginNickName == comment_commentNickName){
				output += "<span style='font-size:12px; color:red; cursor: pointer;' onclick='deleteCCCon("+commentNum+","+comment_commentNum+")'> 삭제</span><br>";
			} else{
				output += "<br>";
			}

		}
			output += "<span class='user_id'>"+loginNickName+"</span><input type='text' id='insertCCCon"+commentNum+"' style='border:none; border-bottom:1px solid black;'><span style='font-size:12px; color:blue; cursor:pointer;' onclick='insertCCCon("+commentNum+")'>  게시</span>";
			
			$("#showCC"+commentNum).html(output);
	}

	/* 대댓글 insert */
	function insertCCCon(commentNum){
		var comment_CommentContent = $("#insertCCCon"+commentNum).val();
		if (comment_CommentContent.trim() == "" || comment_CommentContent.trim() == null) {
			alert("다시 입력해주세요")
		} else{
					
		$.ajax({
			type:"post",
			url : "insertCCCon",
			data : {
				"comment_CommentContent" : comment_CommentContent,
				"commentNum" : commentNum
			},
			dataType : "text",
			success : function(result){
					if(result =="OK"){
						showCC22(commentNum);
					}
			},
			error : function(){
				
			}
		})
		}	
	}

	/* 대댓글 delete */
	function deleteCCCon(commentNum,comment_commentNum){	
					
		$.ajax({
			type:"post",
			url : "deleteCCCon",
			data : {
				"comment_CommentNum" : comment_commentNum
			},
			dataType : "text",
			success : function(result){
					if(result =="OK"){
						showCC22(commentNum);
					}
			},
			error : function(){
				
			}
		})
			
	}
	

	/* 모달창에서 슬라이드 관련 */
	function slick() {
		$('.trans_inner').slick({
			slide : 'div', //슬라이드 되어야 할 태그 ex) div, li 
			infinite : true, //무한 반복 옵션	 
			slidesToShow : 1, // 한 화면에 보여질 컨텐츠 개수
			slidesToScroll : 1, //스크롤 한번에 움직일 컨텐츠 개수
			speed : 100, // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
			dots : true, // 스크롤바 아래 점으로 페이지네이션 여부
			dotsClass : "slick-dots", //아래 나오는 페이지네이션(점) css class 지정
			draggable : true,
		});

	}

	$("#boardViewModal").on('hidden.bs.modal', function() { //??
		$('.trans_inner').slick('unslick');
	});
	
	$("#boardViewModal").on('shown.bs.modal', function() { //??
		slick();
	});
	
	
	/* 모달창에 넣어줄 것들 */
	function postView(postNum) {
		
		getFiles(postNum); // 이미지,비디오 파일 가져오기
		getUser(postNum); // 글쓴이 정보 가져오기
		getPost(postNum); // 게시글 내용 가져오기
		getComments(postNum); // 댓글내용 가져오기
		getLike(postNum); // 좋아요 갯수 가져오기
		getLeftIcon(postNum); // 좋아요 아이콘
		getRightIcon(postNum); // 저장 아이콘

		$("#boardViewModal").modal("show"); // 모달창 띄우기
	}

	function sendDanger(postWriter,postNum){
		console.log("postWriter::"+ postWriter);
		console.log("postNum::"+ postNum);
		var msgsender = '${sessionScope.loginId}';
		var msgrecipient = postWriter;
		var chatDataCode = msgrecipient + "_" + msgsender + "_chat";
		var output = '';
		output += "게시글의 신고 수가 많으므로 게시글을 수정 또는 삭제해주시기 바랍니다.";
		output += "<br>";
		output += "<a href='boardView?postNum="+postNum+"'>신고게시글</a>";
			
		var msgcontent = output;
		console.log(chatDataCode);

		$.ajax({
			type : "post",
			url : "saveMsg_admin",
			data : {
				"msgsender" : msgsender,
				"msgrecipient" : msgrecipient,
				"msgcontent" : msgcontent
				},
			dataType : "text",
			success : function(result){
				alert("경고메세지를 보냈습니다.")
			},
			error : function(){
				alert("경고메세지 보내기 실패");
				console.log("연결실패");
			}	
		});

		
		
		var msgData = {
				msgtype : "chat",
				msgsender : msgsender,
				msgrecipient : msgrecipient,
				msgcontent : msgcontent
			};
			var JSONObject = JSON.stringify(msgData);
			webSocket._sendMessage(JSONObject);
		
		
	}

	function sendDeleteMsg(postNum,postWriter){
		console.log("postNum::"+postNum);
		console.log("postWriter::"+postWriter);
		var msgsender = '${sessionScope.loginId}';
		var msgrecipient = postWriter;
		var chatDataCode = msgrecipient + "_" + msgsender + "_chat";
		var output = '';
		output += "게시글의 신고 수가 많아 검토 후 삭제되었습니다.";
		var msgcontent = output;
		console.log(chatDataCode);

		$.ajax({
			type : "post",
			url : "saveMsg_admin",
			data : {
				"msgsender" : msgsender,
				"msgrecipient" : msgrecipient,
				"msgcontent" : msgcontent
				},
			dataType : "text",
			success : function(result){
			},
			error : function(){
				alert("삭제메세지 보내기 실패");
				console.log("연결실패");
			}	
		});
		
		var msgData = {
				msgtype : "chat",
				msgsender : msgsender,
				msgrecipient : msgrecipient,
				msgcontent : msgcontent
			};
			var JSONObject = JSON.stringify(msgData);
			webSocket._sendMessage(JSONObject);
		
	}
	
	
</script>

</body>
</html>