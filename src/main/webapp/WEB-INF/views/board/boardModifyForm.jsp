<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
 <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/new_post.css">
    <link rel="shortcut icon" href="resources/imgs/instagram.png">
<body>
<section id="container">
    <div id="main_container">

        <div class="post_form_container">
            <form action="boardModify" id="fileForm" class="post_form" method="post" enctype="multipart/form-data" autocomplete="off">
                <div class="title">
                <input type="text" value="${postdto.postNum}" 
                   id="postNum" name="postNum" style="border:0px;font-size:25px;width:45px;text-align:center;" readonly="readonly">번째 글입니다.<br>
                    <h1>글 수정자: ${postdto.nickName }</h1> 
                   
                </div>
                
        <input  type="file" name="file" multiple="multiple" style="border:1px solid black;" required/><br><br><hr><br><br>
        
                <p>
                <textarea name="postContent" id="postContent" cols="50" rows="8" placeholder="게시글 내용 및 # 태그를 입력하세요." 
                style="border:1px solid black;" wrap="hard" >${postdto.postContent }</textarea>
                </p>
                <input class="submit_btn" type="submit" value="수정">
            </form>

        </div>

    </div>


</section>




<script>

</script>



<script type="text/javascript">

</script>

</body>
</html>