	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
    <%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">



    <title>boardView</title>
  <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/detail-page.css">
 
	<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
    <script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
	
	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


<style>
#main_container {
height: 100%;
        }
body {
height: 100%;   
}

video { 
    width: 597px;
    height: 628px;

}

.sprite_heart {
    display: inline-block;
    background: url('resources/imgs/background01.png') no-repeat -26px -261px;
    width: 24px;
    height: 22px;
}
.commentHeart_icon_outline {
    display: inline-block;
    background: url('resources/imgs/Heart_OutLine.png') no-repeat ;
    width: 15px;
    height: 13px;
    float: right;
    cursor: pointer;

}
.commentHeart{
    display: inline-block;
    background: url('resources/imgs/Heart.png') no-repeat ;
    width: 15px;
    height: 13px;
    float: right;
    cursor: pointer;

}

.bottom_icons{
padding: 10px 0px;
}

body{
font-family: 'Gamja Flower', cursive;
font-size: 20px;
}

.sprite_bookmark_outline_on {
    background: url('resources/imgs/background01.png') no-repeat -159px -286px;
    width: 19px;
    height: 24px;
}
.user_name ,.count_likes{
font-size: 15px;

}

textarea:focus {
    outline: none;
}

#inputComment_comment{
width:100px;

    background-color: rgba( 255, 255, 255, 0.0 );

    border: none;

    text-align: center;

    text-decoration: none;

    display: inline-block;

    cursor: pointer;
    
    width: 70px;

}
#inputComment_comment:focus{ 	
    border: none;
    outline:none;
    width: 70px;
}
#inputComment_comment:active{ 	
    border: none;
    outline:none;
        background-color:#E2E2E2;
        width: 70px;
}        
        
        
.on_ModalDiv{
height: 50px;
 line-height: 50px;
text-align: center;
}
.on_ModalDiv:hover{
background-color: #d3d3d3;


}
.scroll_section .admin_container .admin img, .scroll_section .user_container-detail .user img {
    width: 100%;
    height: 120%;
}
	

.element.style {
    width: 597px;
    height: 550px;
}
</style>

</head>
<body>


