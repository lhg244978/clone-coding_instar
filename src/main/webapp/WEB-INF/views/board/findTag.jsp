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
<title>#게시글</title>

<link rel="stylesheet" href="resources/css1/detail-page.css">
<link rel="stylesheet" href="resources/css1/profile.css">

<!-- 모달관련 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>



<!-- 슬라이드관련 -->
<link rel="stylesheet" type="text/css"
	href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />

<script type="text/javascript"
	src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>

<style>
/* 게시글관련 */
#box {
	width: 865px;
	height: 865px;
	margin : 0 auto;
}

#wrap {
	position: relative;
	width: 840px; /* wrap에 속한 div의 넓이+margin값을 더한 넓이와 높이값 */
	height: 840px;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%); /* 중앙정렬 */
}

#wrap>div {
	width: 260px;
	height: 260px;
	/* border:1px solid #333; */
	float: left;
	margin: 10px;
	box-sizing: border-box; /* border 또한 위치값을 갖기에 div크기가 더 커짐을 방지하기 위한 */
}

#wrap>div:nth-child(4) {
	clear: both; /* float:left 의 줄바꿈을 위한 */
}

.thumbNail:hover {
	opacity: 0.3;
}

/* 스크롤바 숨기기 */
.box1 {
	-ms-overflow-style: none; /* IE and Edge */
	scrollbar-width: none; /* Firefox */
}

