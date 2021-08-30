<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

<!-- Facebook Meta Tags / 페이스북 오픈 그래프 -->
<meta property="og:url" content="http://kindtiger.dothome.co.kr/insta">
<meta property="og:type" content="website">
<meta property="og:title" content="instagram">
<meta property="og:description" content="instagram clone">
<meta property="og:image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">
.
<!-- Twitter Meta Tags / 트위터 -->
<meta name="twitter:card" content="instagram clone">
<meta name="twitter:title" content="instagram">
<meta name="twitter:description" content="instagram clone">
<meta name="twitter:image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">

<!-- Google / Search Engine Tags / 구글 검색 엔진 -->
<meta itemprop="name" content="instagram">
<meta itemprop="description" content="instagram clone">
<meta itemprop="image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">


<title>geunstagram</title>
<link rel="stylesheet" href="resources/css/reset.css">
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/login.css">
<link rel="shortcut icon" href="resources/imgs/instagram.png">
<style type="text/css">
body {
	background-image:
		url("resources/imgs/sincerely-media-lQ3go6MNPzo-unsplash.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

.wW1cu{-webkit-flex-basis:236px;-ms-flex-preferred-size:236px;flex-basis:236px;-webkit-box-flex:0;-webkit-flex-grow:0;-ms-flex-positive:0;flex-grow:0;-webkit-flex-shrink:0;-ms-flex-negative:0;flex-shrink:0}@media (max-width:735px){.wW1cu{display:none}}
.h-aRd{border-left:2px solid transparent;display:block;font-size:16px;height:100%;line-height:20px;padding:16px 16px 16px 30px;width:calc(100% - 48px)}

a.h-aRd.fuQUr {}.-HRM-{border-left-color:#262626;border-left-color:rgba(var(--f75,38,38,38),1);font-weight:600}.fuQUr:hover{background-color:#fafafa;background-color:rgba(var(--b3f,250,250,250),1);border-left-color:#dbdbdb;border-left-color:rgba(var(--b6a,219,219,219),1)}.h-aRd,.h-aRd:visited,.h-aRd:hover,.h-aRd:active{color:#262626;color:rgba(var(--i1d,38,38,38),1)}

a.h-aRd.-HRM- {}


</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>


	<section id="container"
		style="background-color: rgba(255, 255, 255, 0.1);">
		

		<div id="main_container">

			<div class="form_container" style="width:850px;display:flex;">
				<div class="form" style="width:185px;float:left;padding:25px 40px;">
				<ul class="wW1cu">
					<li><a class="h-aRd fuQUr" href="memberModify?nickName=${sessionScope.nickName}">프로필편집</a></li>
					<li><a class="h-aRd -HRM-" href="memberPwModify?nickName=${sessionScope.nickName }">비밀번호 변경</a></li>
				</ul>
				</div>
				<div class="form" style="width:485px;float:left;padding:25px 40px;">

					<!-- <h1 class="sprite_insta_big_logo title"></h1> -->
					<form action="memberPwModifyProcess" method="post">
						<p class="login_user_password">
							<label for="userPw">현재 비밀번호 :
							<span id="pwConfirmMsg"></span></label> 
							<input type="password" id="nowUserPw" placeholder="비밀번호를 변경하려면 현재 비밀번호를 입력하세요">
						</p>
						
						<p class="login_user_password">
							<label for="newUserPw">새로운 비밀번호 :</label> 
							<input type="password" id="newUserPw" name="newUserPw" placeholder="새로운 비밀번호를 입력하세요">
						</p>
						
						<p class="login_user_password">
							<label for="userPw">새로운 비밀번호 확인 :
							<span id="checkNewPw"></span></label> 
							<input type="password" id="checkNewUserPw" placeholder="비밀번호 확인">
						</p>
						
						<p class="login_user_name" style="display:none">
							<label for="nickName">닉네임 :</label> 
							<input type="text" id="nickName" name="nickName" value="${memberDTO.nickName }" readonly="readonly">
						</p>

						<button id="submit_btn" class="submit_btn">수정 완료</button>
					</form>	
				</div>
			</div>
		</div>
	</section>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#submit_btn").click(function(){
			var nowUserPw = $("#nowUserPw").val();
			var newUserPw = $("#newUserPw").val();
			var checkNewUserPw = $("#checkNewUserPw").val();

			if(nowUserPw == '' || newUserPw == '' || checkNewUserPw == ''){
				alert("모두 입력해 주십시오");
			} else if(newUserPw != checkNewUserPw){
				alert("비밀번호를 다시 확인해 주세요");
			} else {
				("#submit_btn").submit();
			}
			
		});
	});
	</script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#nowUserPw").keyup(function(){
			var nowUserPw = $("#nowUserPw").val();
			var newUserPw = $("#newUserPw").val();
			
			if(nowUserPw == ${memberDTO.userPw}){
				$("#pwConfirmMsg").css("color","green").text("비밀번호 일치");
			} else {
				$("#pwConfirmMsg").css("color","red").text("비밀번호 불일치");
			}

		});

		$("#checkNewUserPw").keyup(function(){
			var nowUserPw = $("#nowUserPw").val();
			var newUserPw = $("#newUserPw").val();
			var checkNewUserPw = $("#checkNewUserPw").val();

			if(nowUserPw == ''){
				alert("현재 비밀번호를 먼저 설정하세요");
				$("#checkNewUserPw").val("");
				$("#nowUserPw").focus();
			} else if(newUserPw == ''){
				alert("새로운 비밀번호를 먼저 설정하세요");
				$("#checkNewUserPw").val("");
				$("#newUserPw").focus();
				
			} else if(newUserPw == checkNewUserPw){
				$("#checkNewPw").css("color","green").text("새로운 비밀번호와 일치");
			} else {
				$("#checkNewPw").css("color","red").text("새로운 비밀번호와 불일치");
			}
		});

		$("#newUserPw").keyup(function(){
			var nowUserPw = $("#nowUserPw").val();
			var newUserPw = $("#newUserPw").val();
			if(nowUserPw == ''){
				alert("현재 비밀번호를 먼저 설정하세요");
				$("#newUserPw").val("");
				$("#nowUserPw").focus();
			}
		});
	});
	
	</script>

</body>
</html>