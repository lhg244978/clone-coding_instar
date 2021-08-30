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
<body onload="checkRadio()">


	<section id="container"
		style="background-color: rgba(255, 255, 255, 0.1);">
		
		<div id="main_container">

			<div class="form_container" style="width:850px;display:flex;">
				<div class="form" style="width:185px;float:left;padding:25px 40px;">
				<ul class="wW1cu">
					<li><a class="h-aRd -HRM-" href="memberModify?nickName=${sessionScope.nickName}">프로필편집</a></li>
					<li><a class="h-aRd fuQUr" href="memberPwModify?nickName=${sessionScope.nickName }">비밀번호 변경</a></li>
				</ul>
				</div>
				<div class="form" style="width:485px;float:left;padding:25px 40px;">

					<!-- <h1 class="sprite_insta_big_logo title"></h1> -->

					<form action="memberModifyProcess" method="post" enctype="multipart/form-data" autocomplete="off">
						<p class="login_user_name" style="display:flex;align-items:center;justify-content:space-between;">
							<label for="nickName"> ${memberDTO.nickName} : </label> 
							<img alt="" style="max-width:50px;height:auto; border-radius:50%;" 
							src="resources/profileImg/${memberDTO.userProfileName}">
						</p>
						
						<p class="login_user_profile">
							<label for="userProfile">프로필 변경 :</label> 
							<input type="file" id="userProfile" name="userProfile">
							<input type="hidden" name="userNullProfile" value="${memberDTO.userProfileName }">
						</p>

						<p class="login_user_name">
							<label for="userName">이름 :</label> 
							<input type="text" id="userName" name="userName" value="${memberDTO.userName}">
						</p>
						
						<p class="login_user_id">
							<label for="userId">아이디 :</label> 
							<input type="text" id="userId" name="userId" value="${memberDTO.userId}" readonly="readonly">
		
						</p>

						<p class="login_user_name" style="display:none">
							<label for="nickName">닉네임 :</label> 
							<input type="text" id="nickName" name="nickName" value="${memberDTO.nickName }" readonly="readonly">
						</p>
						
						<p class="login_user_name">
							<label for="userBirth">생년월일 :</label> 
							<input type="date" id="userBirth" name="userBirth" value="${memberDTO.userBirth }">
						</p>

						<p class="login_user_phone">
							<label for="userPhone">전화번호 :</label> <br> 
							<input type="text" id="userPhone" name="userPhone" value="${memberDTO.userPhone}">
						</p>
						
						<p class="login_user_addr">
						<label for="userAddr">주소 :</label>
						<input type="text" id="userAddr" name="userAddr" value="${memberDTO.userAddr }">
						<input type="hidden" id="userAddr1" name="userAddr1" value="${memberDTO.userAddr }">
						<input type="button" onclick="changeAddr()" value="주소변경">
						</p>
						
						<p class="login_user_addr" id="changeAddr" style="display:none;">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br> 
						<input type="text" id="sample4_postcode" name="uAddr1" placeholder="우편번호">
						<input type="text" id="sample4_roadAddress" name="uAddr2" placeholder="도로명주소"> 
						<input type="text" id="sample4_jibunAddress" name="uAddr3" placeholder="지번주소">
						<span id="guide" style="color: #999; display: none"></span> 
						<input type="text" id="sample4_extraAddress" name="uAddr4" placeholder="참고항목">
						<input type="text" id="sample4_detailAddress" name="uAddr5" placeholder="상세주소">
						</p>
						
						<p class="login_user_name" style="text-align: center;">
							<br> <label for="user_name">성별</label><br> 
							남 :	<input type="radio" id="man" name="userSex" value="M" style="width: 10px"/> 
							여 : <input type="radio" id="woman" name="userSex" value="F"	style="width: 10px" />
						</p>
						
						<p class="login_user_intro">
							<label for="userIntro">자기 소개 :</label> 
							<input type="text" id="userIntro" name="userIntro" value="${memberDTO.userIntro}">
						</p>
						
						<p class="login_user_show" style="text-align:center;">
							<label for="userShow">게시글 공개여부 :</label> <br>
							전체에게 :	<input type="radio" name="userShow" value="0" style="width: 10px"/> 
							팔로워에게만 : <input type="radio" name="userShow" value="1"	style="width: 10px" />
							맞팔에게만 : <input type="radio" name="userShow" value="2"	style="width: 10px" />
						</p>
					

						<button id="submit_btn" class="submit_btn">수정 완료</button>
					</form>
				</div>
			</div>
		</div>
	</section>

	<script type="text/javascript">
	function checkRadio(){
		$("input:radio[name=userShow]:radio[value=${memberDTO.userShow}]").attr("checked",true);
		$("input:radio[name=userSex]:radio[value=${memberDTO.userSex}]").attr("checked",true);
	}
	</script>

	<script type="text/javascript">
		var checkNum;

		function emailConfirm(){
			var userId = $("#userId").val();
			if(userId == ""){
				alert("이메일을 입력해주세요")
			}else{
				$("#emailConfirm").toggle();
				document.getElementById("confirmNum").focus();
				$.ajax({
					type : "post",
					url : "changeMailSending",
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
						alert("실패");
					}
				});
			}
		}

		function checkConfirm(){
			console.log(checkNum);

			if(document.getElementById("confirmNum").value == ''){
				alert("이메일 인증이 필요합니다.");
			} else if(document.getElementById("confirmNum").value == checkNum){
				alert("이메일 인증에 성공하셨습니다.");
				$("#emailConfirm").attr("disabled",true);
				$("#emailCheck").val("1");
			} else{
				alert("인증번호가 일치하지 않습니다.");
				document.getElementById("confirmNum").focus();
			}
			
		}

		function changeAddr(){
			$("#changeAddr").toggle();
		}

		$(document).ready(function(){
			$("#submit_btn").click(function(){
				var newUserId = $("#userId").val();
				var userId = "${memberDTO.userId}";
				var emailCheck = $("#emailCheck").val();

				if(newUserId == userId){
					emailCheck.val("1");
				}
				
				if(newUserId == ''){
					alert("아이디는 필수입니다.");
					return false;
				} else if(newUserId != userId){
					if(emailCheck == "0"){
						alert("이메일 인증을 해주세요");
						return false;
					} else{
						return true;
					}
				} else if(emailCheck == "0"){
					alert("이메일 인증을 해주세요");
				} else {
					$("#submit_btn").submit();
				}
			});
		});

	</script>

	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function sample4_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample4_postcode').value = data.zonecode;
							document.getElementById("sample4_roadAddress").value = roadAddr;
							document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
							document.getElementById("userAddr1").value = data.jibunAddress;

							// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
							if (roadAddr !== '') {
								document.getElementById("sample4_extraAddress").value = extraRoadAddr;
							} else {
								document.getElementById("sample4_extraAddress").value = '';
							}

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								guideTextBox.innerHTML = '(예상 지번 주소 : '
										+ expJibunAddr + ')';
								guideTextBox.style.display = 'block';
							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}
						}
					}).open();
		}
	</script>

</body>
</html>