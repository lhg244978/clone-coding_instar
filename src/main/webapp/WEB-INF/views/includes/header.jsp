<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>geunstagram</title>

	<!-- 폰트설정 -->
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">

	<!-- 제이쿼리 -->
	<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="shortcut icon" href="resources/imgs/G.JPG">
    	<!-- 웹소켓 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
	
	<script type="text/javascript">
    /* -----------------페이지가 로딩될 때 웹소켓을 실행한다. ----------------- */
	$(document).ready(function() {
		if(${sessionScope.loginId==null}){
			alert("잘못된 접속방식입니다");
			location.href="/"
			return;
		}
		
		icon($(location).attr('pathname'));
		console.log("시작됨?")
		

		var wsUri = "/chat";
		webSocket.init(wsUri);
		
		/* webSocket.init({ url: '<c:url value="/chat" />' });		 */
			
	});
	/*----헤더 아이콘 변경------*/
	function icon(value){
		console.log("pathname="+value)
		
	if(value == '/boardList'){
		$("#home_button").attr('class','home_button');
	
			}else if(value == '/popList'){
		$("#compass_button").attr('class','sprite_compass_icon_inline');
				
				}
			else if(value == '/friends'){
		$("#heart_button").attr('class','sprite_heart_icon_black');
				
				}
			else if(value == '/directmsg'){
		$("#dm_button").attr('class','sprite_dm_black');
				
				}
			else if(value == '/myPage'){
		$("#user_button").attr('class','sprite_user_icon');
				
				}
			else if(value == '/boardWriteForm'){
		$("#camera_button").attr('class','sprite_camera_icon_inline');
				
				}
		
		}
	</script>
	<script type="text/javascript">

	/* -----------------웹소켓 시작주소 ----------------- */
	var webSocket = {
		init: function(param) {
			/* this._url = param.url; */
			console.log("시작됨?"+param)
			this._url = param;
			this._initSocket();
		},


		
	/* -----------------메세지를 받아서 처리하는 항목 ----------------- */
	/*
	  @checkType
	  chat : 채팅관련
	  online : 나의 상태를 상대방에게 전송
	  alse_online : online의 답장
	  offline : 나의 상태를 상대방에게 전송
	*/
	receiveMessage: function(str) {
		var chatData = str.split("/");
		var checkType = chatData[0]; 
		var sender = chatData[1];
		var recipient = chatData[2];
		var content = chatData[3];
		var checkCount = chatData[4];
		var sendMsgTime = chatData[5];
		var hitoryTime =chatData[6];
		console.log("checkType : "+checkType);
		console.log("checkCount♬ :"+checkCount);
		
		if(checkType =='chat'){
			var chatDataCode = sender+"_"+recipient+"_chat";
			var check =sender+"_"+recipient;
			console.log("check:"+check);
	 		var test = $("#"+$.escapeSelector(check)).text()
	 		console.log("★TEST: "+test);
			//1. 채팅방을 만들어줘야해
			if(test == ''){
				creatChatroom(sender,recipient,checkCount);
			};						
			//3. 알람용메세지
			countMsg(sender,recipient,checkCount,hitoryTime);
			//2. 메세지는 해당 방에만 넘겨줘야함.
			var yourNickName=getUserNickName(sender);
			var yourProfile=getUserProfile(sender);
			yourChatMsg(sender,content,chatDataCode,sendMsgTime,yourNickName,yourProfile);
			
			
		}else if(checkType =='online'){
			console.log("online == userOnline실행");
			userOnline(sender,recipient);
			//온라인받았으면 나도 그거에대한 답장을 주면 
			
			var msgData = {
				msgtype : "alse_online",
				msgsender : recipient,
				msgrecipient : sender,
				msgcontent : "온라인알람용"
			};
			var JSONObject = JSON.stringify(msgData);
			webSocket._sendMessage(JSONObject);
		}else if(checkType =='alse_online'){
			//답장이온상태야. sender = deckk1 // deckk2
			console.log("alse_online == userOnline실행")
			userOnline(sender,recipient);	
		}else if(checkType =='offline'){
			userOffline(sender,recipient);
			
		}else if(checkType =='alert'){
			//알람기능
		}
			


		/* -----------------연결이 끊겼을때 메세지(굳이? 나중에 삭제 할 확률 높음)----------------- */		
		},
		closeMessage: function(str) {
			$('#divChatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
		},


		
		/* -----------------웹소켓 연결 끊기 ----------------- */
		disconnect: function() {
			this._socket.close();
			console.log("웹소켓끊기")
		},


		/* -----------------웹소켓 컨트롤러----------------- */
		_initSocket: function() {
			this._socket = new SockJS(this._url);
			this._socket.onmessage = function(evt) {
				webSocket.receiveMessage(evt.data);
			};
			this._socket.onclose = function(evt) {
				webSocket.closeMessage(evt.data);
				
			}
		},


		/* -----------------내가 보낼 메세지 처리항목----------------- */
		_sendMessage: function(str) {
			console.log("보낼메세지:"+str);	
			this._socket.send(str);
		}
	};


	
	/* -----------------웹소켓 연결 메소드 ----------------- */
	function webSocketConnetion(){
		var wsUri = "/chat";
		webSocket.init(wsUri)
	}

	/* -----------------웹소켓 연결해제 메소드----------------- */
	function webSocketDisconnet(){
		webSocket.disconnect();
	}
	
	

</script>
	<style>
	/* 드랍다운 관련 */

	.dropdown {
  	position: relative;
  	display: inline-block;
	}

	.dropdown-content {
  	display: none;
  	position: absolute;
  	background-color: white;
  	min-width: 300px;
  	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  	z-index: 1;
	}

	.dropdown-content a {
  	color: black;
  	padding: 12px 16px;
  	text-decoration: none;
  	display: block;
	}

	.dropdown-content a:hover {background-color: #ddd;}

	.dropdown:hover .dropdown-content {display: block;}

	.dropdown:hover {background-color: #3e8e41;}
	
	a:hover {
		color : black;
		text-decoration : none;
	}
	
	.logout_button{
    display: inline-block;
    background: url('resources/imgs/logout.png') no-repeat ;
    width: 38px;
    height: 28px;
    float: right;

}
	.home_button{
    display: inline-block;
    background: url('resources/imgs/home.png') no-repeat ;
    width: 24px;
    height: 24px;
   

}
	.sprite_dm {
    display: inline-block;
    background: url('resources/imgs/background01.png') no-repeat -156px -232px;
    width: 25px;
    height: 25px;
}
	.sprite_geun_logo {
    display: inline-block;
    background: url('resources/imgs/geunsta.png') no-repeat -6px -12px;
    width: 153px;
    height: 24px;
	}
		.sprite_dm_black {
    display: inline-block;
    background: url('resources/imgs/dm_black.png') no-repeat;
    width: 24px;
    height: 24px;
}
	.sprite_user_icon {
    display: inline-block;
    background: url('resources/imgs/black_user.png') no-repeat;
    width: 25px;
    height: 25px;
 
}

	.home_button{
    display: inline-block;
    background: url('resources/imgs/home.png') no-repeat ;
    width: 24px;
    height: 24px;
  

}
	.white_Home_button{
    display: inline-block;
    background: url('resources/imgs/white_H.png') no-repeat ;
    width: 24px;
    height: 24px;
   

}
	.sprite_compass_icon_inline{
    display: inline-block;
    background: url('resources/imgs/black_N.jpg') no-repeat ;
    width: 24px;
    height: 24px;


}
	.sprite_heart_icon_black{
    display: inline-block;
    background: url('resources/imgs/black_H.png') no-repeat ;
    width: 24px;
    height: 24px;
    

}
	
	.sprite_camera_icon_inline{
    display: inline-block;
    background: url('resources/imgs/black_camera.png') no-repeat ;
    width: 24px;
    height: 24px;
	
}

/* 스크롤바 숨기기 */
.box1 {
	-ms-overflow-style: none; /* IE and Edge */
	scrollbar-width: none; /* Firefox */
}

.box1::-webkit-scrollbar {
	display: none; /* Chrome, Safari, Opera*/
}

	
	
	</style>

</head>
<body style="font-family: 'Gamja Flower', cursive; font-size: 20px;">


<section id="container">


    <header id="header" style="position: fixed;">
        <section class="inner">

            <h1 class="logo">
                    <a href="boardList"><div class="sprite_geun_logo"></div></a>
            </h1>

			
  <!-- <button class="dropbtn">드롭다운 메뉴</button>
  <div class="dropdown-content">
    <a href="#">홈</a>
    <a href="#">회사소개</a>
    <a href="#">제품소개</a>
    <a href="#">오시는길</a>
  </div> -->

            <div class="search_box dropdown" >
                <input type="text" placeholder="검색" id="search-field" autocomplete="off" style="width:180px; height:34px; padding: 3px 10px;box-sizing: border-box;">

                <div class="fake_field">
                    <span class="sprite_small_search_icon"></span>
                    <span>검색</span>
                </div>
                <div class="dropdown-content box1" style="max-height:365px; overflow-y : scroll;">
    			
  				</div>
                
                
            </div>

            <div class="right_icons" style="width:230px;">
    
	
                <a href="boardList"><div class="white_Home_button" id="home_button"></div></a>
		 
			
                <a href="boardWriteForm"><div class="sprite_camera_icon" id="camera_button"></div></a> 
              
        
                <a href="popList"><div class="sprite_compass_icon" id="compass_button"></div></a>


 				<a href="friends?checkNum=0"><div class="sprite_heart_icon_outline"  id="heart_button"></div></a>
		      
                <a href="directmsg"><div class="sprite_dm" id="dm_button"></div></a>
                
                <a href="myPage?userId=${sessionScope.loginId }"><div class="sprite_user_icon_outline" id="user_button"></div></a>
                
                <a href="memberLogout"><div class="logout_button"></div></a>
                
            </div>
<%-- <input type="hidden" id="log" value="${sessionScope.loginId }" > --%>

        </section>

    </header>
</body>
<script type="text/javascript">
	$(function(){
		$("#search-field").keyup(function(){
		var search = $("#search-field").val();
		if(search.match("%")){
			console.log(search);
				var result='';
				searchUser(result);
			
		}
			if(search == "" || search =="#"){
				$(".dropdown-content").css('display','none');
				
			} else if(search.substr(0,1) != "#"){
				if(search.substr(0,1) == "@"){
					var Usearch = search.substr(1);
					
					$.ajax({
						type : "post",
						url : "searchUser", 
						data : {
							"searchUser" : Usearch
						},
						dataType : "json",
						success : function(result){
							searchUser(result);
						},
						error : function(){
							alert("연결실패");
						}
					});
				} else{				
				$.ajax({
					type : "post",
					url : "searchUser", 
					data : {
						"searchUser" : search
					},
					dataType : "json",
					success : function(result){
						searchUser(result);
						
					},
					error : function(){
						alert("연결실패");
					}
				});
				}
				$(".dropdown-content").css('display','block');
				
			}  else if(search.substr(0,1) == "#"){
				console.log(search);
				$.ajax({
					type : "post",
					url : "searchPost", 
					data : {
						"searchPost" : search
					},
					dataType : "json",
					success : function(result){
						searchPost(result);
					},
					error : function(){
						
					}
				});
				$(".dropdown-content").css('display','block');
			}
		})
	});
	
	function searchUser(result){
		var output ='';
		if (result.length==0){
			
			output += "<a href='#' style='pointer-events: none; cursor: default;'>";
			output += "<header class='top'>";
			output += "<div class='user_container' style='display:flex; align-items:center;'>";
			output += "검색된 정보가 없습니다."
			output += "</div>";
			output += "</header>";
			output += "</a>";
			
			
			$(".dropdown-content").html(output);
		}
		for ( var i in result){
			var userProfileName = result[i].userProfileName;
			var nickName = result[i].nickName;
			var userIntro = result[i].userIntro;
			var userId = result[i].userId;
			var loginId = '${sessionScope.loginId}';
			
			if(userId == loginId){
			output += "<a href='myPage?userId="+userId+"'>";
		}else{
			output += "<a href='otherPage?userId="+userId+"'>";
			}
			output += "<header class='top'>";
			output += "<div class='user_container' style='display:flex; align-items:center;'>";
			output += "<div class='profile_img' style='margin-left:0; width:36px; height:36px; border-radius: 50%; overflow:hidden; margin-right:10px;'>";
			output += "<img src='resources/profileImg/"+userProfileName+"' alt='' style='width:36px; height:36px;'>";
			output += "</div>";
			output += "<div class='user_name'>";
			output += "<div class='nick_name' style='font-size:15px;'>"+nickName+"</div>";
			output += "<div class='country' style='font-size:15px;'>"+userIntro+"</div>";
			output += "</div>";
			output += "</div>";
			output += "</header>";
			output += "</a>";
			
			
			$(".dropdown-content").html(output);
		}
	}
	
	function searchPost(result){
		var output ='';
		if (result.length==0){
			
			output += "<a href='#' style='pointer-events: none; cursor: default;'>";
			output += "<header class='top'>";
			output += "<div class='user_container' style='display:flex; align-items:center;'>";
			output += "검색된 정보가 없습니다."
			output += "</div>";
			output += "</header>";
			output += "</a>";
			
			
			$(".dropdown-content").html(output);
		}
		for ( var i in result){
			var tagName = result[i].tagName;
			var countPost = result[i].countPost;
		    var newTagName = tagName.substr(1);
			
			if(tagName != "#"){
			output += "<a href='searchPostList?tagName="+newTagName+"'>";
			output += "<header class='top'>";
			output += "<div class='user_container' style='display:flex; align-items:center;'>";
			output += "<div class='profile_img' style='margin-left:0; width:32px; height:32px; border-radius: 50%; overflow:hidden; margin-right:10px;'>";
			output += "<img src='resources/profileImg/shop.png' alt='' style='width:100%; height:100%;'>";
			output += "</div>";
			output += "<div class='user_name'>";
			output += "<div class='nick_name' style='font-size:15px;'>"+tagName+"</div>";
			output += "<div class='country' style='font-size:15px;'>게시글 "+countPost+"개</div>";
			output += "</div>";
			output += "</div>";
			output += "</header>";
			output += "</a>";
			}
			
			$(".dropdown-content").html(output);
		}
	}
/* 	$(document).ready(function(){
		var log = $("#log").val();
		console.log("log"+log);
		if(log == null){
		shutdown();
			}
		
			});
		
	function shutdown(){
		alert("로그인이 필요합니다.");
		location.href="memberLoginForm";
	}

	function shutdown(){
		alert("로그인이 필요합니다.");
		location.href="memberLoginForm";
	}
 */

</script>
<script type="text/javascript">

	function userInfo(){
		var loginId = '${sessionScope.loginId}';
		var nick=getUserNickName(loginId);
		var profile=getUserProfile(loginId);
		var output = "<img src='resources/profileImg/"+profile+"' class='rounded-circle mr-1' width='40' height='40'>"
		$("#myProfile").html(output);
		$("#myNickName").html(nick);
	}
	/*--------------- 모달창을 보여준다 ---------------*/
	function modalshow() {
		$("#chatModal").modal("show");
		$.ajax({ //내가 팔로워 한 애들을 불러오기위한 ajax
			type : "post",
			url : "newgetFollower",
			data : {
				"userId": '${sessionScope.loginId }'
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
		$("#chatModal").modal("show");
		
	}
	
	/*--------------- 모달 관련---------------*/
	function followerList(result){
		output='';
		var loginId = '${sessionScope.loginId}';
		//전체 큰 반복문 출력하게해줌
		for(var i in result){
			var id = result[i].following; //i번째 내가 팔로우 누른 사람들
			var info = getUserInfo(id);
			var nickName = info.nickName;
			var userName = info.userName; // i번째 친구추천 리스트의 이름
			var userProfile = info.userProfileName; // i번째 친구추천 리스트의 프로필사진
					output += "<div class='contents1'>";
					output += "<div class='contents2'>";
					output += "<img src='resources/profileImg/"+userProfile+"' alt=''></div>";
					output += "</div>"
					output += "<div class='contents3'>";
					output += "<div class='contents4_2'>"+nickName+"</div>" ;
					output += "<div class='contents4_2'>"+userName+"</div>" ;
					output += "</div>";
					output += "<div class='contents5'>";
					output += "<a href='#' class='btn btn-primary followingbtn' onclick='newChat_prepare(\""+id+"\")'><span class='text'>대화하기</span></a>";
					output += "</div>";
					output += "</div>";
					output += "<div style='clear: both;''><br></div>";				
				}					
		console.log(output);
		$("#followerList").html(output); 		
	}

	
	/*--------------- 모달창을 보여준다 ---------------*/
	function getUserNickName(id){
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

	
	/*--------------- 모달창을 보여준다 ---------------*/
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

	
	/*--------------- 모달창을 보여준다 ---------------*/
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
	}

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

	
	/*--------------- 모달창을 보여준다 ---------------*/
	function getF4f(loginId){
		var f4f ='';
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

	
	/*--------------- 모달창을 보여준다 ---------------*/
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

	
	/*--------------- 기존에있던 채팅방을 불러온다 ---------------*/
	function chatRoomList(result) {
		for ( var i in result) {
			var send = result[i].mynick;
			var recive = result[i].yournick;
			var count = result[i].checkCount;
			var hisoryTime = result[i].historyTime;
			creatChatroom(send, recive,count,hisoryTime);
		}
	}


	
	/* -----------------모달창 닫기----------------- */
	function newChat_prepare(id){
		$("#chatModal").modal("hide");
		newChat(id)
	}

	/* -----------------새로운 [채팅리스트] 생성한다----------------- */
	function newChat(id) {
		console.log("새로운 채팅방을 만듭니다.");
		//임시방편으로 만들어 놓음.
		var recive = id;
		var send = '${sessionScope.loginId}';
		var checkMsg=0;
		var hisoryTime="";
		/* var idName = send+"_"+recive; */
		// 대화방을 만들어준다.(기존에 대화방이 있을경우에는 대화방을 만들지 않음.)
		creatChatroom(send, recive,checkMsg,hisoryTime);
		

	}

	function countMsg(send, recive,checkMsg,hitoryTime) {
		var loginId = '${sessionScope.loginId}';
		//이미 만들어져 있을 경우에는 생성하지 않아야해. 이미 
		console.log("checkMsg"+checkMsg)
		var creatRoom = '';
		var chatRoomName = '';
		var onOffline ='';
		$.escapeSelector('#test')
		chatRoomName = send + "_" + recive;
		ChatRoomTimeName = chatRoomName+"_Thumbnail";
		$("#count_"+$.escapeSelector(chatRoomName)).text(checkMsg);
		$("#"+$.escapeSelector(ChatRoomTimeName)).text(hitoryTime);
		
	}

	
	/* -----------------대화할때 채팅방을 만들어준다.----------------- */
	/*##############프로필넣어야함 채팅방리스트 상대방 사진###################*/
	function creatChatroom(send, recive,checkMsg,hisoryTime) {
		var loginId = '${sessionScope.loginId}';
		//이미 만들어져 있을 경우에는 생성하지 않아야해. 이미 
		var creatRoom = '';
		var chatRoomName = '';
		var onOffline ='';
		var chatHistroyTimeId='';
		var check = Number(checkMsg);
		var timeMsg='';
		
		if(hisoryTime !=''){
			timeMsg = "최근대화 "+hisoryTime;
		}
		
		if(check==0){
			check='';
		}
		/* 내가 보는 기준*/
		if (loginId == send) {
			var nick = getUserNickName(recive);
			var userProfile = getUserProfile(recive);
			console.log(userProfile);
			
			
			chatRoomName = recive + "_" + send;
			var countName = "count_"+recive + "_" + send;
			onOffline =recive + "_" + send+"_onoff";
			chatHistroyTimeId=recive+"_"+send+"_Thumbnail";
			
			console.log("새로운 채팅방을 만드는 중입니다. 만든사람 :" + send + " 받는이 : "+ recive);
			creatRoom += "<a href='#' class='list-group-item list-group-item-action border-0' onclick='chatStart(\""+ recive + "\")'>";
			creatRoom += "<div class='badge bg-success float-right' id = '"+countName+"'>"+check+"</div>";
			creatRoom += "<div class='d-flex align-items-start'>";
			creatRoom += "<img src='resources/profileImg/"+userProfile+"' alt='' class='rounded-circle mr-1' alt='Vanessa Tucker' width='40' height='40'>";
			creatRoom += "<div class='flex-grow-1 ml-3'>";
			creatRoom += "<span id='"+chatRoomName+"'>" + nick + "</span>";
			creatRoom += "<div class='small'><span id='"+onOffline+"' class='fas fa-circle chat-offline'>offline</span></div>";
			creatRoom += "<div class='small'><span id='"+chatHistroyTimeId+"' class='fas fa-circle chat-offline' style='color:black'>"+timeMsg+"</span></div>";
			creatRoom += "</div></div></a>"
			chatRoomNam ="count_"+recive + "_" + send;
			$("#createChatList").append(creatRoom);
			console.log("새로운 채팅방을 생성했습니다.")
			$("#"+$.escapeSelector(countName)).text(check);
		/*상대방에게 만들어주는 기준*/
		} else {
			var nick = getUserNickName(send);
			var userProfile = getUserProfile(send);
			console.log(userProfile);
			chatRoomName = send + "_" + recive;
			var countName = "count_"+send + "_" + recive;
			onOffline =send + "_" + recive+"_onoff";
			chatHistroyTimeId=send+"_"+recive+"_Thumbnail";
			console.log("새로운 채팅방을 만드는 중입니다. 만든사람 :" + recive + " 받는이 : "+ send);

			creatRoom += "<a href='#' class='list-group-item list-group-item-action border-0' onclick='chatStart(\""+ send + "\")'>";
			creatRoom += "<div class='badge bg-success float-right' id = '"+countName+"' >"+check+"</div>";
			creatRoom += "<div class='d-flex align-items-start'>";
			creatRoom += "<img src='resources/profileImg/"+userProfile+"' alt='' class='rounded-circle mr-1' alt='Vanessa Tucker' width='40' height='40'>";
			creatRoom += "<div class='flex-grow-1 ml-3'>";
			creatRoom += "<span id='"+chatRoomName+"'>" + nick + "</span>";
			creatRoom += "<div class='small'><span id='"+onOffline+"' class='fas fa-circle chat-offline'>offline</span></div>";
			creatRoom += "<div class='small'><span id='"+chatHistroyTimeId+"' class='fas fa-circle chat-offline' style='color:black'>"+timeMsg+"</span></div>";
			creatRoom += "</div></div></a>"
			$("#createChatList").append(creatRoom);
			console.log("새로운 채팅방을 생성했습니다.")
			$("#"+$.escapeSelector(countName)).text(check);
		}
	}


	
	/* -----------------userOnline을 표시해준다---------------- */
	function userOnline(sender,recipient){
		var id =sender+"_"+recipient+"_onoff";
		console.log("userOnline :"+id)
		//1. 클래스를 변경
		$("#"+$.escapeSelector(id)).text("online");
		//2. 텍스트를 변경
		$("#"+$.escapeSelector(id)).removeClass('chat-offline').addClass('chat-online');

			
	}


	
	/* -----------------userOffline을 표시해준다---------------- */
	function userOffline(sender,recipient){
		var id =sender+"_"+recipient+"_onoff";
		console.log("userOffline :"+id)
		//1. 클래스를 변경
		$("#"+$.escapeSelector(id)).text("offline");
		//2. 텍스트를 변경
		$("#"+$.escapeSelector(id)).removeClass('chat-online').addClass('chat-offline');	
	}
	
	

	/* -----------------[대화상대를 골라]채팅을 시작한다----------------- */
	function chatStart(param) {
		$("#divChatData").empty();
		var recive = param;
		var send = '${sessionScope.loginId}';
		$.ajax({
			type : "post",
			url : "getMsg",
			data : {
				"send" : send,
				"recive" : recive
			},
			dataType : "json",
			success : function(result) {
				chatHistory(result, recive);
			},
			error : function() {
				chatHistory_Not(recive);
			}
		})
		
	}


	
	//* -----------------[채팅을 시작할때 대화 내역이 있으면] 대화내역을 불러온다----------------- */
	function chatHistory(result, recive) {
		console.log("채팅내역을 불러왔습니다.")
		var myId = '${sessionScope.loginId}';
		var chatDataCode = recive + "_" + myId + "_chat";
		var output = "<div class='chat-messages p-4' id="+chatDataCode+" style='height: 800px; '> </div>";
		var sendBtn = ''
		$("#chatMenu").html(output);
		var myNickName = getUserNickName(myId);
		var myProfile = getUserProfile(myId);
		/* var yourNickName = nick; */
		var yourNickName =getUserNickName(recive)
		var yourProfile = getUserProfile(recive);
		var profileOutPut =  "<img src='resources/profileImg/"+yourProfile+"' class='rounded-circle mr-1' width='40' height='40'>"
		$("#yourProfile").html(profileOutPut);
		$("#chatName").text(yourNickName);
		for ( var i in result) {
			var sender = result[i].msgsender;
			var content = result[i].msgcontent;
			var time = result[i].msgtimeSet;
			if (sender == myId) {
				myChatMsg(sender, content, chatDataCode,time,myNickName,myProfile)
			} else {
				yourChatMsg(sender, content, chatDataCode,time,yourNickName,yourProfile)
			}
		}
		
		sendBtn = "<input type='text' class='form-control' placeholder='메시지 입력...' type='text' id='message' size='10' onkeypress='if(event.keyCode==13){sendChat(\""
				+ recive + "\");}'>";
		sendBtn += "<button class='btn btn-primary' id='btnSend' onclick='sendChat(\""
				+ recive + "\")'>Send</button>";
		$("#text_sendBtn").html(sendBtn);

		$("#"+$.escapeSelector(chatDataCode)).scrollTop($("#"+$.escapeSelector(chatDataCode))[0].scrollHeight);
	}



	/* -----------------채팅 내역이 없을 경우 새로운 대화를 시작한다.----------------- */
	function chatHistory_Not(recive) {
		var sendBtn = ''
		var myId = '${sessionScope.loginId}';
		var chatDataCode = recive + "_" + myId + "_chat";
		var output = "<div class='chat-messages p-4' id="+chatDataCode+" style='height: 800px; '> </div>";
		$("#chatMenu").html(output);
		var yourNickName =getUserNickName(recive)
		var yourProfile = getUserProfile(recive);
		var profileOutPut =  "<img src='resources/profileImg/"+yourProfile+"' class='rounded-circle mr-1' width='40' height='40'>"
		$("#yourProfile").html(profileOutPut);
		$("#chatName").text(yourNickName);

		
		console.log("불러올 채팅 내역이 없으므로 새로운 대화를 시작합니다.")
		sendBtn = "<input type='text' class='form-control' placeholder='메시지 입력...' type='text' id='message' size='10' onkeypress='if(event.keyCode==13){sendChat(\""
				+ recive + "\");}'>";
		sendBtn += "<button class='btn btn-primary' id='btnSend' onclick='sendChat(\""
				+ recive + "\")'>Send</button>";
		$("#text_sendBtn").html(sendBtn);
	}



	/* -----------------[SEND]버튼을 눌러 채팅을 보낸다.----------------- */
	function sendChat(recive) {
		var msgsender = '${sessionScope.loginId}';
		var msgrecipient = recive;
		var msgcontent = $("#message").val();
		var chatDataCode = msgrecipient + "_" + msgsender + "_chat";
		var msgTime='';
		var msgCount ='';
		var myNickName=getUserNickName(msgsender);
		var myProfile =getUserProfile(msgsender);
		/* var yourNickName=getUserNickName(msgrecipient); */
		console.log(chatDataCode);

		
		//보낸 메세지를 저장해야함
		$.ajax({
			type : "post",
			url : "saveMsg",
			data : {
				"msgsender" : msgsender,
				"msgrecipient" : msgrecipient,
				"msgcontent" : msgcontent
			},
			dataType : "text",
			success : function(result) {
				msgTime=result;
				console.log("메세지보낸시간 : "+msgTime);
				myChatMsg(msgsender, msgcontent, chatDataCode,msgTime,myNickName,myProfile);
				wsMessgeSend(msgsender,msgrecipient, msgcontent,msgTime);
			},
			error : function() {
				console.log("연결실패");
			}
		});

	}	
	function wsMessgeSend(msgsender,msgrecipient,msgcontent,msgTime){
		console.log("msgTime:"+msgTime)
		var msgData = {
			msgtype : "chat",
			msgsender : msgsender,
			msgrecipient : msgrecipient,
			msgcontent : msgcontent,
			msgtimeSet : msgTime	
		}
		var JSONObject = JSON.stringify(msgData);
		webSocket._sendMessage(JSONObject);
		$('#message').val('');
	}


	
	/* -----------------메세지 보낸 입장의 채팅을 관리----------------- */
	function myChatMsg(sender, content,chatDataCode,time,myNickName,myProfile) {
		console.log("★"+time)
		console.log("data@@@@" +myProfile)
		var output = '';
		output += "<div class='chat-message-left pb-4'>";
		output += "<div>";
		output += "<img src='resources/profileImg/"+myProfile+"' alt='' class='rounded-circle mr-1' alt='Sharon Lessman' width='40' height='40'>";
		output += "<div class='text-muted small text-nowrap mt-2'>"+time+"</div>";
		output += "</div>";
		output += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 ml-3'>";
		output += "<div class='font-weight-bold mb-1'>" + myNickName + "</div>";
		output += content
		output += "</div></div>"
		$("#"+$.escapeSelector(chatDataCode)).append('<div>' + output + '</div>');
		$("#"+$.escapeSelector(chatDataCode)).scrollTop($("#"+$.escapeSelector(chatDataCode))[0].scrollHeight);
	}


	
	/* -----------------메세지 받는 입장의 채팅을 관리 ----------------- */
	function yourChatMsg(sender, content,chatDataCode,time,yourNickName,yourProfile) {
		
		console.log("data####" +yourProfile)
		var str = chatDataCode.split("_");
		var chatData = str[0]+"_"+str[1];
		var output = '';
		output += "<div class='chat-message-right pb-4'>";
		output += "<div>";
		output += "<img src='resources/profileImg/"+yourProfile+"' alt='' class='rounded-circle mr-1' alt='Sharon Lessman' width='40' height='40'>";
		output += "<div class='text-muted small text-nowrap mt-2'>"+time+"</div>";
		output += "</div>";
		output += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 ml-3'>";
		output += "<div class='font-weight-bold mb-1'>" + yourNickName + "</div>";
		output += content
		output += "</div></div>"

		//맞는 곳에 뿌려줘야함.
		
		$("#"+$.escapeSelector(chatDataCode)).append('<div>' + output + '</div>');
		var text = $("#"+$.escapeSelector(chatDataCode)).length;
		console.log("d?D?D?"+text);
		if($("#"+$.escapeSelector(chatDataCode)).length>0){//내가 그 채팅방을 보고있는경우에만 실행
			console.log("메세지0으로 실행됨??")
			var countnumbr ='';
			$("#"+$.escapeSelector(chatDataCode)).scrollTop($("#"+$.escapeSelector(chatDataCode))[0].scrollHeight);
			$("#count_"+$.escapeSelector(chatData)).text(countnumbr);
		}
		
}

/* 	function myProfile(){
	var myId = '${sessionScope.loginId}';
	var myProfile = getUserProfile(myId);
	
	}

	function myProfile(){
		var myId = '${sessionScope.loginId}';
		var myProfile = getUserProfile(myId);
		
	} */


	
</script>
</html>