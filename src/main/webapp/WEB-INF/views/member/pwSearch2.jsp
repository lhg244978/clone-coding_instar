<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.success{
color: #390;
font-size:25px;
}
h1{

height:50px;
font-size:30px;
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



               <form action="pwSearch2" method="post" >
            <div class="form">
                <div class="sprite_geun_logo"></div><br>
                <h2><img src="https://static.nid.naver.com/images/web/user/h_find_pw2.gif" width="100" height="21" alt="비밀번호 찾기"  ></h2>
                <br>
                <h3>비밀번호 찾기를 성공하셨습니다.</h3><br>
                <ul style="font-size:20px;">
   				 <li>01. 닉네임 입력></li>
   				 <li>02. 이메일 인증></li>
 			     <li class="success">03. 비밀번호 찾기 성공</li>
				</ul><br><br><br>
              <h2>[${memberdto.userId}]회원님의 비밀번호는 [${memberdto.userPw }] 입니다.</h2>
              <br>
              <button type="button" onclick="location.href='memberLoginForm'">로그인 페이지로</button>
                   <br><br>
                    </div>
                    
                    
                
            </form>

            </div>

        </div>

    </div>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    


</body>
</html>