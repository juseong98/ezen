<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//���ǿ� ���� ���ڿ� �����ڵ� ����
String answer = (String)session.getAttribute("code");
out.print(answer);
%>