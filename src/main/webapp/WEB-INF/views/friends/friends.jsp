<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<!-- <script src="resources/js/friends.js"></script> -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	
	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" /> -->
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
	
	
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
   	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
   	
   	
	<link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
	<link rel="stylesheet" href="resources/css/friends.css">
	
    <!-- <link rel="stylesheet" href="resources/css/friendsModal.css"> -->
	
	
	
<body>
	 <div id="main_container">

        <section class="b_inner">

            <div class="hori_cont">
                <div class="detail">
                    <p class="about">
                        <span class="friends" style="margin: auto;">친구추천</span>
                        <span class="follower">팔로워</span>
                        <span class="following">팔로잉</span>
                    </p>
                </div>
            </div>

            <div class="friends_contents contents_container active" id="friendsAddList">
				<!-- 친구추천내용 -->
            </div>


            <div class="follower_contents contents_container" id="followerList">
				<!-- 팔로우리스트내용 -->
            </div>

            <div class="following_contents contents_container" id="followingList">
				<!-- 팔로잉리스트내용 -->
             </div>
	
	
	<div class="modal fade" id="followModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document"  style="magin-left:50%; margin-top:15%;">
			<div class="modal-content">
				<div class="modal-header">
					<div class="profile_img" id="modal-img-profile" style="border-radius: 70%; overflow:hidden; background-color: red;">
						<!-- 이미지 -->
						
					</div>
				</div>
				<div class="modal-body">
				<span id="modal-text-content" class="text" style="vertical-align: middle;"> <!-- 글 내용--></span></div>
				<div class="modal-footer" id="modal-btn-follow">
					<!-- 내용 -->
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" id="unFollowModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document"  style="magin-left:50%; margin-top:15%;">
			<div class="modal-content">
				<div class="modal-header">
					<div class="profile_img" id="modal-img-profile-2">
						<!-- 이미지 -->
						
					</div>
				</div>
				<div class="modal-body">
				<span id="modal-text-content-2" class="text" style="vertical-align: middle;"> <!-- 글 내용--></span></div>
				<div class="modal-footer" id="modal-btn-follow-2">
					<!-- 내용 -->
				</div>
			</div>
		</div>
	</div>
	

        </section>
		
			
			
			
			
			
			
			
			
											
   
    </div>
    
    
    
</body>

