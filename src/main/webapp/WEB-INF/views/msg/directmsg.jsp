<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!--  This file has been downloaded from bootdey.com    @bootdey on twitter -->
<!--  All snippets are MIT license http://bootdey.com/license -->
<title>white chat - Bootdey.com</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" /> -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">


<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />

<!--css  -->
	<link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
    
<!-- 웹소켓 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>



<!-- 웹 페이지 로딩될때 채팅 내역을 불러오는 ajax-->

<script type="text/javascript">
	$(document).ready(function() {
		var loginId = '${sessionScope.loginId}';
		console.log("디엠창로딩");
		$.ajax({
			type : "post",
			url : "get_ChatRoom",
			data : {
				"loginId" : loginId
			},
			dataType : "json",
			success : function(result) {
				console.log(result);
				userInfo(loginId);
				chatRoomList(result);
			},
			error : function() {
				console.log("불러올 채팅목록이 없음");
			}
		})
	});


	$(window).on('load',function(){
	      var loginId = '${sessionScope.loginId}'; // deckk@naver.com
	      var partner = '${partner}';
	      console.log(partner);

	      
	      var check = partner + "_" + loginId;
	      
	      console.log(check);
	      if(partner != ''){
	         if($("#"+ $.escapeSelector(check)).length){
	            chatStart(partner);
	         } else {
	            newChat_prepare(partner);
	            chatStart(partner);
	         }
	      }
	      

	      });

	
</script>



<style type="text/css">
body {
	margin-top: 20px;
}

.chat-online {
	color: #34ce57
}

.chat-offline {
	color: #e4606d
}

.chat-messages {
	display: flex;
	flex-direction: column;
	max-height: 800px;
	overflow-y: scroll
}

.chat-message-left, .chat-message-right {
	display: flex;
	flex-shrink: 0
}

.chat-message-left {
	margin-right: auto
}

.chat-message-right {
	flex-direction: row-reverse;
	margin-left: auto
}

.py-3 {
	padding-top: 1rem !important;
	padding-bottom: 1rem !important;
}

.px-4 {
	padding-right: 1.5rem !important;
	padding-left: 1.5rem !important;
}

.flex-grow-0 {
	flex-grow: 0 !important;
}

.border-top {
	border-top: 1px solid #dee2e6 !important;
}.contents_container.active{
    display: flex;
}
/*글내용 1번~5번*/
.contents1{
  	width: 100%; background-color: white;
}
.contents2{
    width: 17%; height: 80px; float:left; border-radius:70%; overflow: hidden;
}
.contents2 img{
    width:100%; height:100%; object-fit:cover;
}
.contents3{
    width: 60%; height: 80px; float:left; margin-left: 2%;
}
 
.contents4_1{
    width: 100%; height: 33%;
}
.contents4_2{
    width: 100%; height: 50%;
}
.contents5{
    width: 20%; height: 80px; float:left; display:flex;
}
.contents5 .followingbtn{
    width: 100%; height: 100%; border-radius: 10px; line-height: 55px;


</style>
</head>
<body>
	<main class="content">
		<div class="container p-0" style="max-height: 1000px; height: 100%;">

			<h1 class="h3 mb-3">Messages</h1>

			<div class="card" style="max-height: 1000px; height: 100%">
				<div class="row g-0" style="height: 100%;">
					<div class="col-12 col-lg-5 col-xl-3 border-right">

						<!-- 자기정보 -->
						<div class="py-2 px-4 border-bottom d-none d-lg-block">
							<div class="d-flex align-items-center py-1">
								<div class="position-relative" id="myProfile">
								<!-- @@@@@@@@@자기프로필사진@@@@@@@@@  -->	
								</div>
								<div class="flex-grow-1 pl-3">
								<!-- @@@@@@@@@자기닉네임@@@@@@@@@  -->	
									<span id="myNickName">
									
									</span>
								</div>
								<div>

								</div>
							</div>
						</div>

						<!-- 대화리스트 -->
						<div id="createChatList">
							
						</div>


						<hr class="d-block d-lg-none mt-1 mb-0">
					</div>
					<div class="col-12 col-lg-7 col-xl-9" style="height: 950px">
						<!-- 상대 -->
						<div class="py-2 px-4 border-bottom d-none d-lg-block">
							<div class="d-flex align-items-center py-1">
							
								<!-- @@@@@@@@@상대프로필사진@@@@@@@@@  -->
								<div class="position-relative" id="yourProfile">								
									<img src="https://bootdey.com/img/Content/avatar/avatar3.png"
										class="rounded-circle mr-1" alt="Sharon Lessman" width="40"
										height="40">
								</div>
								<div class="flex-grow-1 pl-3">
									<strong id="chatName">새롭게 대화를 시작해주세요!</strong>
								</div>
								<div>
									<button class="btn btn-light border btn-lg px-3"
										onclick="modalshow()">							
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round"
											class="feather feather-more-horizontal feather-lg">
											<circle cx="12" cy="12" r="1"></circle>
											<circle cx="19" cy="12" r="1"></circle>
											<circle cx="5" cy="12" r="1"></circle></svg>
									</button>
								</div>
							</div>
						</div>

						<!-- 채팅창 -->
						<div class="position-relative" id="chatMenu">
							<!-- <div class="chat-messages p-4" id="divChatData" style="height: 800px; "> -->

							<!-- 채팅내용 - 상대 -->
							<!-- 							<div class="chat-message-right pb-4">
								<div>
									<img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
									<div class="text-muted small text-nowrap mt-2">시간</div>
								</div>
								<div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
									<div class="font-weight-bold mb-1">다른유저</div>
									<p>내용1ddd</p>
								</div>
							</div>

							채팅내용 - 나
							<div class="chat-message-left pb-4">
								<div>
									<img src="https://bootdey.com/img/Content/avatar/avatar3.png" class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
									<div class="text-muted small text-nowrap mt-2">시간</div>
								</div>
								<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
									<div class="font-weight-bold mb-1">나</div>
									내용
								</div>
							</div> -->


							<!-- </div> -->
						</div>
						<!-- 메세지보내기창 -->
						<div class="flex-grow-0 py-3 px-4 border-top">
							<div class="input-group" id="text_sendBtn">
								<!-- <input type="text" class="form-control" placeholder="메시지 입력..." type="text" id="message" size="10" onkeypress="if(event.keyCode==13){sendChat();}">
							<button class="btn btn-primary" id="btnSend" onclick="sendChat()">Send</button> -->
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</main>
	
	
<div class="modal fade" id="chatModal"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
  <div class="modal-dialog" style="magin-left:50%; margin-top:10%;">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <div><span>새로운 대화창</span></div>
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title"></h4>
      </div>
      <!-- body -->
      <div class="modal-body" id="followerList" style="overflow-y:scroll; height:500px; margin: 1%">
     <!-- 리스트 출력하는 부분입ㄴ -->
			 
      </div>
  
    </div>
  </div>
</div>


</body>

</html>