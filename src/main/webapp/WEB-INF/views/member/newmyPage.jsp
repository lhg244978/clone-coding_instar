<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

   
    
    
    <title>마이페이지</title>
    
    <link rel="stylesheet" href="resources/css/profile.css">
    <link rel="shortcut icon" href="imgs/instagram.png">


	
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
<style type="text/css">
 

.hori_cont{
    display: flex;
    margin-bottom: 30px;
}


.profile_wrap{
    width: 40%;

}
.profile_img{
    width: 152px;
    height: 152px;
    overflow:hidden;
    border-radius: 50%;
    margin: 0 auto;
}

.profile_img img{
    width: 100%;
    height: 100%;
}


.detail{
    /*display: flex;*/
    /*align-items: center;*/
    /*flex-direction: column;*/
    /*justify-content: center;*/
}
.detail .top{
    display: flex;
    align-items: center;
}

.detail .top .user_name{
    font-size: 35px;
    font-weight: 200;
    display: inline-block;
    padding-right: 25px;
    margin-top: 10px;
}

.detail .top > a{
    height: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 120px;
    border: 1px solid #dbdbdb;
    border-radius: 3px;
    color: #262626;
    padding: 3px 20px;
    font-weight: 600;
    vertical-align: text-bottom;
    text-decoration: none;
    box-sizing: border-box;
}


.detail .middle{
    display: flex;
    height: 50px;
    padding: 18px 0;
    font-size: 15px;
    font-weight: 600;
}


.detail .middle > li{
    margin-right: 35px;
}
.detail .about > span{
    display:inline-block;
    cursor: pointer;
    position:relative;
}

.detail .about > span:nth-child(1){
    margin-right: 50px;
}


.detail .about > span:after{
    content:'';
    width:0;
    height:1px;
    position:absolute;
    left:0;
    bottom:-5px;
    transition:all 0.5s;
    background:#dd2d76;
}

.detail .about > span.on:after{
    width:100%;
}

.contents_container{
    /*display: flex;*/
    flex-wrap: wrap;
   
    display: none;
}


.contents_container.active{
    display: flex;
}

.contents_container .pic{
    width:300px;
    height:300px;
    overflow:hidden;
    margin-bottom: 18px;


}

.contents_container .pic img{
    width: 100%;
    height: 100%;
}


@media screen and (max-width:1000px){

    .contents_container {
        justify-content: center;

    }


    .contents_container .pic{
        margin:10px;
    }
}

a {
	text-decoration:none;
}



 
</style>
</head>
<body>


<section id="container">

  

    <div id="main_container">

        <section class="b_inner">

            <div class="hori_cont">
                <div class="profile_wrap">
                	
                    <div class="profile_img">
                        <img src="resources/profileImg/${userMypage.userProfileName }" alt="">

                    </div>
                </div>

                <div class="detail">
                    <div class="top">
                        <div class="user_name">${userMypage.nickName}</div>
                        <a href="memberModify?nickName=${sessionScope.nickName }" >정보 수정</a>
                        <a href="boardWriteForm">글쓰기</a>
                    </div>

                    <ul class="middle" style="height:15px;">
                        <li>
                            <span>게시물</span>
                            ${postCount }
                        </li>
                        <li>
                        	<a href="friends?checkNum=1" style="color:black;">
                            <span>팔로워</span>
                            ${followerCount }
                            </a>
                        </li>
                        <li>
                        	<a href="friends?checkNum=2" style="color:black">
                            <span>팔로우</span>
                            ${followCount }
                            </a>
                        </li>
                    </ul>
                    <div class="detail">${userMypage.userIntro }</div><br><br>
                    <p class="about">
                        <span class="nick_name">게시물</span>
                        <span class="book_mark">저장됨</span>
                    </p>

                </div>
            </div>
			
			<!-- 내 게시물 -->
            <div class="mylist_contents contents_container active" >
            <c:forEach var="plist" items="${postList}">
                <div class="pic" style="margin-right:11.6px;" >
                <c:set var="thumbNail" value="${fn:split(plist.thumbnail,'.')}"/>
                <c:set var="thumbNailType" value="${fn:length(thumbNail)-1}"/>
                	<c:if test="${thumbNail[thumbNailType] == 'jpeg' ||thumbNail[thumbNailType] == 'png' || thumbNail[thumbNailType] == 'gif' || thumbNail[thumbNailType] == 'JPG' || thumbNail[thumbNailType] == 'jpg' || thumbNail[thumbNailType] == 'PNG' || thumbNail[thumbNailType] == 'bmp'}">                	
                    <a href="boardView?postNum=${plist.postNum }">                    
                    <img src="resources/fileUpload/${plist.thumbnail}" alt=""></a>                	
                	</c:if>
                	 
                    <c:if test="${thumbNail[thumbNailType] == 'mp4' || thumbNail[thumbNailType] == 'webm' || thumbNail[thumbNailType] == 'ogg' }">
                    <a href="boardView?postNum=${plist.postNum }">
                    <video controls autoplay loop muted width="300px" height="300px" >                    
                    <source src="resources/fileUpload/${plist.thumbnail }" type="video/${thumbNail[thumbNailType]}" >
                    </video>
                    </a>
                    </c:if>
                </div>
            </c:forEach>    
            </div>

			<!-- 저장된 게시물 -->
            <div class="bookmark_contents contents_container">
            <c:forEach var="savepostList" items="${savepostList}" >
                <div class="pic" style="margin-right:11.6px;">
                <c:set var="thumbNail" value="${fn:split(savepostList.thumbnail,'.') }"/>
                <c:set var="thumbNailType" value="${fn:length(thumbNail)-1}"/>
                <c:if test="${thumbNail[thumbNailType] == 'jpeg' ||thumbNail[thumbNailType] == 'png' || thumbNail[thumbNailType] == 'gif' || thumbNail[thumbNailType] == 'JPG' || thumbNail[thumbNailType] == 'jpg' || thumbNail[thumbNailType] == 'PNG' || thumbNail[thumbNailType] == 'bmp'}">
                    <a href="boardView?postNum=${savepostList.postNum }">
                    <img src="resources/fileUpload/${savepostList.thumbnail }" alt=""></a>
                    </c:if>
                    
                    <c:if test="${thumbNail[thumbNailType] == 'mp4' || thumbNail[thumbNailType] == 'webm' || thumbNail[thumbNailType] == 'ogg' }">
                    <a href="boardView?postNum=${savepostList.postNum }">
                    <video controls autoplay loop muted width="300px" height="300px">
                    <source src="resources/fileUpload/${savepostList.thumbnail }" type="video/${thumbNail[thumbNailType]}">
                    </video>
                    </a>
                    </c:if>
                </div>
            </c:forEach>    
            </div>




        </section>
    </div>
	

</section>


<!--<script src="js/insta.js"></script>-->
<script src="resources/js/profile.js"></script>
<script>
 


</script>
</body>
</html>