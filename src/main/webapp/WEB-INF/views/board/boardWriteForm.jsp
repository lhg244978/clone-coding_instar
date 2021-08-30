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
    
<style>
	input{
		cursor : pointer;
	}
</style>    
<body>
<section id="container">
    <div id="main_container">

        <div class="post_form_container">
            <form action="boardWriteFile" id="fileForm" class="post_form" method="post" enctype="multipart/form-data" autocomplete="off">
                <div class="title">
                   <h1>글 작성자: ${sessionScope.nickName }</h1>
                </div>
                
        <input  type="file" name="file" multiple="multiple" style="border:1px solid black;" required/><br><br><hr><br><br>
        
                <p>
                <textarea name="postContent" id="postContent" placeholder="게시글 내용 및 # 태그를 입력하세요." 
                style="border:1px solid black; width:385px; height:144px; resize:none;"></textarea>
                </p>
                <input class="submit_btn" type="submit" value="등록">
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