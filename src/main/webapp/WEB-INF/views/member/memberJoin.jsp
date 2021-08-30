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
<meta property="og:image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">

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
<link rel="shortcut icon" href="resources/imgs/G.JPG">
<style type="text/css">
body {
	background-image:
		url("resources/imgs/sincerely-media-lQ3go6MNPzo-unsplash.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>


	<section id="container" style="background-color: rgba(255, 255, 255, 0.1);">

		<div id="main_container">

			<div class="form_container" style="width:500px">

				<div class="form">

		<div style="text-align:center;margin-top:20px;">		
		<img alt="" src="resources/imgs/joinImg.jpg" >
		</div>
			
					<label style="font-size:10px;color:grey;">*는 필수입력항목 입니다.</label>

					<form action="memberJoin" method="post" enctype="multipart/form-data" autocomplete="off">
						<p class="login_user_name">
							<label for="userName">이름 :</label> 
							<input type="text" id="userName" name="userName">
						</p>

						<p class="login_user_id">
							<label for="userId">* 아이디 :</label> 
							<input type="text" id="userId" name="userId" placeholder="이메일을 입력해주세요">
							<input type="button" value="아이디 중복 확인" onclick="checkId()">
							<input type="hidden" id="idCheck" value="0">
							<input type="button" id="emailToggle" value="이메일 인증받기" onclick="confirmEmail()">
								<label id="emailConfirmToggle" style="display:none; width:418px;">
									<input type="text" id="confirmNum" placeholder="인증번호" style="width:70%;">
									<input type="button" id="emailConfirm" value="확인" onclick="checkConfirm()" style="width:28.5%;">
									<input type="hidden" id="emailCheck" value="0">
								</label>
							
						</p>

						<p class="login_user_password">
							<label for="userPw">* 비밀번호 :</label> 
							<input type="password" id="userPw" name="userPw">
						</p>
						
						<p class="login_user_password">
							<label for="userPw">* 비밀번호 확인 :
							<span id="pwConfirmMsg"></span></label>
							<input type="password" id="checkPw">
						</p>
						
						<p class="login_user_name">
							<label for="nickName">* 닉네임 :</label> 
							<input type="text" id="nickName" name="nickName">
							<input type="button" value="닉네임 중복 확인" onclick="checkNickName()">
							<input type="hidden" id="nickNameCheck" value="0">
						</p>

						<p class="login_user_name">
							<label for="userBirth">* 생년월일 :</label> 
							<input type="date" id="userBirth" name="userBirth">
						</p>

						<p class="login_user_name">
							<label for="userPhone">전화번호 :</label> <br> 
							<select id="userPhone1" name="userPhone1" style="width: 81px;height:32px;" >
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="070">070</option>
								<option value="032">032</option>
								<option value="02">02</option>
								<option value="063">063</option>
								<option value="071">071</option>
								<option value="033">033</option>
							</select> - 
							<input type="text" id="userPhone2" style="width: 81px"
							name="userPhone2"> - 
							<input type="text" id="userPhone3"
							style="width: 81px" name="userPhone3">
						</p>


						<input type="button" onclick="sample4_execDaumPostcode()"
							value="우편번호 찾기"><br> 
						<input type="text" id="sample4_postcode" name="uAddr1" placeholder="우편번호">
						<input type="text" id="sample4_roadAddress" name="uAddr2" placeholder="도로명주소"> 
						<input type="text" id="sample4_jibunAddress" name="uAddr3" placeholder="지번주소">
						<span id="guide" style="color: #999; display: none"></span> 
						<input type="text" id="sample4_extraAddress" name="uAddr4" placeholder="참고항목">
						<input type="text" id="sample4_detailAddress" name="uAddr5" placeholder="상세주소">


						<p class="login_user_name" style="text-align: center;">
							<br> <label for="user_name">성별</label><br> 
							남 :	<input type="radio" id="man" name="userSex" value="M" style="width: 10px" checked /> 
							여 : <input type="radio" id="woman" name="userSex" value="F"	style="width: 10px" />
						</p>

						<p class="login_user_name">
							<label for="userProfile">프로필 :</label> 
							<input type="file" id="userProfile" name="userProfile">
						</p>
						
						<p class="login_user_name">
							<label for="userIntro">자기 소개 :</label> 
							<input type="text" id="userIntro" name="userIntro">
						</p>

						<p class="login_user_name" style="text-align: center;">
							<label for="admin">관리자</label> 
							<input type="checkbox" id="admin" name="admin" onclick="checkAdmin()">
						</p>

						<button id="submit_btn" class="submit_btn" type="submit">회원가입</button>
					</form>
				</div>
			</div>
		</div>
	</section>
	

	<script type="text/javascript">

		function checkId(){
			var userId = $("#userId").val();
			if(userId == ""){
				alert("이메일을 입력해주세요");
			} else{
				$.ajax({
					type : "post",
					url : "idCheck",
					data : {
						"userId" : userId
					},
					dataType : "text",
					success : function(result){
						if(result == "OK"){
							console.log("사용가능아이디 OK")
							$("#idCheck").val("1");
							alert("사용가능한 아이디 입니다.");
							$(document).ready(function(){
								$("#userId").keyup(function(){
									$("#idCheck").val("0");
								});
							});
						} else {
							alert("이미 사용중인 아이디 입니다.")
						}
					},
					error : function(){
						alert("아이디 중복 확인 실패");
					}
				});
			}	
		}

		function checkNickName(){
			var nickName = $("#nickName").val();
			if(nickName == ""){
				alert("닉네임을 입력해 주세요");
			} else {
				$.ajax({
					type : "post",
					url : "nickNameCheck",
					data : {
						"nickName" : nickName
						},
					dataType : "text",
					success : function(result){
						if(result == "OK"){
							console.log("사용 가능한 닉네임 OK");
							$("#nickNameCheck").val("1");
							alert("사용 가능한 닉네임 입니다.");
							$(document).ready(function(){
								$("#nickName").keyup(function(){
									$("#nickNameCheck").val("0");
								});
							});
						} else {
							alert("이미 사용중인 닉네임 입니다.");
						}
					},
					error : function(){
						alert("닉네임 중복 확인 실패");
					}
				});
			}
		}

	
		var checkNum;

		function confirmEmail(){
			var userId = $("#userId").val();
			var idCheck = $("#idCheck").val();
			if(userId == ""){
				alert("이메일을 입력해주세요");
			}else if(idCheck == "0"){
				alert("아이디 중복확인을 먼저 해주세요");
			}else{
				$("#emailConfirmToggle").toggle();
				$("#emailToggle").attr("disabled",true);
				document.getElementById("confirmNum").focus();
				$.ajax({
					type : "post",
					url : "joinMailSending",
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
		
		function checkAdmin() {
			if($("#admin").is(":checked")){
				var ad = prompt("관리자 계정 비밀번호를 입력하시오");
				var checkad = "1111";

				if (ad == checkad) {
					alert("관리자 정보 확인 완료");
					document.getElementById("admin").value = 1;
					$("#admin").prop("checked",true);
					return;
				} else {
					alert("관리자 비밀번호가 틀립니다.");
					document.getElementById("admin").value = 0;
					$("#admin").prop("checked",false);
					return;
				}

			} else {
				document.getElementById("admin").value = 0;
			}
		}
		
		$(document).ready(function(){
			$("#checkPw").keyup(function(){
				var checkPw = $("#checkPw").val();
				var userPw = $("#userPw").val();

				if(userPw == ''){
					alert("비밀번호가 입력되지 않았습니다.");
					$("#checkPw").val("");
					$("#userPw").focus();
					return;
				}

				if(checkPw == userPw){
					$("#pwConfirmMsg").css("color","green").text("비밀번호 일치");
				} else {
					$("#pwConfirmMsg").css("color","red").text("비밀번호 불일치");
				}
			});

			$("#submit_btn").click(function(){
				var userId = $("#userId").val();
				var userPw = $("#userPw").val();
				var checkPw = $("#checkPw").val();
				var userBirth = $("#userBirth").val();
				var nickName = $("#nickName").val();
				var emailCheck = $("#emailCheck").val();
				var idCheck = $("#idCheck").val();
				var nickNameCheck = $("#nickNameCheck").val();

				if(userId == '' || userPw == '' || checkPw == '' || nickName == '' || userBirth == ''){
					alert("*는 필수항목입니다.");
					return false;
				} else if(checkPw != userPw){
					alert("비밀번호를 다시 확인해 주세요");
					return false;
				} else if(idCheck == "0"){
					alert("아이디 중복 확인을 해주세요");
					return false;
				}else if(emailCheck == "0"){
					alert("이메일 인증을 해주세요");
					return false;
				} else if(nickNameCheck == "0"){
					alert("닉네임 중복 확인을 해주세요");
				}else {
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