<section id="container" style="height: 100%">


   


    <div id="main_container">
	<c:choose>
	<c:when test="${postView.postFileImg != '[]'}">
        <section class="b_inner">
		</c:when>
		<c:otherwise>
        <section class="b_inner" style="width: 300px">
 	</c:otherwise>
		</c:choose>
            <div class="contents_box">

                <article class="contents cont01">

                    <div class="img_section">
                        <div class="trans_inner" style="height: 100%">
                        
                        <input type="hidden" value="${postView.postNum}"  id="postNum" >
                        <input type="hidden" value="${postView.postWriter}"  id="postWriter" >
                        <input type="hidden" value="${sessionScope.loginId}"  id="loginId" >
                        
                        <c:forEach var="type" items="${postView.postType}" varStatus="status" >
                        <c:if test="${type == 'jpg' ||type == 'png' || type == 'gif' ||type == 'jpeg' || type == 'JPG'|| type == 'PNG'|| type == 'bmp'}">     
                            <div><img src="resources/fileUpload/${postView.postFileImg[status.index] }" alt="" style=" width: 597px;height: 628px;"></div>
					</c:if>
						  <c:if test="${type == 'mp4' ||type == 'webm' || type == 'ogg'}"> 
						   <div>
						   <video controls autoplay loop muted> 
						   <source src="resources/fileUpload/${postView.postFileImg[status.index] }" type="video/${type}">							   
						   </video>
						   </div>
						  </c:if>
							</c:forEach>
         
                        </div>
                    </div>


                    <div class="detail--right_box">

                        <header class="top">
                            <div class="user_container">
                                <div class="profile_img">
                                <c:choose>
                                <c:when test="${sessionScope.nickName== postView.nickName}">
                        <a href="myPage?userId=${sessionScope.loginId}">
                        <img src="resources/profileImg/${postView.postWriterProfile}" id="user_profile" alt="프로필사진"></a>
                        </c:when>
                        <c:otherwise>
                         <a href="otherPage?userId=${postView.postWriter}">
                        <img src="resources/profileImg/${postView.postWriterProfile}" id="user_profile" alt="프로필사진">
                        </a>
                        </c:otherwise>
                        </c:choose>
                                </div>
                                <div class="user_name">
                                 <c:choose>
                                <c:when test="${sessionScope.nickName== postView.nickName}">
                        <a href="myPage?userId=${sessionScope.loginId}" style="color:black">
                        <div class="nick_name">${postView.nickName}</div>
                        </a>
                        </c:when>
                        <c:otherwise>
                         <a href="otherPage?userId=${postView.postWriter}" style="color:black">
                        <div class="nick_name">${postView.nickName}</div>
                        </a>
                        </c:otherwise>
                        </c:choose>
                                </div>
                            </div>
                            <div>
                            <select id="selectPage" > 
                         <option value = "1">최근 순으로 보기</option>
                         <option value = "2">좋아요 순으로 보기</option>
                            </select></div>
                        <div class="sprite_more_icon" id="modal_show" style="cursor: pointer;" onclick="modal_show('${postView.postNum}')"> 
                            </div>

                        </header>
					<!-- 댓글 -->
                        <section class="scroll_section" style="overflow: auto; height: 240px" id="scroll_section">
                            <div class="admin_container" id="admin_container">       
                                <div class="comment" style="font-size: 13px;">
                              	댓글이 아직 하나도 없습니다.
            
                                </div> 
                            </div>

               
                        </section>


                        <div class="bottom_icons">
                            <div class="left_icons">
                                         <c:choose>
                        <c:when test="${postView.postLike == null }">
                            <div class="heart_btn">
                                <div class="sprite_heart_icon_outline" id="likeClick_${postView.postNum}" data-name="heartbeat" onclick="like(${postView.postNum})"></div>  
                            </div>
                            </c:when>
                          <c:otherwise>
                            <div class="heart_btn">
                                <div class="sprite_heart" id="likeClick_${postView.postNum}" data-name="heartbeat" onclick="like(${postView.postNum})"></div>  
                            </div>                  
                          </c:otherwise>                
                            </c:choose>       
                              
                            </div>

                            <div class="right_icon">
                                <c:choose>
                          	<c:when test="${postView.postBookmark == null }">                    
                            <div class="sprite_bookmark_outline" id="bookmark_${postView.postNum}" onclick="bookmark(${postView.postNum})"></div>
                            </c:when>
                            <c:otherwise>                        
                            <div class="sprite_bookmark_outline_on" id="bookmark_${postView.postNum}" onclick="bookmark(${postView.postNum})"></div>
                            </c:otherwise>
                            </c:choose>
                            </div>
                        </div>
                       <div class="tagContent" id="tagContent" style="width: 100%;word-break:break-all;word-wrap:break-word;">${postView.postContent}</div>
                        <div class="count_likes" style="font-size: 12px">
                            좋아요
                                <span class="count" id="likeCount_${postView.postNum}">${postView.likeComments}</span>
                            개
                        </div>

                     	<c:if test="${postView.postTimeSet!='0'}">
                  	  <div class="timer">${postView.postTimeSet}시간 전</div>
					</c:if>
					<c:if test="${postView.postTimeSet=='0'}">
		                    <div class="timer">방금 전</div>
						</c:if>
		
                        <div class="commit_field">
					<textarea  rows="5" cols="25" id ="commentContent" wrap="hard" placeholder="댓글달기.." style="width: 80% ; height: 100%; border: none; resize: none;"></textarea>
	<div style="text-align: right; color: blue; vertical-align: middle; height: 100%; width: 20%; float: right; padding-top: 75px"> 
	<div class="" onclick="commentInsert(${postView.postNum})" style="cursor: pointer; font-size: 15px" >댓글달기</div>
 	</div>
		 <div style="text-align: center; font-size: 13px;">비밀댓글: <input type="checkbox" style="height: 12px; width: 12px;" id="secCheckbox"></div>        
                 		   </div>
					</div>
                </article>

            </div>

    </div>
</section>

      <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="text-align: center; padding: 0" id = "basicModal">
                   
                 
                 
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>                  
            </div>
        </div>
    </div>
 </div>

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


