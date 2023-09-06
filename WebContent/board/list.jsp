<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../include/header.jsp" %>
<%@ page import="java.util.*" %>
<%
String menu = request.getParameter("menu");
if(menu == null || menu.equals(""))
{
	response.sendRedirect("../main/index.jsp");
	return;
}
String menuname = "";
switch(menu)
{
	case "N" :
		menuname = "뉴스 기사";
		break;
	case "T" :
		menuname = "대회 이야기";
		break;
	case "H" :
		menuname = "대회 하이라이트";
		break;
	case "F" :
		menuname = "자유 주제";
		break;
	case "Q" :
		menuname = "질문 & 답변";
		break;
	case "I" :
		menuname = "정보 & 팁";
		break;
	case "P" :
		menuname = "파티 모집";
		break;
	case "M" :
		menuname = "이미지";
		break;
}

int pageNo = 1;
int dataTotal = bdto.GetTotal(menu);
try
{
	pageNo = Integer.parseInt(request.getParameter("pageNo"));
}catch(Exception e){}

System.out.println("list");
blist = bdto.List(menu, pageNo);
System.out.println(pageNo);
String scopt = "";
String scword = "";
try
{
	scopt = request.getParameter("scopt");
	scword = request.getParameter("scword");
}catch(Exception e){}
//System.out.println("scopt : " + scopt);
//System.out.println("scword : " + scword);
//if(scopt == null) scopt = "btitle";	
if(scword == null) scword = "";	
	
if(scopt != null && scword != null)
{
	blist = bdto.ListSearch(menu, pageNo, scopt, scword);
}
%>
<script>
	window.onload = function()
	{
		
		$("#btnwrite").click(function() {
			if( <%=islogin%> == true )
			{
				document.location = "write.jsp?menu=<%= menu %>";
			}else
			{
				if(confirm("글쓰기 권한이 없습니다. 로그인 하시겠습니까?") == true)
				{
					document.location = "../user/userlogin.jsp";
					return;
				}

			}
		});
		
		$("#btnsearch").click(function(){
			alert("btnsearch");
			dosearch();
		});
		
	    $("#scword").keydown(function(key){
	        if (key.keyCode == 13)
	        {
	        	dosearch();
	        }
	    });
	    
	}
	
	function dosearch()
	{
		<%
		System.out.println("dosearch()");
		%>
		var url = "list.jsp"
		url += "?menu=" + "<%= menu %>";
		url += "&page=" + <%= pageNo %>;
		url += "&scopt=" + $("#scopt").val(); 
		url += "&scword=" + encodeURIComponent($("#scword").val());
		
		document.location = url;
	}
	
</script>
<style>
.listtitle
{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 380px;
  height: 25px;
}
</style>
<!-- 컨텐츠 영역 시작 ======================================== -->
<div style="margin: 0px 0px 0px 50px"><h1><%= menuname %></h1></div>
<div align="right" style="margin: 0px 50px 0px 0px;">
	<button class="btnblue" id="btnwrite" style="width:60px;height:30px">글쓰기</button>
