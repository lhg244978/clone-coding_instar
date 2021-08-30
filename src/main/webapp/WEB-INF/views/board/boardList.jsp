<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>geunstagram</title>

<link rel="stylesheet" href="resources/css/reset.css">
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="resources/css/style.css">

<link rel="stylesheet" type="text/css"
	href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<script type="text/javascript"
	src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


<style type="text/css">
#side_box {
	position: fixed;
	top: 200px;
	right: 10%;
}

.sprite_heart {
	display: inline-block;
	background: url('resources/imgs/background01.png') no-repeat -26px
		-261px;
	width: 24px;
	height: 22px;
}

.bottom_icons {
	padding: 10px 0px;
}

body {
	font-family: 'Gamja Flower', cursive;
	font-size: 20px;
}

.sprite_bookmark_outline_on {
	background: url('resources/imgs/background01.png') no-repeat -159px
		-286px;
	width: 19px;
	height: 24px;
}

.user_name, .count_likes {
	font-size: 15px;
}

video {
	width: 612px;
	height: 527px;
}

.on_ModalDiv {
	height: 50px;
	line-height: 50px;
	text-align: center;
}

.on_ModalDiv:hover {
	background-color: #d3d3d3;
}

.siren_button {
	display: inline-block;
	background: url('resources/imgs/siren.jpg') no-repeat;
	width: 22px;
	height: 24px;
	float: right;
}

</style>



