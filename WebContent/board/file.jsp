<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../include/upload.jsp" %>    
<%@ page import="cteam.vo.*" %> 
<%@ page import="cteam.dto.*" %>
<%@ page import="cteam.dao.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%
String bno = request.getParameter("bno");
if(bno == null)
{
	response.sendRedirect("../main/index.jsp");
	return;
}
BoardDTO bdto = new BoardDTO();
BoardVO  bvo  = bdto.Read(bno,false);

String bfname = bvo.getBfname();
String bpname = bvo.getBpname();

String filename = bpname;

String fullname = uploadPath + "\\" + filename;

//한글코드를 encoding 한다.
bfname = URLEncoder.encode(bfname, "utf-8");
response.setContentType("application/octet-stream");   
response.setHeader("Content-Disposition","attachment; filename=" + bfname + ";");
response.setHeader("Content-Transfer-Encoding", "binary");

File file = new File(fullname);
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096];
//copy binary contect to output stream
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}
fileIn.close();
ostream.flush();
ostream.close();
%>