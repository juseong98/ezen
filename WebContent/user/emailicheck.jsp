<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="cteam.dao.*" %>
<%@ page import="cteam.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="cteam.vo.*" %>
<%

UserVO user = new UserVO();
//String email = request.getParameter("usermail");
String usermail = request.getParameter("usermail");
System.out.println("usermail:"+usermail);

UserDTO dto = new UserDTO();

//�����ڵ� ���� ���ڿ� ����
String code = dto.GetToken();

//boolean flag = 

//�̸��Ϸ� �����ڵ� ����
dto.sendEmail(usermail,code);
//System.out.println("flag:"+flag);
System.out.println("code:"+code);
// code= "1111";
//out.println("{\"code\":\""+code+"\"}");

session.setAttribute("code",code);
%>