</head>
<body>


	<section id="container">



		<!--  <div class="hidden_menu">
        <div class="scroll_inner">
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>

            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>
            <div class="user">
                <div class="thumb_img"><img src="imgs/thumb.jpeg" alt="프로필사진"></div>
                <div class="id">kindtigerrr</div>
            </div>

        </div>
    </div> -->

		<!-- 리스트 시작 [컨텐츠] -->

		<input type="hidden" value="${fn:length(postList)}" id="tagLength">
		<section id="main_container">
			<div class="inner">
				<div class="contents_box" id="contents_box">
					<input type="hidden" value="${sessionScope.loginId}" id="loginId">
					<c:if test="${postList != null }">
						<c:forEach var="list" items="${postList}">
							<input type="hidden" value="${list.postWriter}"
								id="postWriter_${list.postNum}">
							<article class="contents">
								<header class="top">
									<div class="user_container">

										<div class="profile_img">
											<a href="otherPage?userId=${list.postWriter }"> <img
												src="resources/profileImg/${list.postWriterProfile }" alt="">
											</a>
										</div>
										<div class="user_name">
											<div class="nick_name">${list.nickName }</div>
											<div class="rn" style="display:none" id = "countRn_${list.rn }">${list.rn }</div>
										</div>
									</div>
									<div class="sprite_more_icon" id="modal_show"
										style="cursor: pointer;"
										onclick="modal_show('${list.postNum}')"></div>
								</header>

								<div class="img_section">
									<div class="trans_inner">
										<c:forEach var="type" items="${list.postType}"
											varStatus="status">
											<c:if
												test="${type == 'jpeg' ||type == 'png' || type == 'gif' ||type == 'JPG'||type == 'jpg'||type == 'PNG' || type == 'bmp'}">
												<div>
													<img
														src="resources/fileUpload/${list.postFileImg[status.index] }"
														alt="" style="height: 527px; width: 612px;">
												</div>
											</c:if>
											<c:if
												test="${type == 'mp4' ||type == 'webm' || type == 'ogg'}">
												<div>
													<video controls autoplay loop muted>
														<source
															src="resources/fileUpload/${list.postFileImg[status.index] }"
															type="video/${type}" style="height: 527px; width: 612px;">
													</video>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>

								<div class="bottom_icons" style="padding: 10px 0px;">
									<div class="left_icons">
										<c:choose>
											<c:when test="${list.postLike == null }">
												<div class="heart_btn">
													<div class="sprite_heart_icon_outline"
														id="likeClick_${list.postNum}" data-name="heartbeat"
														onclick="like(${list.postNum})"></div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="heart_btn">
													<div class="sprite_heart" id="likeClick_${list.postNum}"
														data-name="heartbeat" onclick="like(${list.postNum})"></div>
												</div>
											</c:otherwise>
										</c:choose>
										<div>
											<div class="sprite_bubble_icon"
												onclick="boardView(${list.postNum})"></div>
										</div>
									</div>

									<div class="right_icon">
										<c:choose>
											<c:when test="${list.postBookmark == null }">
												<div class="sprite_bookmark_outline"
													id="bookmark_${list.postNum}"
													onclick="bookmark(${list.postNum})"></div>
											</c:when>
											<c:otherwise>
												<div class="sprite_bookmark_outline_on"
													id="bookmark_${list.postNum}"
													onclick="bookmark(${list.postNum})"></div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="count_likes">
									좋아요 <span class="count" id="likeCount_${list.postNum}">${list.likeComments}</span>
									개
									댓글 <span class="count" id="commentCount_${list.postNum}">${list.commentCount}</span>
									개
								</div>

								<div class="commet_container">

									<div class="postContent" id="rn_${list.rn}"
										style="width: 100%;">${list.postContent}</div>

								</div>
								<c:if test="${list.postTimeSet!='0'}">
									<div class="timer">${list.postTimeSet}시간전</div>
								</c:if>

								<c:if test="${list.postTimeSet=='0'}">
									<div class="timer">방금 전</div>
								</c:if>


							</article>
						</c:forEach>
					</c:if>

					<c:if test="${empty postList }">
						<article class="contents">
							<h1>게시물이 없습니다. 팔로우를 해주십시오.</h1>
						</article>
					</c:if>
					<div id="nextBox"></div>

				</div>


				<!-- 리스트 끝 -->

				<div id="side_box">
					<input type="hidden" id="page" value="1">

					<div class="side_box">
						<div class="user_profile">
							<div class="profile_thumb">
								<a href="myPage?userId=${user.userId}"> <img
									src="resources/profileImg/${user.userProfileName}"
									id="user_profile" alt="프로필사진">
								</a>
							</div>
							<div class="detail">
								<a href="myPage?userId=${user.userId}" style="color:black;"><div class="id m_text">${user.nickName}

									<c:if test="${user.admin==1 }">
										<a href="goAdminPage?nickName=${sessionScope.nickName}" ><div class="siren_button"></div></a>
									</c:if>
								</div></a>
								<div class="ko_name" id="ko_name"></div>
							</div>
						</div>


						<article class="recommend">
							<header class="reco_header">
								<div>회원님을 위한 추천</div>
								<div class="more" onclick="friends()">모두 보기</div>
							</header>
							<c:forEach var="recommendList" items="${recommend}">
								<div class="thumb_user">
									<div class="profile_thumb">
										<a href="otherPage?userId=${recommendList.yourId}"><img
											src="resources/profileImg/${recommendList.yourIdProfile} "
											alt="프로필사진"></a>
									</div>
									<div class="detail">
										<a href="otherPage?userId=${recommendList.yourId}" style="color:black;"><div class="id">${recommendList.yourNickName}</div></a>
										<div class="time">${recommendList.friendConunt}명이
											팔로우중입니다</div>
									</div>
									<div class="more"
										style="text-align: right; margin-left: auto; color: blue; cursor: pointer;"
										onclick="following('${recommendList.yourNickName}')"
										id="following_${recommendList.yourNickName}">팔로우</div>
								</div>
							</c:forEach>


						</article>
					</div>
				</div>

			</div>
		</section>



	</section>


	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="text-align: center; padding: 0"
					id="basicModal"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 신고Modal -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="report" method="post" id="reportForm">
					<div class="modal-body" style="text-align: center;"
						id="reportModelBody"></div>
				</form>
				<div class="modal-footer" id="reportModelFooter"></div>
			</div>
		</div>
	</div>










	<script>history.scrollRestoration = "manual"</script>
	<script type="text/javascript">

function friends(){
	location.href ='friends?checkNum=0';
}


function modal_show(value){
	 $("#exampleModal").modal("show");
	var postWriter = $("#postWriter_"+value).val();
	var loginId = $("#loginId").val();
	console.log("log:::"+loginId+"   writer:::::"+postWriter);
	 var output="";
	 if(loginId != postWriter){
	 output +="<div style='cursor: pointer; color: red;' class='on_ModalDiv' onclick='reportModal("+value+")'>신고</div>";
	 output +="<div style='cursor: pointer; color: red;' class='on_ModalDiv' onclick='unFollowingModal("+value+")'>팔로우취소</div>";
	 output +="<div style='cursor: pointer;' class='on_ModalDiv' onclick ='boardView("+value+")'>상세보기</div>";
	 }else{
		 output +="<div style='cursor: pointer; color: red;' class='on_ModalDiv' onclick='boardDelete("+value+")'>게시물삭제</div>";
		 output +="<div style='cursor: pointer;' class='on_ModalDiv' onclick='boardModifyForm("+value+")'>게시물수정</div>";
		 }

   
	 $("#basicModal").html(output);
}