<script type="text/javascript">
	$(document).ready(function(){
		list();

		
		
});
	function list(){
		var userId ='${sessionScope.loginId}';
		console.log("세션 아이디값 : "+userId);
			$.ajax({ //친구추가를 위한 ajax
				type : "post",
				url : "getNickName",
				data : {
					"userId":userId
				},
				dataType:"json",
				success:function(result){
					console.log(result);
					friendsAdd(result);				
				},
				error:function(){
					console.log("실패")
				}
			})

			$.ajax({ //팔로워를 불러오기위한 ajax
				type : "post",
				url : "getFollower",
				data : {
					"userId":userId
				},
				dataType:"json",
				success:function(result){
					console.log(result);
					followerList(result);
				},
				error:function(){
					console.log("실패")
				}
			})

			$.ajax({ //팔로잉를 불러오기위한 ajax
				type : "post",
				url : "getFollowing",
				data : {
					"userId":userId
				},
				dataType:"json",
				success:function(result){
					console.log(result);
					followingList(result);	
				},
				error:function(){
					console.log("실패")
				}
			})
	}

	
	function friendsAdd(result){
		var output ='';
		var loginId = '${sessionScope.loginId}'; //내 아이디
		for(var i in result){
			var id = result[i].following; //i번째 친구추천 리스트의 아이디
			console.log("#######"+id);
			var info = getUserInfo(id);
			var nickName = info.nickName;
			var userName = info.userName; // i번째 친구추천 리스트의 이름
			var userProfile = info.userProfileName; // i번째 친구추천 리스트의 프로필사진
			var reason = getReason(id,loginId); // i번째 친구추천 리스트의 이유 ex)deckk15님 외 n명이 팔로우하고있습니다.
          output +="<div class='contents1'>";
          output +="<div class='contents2'><img src='resources/profileImg/"+userProfile+"' alt=''></div>"; //프로필변경해야함
		  output +="<div class='contents3'>";
		  output +="<div class='contents4_1'>"+nickName+"</div>"; // 닉네임
		  output +="<div class='contents4_1'>"+userName+"</div>"; // 이름
		  output +="<div class='contents4_1'>"+reason+"</div>";
		  output +="</div>";
		  output +="<div class='contents5'><a href='#' class='btn btn-primary followingbtn' onclick='followModal(\""+id+"\",\""+nickName+"\",\""+userProfile+"\")'><span class='text'>팔로우</span></a></div>";
		  output +="</div>";
		}
		$("#friendsAddList").html(output);
	}

	
	function followerList(result){
		output='';
		var loginId = '${sessionScope.loginId}';
		//맞팔가져옴
		var f4f = getF4f(loginId);
		var f4fList =[];
		for(var i in f4f){
			f4fList.push(f4f[i].follower);			
		}
		//맞팔아닌애들 가져옴
		var unF4f = getUnF4f(loginId);
		var unF4fList =[];
		for(var i in unF4f){
			unF4fList.push(unF4f[i].follower);			
		}
		//전체 큰 반복문 출력하게해줌
		for(var i in result){
			var id = result[i].follower; //i번째 친구추천 리스트의 아이디
			var info = getUserInfo(id);
			var nickName = info.nickName;
			var userName = info.userName; // i번째 친구추천 리스트의 이름
			var userProfile = info.userProfileName; // i번째 친구추천 리스트의 프로필사진
			// 맞팔인애들 버튼 구현
			for(var j in f4fList){
				if(id == f4fList[j]){ 
					output +="<div class='contents1'>";
					output +="<div class='contents2'><img src='resources/profileImg/"+userProfile+"' alt=''></div>"; //프로필변경해야함
					output +="<div class='contents3'>";
					output +="<div class='contents4_2'>"+nickName+"</div>";
					output +="<div class='contents4_2'>"+userName+"</div>";
					output +="</div>";
					output +="<div class='contents5'><a href='#' class='btn btn-secondary followingbtn' onclick='unFollowModal(\""+id+"\",\""+nickName+"\",\""+userProfile+"\")'><span class='text'>팔로잉</span></a></div>";
					output +="</div>";
					//<a href='#' class='btn btn-secondary followingbtn' onclick='unFollowbtn(\""+id+"\")'><span>팔로잉</span></a>
				}		
			}
			// 맞팔 아닌애들 버튼 구현
			for(var j in unF4fList){
				if(id == unF4fList[j]){ 
			        output +="<div class='contents1'>";
			        output +="<div class='contents2'><img src='resources/profileImg/"+userProfile+"' alt=''></div>"; //프로필변경해야함
					output +="<div class='contents3'>";
					output +="<div class='contents4_2'>"+nickName+"</div>"; 
					output +="<div class='contents4_2'>"+userName+"</div>"; 
					output +="</div>";
					output +="<div class='contents5'><a href='#' class='btn btn-primary followingbtn' onclick='followModal(\""+id+"\",\""+nickName+"\",\""+userProfile+"\")'><span class='text'>팔로우</span></a></div>";
				    output +="</div>";
				}			
			}			
		}
		
		$("#followerList").html(output); 		
	}
	
	
	function followingList(result){
		output='';
		var loginId = '${sessionScope.loginId}';
		for(var i in result){
			var id = result[i].following; //i번째 친구추천 리스트의 아이디
			var info = getUserInfo(id);
			var nickName = info.nickName;
			var userName = info.userName; // i번째 친구추천 리스트의 이름
			var userProfile = info.userProfileName; // i번째 친구추천 리스트의 프로필사진
          output +="<div class='contents1'>";
          output +="<div class='contents2'><img src='resources/profileImg/"+userProfile+"' alt=''></div>"; //프로필변경해야함
		  output +="<div class='contents3'>";
		  output +="<div class='contents4_2'>"+nickName+"</div>"; // 닉네임
		  output +="<div class='contents4_2'>"+userName+"</div>"; // 이름
		  output +="</div>";
		  output +="<div class='contents5'><a href='#' class='btn btn-secondary followingbtn' onclick='unFollowModal(\""+id+"\",\""+nickName+"\",\""+userProfile+"\")'><span class='text'>팔로잉</span></a></div>";
		  output +="</div>";
		}
		$("#followingList").html(output);
	}
	

	//유저의 닉네임을 가쟈옴
	
	function getUserInfo(id){
		var userInfo ='';
		$.ajax({
			type :"post",
			url :"getUserInfo",
			data :{
				"userId":id
				},
			dataType:"json",
			async:false,
			success:function(result){
				userInfo = result;
			},
		})
		return userInfo;
	}
	
	/* function getUserNickName(id){
		var nickName ='';
		
		$.ajax({
			type :"post",
			url :"getUserNickName",
			data :{
				"userId":id
				},
			dataType:"text",
			async:false,
			success:function(result){
				nickName = result;
				
			},
		})
		return nickName;
	}
	
	//유저의 이름 가져옴 member
	function getUserName(id){
		var name ='';
		
		$.ajax({
			type :"post",
			url :"getUserName",
			data :{
				"userId":id
				},
			dataType:"text",
			async:false,
			success:function(result){
				name = result;
				
			},
		})
		return name;
	}
	
	//프로필사진을 가져옴 member
	function getUserProfile(id){
		var img ='';
		
		$.ajax({
			type :"post",
			url :"getUserProfile",
			data :{
				"userId":id
				},
			dataType:"text",
			async:false,
			success:function(result){
				img = result;
				
			},
		})
		return img;
	} */
		

	//친구추천 이유를 가져옴 follow
	function getReason(id,loginId){
		var reason ='';
		
		$.ajax({
			type :"post",
			url :"getReason",
			data :{
				"yourId":id,
				"myId":loginId
				},
			dataType:"text",
			async:false,
			success:function(result){
				reason=result;
			},
		})
		return reason;
	}
		

