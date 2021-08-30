<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
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
    <link rel="shortcut icon" href="resources/imgs/instagram.png">
	<style type="text/css">
	body{
	background-image: url("resources/imgs/sincerely-media-lQ3go6MNPzo-unsplash.jpg");
	background-repeat: no-repeat;
	background-size: cover;	}
	<style>
	ul {
    list-style:none;
    margin:0;
    padding:0;
}

li {
    margin: 0 0 0 0;
    padding: 0 0 0 0;
    border : 0;
    float: left;
}
.check{
color: #390;
font-size:25px;
}
.sprite_geun_logo {
    display: inline-block;
    background: url('resources/imgs/GIF/geunsta2.png') no-repeat -18px -4px;
    width: 280px;
    height: 70px;
	}
</style>
</head>
<body>


    <div id="main_container">

        <div class="form_container2" 
    style="margin: 0 auto; background-color: #fff; border: 1px solid #e6e6e6; padding: 0 80px 60px 80px; margin-bottom: 30px;">

            <div class="form">


               <form action="pwSearch2" method="post">
                <div class="sprite_geun_logo"></div><br>
                <h2><img src="https://static.nid.naver.com/images/web/user/h_find_pw2.gif" width="100" height="21" alt="비밀번호 찾기"  ></h2>
               <br>
                <h3>이메일 인증을 통해 비밀번호를 찾으세요.</h3><br>
                <ul style="font-size:20px;">
   				 <li>01. 닉네임 입력></li>
   				 <li class="check">02. 이메일 인증></li>
 			     <li>03. 비밀번호 찾기 성공</li>
				</ul><br><br>
				<c:choose>
				<c:when test="${memberdto.userId!=null }">
               <br><h1 style="font-size:22px;">[${memberdto.nickName}]닉네임으로 가입된 이메일은 [${memberdto.userId}] 입니다.</h1>
               <input type="hidden" id="userId" value="${memberdto.userId}">
                   <br><br>
				<div class="boxCheck" style="border:1px solid black;border-color:gray;">
               <p class="checkEmail" style="line-height:100px;">
                       <input type="radio" id="checkEmail" name="checkEmail" onclick="inputEmail()" style="width:20px;height:20px;border:1px;">
                       <a style="font-size:22px; position:static;">이메일 인증을 통해 비밀번호 찾기</a>
                    </p>
                    </div>
                    
                    </c:when>
                    <c:otherwise>
                   <h1 style="font-size:22px;">[${memberdto.nickName}] 회원으로 가입된 이메일은 존재하지 않습니다.</h1><br><br>
                   <button type="button" onclick="location.href='memberPwSearch'">다른회원으로 조회하기</button>
                    </c:otherwise>
                    </c:choose>
                
            </form><br>
<button type="button" onclick="location.href='memberLoginForm'">로그인 페이지로</button>
            </div>

        </div>
    </div>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
  function inputEmail(){
	  var userId = $("#userId").val();
			console.log("inputEmail() 실행");
			var output = '';
			output +="<br>";
			output +="<br>";
			output += "<p class='login_user_id'>"
			output += "<input type='text' id='userId' name='userId' value="+userId+" style='width:300px; height:50px; font-size:22px;'>";
			output += "<input type='button' value='이메일 인증받기' onclick='confirmEmail()' style='background-color:cornflowerblue;width:150px;height:50px;cursor:pointer;'>";
			output +="<br>";
			output +="<br>";
			output += "<label id='emailConfirmToggle' style='display:none;width418px;'>";
			output += "<input type='text' id='confirmNum' placeholder='인증번호'  style='width:70%;'>";
			output += "<input type='button' id='emailConfirm' value='확인' onclick='checkConfirm()' style='width:28.5%;cursor:pointer;'>"
			output += "</lavel>"
			output += "</p>"
			$(".boxCheck").after(output);
			$(".boxCheck").hide();
			
  }
  var checkNum;

  function confirmEmail(){
		var userId = $("#userId").val();
		if(userId == ""){
			alert("이메일을 입력해주세요")
		}else{
			$("#emailConfirmToggle").toggle();
			document.getElementById("confirmNum").focus();
			$.ajax({
				type : "post",
				url : "mailSending",
				data : {
					"userId" : userId
					},
				dataType : "text",
				success : function(result){
					alert("메일을 전송하였습니다.");
					checkNum = result;
					console.log("인증번호::" + result);
				},
				error : function(){
					alert("메일전송 실패");
				}
			});
		}
	}


  function checkConfirm(){
     console.log(checkNum);
     var userId = $("#userId").val();
     console.log(userId);
     if(document.getElementById("confirmNum").value == checkNum){
        alert("이메일 인증에 성공하셨습니다.");
        var output = '';
        output +="<br>";
        output +="<br>";
        output +="<br>";
        output +="<br>";
		output +="<input type='submit' value='비밀번호 확인하기' style='background-color:cornflowerblue;cursor:pointer'>";
		$("#emailConfirm").after(output);
     } else{
        alert("인증번호가 일치하지 않습니다.");
        document.getElementById("confirmNum").focus();
     }
  }

			</script>


</body>
</html>