</div>
<br>
<table align="center" class="listtable" style="text-align:center;width:860px;margin:0px 50px 0px 50px" >
	<%
	if(menu.equals("H") || menu.equals("M"))
	{
		%>
		<tr>
			<th style="width:120px">미리보기</th>
			<th>제목</th>
			<th style="width:185px">작성자</th>
			<th style="width:60px;text-align:center">추천</th>
			<th style="width:60px;text-align:center">조회수</th>
			<th style="width:60px;text-align:center">작성일</th>
		</tr>
		<%
	}else
	{
		%>
		<tr>
			<th style="width:40px">번호</th>
			<th>제목</th>
			<th style="width:185px">작성자</th>
			<th style="width:60px">추천</th>
			<th style="width:60px">조회수</th>
			<th style="width:60px">작성일</th>
		</tr>
		<%
	}
	
	//공지 리스트
	ArrayList<BoardVO> blistNoti = bdto.List(menu); 
	for(BoardVO bvo : blistNoti)
	{
		%>
		<tr>
			<td><b>공지</b></td>
			<td style="text-align:left;padding:5px">
			<%
			if( bvo.getBtitle().length() >= 25)
			{
			%>
			<div style="display:flex;">
				<div class="listtitle">
					<a href="view.jsp?menu=<%= menu %>&bno=<%= bvo.getBno() %>"><%= bvo.getBtitle() %></a>
				</div>
				<%
				if(!bvo.getRcount().equals("0")) 
				{
					%>&nbsp;<span class="fontcolor">(<%= bvo.getRcount() %>)</span><%
				}
				%>				
			</div>
			<%
			}else
			{
			%>
			<div style="display:flex;">
				<div>
					<a href="view.jsp?menu=<%= menu %>&bno=<%= bvo.getBno() %>"><%= bvo.getBtitle() %></a>
				</div>
				<%
				if(!bvo.getRcount().equals("0")) 
				{
					%>&nbsp;<span class="fontcolor">(<%= bvo.getRcount() %>)</span><%
				}
				%>				
			</div>
			<%
			}
			%>
			</td>
			<td>관리자</td>
			<td><%= bvo.getGcount() %></td>
			<td><%= bvo.getHit() %></td>
			<td><%= bvo.getWdate() %></td>
		</tr>		
		<%
	}
	for(BoardVO bvo : blist)
	{
		%>
		<tr>
			<td>
				<%
				switch(menu)
				{
				case "H" :
					if(!bvo.getYoutube().equals(""))
					{	
						if(Integer.parseInt(bvo.getBlcount()) < 11)
						{	
							%>
							<img src="https://img.youtube.com/vi/<%= bvo.getYoutube() %>/maxresdefault.jpg" class="thumbnail">
							<%
						}
					}
					break;
				case "M" : 	
					if(!bvo.getBfname().equals(""))
					{
						if(Integer.parseInt(bvo.getBlcount()) < 11)
						{	
							%>
							<img src="file.jsp?bno=<%= bvo.getBno() %>" style="width:120px;height:90px" class="thumbnail">
							<%
						}		
					}
					break;
				default :
					%>
					<%= bvo.getBno() %>
					<%
					break;
				}
				
				%>
			</td>
			<td style="text-align:left;padding:5px">
				<%
				if(Integer.parseInt(bvo.getBlcount()) < 11)
				{
						if( bvo.getBtitle().length() >= 25)
						{
						%>
						<div style="display:flex;">
							<div class="listtitle">
								<a href="view.jsp?menu=<%= menu %>&bno=<%= bvo.getBno() %>"><%= bvo.getBtitle() %></a>
							</div>
							<%
							if(!bvo.getRcount().equals("0")) 
							{
								%>&nbsp;<span class="fontcolor">(<%= bvo.getRcount() %>)</span><%
							}
							%>				
						</div>
						<%
						}else
						{
						%>
						<div style="display:flex;">
							<div>
								<a href="view.jsp?menu=<%= menu %>&bno=<%= bvo.getBno() %>"><%= bvo.getBtitle() %></a>
							</div>
							<%
							if(!bvo.getRcount().equals("0")) 
							{
								%>&nbsp;<span class="fontcolor">(<%= bvo.getRcount() %>)</span><%
							}
							%>				
						</div>
						<%
						}
				}else
				{
					%>
					<b>신고가 누적된 글입니다.</b> <a href="view.jsp?menu=<%= menu %>&bno=<%= bvo.getBno() %>">[내용보기]</a>
					<%
				}
				%>
			</td>
			<td><span class="font<%= bvo.getTeam() %>">[<%= bvo.getTeam() %> <%= bvo.getPosition() %>]</span><%= bvo.getNick() %></td>
			<td><%= bvo.getGcount() %></td>
			<td><%= bvo.getHit() %></td>
			<td><%= bvo.getWdate() %></td>
		</tr>
		<%
	}
	%>
	
	
</table>
<br>
<div align="center">

<%
	PageVO paging = new PageVO();
	
	if(scopt != null && scword != null)
	{
		dataTotal = bdto.GetTotal(menu, scopt, scword);
		
		//전체 게시물 갯수를 설정한다.
		paging.SetPgTotal(dataTotal,pageNo);
		
		//이전 블럭 얻기
		paging.SetPgURL("<a href='list.jsp?menu=" + menu + "&pageNo={page}&scopt="+scopt+"&scword="+scword+"'>이전</a>");
		out.println(paging.GetPrevBlock());
		
		//페이징 얻기
		paging.SetPgURL("<a href='list.jsp?menu=" + menu + "&pageNo={page}&scopt="+scopt+"&scword="+scword+"'>{page}</a>");
		out.println(paging.GetPaging(pageNo));		
		
		//다음 블럭 얻기
		paging.SetPgURL("<a href='list.jsp?menu=" + menu + "&pageNo={page}&scopt="+scopt+"&scword="+scword+"'>다음</a>");
		out.println(paging.GetNextBlock());
	}else
	{
		//전체 게시물 갯수를 설정한다.
		paging.SetPgTotal(dataTotal,pageNo);
		
		//이전 블럭 얻기
		paging.SetPgURL("<a href='list.jsp?menu=" + menu + "&pageNo={page}'>이전</a>");
		out.println(paging.GetPrevBlock());
		
		//페이징 얻기
		paging.SetPgURL("<a href='list.jsp?menu=" + menu + "&pageNo={page}'>{page}</a>");
		out.println(paging.GetPaging(pageNo));		
		
		//다음 블럭 얻기
		paging.SetPgURL("<a href='list.jsp?menu=" + menu + "&pageNo={page}'>다음</a>");
		out.println(paging.GetNextBlock());
	}
%>
</div>
<br>
<div align="center"> 
	<select name="scopt" id="scopt" style="height:30px;vertical-align:middle">
	<%
	if( scopt != null )
	{
	%>
		<option value="btitle" <%= scopt.equals("btitle") ? "selected" : "" %>>제목</option>						
		<option value="bnote" <%= scopt.equals("bnote") ? "selected" : "" %>>내용</option>						
		<option value="nick" <%= scopt.equals("nick") ? "selected" : "" %>>작성자</option>
	<%
	}else{
		%>
		<option value="btitle">제목</option>						
		<option value="bnote">내용</option>						
		<option value="nick">작성자</option>
		<%
	}
	%>						
	</select>
	<input name="scword" id="scword" type="text" value="<%= scword %>" style="height:25px;vertical-align:middle">
	<button type="button" class="btnblue" id="btnsearch" style="width:60px;height:30px">검색</button>
</div>
<!-- 컨텐츠 영역 종료 ======================================== -->
<%@ include file="../include/footer.jsp" %>