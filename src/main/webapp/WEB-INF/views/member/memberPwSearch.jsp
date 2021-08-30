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
    <link rel="shortcut icon" href="resources/imgs/G.JPG">
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
.input_nickName{
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


                   <div class="sprite_geun_logo"></div>
				<h2><img src="https://static.nid.naver.com/images/web/user/h_find_pw2.gif" width="100" height="21" alt="비밀번호 찾기"  ></h2>
				<br>
				<h3>입력한 닉네임으로 가입된 이메일을 확인하세요.</h3>
				<br><br>
				<ul style="font-size:20px;">
   				 <li class="input_nickName">01. 닉네임 입력></li>
   				 <li>02. 이메일 인증></li>
 			     <li>03. 비밀번호 찾기 성공</li>
				</ul><br><br>
				
                <form action="pwSearch1" method="post">
                    <p class="login_user_name">
                        <input type="text" id="nickName" name="nickName" placeholder="닉네임 입력">
                    </p>
                   
                    <input type="submit" id="submit_btn" value="다음" class="submit_btn"><br><br>
                </form>
                <button type="button" onclick="location.href='memberLoginForm'">로그인 페이지로</button>
            </div>

        </div>

    </div>


</body>

</html>