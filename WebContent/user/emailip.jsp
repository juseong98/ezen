<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="cteam.dao.*" %>
<%@ page import="cteam.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="cteam.vo.*" %>
<%
String email = request.getParameter("usermail");
UserDTO dto = new UserDTO();
//ȸ������ �� �Է��� �̸��� ������
dto.IpEmail(email);

response.sendRedirect("userlogin.jsp");


%>