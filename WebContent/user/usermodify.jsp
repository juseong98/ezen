<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cteam.dao.*" %>
<%@ page import="cteam.dto.*" %>
<%@ page import="cteam.vo.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");

//로그인 정보가 없으면 돌려보냄
if(login == null)
{
	%>
	<script>
	alert("로그인 정보가 없습니다.");
	document.location = "userlogin.jsp";
	</script>
	<%
	return;
	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.7.0.js"></script>
</head>
<body>
<style>
	.userip_form
	{
    	width: 400px;
	    margin: auto; 
	    padding: 0 20px;
	    margin-bottom: 20px;
	}
	
	
	.userip_form.fild
	{
		margin:5px 0;
	}
	
	
	.userip_form b
	{
	    display: block; 
	    margin-bottom: 5px;
	}
	
	.userip_form input:not(input[type=test]),.userip_form select
	{
	    border: 1px solid #dadada;
	    padding: 15px;
	    width: 100%;
	    margin-bottom: 5px;
	}
	
	.userjoin_form input[type=button],
	.userjoin_form input[type=submit]
	{
	}
	
	.userip_form.fild_team div
	{ 
	    display: flex;
	    gap:10px; 
	}
	
	.fild.tel-number div 
	{
    	display: flex;
	}
	
	.fild.tel-number div input:nth-child(1)
	{
    	flex:2;
 	}

	.fild.tel-number div input:nth-child(2)
	{
    	flex:1;
	}
	
	.fild_team
	{
    	width: 400px;
	    margin: auto;
	    padding: 0 20px;
	    margin-bottom: 20px;
	}
	
	.fild_pt
	{
		width: 400px;
	    margin: auto; 
	    padding: 0 20px;
	    margin-bottom: 20px;
	}
	
	.ipok
	{
		width: 100px;
		margin-left: auto;
	}
	
	.ipok
	{
		width:33%; 
		float:left;
		/*border: 1px solid gold; 
		float: left; 
		width: 33%;"
		*/
	}
	.ipcansel
	{
		width:33%;
		float: right;
		/*
		border: 1px solid gold; 
		float: left; 
		width: 33%;
		*/
	}
	</style>
	<script>
	//현재 비밀번호 검사 - ajax
	
	//
		var checkCode = "ERROR";
	//닉네임 중복검사
		var nickcheckCode = "오류";
	
		window.onload = function()
		{
			$("#userpw").focus();
			
			//닉네임 입력시 키 이벤트
			$("#user").keyup(function(){
				DuplicateCheckNICK();
			});
			
			//수정 button 
			$("#btnSumit").click(function(){
				if( $("#userpw").val() == "")
				{
					alert("현재 비밀번호를 입력해주세요.");
					$("#userpw").focus();
					return false;
				}
				if( $("#newpw").val() == "")
				{
					alert("새로운 비밀번호를 입력해주세요.");
					$("#newpw").focus();
					return false;
				}
				
				if( $("#userpwcheck").val() != $("#newpw").val())
				{
					alert("새로운 비밀번호를 다시 한번 확인해주세요.");
					$("#userpwcheck").focus();
					return false;
				}
				
				if( $("#user").val() == "")
				{
					alert("닉네임을 입력해주세요.");
					$("#user").focus();
					return false;
				}
				if(confirm("변경된 정보를 수정하시겠습니까?") == false)
				{
					return;
				}
				$("#usermodifyFrm").submit();
			});
			$("#btnCancel").click(function(){
				if(confirm("회원정보 변경을 취소하시겠습니까?") == false) return;
				document.location = "index.jsp";
			});
		}
		
		//특수문자 입력 방지
		function characterCheck(obj){
		    var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
		    var regex = /(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g;
		    if(regExp.test(obj.value)){
		        alert("특수문자는 입력할 수 없습니다.");
		        obj.value = "";
		    }
		    if(regex.test(obj.value)){
		        alert("특수문자는 입력할 수 없습니다.");
		        obj.value = "";
		    }
		}
		
		function DuplicateCheckNICK()
		{
			nickcheckCode = "오류";
			
			userNICK = $("#user").val();
			if(userNICK == "")
			{
				$("#nickmsg").html("닉네임을 입력하세요.");
				return;
			}
			
			$.ajax({
				type : "get",
				url: "usernickcheck.jsp?user=" + userNICK,
				dataType: "html",
				contentType : "application/html; charset:UTF-8",
				success : function(data) 
				{	
					// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
					data = data.trim();
					//오류 / 중복 / 중복안됨
					console.log(data);
					nickcheckCode = data;
					//alert("완료");
					switch(data)
					{
					case "오류":
						$("#nickmsg").html("닉네임 중복검사 오류입니다.");
						break;
					case "현재 닉네임":
						$("#nickmsg").html("<span style='color:blue'>현재 닉네임입니다.</span>");
						break;
					case "중복안됨":
						$("#nickmsg").html("사용 가능한 닉네임입니다.");
						break;
					case "중복":
						$("#nickmsg").html("<span style='color:red'>중복된 닉네임입니다.</span>");
						break;	
					}
				},
				error : function(xhr, status, error) 
				{
					// 통신 오류 발생시
				}
			});			
		}
	
	</script>
	<center><img src="../images/logo2.png"></center>
	<form action="usermodifyok.jsp" method="post" id="usermodifyFrm" name="usermodifyFrm"> 
		<div class="userip_form">
			<div class="fild">
			<b>아이디</b>
			<input class="userid" type="text" id="userid" name="userid" value="<%= login.getId() %>" disabled>
			</div>
			<div class="fild">
			<b>현재비밀번호</b>
			<input maxlength="20" class="userpw" type="password" id="userpw" name="userpw" placeholder="현재 비밀번호를 입력해주세요(최대 20글자)">
			</div>
			<div class="fild">
			<b>새 비밀번호 </b>
			<input maxlength="20" class="userpwcheck" type="password" id="newpw" name="newpw" placeholder="새 비밀번호를 입력하세요(최대 20글자)">
			</div>
			<div class="fild">
			<b>새 비밀번호 확인 </b>
			<input maxlength="20" class="userpwcheck" type="password" id="userpwcheck" name="userpwcheck" placeholder="새 비밀번호 확인을 입력하세요(최대 20글자)">
			</div>
			<div class="fild">
			<b>이름</b>
			<input class="username" id="username" name="username" value="<%= login.getName() %>"disabled>
			</div>
			<div class="fild">
			<b>닉네임</b>
			<input maxlength="6" class="user" id="user" name="user" value="<%= login.getNick() %>" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)">
			<span id="nickmsg">변경하실 닉네임을 입력해주세요.</span>
			</div>
			<div class="fild_team">
			<b>응원하는 팀</b>
				<select name="userteam" id="userteam" class="fild_team">
						<option <%= login.getTeam().equals("T1") ? "selected" : "" %>>T1</option>
						<option <%= login.getTeam().equals("BRO") ? "selected" : "" %>>BRO</option>
						<option <%= login.getTeam().equals("DK") ? "selected" : "" %>>DK</option>
						<option <%= login.getTeam().equals("DRX") ? "selected" : "" %>>DRX</option>
						<option <%= login.getTeam().equals("GENG") ? "selected" : "" %>>GENG</option>
						<option <%= login.getTeam().equals("HLE") ? "selected" : "" %>>HLE</option>
						<option <%= login.getTeam().equals("KDF") ? "selected" : "" %>>KDF</option>
						<option <%= login.getTeam().equals("KT") ? "selected" : "" %>>KT</option>
						<option <%= login.getTeam().equals("LSB") ? "selected" : "" %>>LSB</option>
						<option <%= login.getTeam().equals("NS") ? "selected" : "" %>>NS</option>
						</select>
			</div>
			<div class="fild_pt">
			<b>주 포지션</b>
				<select name="userpt" id="userpt" class="fild_pt">
					<option <%= login.getPosition().equals("TOP") ? "selected" : "" %>>TOP</option>
					<option <%= login.getPosition().equals("MID") ? "selected" : "" %>>MID</option>
					<option <%= login.getPosition().equals("JUG") ? "selected" : "" %>>JUG</option>
					<option <%= login.getPosition().equals("AD") ? "selected" : "" %>>AD</option>
					<option <%= login.getPosition().equals("SUP") ? "selected" : "" %>>SUP</option>
				</select>
			</div>
			<div class=ipok>
				<input class="ipok" id="btnSumit"type="button" value="수정">
			</div>
			<div class="ipcansel">
				<input class="ipcansel" id="btnCancel"type="button" value="취소">
			</div>
		</div>
		</form>
</body>
</html>