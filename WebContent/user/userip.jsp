<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="cteam.dao.*" %>
<%@ page import="cteam.dto.*" %>
<%@ page import="cteam.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	.userip_form b
	{
	    display: block; 
	    margin-bottom: 5px;
	}
	.userip_form input:not(input[type=test])
	{
	    border: 1px solid #dadada;
	    padding: 15px;
	    width: 100%;
	    margin-bottom: 5px;
	}
	
	.userjoin
	{
		width:33%; 
		text-align:center;
		margin: 0 auto;
		height: auto;
		float:left;
	}
	
	.useripok
	{
		width:100%; 
		float:left;
	}
	.useripcansel
	{
		width:33%; 
		float:right;
	}
	.ipjoin
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
	
	var checkCode = "ERROR";
	
	
	
	window.onload = function()
	{
		$("#usermail").focus();
		
		//�߼� button ������ id ��
		$("#sendId").click(function(){
			
			var usermail = 	$("#usermail").val();
			var code="";
			if(!email_check(usermail))
			{
				alert("�̸��� ���Ŀ� �°� �Է����ּ���");
				$("#usermail").focus();
				return false;
			}
			
			 //alert("tet");
			if($("#usermail").val() == "")
			{
				alert("�̸����� �Է��ϼ���");
				$("#usermail").focus();
				return false;
			}
			
			$.ajax({
				type : "post",
				url: "emailicheck.jsp",
				data: {"usermail": usermail},
				dataType: "html", //html,xml,json �� �� ������ Ÿ���� ���� �� ����
				success : function(data) 
				{
				//alert(data.length);
				code ="<%=session.getAttribute("code")%>";
			//alert(data);
			//	alert(code);
					alert("�̸��Ϸ� �����ڵ带 ���½��ϴ�.");
				},
				error : function(){
					alert("�����ڵ� ���� �����Դϴ�");
				}
			});				

			});
		
		$("#sendcode").click(function(){
			
			$.ajax({
				type : "get",
				url: "getcode.jsp",
				dataType: "html",
				success : function(data) 
				{	
					// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
					//String code = (String)session.getAttribute("code");
					data = data.trim();					
					console.log(data);
					if($("#usercode").val() != data)
					{
						alert("�����ڵ尡 ��ġ ���� �ʽ��ϴ�.");
						$("#usercode").focus();
					}else
					{		alert("���̵�� ��й�ȣ�� ���۵Ǿ����ϴ�.");
							//$("#joinFrm").submit();
							document.ipFrm.submit();
							document.location = "userlogin.jsp";
							window.close();
					}
				},
				error : function(xhr, status, error) 
				{
					// ��� ���� �߻���
				}
			});
		});
		
	}
	
	
	function email_check(usermail) 
	{

		var reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		return reg.test(usermail);

	}
	
	</script>
	<center><img src="../images/logo2.png"></center>
	<form action="emailip.jsp" method="post" id="ipFrm" name="ipFrm">
		<div class="userip_form">
			<div class="fild">
			<b>�̸���</b>
			<input class="usermail" type="text" id="usermail" name="usermail" placeholder="ȸ�����Խ� ����� �̸����� �Է����ּ���.">
			</div>
			<div class="useripok">
			<input class="ipcansel" type="button" value="�߼�" id="sendId">
			</div>
			<br>
			<br>
			<br>
			<div class="fild">
			<b>������ȣ</b>
			<input class="usercode" type="text" id="usercode" name="usercode" placeholder="�����ڵ带 �Է����ּ���.">
			</div>
			<div class="useripok">
			<input class="ipcansel" type="button" value="ã��" id="sendcode">
			</div>
			<br>
			<br>
			<br>
			<br>
			<br>
			<div class=userjoin>
			<a onclick="window.close()" href="./userjoin.jsp" target="_blank">
			<input class="ipjoin" type="button" value="ȸ������">
			</a>
			</div>
			<div class="useripcansel">
			<a href="../index.jsp"><input class="ipcansel" type="button" value="â �ݱ�" onclick="window.close()"></a>
			</div>
		</div>
		</form>
</body>
</html>