function boardView (value){
var valNum = Number(value);
	location.href="boardView?postNum="+valNum+"";
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




function close_modal(value){
    $("#exampleModal").modal("hide");
    $("#reportModal").modal("hide");
}

function report(value){
	var postNum = value;
	console.log(postNum);
}

function unFollowingModal(value){
	var postNum = value;
	console.log(postNum);
			$("#exampleModal").modal("hide");
	$.ajax({
		type : "get",
		url : "unFollowingModal",
		data: { "postNum": postNum},  
		dataType: "text",                    
		success: function(result){
			if(result == "OK"){
			alert("팔로우를 취소하셨습니다.");
			location.reload();
				}
			  
		},
		error: function(){
			alert("연결실패");
			}
		});

}




function following(value){
	var following = value;
	console.log(following);

	$.ajax({
		type : "get",
		url : "following",
		data: { "following": following},  
		dataType: "text",                    
		success: function(result){
			if(result == "OK"){
			$("#following_"+following).removeAttr('onclick');
			$("#following_"+following).text("팔로우취소");
			$("#following_"+following).attr('onclick', "unFollowing('"+following+"')");
			$("#following_"+following).attr('id','unFollowing_'+following).css('color','red');
			alert("팔로우하셨습니다.");
				}
			  
		},
		error: function(){
			alert("연결실패");
			}

		
		});

}

function unFollowing(value){
	var following = value;
	console.log(following);

	$.ajax({
		type : "get",
		url : "unFollowing",
		data: { "following": following},  
		dataType: "text",                    
		success: function(result){
			if(result == "OK"){
				$("#unFollowing_"+following).removeAttr('onclick');
				$("#unFollowing_"+following).text("팔로우");
				$("#unFollowing_"+following).attr('onclick', "following('"+following+"')");
				$("#unFollowing_"+following).attr('id','following_'+following).css('color','blue');
			alert("팔로우를 취소하셨습니다.");
			 
				}
			  
		},
		error: function(){
			alert("연결실패");
			}

		
		});

}



function tag(v){
	if($("#countRn_"+v).text() != ''){
	var content = $('#rn_'+v).html();
	var splitedArray = content.split(' ');
	var linkedContent = "";
	for(var word in splitedArray)
	{
	  list = splitedArray[word];
	
	console.log(list);
	   if(list.indexOf('#') == 0)
	   {
		   var newWord = list.substr(1);
		   list = "<a href='searchPostList?tagName="+newWord+"'>"+list+"</a>";
	   }
	   linkedContent += list+' ';
	}
	$('#rn_'+v).html(linkedContent) ; 
	}
	};
	

	

function pageList(result){
	var output = '';
	var outRn = [];
	for(var i in result){
		var postNum = result[i].postNum;
		var postWriter = result[i].postWriter;
		var postWriterProfile = result[i].postWriterProfile;
		var postWriterProfileName = result[i].postWriterProfile;
		var postWriterAddr = result[i].postWriterAddr;
		var nickName = result[i].nickName;
		var postContent = result[i].postContent;
		var postFileImg = result[i].postFileImg;
		var postType = result[i].postType;
		var postTime = result[i].postTime;
		var postTimeSet = result[i].postTimeSet;
		var likeComments = result[i].likeComments;
		var commentCount = result[i].commentCount;
		var	rn = result[i].rn;
		var postLike = result[i].postLike;
		var postBookmark = result[i].postBookmark;
		var postBookmark= result[i].postBookmark;
		
			
			console.log(postBookmark);
		 output +=" <article class='contents'>";
		 output +=" <header class='top'>";
		 output +=" <input type='hidden' value="+postWriter+"  id='postWriter_"+postNum+"'>";
		 output +=" <div class='user_container'>  <div class='profile_img'>";
		 output +=" <img src='resources/profileImg/"+postWriterProfile+"' alt=''>  </div>" ;
		 output += " <div class='user_name'>";
		 output += " <div class='nick_name'>"+nickName+"</div>";         
		 output +="	<div class='rn' style='display:none;' id = 'countRn_"+rn+"'>"+rn+"</div>";
		 output +="  </div> </div>" ;
		 output +="  <div class='sprite_more_icon' id='modal_show' style='cursor: pointer;' onclick='modal_show("+postNum+")'> </div> </header>" ;      
		 output += " <div class='img_section'> <div class='trans_inner' id='trans_inner"+rn+"'>";
		 for(var j in postFileImg){
			 var img = postFileImg[j]
			 var imgType = postType[j]
			 if(imgType == "jpeg" ||imgType == "png" || imgType == "gif" ||imgType == "JPG"||imgType == "jpg"||imgType == "PNG" || imgType == "bmp"){
		 output +=" <div><img src='resources/fileUpload/"+img+"' alt=''style='height: 527px;width: 612px;'></div>" ;
				 }
			 else if (imgType == "mp4"||imgType == "ogg"||imgType =="webm"){
		 output +=" <div><video controls autoplay loop muted> <source src='resources/fileUpload/"+img+"' type='video/"+imgType+"'style='height: 527px;width: 612px;'>";
		 output +=" </video></div>";
				 }
		 }
		 output +="</div></div>";
		 output +=" <div class='bottom_icons' style='padding: 10px 0px;'>   <div class='left_icons'>";
		 if(postLike == null){
		 output +=" <div class='heart_btn'> <div class='sprite_heart_icon_outline' id='likeClick_"+postNum+"' data-name='heartbeat' onclick='like("+postNum+")'></div></div>";
			 }
		 else{
		 output +=" <div class='heart_btn'> <div class='sprite_heart' id='likeClick_"+postNum+"' data-name='heartbeat' onclick='like("+postNum+")'></div></div>";
			 }
		 output +=" <div> <div class='sprite_bubble_icon'  onclick ='boardView("+postNum+")'></div></div>";
		 output +=" </div>";
		 output +=" <div class='right_icon'>";
		 if(postBookmark == null){
		 output +=" <div class='sprite_bookmark_outline' id='bookmark_"+postNum+"' onclick='bookmark("+postNum+")'></div>";
		 }else{
		 output +=" <div class='sprite_bookmark_outline_on' id='bookmark_"+postNum+"' onclick='bookmark("+postNum+")'></div>";	
			 }
		 output +="</div></div>";
		 output +=" <div class='count_likes'> 좋아요 <span class='count' id = 'likeCount_"+postNum+"'>"+likeComments+"</span>개";
		 output +=" 댓글 <span class='count' id = 'commentCount_"+postNum+"'>"+commentCount+"</span>개</div>";
		 output +=" <div class='commet_container'><div class='commet'  id='rn_"+rn+"'>"+postContent+"</div></div>"   ;   
		 if(postTimeSet>0){
		 output += "<div class='timer'>"+postTimeSet+"시간 전</div>  </article> ";          
			 }  
		 else{
		 output += "<div class='timer'>방금 전</div>  </article> ";          
			 }

		 outRn.push(rn);
			
	}
	
	  $('.trans_inner').slick('unslick');

	$("#nextBox").before(output);
	slick();
	console.log(outRn);
	for (var k in outRn){
		var rnList= outRn[k];
		var result = Number(rnList);
		console.log(result);
			tag(result);
	
	}
	};




function pageListNull(){
	var output = '';
	var lastText = $("#lastText").text();
	console.log("lastText::"+lastText);
	if(lastText!="게시물이 없습니다. 팔로우를 해주십시오."){
	output = "<article class='contents'> <h1 id ='lastText'>게시물이 없습니다. 팔로우를 해주십시오.</h1>  </article>" 
	$("#nextBox").before(output);
	}
	else{
	return;
		}
};

function slick(){
$('.trans_inner').slick({
	slide: 'div',		//슬라이드 되어야 할 태그 ex) div, li 
	infinite : true, 	//무한 반복 옵션	 
	slidesToShow : 1,		// 한 화면에 보여질 컨텐츠 개수
	slidesToScroll : 1,		//스크롤 한번에 움직일 컨텐츠 개수
	speed : 100,	 // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
	dots : true, 		// 스크롤바 아래 점으로 페이지네이션 여부
	dotsClass : "slick-dots", 	//아래 나오는 페이지네이션(점) css class 지정
	draggable : true, 
	});

};

function likeVal(likeNum){
	

	$.ajax({
	    type: "get",  		  // HTTP 요청 방식(GET, POST)
	    url: "likeVal", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    data: { "postNum": likeNum },                // HTTP 요청과 함께 서버로 보낼 데이터
	    dataType: "text",                    // 서버에서 보내줄 데이터의 타입
		success: function(result){
			console.log(result);	
			$('#likeCount_'+likeNum).text(result);
				},	
				error: function(){
				alert("연결실패");
				}
			});
	
}

function countComment(likeNum){
	

	$.ajax({
	    type: "get",  		  // HTTP 요청 방식(GET, POST)
	    url: "likeVal", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    data: { "postNum": likeNum },                // HTTP 요청과 함께 서버로 보낼 데이터
	    dataType: "text",                    // 서버에서 보내줄 데이터의 타입
		success: function(result){
			console.log(result);	
			$('#likeCount_'+likeNum).text(result);
				},	
				error: function(){
				alert("연결실패");
				}
			});
	
}

function like(num){
	var likeNum = Number(num);
	console.log(likeNum);
	$.ajax({
	    type: "get",  		  // HTTP 요청 방식(GET, POST)
	    url: "likeUsers", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    data: { "postNum": likeNum },                // HTTP 요청과 함께 서버로 보낼 데이터
	    dataType: "text",                    // 서버에서 보내줄 데이터의 타입
		success: function(result){
			console.log(result);
			if(result == "OK"){
				console.log("result::"+result);
				alert('좋아요를 누르셨습니다.');
				$('#likeClick_'+likeNum).attr('class','sprite_heart');
				likeVal(likeNum);
			}
			else{	
				alert('좋아요를 취소하셨습니다.');
				$('#likeClick_'+likeNum).attr('class','sprite_heart_icon_outline')
				likeVal(likeNum);
			}
			},
			error: function(){
				alert("연결실패");
				}
	
	});
}
function bookmark(num){
	var bookNum = Number(num);
	console.log(bookNum);
	$.ajax({
	    type: "get",  		  // HTTP 요청 방식(GET, POST)
	    url: "bookmark", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    data: { "postNum": bookNum },                // HTTP 요청과 함께 서버로 보낼 데이터
	    dataType: "text",                    // 서버에서 보내줄 데이터의 타입
		success: function(result){
			console.log(result);
			if(result == "OK"){
				console.log("result::"+result);
				alert('저장 하였습니다.');
				$('#bookmark_'+bookNum).attr('class','sprite_bookmark_outline_on');
			}
			else{	
				alert('저장을 취소하셨습니다.');
				$('#bookmark_'+bookNum).attr('class','sprite_bookmark_outline');	
			}
			},
			error: function(){
				alert("연결실패");
				}
	
	});
	
		
}





$(document).ready(function(){
 var page = 1; 
/*  window.onbeforeunload = function() {
	 history.go(0);
	}; */
	slick();

   

    var listString = Number($("#tagLength").val());
 	console.log("listString"+listString);
   for(var i=1; i<=listString; i++){
	tag(i);
	   }

	


	


	
$(window).scroll(function(){
	var scrollHeight = $(window).scrollTop()+ $(window).height();
	var documentHeight = $(document).height();
	
				console.log("scroll"+scrollHeight);
				console.log("document"+documentHeight);
	if((scrollHeight+2)> documentHeight){
	page= page + 5;
		console.log("==page"+page);
	
		$.ajax({
		    type: "get",  		  // HTTP 요청 방식(GET, POST)
		    url: "boardListPage", // 클라이언트가 요청을 보낼 서버의 URL 주소
		    data: { "page": page },                // HTTP 요청과 함께 서버로 보낼 데이터
		    dataType: "json",                    // 서버에서 보내줄 데이터의 타입
			success: function(result){
				console.log(result);
				if(result!=""){
					console.log("list::"+result);
					pageList(result);	

				}
				else{
					pageListNull();
				}
				},
				error: function(){
					alert("연결실패");
					}
		
		});
		 
	}

	
});







});


</script>


</body>
</html>