function modal_show(value){
	 $("#exampleModal").modal("show");
	var postWriter = $("#postWriter").val();
	var loginId = $("#loginId").val();
	var admin =${admin};
	
	console.log("admin:::"+admin);
	console.log("log:::"+loginId+"   writer:::::"+postWriter);
	 var output="";
	
	 if(admin == 1){
		 output +="<div style='cursor: pointer; color: red;' class='on_ModalDiv' onclick='boardDelete("+value+")'>게시물삭제</div>";
		 output +="<div style='cursor: pointer;' class='on_ModalDiv' onclick='boardModifyForm("+value+")'>게시물수정</div>";
	 }else if (loginId != postWriter){
	 output +="<div style='cursor: pointer; color: red;' class='on_ModalDiv' onclick='reportModal("+value+")'>신고</div>";
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





function tag(){
	
	var content = $('#tagContent').html();
	console.log(content);
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
	$('#tagContent').html(linkedContent) ; 

	};
	





function inputComment_comment(num){
var commentNum = Number(num);
var comment_CommentContent = $("#comment_comment_join"+commentNum).val();
var postNum= $("#postNum").val();
var page = $("#selectPage option:selected").val();

$.ajax({
	type : "post",
	url : "insertComent_Comment",
	data: {"commentNum":commentNum, "comment_CommentContent":comment_CommentContent},
	dataType: "json",
	success: function(result){
		console.log(result);	
			alert("댓글을 다셨습니다.");
			comments(postNum,page);
			
			
			},
			error: function(){
			alert("연결실패");
			}
});
	
}



function commentInsert(postNum){
var commentContent = $("#commentContent").val();
var commentSec;
var page = $("#selectPage option:selected").val();


	if($('#secCheckbox').is(':checked')){
		commentSec= 1;
		}else{
		commentSec= 0;
			}

	console.log(commentSec);

	$.ajax({
		type: "get",
		url: "commentInsert",
		data :{"postNum": postNum,"commentContent" :commentContent, "commentSec":commentSec},
		dataType: "text",
		success: function(result){
			console.log(result);	
			if(result = "ok"){
				alert("댓글을 다셨습니다.");
				comments(postNum,page);
				$("#commentContent").val("");
				}else{
				alert("입력실패");
					}
				},	
				error: function(){
				alert("연결실패");
				}


		
		});
	
};







	
function comment_comment(value){	
$("#comment_comment_"+value).toggle();
	
}




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

function commentLike(num){
	var postNum = $("#postNum").val();
	var page = $("#selectPage option:selected").val();
	var commentNum = Number(num);
	console.log(commentNum);
	$.ajax({
	    type: "get",  		  // HTTP 요청 방식(GET, POST)
	    url: "commentLike", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    data: { "commentNum": commentNum },                // HTTP 요청과 함께 서버로 보낼 데이터
	    dataType: "text",                    // 서버에서 보내줄 데이터의 타입
		success: function(result){
			console.log(result);
			if(result == "OK"){
				console.log("result::"+result);
				alert('좋아요를 누르셨습니다.');
				$('#likeComments_'+commentNum).attr('class','commentHeart');
				comments(postNum,page);
			}
			else{	
				alert('좋아요를 취소하셨습니다.');
				$('#likeComments_'+commentNum).attr('class','commentHeart_icon_outline')
				comments(postNum,page);
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

	if(${error != null}){
		alert("이미 삭제 또는 블라인드 처리된 게시글입니다.");
		location.href="boardList";
		return;
	}

	
	var postNum = $("#postNum").val();
	var page = $("#selectPage option:selected").val();
	slick();
	console.log(postNum);
	comments(postNum, page);
	tag();

	$("#selectPage").change(function() {
	page = 	$("#selectPage option:selected").val();
		
			comments(postNum , page);
	
			
			});

			


	
});



function comments (postNum,page){
	$.ajax({
		type: "post",
		url: "postComment",
		data: { "postNum": postNum ,"page":page} , 
		dataType : "json",
		success: function(result){
			if(result.length>0){
			console.log("result::"+result);
			commentOut(result);
				}else{
			console.log("null");
					}
		},
		error: function(){
			alert("연결실패");
}
		});
	

	}


function commentOut(result){
	var postWriter = $("#postWriter").val();
	var loginId = $("#loginId").val();
	var userId = '${sessionScope.loginId}'
		var loginNickName = '${sessionScope.nickName}'
		
		var output = "";
		for(var i in result){
		var commentNum = result[i].commentNum;
		var postNum = result[i].postNum;
		var commentWriter = result[i].commentWriter;
		var commentWriterProfile = result[i].commentWriterProfile;
		var commentContent = result[i].commentContent;
		var commentSec = result[i].commentSec;
		var commentTime = result[i].commentTime;
		var commentTimeSet = result[i].commentTimeSet;
		var comment_comment = result[i].comment_comment;
		var commentNickname = result[i].commentNickname;
		var likeComments = result[i].likeComments;
		var likeCommentCount = result[i].likeCommentCount;




		
		if(commentContent == null ){
			commentContent="";
			}

		if(commentNickname == loginNickName){
		output +=  "<div class='admin_container' id='admin_container'>";
			output += "<a href='myPage?userId="+userId+"'><div class='admin'><img src='resources/profileImg/"+commentWriterProfile+"' alt='user'></div></a>";
		output +=  "<div class='comment' style='font-size: 13px;'>";
				}else{
		output +=  "<div class='admin_container' id='admin_container'>";
		output += "<a href='otherPage?userId="+commentWriter+"'><div class='admin'><img src='resources/profileImg/"+commentWriterProfile+"' alt='user'></div></a>";
		output +=  "<div class='comment' style='font-size: 13px;'>";
					}

		if(commentSec==0){
			if(likeComments==loginId){
				if(commentNickname == loginNickName){
		output +=  "<a href='myPage?userId="+userId+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
							}else{
		output +=  "<a href='otherPage?userId="+commentWriter+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
								}
		output +=  "</div><div class='commentHeart' id='likeComments_"+commentNum+"' data-name='' onclick='commentLike("+commentNum+")'></div> ";				
		}else{
			if(commentNickname == loginNickName){
				output +=  "<a href='myPage?userId="+userId+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
									}else{
				output +=  "<a href='otherPage?userId="+commentWriter+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
										}
					output +=  "</div><div class='commentHeart_icon_outline' id='likeComments_"+commentNum+"' data-name='' onclick='commentLike("+commentNum+")'></div> ";		
		}	
			}else if(loginId == postWriter || loginId == commentWriter){
				if(likeComments==loginId){
					if(commentNickname == loginNickName){
						output +=  "<a href='myPage?userId="+userId+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
											}else{
						output +=  "<a href='otherPage?userId="+commentWriter+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
												}
					output +=  "</div><div class='commentHeart' id='likeComments_"+commentNum+"' data-name='' onclick='commentLike("+commentNum+")'></div> ";						
					}
				else{
					if(commentNickname == loginNickName){
						output +=  "<a href='myPage?userId="+userId+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
											}else{
						output +=  "<a href='otherPage?userId="+commentWriter+"'><span class='user_id'>"+commentNickname+"</span></a><div style='width:100%; word-break:break-all;word-wrap:break-word;'>"+commentContent+"";
												}
					output +=  "</div><div class='commentHeart_icon_outline' id='likeComments_"+commentNum+"' data-name='' onclick='commentLike("+commentNum+")'></div> ";							
					}
				}
	else{
	output +=  "<span class='user_id'>"+commentNickname+"</span>비밀댓글입니다.";
	
			}
	
	if(commentTimeSet!='0'){
	output +=  "<div class='time' style='font-size: 8px'>"+commentTimeSet+"시간 전 좋아요:"+likeCommentCount+" </div>";
		}else{
	output +=  "<div class='time' style='font-size: 8px'>방금전 좋아요: "+likeCommentCount+" </div>";
			}

	if(loginId == commentWriter){
	output +=" <div style ='float:right; color:red ;cursor: pointer' onclick='commentDelete("+commentNum+")'> 삭제 </div>"
		}	
	

	if(commentSec==0){

		output +=  " <div onclick ='comment_comment("+commentNum+")' style='cursor: pointer;width: 60px'>답글보기</div>";
		output +=  " <div id='comment_comment_"+commentNum+"'style= 'display: none;'> ";
		output +=  " <div id='outputComment_comment_"+commentNum+"> ";

		if(comment_comment != null){		
		for(var j in comment_comment){
		console.log("::::::"+comment_comment);
		var comment_CommentNum =  comment_comment[j].comment_CommentNum;
		var comment_CommentWriter = comment_comment[j].comment_CommentWriter;
		var comment_CommentContent = comment_comment[j].comment_CommentContent;
		var comment_CommentTime = comment_comment[j].comment_CommentTime;
		var comment_CommentTimeSet = comment_comment[j].comment_CommentTimeSet;
		var comment_CommentNickName = comment_comment[j].comment_CommentNickName;	
	
		output +=  "<div class ='comment_commentContent'><span class='user_id'>"+comment_CommentNickName+"</span>"+comment_CommentContent+"";
		if(loginId == comment_CommentWriter){
		output += "<span style='font-size:12px; color:red; cursor: pointer;' onclick='deleteCCCon("+commentNum+","+comment_CommentNum+")'> 삭제</span></div>";
		}else{
		output += "</div>";
			}
		}}	

		output +=  " <div class ='comment_comment_join'> <input type='text' id='comment_comment_join"+commentNum+"' style='width: 180px'>  <button onclick= 'inputComment_comment("+commentNum+")'  >댓글달기</button>  </div>";
		output +=  "</div></div></div></div>";
		
			}else if(loginId == postWriter || loginId == commentWriter){

				output +=  " <div onclick ='comment_comment("+commentNum+")' style='cursor: pointer;width: 60px'>답글보기</div>";
				output +=  " <div id='comment_comment_"+commentNum+"'style= 'display: none;'> ";
				output +=  " <div id='outputComment_comment_"+commentNum+"> ";


				if(comment_comment != null){		
				for(var j in comment_comment){
				console.log("::::::"+comment_comment);
				var comment_CommentNum =  comment_comment[j].comment_CommentNum;
				var comment_CommentWriter = comment_comment[j].comment_CommentWriter;
				var comment_CommentContent = comment_comment[j].comment_CommentContent;
				var comment_CommentTime = comment_comment[j].comment_CommentTime;
				var comment_CommentTimeSet = comment_comment[j].comment_CommentTimeSet;
				var comment_CommentNickName = comment_comment[j].comment_CommentNickName;			
				output +=  "<div class ='comment_commentContent'><span class='user_id'>"+comment_CommentNickName+"</span>"+comment_CommentContent+"";
				if(loginId == comment_CommentWriter){
					output += "<span style='font-size:12px; color:red; cursor: pointer;' onclick='deleteCCCon("+commentNum+","+comment_CommentNum+")'> 삭제</span></div>";
					}else{
					output += "</div>";
						}
				}}	
				output +=  " <div class ='comment_comment_join'> <input type='text' id='comment_comment_join"+commentNum+"' style='width: 180px'>  <button onclick= 'inputComment_comment("+commentNum+")' >댓글달기</button>  </div>";
				output +=  "</div></div></div></div>";
				}
			else{
		output +=  "</div></div>";

				}
	}

	$("#scroll_section").html(output);	
}

function boardDelete(value){
	var postNum = value;
	console.log(postNum);
			$("#exampleModal").modal("hide");
	$.ajax({
		type : "get",
		url : "boardDelete",
		data: { "postNum": postNum},  
		dataType: "text",                    
		success: function(result){
			if(result == "OK"){
			alert("게시물을 삭제하셨습니다.");
			location.href='boardList';
				}
		},
		error: function(){
			alert("연결실패");
			}

		});

}


function boardModifyForm(value){
	var postNum = value;
	console.log(postNum);
			$("#exampleModal").modal("hide");
			location.href="boardModifyForm?postNum="+postNum+"";
}


function commentDelete(commentNum){
	var postNum= $("#postNum").val();
	var page = $("#selectPage option:selected").val();
	$.ajax({
		type : "post",
		url : "commentDelete",
		data :{
			"commentNum" : commentNum
		},
		dataType : "text",
		success : function(result){
			if(result == "OK"){
				alert("댓글이 삭제되었습니다.");
				comments(postNum,page);
		
			}
		},
		error : function(){
			
		}
	});
	
}

function deleteCCCon(commentNum,comment_commentNum){	
	var postNum= $("#postNum").val();
	var page = $("#selectPage option:selected").val();
	$.ajax({
		type:"post",
		url : "deleteCCCon",
		data : {
			"comment_CommentNum" : comment_commentNum
		},
		dataType : "text",
		success : function(result){
				if(result =="OK"){
					alert("댓글이 삭제되었습니다.");
					comments(postNum,page);
				}
		},
		error : function(){
			
		}
	})
		
}

</script>


</html>