/* 	// 친구추천 카운트를 해줌 만약 0명일경우는 없음! follow
	function getReasonCount(id,loginId){
		var reasonCount ='';
		
		$.ajax({
			type :"post",
			url :"getReasonCount",
			data :{
				"yourId":id,
				"myId":loginId
				},
			dataType:"text",
			async:false,
			success:function(result){
				reasonCount = result;
				
			},
		})
		return reasonCount;
	}
 */

	function getF4f(loginId){
		var f4f ='';
		console.log("%%%%%%%%%%%%%%%%%%%%%%%%%getF4f")
		$.ajax({
			type :"post",
			url :"getF4f",
			data :{
				"userId":loginId
				},
			dataType:"json",
			async:false,
			success:function(result){
				f4f = result;
				console.log(result)
			},
		})
		return f4f;
	}

	function getUnF4f(loginId){
		var unF4f ='';
		$.ajax({
			type :"post",
			url :"getUnF4f",
			data :{
				"userId":loginId
				},
			dataType:"json",
			async:false,
			success:function(result){
				unF4f = result;
				console.log(result)
			},
		})
		return unF4f;
	}


	function followModal(id,nickName,userProfile){
		console.log("followModal::"+id+"::"+nickName+"::"+userProfile);
		var profile ="<img alt='프로필사진' src='resources/profileImg/"+userProfile+"'>";
		console.log(profile);		
		var nick = nickName+"님을 팔로우 하시겠습니까?";
		var id = "<a class='btn' id='modalFollow' href='#' onclick ='followbtn(\""+id+"\")' style='color:#3897f0;'>팔로우</a><button class='btn' type='button' onclick ='modalhide();'; data-dismiss='modal' style='color: red;''>취소하기</button>"
		$("#modal-img-profile").html(profile);
		$("#modal-text-content").text(nick);
		$("#modal-btn-follow").html(id);
		$("#followModal").modal("show");
		
	}
	function followbtn(id){
		console.log("followbtn"+id);
		 var loginId = '${sessionScope.loginId}';
	$.ajax({
			type:"post",
			url:"follow",
			data:{
				"myId" : loginId,
				"yourId" : id
				},
			dataType:"text",
			success:function(result){
				console.log(result);
				list();
			},
			error:function(){
				console.log("실패");
			},
		})
		$("#followModal").modal('hide');
	}

	function unFollowModal(id,nickName,userProfile){//프로필,닉네임,아이디
		console.log("unFollowModal::"+id+"::"+nickName+"::"+userProfile)
		var profile ="<img alt='정신나갈거같애' src='resources/profileImg/"+userProfile+"'>";	
		var nick = nickName+"님을 팔로우취소 하시겠습니까?";
		var id = "<a class='btn' id='modalUnFollow' href='#' onclick ='unFollowbtn(\""+id+"\")' style='color:black;'>팔로우취소</a><button class='btn' type='button' onclick ='modalhide();'; data-dismiss='modal' style='color: red;''>취소하기</button>"
		$("#unFollowModal").modal("show");
		$("#modal-img-profile-2").html(profile);
		$("#modal-text-content-2").text(nick);
		$("#modal-btn-follow-2").html(id);
		
	}
	

	function unFollowbtn(id){
		console.log("unFollowbtn"+id);
		 var loginId = '${sessionScope.loginId}';
		$.ajax({
			type:"post",
			url:"unFollow",
			data:{
				"myId" : loginId,
				"yourId" : id
				},
			dataType:"text",
			success:function(result){
				console.log(result)
				list()
			},
			error:function(){
				console.log("실패")
			},
		})
		$("#unFollowModal").modal("hide");	
	}


		
</script>






<script type="text/javascript">

$(document).ready(function(){
   var checkNum = '${checkNum}';
   if (checkNum == 1){
	   flex_Container[1].classList.add('active');
	   taps[1].classList.add('on');
   } else if (checkNum == 2){
	   flex_Container[2].classList.add('active');
	   taps[2].classList.add('on');
   } else {
	   flex_Container[0].classList.add('active');
	   taps[0].classList.add('on');
   }        
});

const tapContainer = document.querySelector('.about'); //.about이라는 클래스 이름을 찾아서 불러옴
const flex_Container = document.querySelectorAll('.contents_container'); //내용물
const taps = document.querySelectorAll('.about > span'); //클래스가 about인 span 태그
/*
querySelector = elmelntById와는 다르게 선택기를 사용해서 검색함.
*/
tapContainer.addEventListener('click', openCity);
function openCity(e){
    let elem = e.target;
   
    for (var i = 0; i < flex_Container.length; i++) {
        console.log(flex_Container[i]);
        console.log(taps[i]);
        flex_Container[i].classList.remove('active');
        taps[i].classList.remove('on');
    }
    
    if(elem.matches('[class="friends"]')){
        
        flex_Container[0].classList.add('active');
        taps[0].classList.add('on');
        
    }else if(elem.matches('[class="follower"]')){
        
        flex_Container[1].classList.add('active');
        taps[1].classList.add('on');
        
    }else if(elem.matches('[class="following"]')){
        
        flex_Container[2].classList.add('active');
        taps[2].classList.add('on');
    }  
    
}
</script>

</html>