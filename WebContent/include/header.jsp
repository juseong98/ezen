<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="cteam.dao.*" %>
<%@ page import="cteam.dto.*" %>
<%@ page import="cteam.vo.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
//String loginyes = "N";
boolean islogin = false;
String id = "";
if(login != null){  
	islogin = true;
	id = login.getId();
}
//임시 로그인
BoardDTO bdto = new BoardDTO();
ArrayList<BoardVO> blist = new ArrayList<BoardVO>(); 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>LOL EZEN</title>
		<link rel="stylesheet" href="../css/cteam.css">
		<script src="../js/jquery-3.7.0.js"></script>
	</head>
	<body>
		<div class="divpagebg">
			<div class="divlogo" onclick="location.href='../main/index.jsp'"></div>
			<div class="divmain">
				<div class="divleft">
					<hr style="border:solid 2px black">
					<div class="divloginfrm">
						<%
						if(login == null)
						{
							%>
							<br>
							<form action="../user/userlogin.jsp">
								<input type="submit" class="btnblue" value="로그인" style="height:50px;width:150px;font-size:20pt">
							</form>
							<br>
							<a href="../user/userjoin.jsp">회원가입</a>
							<br>
							<a href="" onclick="window.open('../user/userip.jsp','window_name','width=500,height=500,location=no,status=no,scrollbars=yes')">아이디 / 비밀번호 찾기</a>
							<%
						}else
						{
							%>
							[<%= login.getNick() %>] 님<br>로그인하였습니다.<br>
							<a href="../user/usermodify.jsp" style="display:block;margin:10px">회원 정보수정</a>
							<button type="button" class="btnorange" style="height:50px;width:150px;font-size:20pt" onclick="location.href='../user/logout.jsp'">로그아웃</button><br>
							<%
						}
						%>
					</div>
					<hr style="border:solid 2px black">
					<div class="menuesports">
						<ul>
							<li><span class="menuhead">대회 게시판</span></li>
							<li>
								<a href="../board/list.jsp?menu=N">
									뉴스 기사
								</a>
							</li>
							<li>
								<a href="../board/list.jsp?menu=T">
									대회 이야기
								</a>
							</li>
							<li>
								<a href="../board/list.jsp?menu=H">
									대회 하이라이트
								</a>
							</li>
						</ul>
					</div>
					<hr style="border:solid 2px black">
					<div class="menucommu" style="height:235px">
						<ul>
							<li><span class="menuhead">커뮤니티</span></li>
							<li>
								<a href="../board/list.jsp?menu=F">
									자유 주제
								</a>
							</li>
							<li>
								<a href="../board/list.jsp?menu=Q">
									질문 & 답변
								</a>
							</li>
							<li>
								<a href="../board/list.jsp?menu=I">
									정보 & 팁
								</a>
							</li>
							<li>
								<a href="../board/list.jsp?menu=P">
									파티 모집
								</a>
							</li>
							<li>
								<a href="../board/list.jsp?menu=M">
									이미지
								</a>
							</li>
						</ul>
					</div>

				</div>
				
				<div class="divcenter">