.box1::-webkit-scrollbar {
	display: none; /* Chrome, Safari, Opera*/
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
body{
		background : #fafafa;
	}

.scroll_section .admin_container .admin img, .scroll_section .user_container-detail .user img {
    width: 100%;
    height: 120%;
}




</style>




</head>
<body>


	<section id="container">






		<!-- 인기 게시글 목록 -->
		<section id="main_container">
			<div class="inner">
			<!-- 해쉬태그 내용관련 -->
			
			 <div class="hori_cont">
                <div class="profile_wrap">
                    <div class="profile_img">
                        <img src="resources/profileImg/shop.png" alt="" style="width:152px; height:152px;">
                    </div>
                </div>

                <div class="detail">
                    <div class="top">
                        <div class="user_name">${tagPostView.tagName}</div>
                        
                    </div>

                    <ul class="middle">
                        <li>
                            <span>게시물</span>
                            ${tagPostView.countPost}
                        </li>
                    </ul>
                

                </div>
            </div>
			
			<!-- 해쉬태그 내용관련 끝 -->
			<hr>

				<div class="contents_box">
					<article>
						<div id="box">
							<div id="wrap">
								<c:forEach var="multiFile" items="${multiFile }">
									<div>
										<a onclick="postView('${multiFile.postNum}')"> 
										    <c:choose>
											<c:when test="${multiFile.fileType == 'bmp' ||multiFile.fileType == 'jpg' || multiFile.fileType == 'png' || multiFile.fileType == 'gif' || multiFile.fileType == 'jpeg' || multiFile.fileType == 'JPG' || multiFile.fileType == 'PNG' || multiFile.fileType ==  'GIF' || multiFile.fileType == 'JPEG'}">
                                            <img class="thumbNail" src="resources/fileUpload/${multiFile.files }" alt="" style="width: 100%; height: 100%;">
                                            </c:when>
                                            <c:when test="${multiFile.fileType == 'mp4' || multiFile.fileType == 'ogg' || multiFile.fileType == 'webm' || multiFile.fileType == 'MP4' || multiFile.fileType == 'OGG' || multiFile.fileType == 'WEBM'}">
											<video loop muted preload="metadata" style="width:100%; height:100%;"> <source src="resources/fileUpload/${multiFile.files }#t=0.5" type="video/${multiFile.fileType }" ></video>
											</c:when>										
											</c:choose>
										</a>

									</div>
								</c:forEach>

							</div>
						</div>
					</article>
					<br> <br>
				</div>
			</div>
		</section>
		<!-- 인기 게시글 목록 끝 -->
		
	</section>









	<!-- 모달내용 시작 -->


	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
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
								<div class="admin_container box1" id="showPost" style="height:60px;overflow:auto;">
										<!-- 글쓴이의 게시글 내용 -->
										
										<div class="comment box1">
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

	<!-- 신고Modal -->
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="report" method="post" id ="reportForm">
                <div class="modal-body" style="text-align:center;" id="reportModelBody">
              
                    
            
                </div>
                </form>
                <div class="modal-footer" id="reportModelFooter">
                  
                 
                                
            </div>
        </div>
    </div>
    </div>


















</body>
<script type="text/javascript">

	function postReport(postNum) {
		console.log(postNum);
		var reason = prompt("신고사유를 입력해주세요");
		console.log(reason);
		if (reason.trim() == "" || reason.trim() == null) {
			alert("다시 입력해주세요")
		} else {
			$.ajax({
				type : "post",
				url : "reporting",
				data : {
					"reason" : reason,
					"postNum" : postNum
				},
				dataType : "text",
				success : function(result) {
					if (result == "OK") {
						alert("정상적으로 신고되었습니다.");
					} else {
						alert("오류");
					}
				},
				error : function() {
					alert("연결실패");
				}

			});

		}
	}
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
			if (imgType == "bmp"||imgType == "jpg" || imgType == "png" || imgType == "gif" || imgType == "jpeg" || imgType == "JPG" || imgType == "PNG" || imgType == "GIF" || imgType == "JEPG") {
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
		var loginNickName = '${sessionScope.nickName}';
		var loginId = '${sessionScope.loginId}';

		output += "<div class='user_container'>";
		output += "<div class='profile_img'>";
		if(loginNickName==nickName){
		output += "<a href='myPage?userId="+loginId+"'><img src='resources/profileImg/"+userProfileName+"' alt=''></a>";
		}else{
		output += "<a href='otherPage?userId="+userId+"'><img src='resources/profileImg/"+userProfileName+"' alt=''></a>";
			}
		output += "</div>";
		output += "<div class='user_name'>";
		if(loginNickName==nickName){
		output += "<div class='nick_name'><a href='myPage?userId="+userId+"' style='color:black;'>" + nickName + "</a></div>";
			}else{
		output += "<div class='nick_name'><a href='otherPage?userId="+userId+"' style='color:black;'>" + nickName + "</a></div>";
				}
		output += "</div>";
		output += "</div>";
		output += "<div>";
		if(loginNickName != nickName){
		output += "<span style='color: red; font-size:14px; cursor:pointer;' onclick='postReport("+ postNum + ")'>신고</span>";
		}	
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
				  newWord.replace('<br>','');
				  
			      word = "<a href='searchPostList?tagName="+newWord+"'>"+word+"</a>"; 
			   }
			else if(word.indexOf('@') == 0)
			   {
				  var newWord = word.substr(1);
				  newWord.replace('<br>','');
				  
				  word = "<a href='searchUser?searchUser="+newWord+"'>"+word+"</a>"; 
			   }
			   linkedContent += word+' ';
			}
			postContent = linkedContent;
			

		output += "<div class='admin'>";
		output += "</div>";
		output += "<div class='comment' style='text-align:left; margin-left:20px;'>";
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
		var loginId = '${sessionScope.loginId}'
		var loginNickName = '${sessionScope.nickName}'
		
		for ( var i in result) {
			var commentNum = result[i].commentNum;
			var commentProfile = result[i].commentProfile;
			var commentWriter = result[i].commentWriter;
			var commentContent = result[i].commentContent;
			var commentNickName = result[i].commentNickname;
			var commentSec = result[i].commentSec;
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
			if(commentNickName == loginNickName){
			output += "<a href='myPage?userId="+loginId+"'><img src='resources/profileImg/"+commentProfile+"' alt=''></a>";
				}else{
			output += "<a href='otherPage?userId="+commentWriter+"'><img src='resources/profileImg/"+commentProfile+"' alt=''></a>";
					}
			output += "</div>";
			output += "<div class='comment'>";
			// 공개댓글
			if(commentSec == 0){
				if(commentNickName == loginNickName){
				output += "<a href='myPage?userId="+loginId+"'><span class='user_id'>" + commentNickName + "</span></a>";
				}else{
				output += "<a href='otherPage?userId="+commentWriter+"'><span class='user_id'>" + commentNickName + "</span></a>";
					}
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
					output += "<span class='user_id'>" + commentNickName + "</span>";
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
						output += "<span class='user_id'>" + commentNickName + "</span>";
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
		output += "<div class='sprite_dm' onclick='goMessage("+postNum+")'></div>";
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
			var comment_commentNickName = result[i].comment_CommentNickName;
			var comment_commentContent = result[i].comment_CommentContent;

			output += "<span class='user_id'>"+comment_commentNickName+"</span>"+comment_commentContent;
			if(loginNickName == comment_commentNickName){
				output += "<span style='font-size:12px; color:red; cursor: pointer;' onclick='deleteCCCon("+commentNum+","+comment_commentNum+")'> 삭제</span><br>";
			} else{
				output += "<br>";
			}

		}
			output += "<span class='user_id'>"+loginNickName+"</span><input type='text' id='insertCCCon"+commentNum+"' style='border:none; border-bottom:1px solid black;width:150px;'><span style='font-size:12px; color:blue; cursor:pointer;' onclick='insertCCCon("+commentNum+")'>게시</span>";
			
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

	$("#exampleModal").on('hidden.bs.modal', function() { //??
		$('.trans_inner').slick('unslick');
	});
	
	$("#exampleModal").on('shown.bs.modal', function() { //??
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

		$("#exampleModal").modal("show"); // 모달창 띄우기
	}

	/* 디엠으로 */
	   function goMessage(postNum){
	      $.ajax({
	         type : "post",
	         url : "alreadyFol",
	         data : {
	            "postNum" : postNum
	         },
	         dataType : "text",
	         success : function(result){
	            if(result == "OK"){
	               location.href = "goMessage?postNum="+postNum;
	            } else if (result == "NO") {
	               alert("팔로우를 먼저해주세요");
	               location.href = "otherPage2?postNum="+postNum;
	            } else {
	               alert("자기 자신에게 보낼 수 없습니다.")
	            }
	         },
	         error : function(){
	            
	         }
	      });
	   }

	   function reportModal(value){
			 $("#exampleModal").modal("hide");
			 $("#reportModal").modal("show");
			 var output="";
			 output+="<button type='submit' class='btn btn-secondary' style='background:red' data-dismiss='modal' onclick='reportSubmit()'>신고</button> ";
			 output+="   <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button>  ";
			 var output2="";
			 output2+=" <input type='hidden' name= 'postNum' value="+value+">";
			 output2+=" 신고내용을 입력해주세요<br>";
			 output2+="<input type='text' name ='reason' style='width: 450px'>";
			 
		  
		   
			 $("#reportModelFooter").html(output);
			 $("#reportModelBody").html(output2);
		}
		
		function reportSubmit(){
			alert("신고완료");
			$("#reportForm").submit();
		}
</script>


</html>