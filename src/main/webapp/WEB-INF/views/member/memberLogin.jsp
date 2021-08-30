<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>
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
    <meta property="og:image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">
    
    <!-- Twitter Meta Tags / 트위터 -->
    <meta name="twitter:card" content="instagram clone">
    <meta name="twitter:title" content="instagram">
    <meta name="twitter:description" content="instagram clone">
    <meta name="twitter:image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">

    <!-- Google / Search Engine Tags / 구글 검색 엔진 -->
    <meta itemprop="name" content="instagram">
    <meta itemprop="description" content="instagram clone">
    <meta itemprop="image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">


    <title>geunstagram</title>
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/login.css">
    <link rel="shortcut icon" href="resources/imgs/G.JPG">
	<style type="text/css">
	body{
	background-image: url("resources/imgs/sincerely-media-lQ3go6MNPzo-unsplash.jpg");
	background-repeat: no-repeat;
	background-size: cover;	}
	.sprite_geun_logo {
    display: inline-block;
    background: url('resources/imgs/GIF/geunsta2.png') no-repeat -6px -12px;
    width: 280px;
    height: 81px;
    background-position: center;
	}
	</style>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
</head>
<body>
 <!-- onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="" -->

    <div id="main_container">
        <div class="form_container">
            <div class="form">
              <div class="sprite_geun_logo"></div>

                <form action="memberLogin" method="post">
                    <p class="login_user_name">
                        <label for="user_name">아이디:</label>
                        <input type="text" id="userId" name="userId">
                    </p>

                    <p class="login_user_password">
                        <label for="user_password">비밀번호:</label>
                        <input type="password" id="userPw" name="userPw">
                    </p>

                    <input type="submit" id="submit_btn" value="로그인" class="submit_btn">
                </form>

            </div>

            <div class="bottom_box">
                <div>
                   <span>회원가입이 필요하신가요? </span><a href="memberJoinForm">회원가입</a>
                   <a href="memberPwSearch">비밀번호를 잊으셨나요?</a><br>
                <div>
                </div>
                </div>
            </div>
        </div>
    </div>
    
<!-- Modal -->
<div class="modal fade" id="usersJoinModal" tabindex="-1" role="dialog"	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">알림창</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body" id="joinMsg" style="text-align:center;padding:0;">내용이 나오는 부분</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal" style="background-color:#3897f0;">Close</button>
			</div>
		</div>
	</div>
</div>

  
<script type="text/javascript">

	
/* 	history.pushState(null, null, '');

window.onpopstate = function(event) {

  var prevUrl = document.referrer;
	alert(prevUrl);
  if(prevUrl.indexOf('boardList') < 0){  //뒤로가기를 한 페이지가 test.do 페이지가 아니면 뒤로가기, test.do 페이지면 새로고침합니다.

  
    location.reload();

  }else{

	location.reload();

  }

};
*/

/* 	 window.onpageshow = function(event) {



    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {


    	location.reload();
// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우

    }

}
*/
/* 	 window.history.forward();
	 console.log("실행 :::  window.history.forward();")
	  */
	  





	$(document).ready(function(){
			
		var joinMsg = '${joinMsg}';
		var id = '${sessionScope.loginId}'
		checkModal(joinMsg);
		console.log(id);
		function checkModal(joinMsg){
			console.log("joinMsg::" + joinMsg);
			if(joinMsg == ''){
				return;
			} else if(joinMsg == 0){
				$(".modal-body").text("회원가입에 실패하였습니다.")
		    	$("#usersJoinModal").modal("show");
			} else{
				$(".modal-body").text(joinMsg)
		    	$("#usersJoinModal").modal("show");
			}
				
		}
	});

		$(document).ready(function(){

			var loginMsg = '${loginMsg}';
			
			checkModal(loginMsg);
					
			function checkModal(loginMsg){
				console.log("loginMsg::" + loginMsg);
				if(loginMsg == ''){
					return;
				} else if(loginMsg == 0){
					$(".modal-body").text("로그인에 실패하였습니다.")
			    	$("#usersJoinModal").modal("show");
				} else{
					$(".modal-body").text(loginMsg)
			    	$("#usersJoinModal").modal("show");
				}
					
			}	
		
	});

</script>


</body>
</html>