<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../include/header.jsp" %>
<%@ page import="java.util.*" %>
<%
String menu = request.getParameter("menu");
if(menu == null)
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
		menuname = "팀원 모집";
		break;
	case "M" :
		menuname = "이미지";
		break;
}

String bno = request.getParameter("bno");
if(bno == null || bno.equals("")) response.sendRedirect("list.jsp?menu=" + menu);




// 저장된 쿠키 불러오기
Cookie[] cookieFromRequest = request.getCookies();
String cookieValue = null;
for(int i = 0 ; i<cookieFromRequest.length; i++) {
	// 요청정보로부터 쿠키를 가져온다.
	cookieValue = cookieFromRequest[0].getValue();	// 테스트라서 추가 데이터나 보안사항은 고려하지 않으므로 1번째 쿠키만 가져옴	
}

	
	// 쿠키 세션 입력
if (session.getAttribute(bno+":cookie") == null) {
 	session.setAttribute(bno+":cookie", bno + ":" + cookieValue);
} else {
	session.setAttribute(bno+":cookie ex", session.getAttribute(bno+":cookie"));
	if (!session.getAttribute(bno+":cookie").equals(bno + ":" + cookieValue)) {
	 	session.setAttribute(bno+":cookie", bno + ":" + cookieValue);
	}
}
	BoardVO bvo = bdto.Read(bno, false);
	
	// 글 상세 조회

	// 조회수 카운트
	if (!session.getAttribute(bno+":cookie").equals(session.getAttribute(bno+":cookie ex"))) {
		bdto.Read(bno, true);
 	// 가시적으로  조회수 1 추가해줌
	}
	
	//System.out.println("중복방지 111 = " + session.getAttribute(seq+":cookie") );
	//System.out.println("중복방지 222 = " + session.getAttribute(seq+":cookie ex") );
	//System.out.println("중복방지 333 = " + session.toString() );
	//for(int i = 0; i < session.getValueNames().length; i++){
	//	System.out.println("중복방지 444 = " + session.getValueNames()[i].toString() );
	//}

%>
<script>
	window.onload = function()
	{
		
		//글 하단 버튼
		$("#btnlist").click(function(){
			document.location = "list.jsp?menu=<%= menu %>";
		});
		
		$("#btnmodify").click(function(){
			document.location = "modify.jsp?menu=<%= menu %>&bno=<%= bno %>";
		});
		
		$("#btndelete").click(function(){
			if(confirm("게시글을 삭제하시겠습니까?") == true)
			{
				document.location = "deleteok.jsp?menu=<%= menu %>&bno=<%= bno %>";
			}
		});
		
		$("#btngood").click(function(){
			if(confirm("게시글을 추천하시겠습니까?") == true)
			{
				
				if(<%= islogin %> == false )
				{
					if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?") == true)
						{
							document.location = "../user/userlogin.jsp"
							return;
						}
				}
				$.ajax({
					type : "post",
					url : "service.jsp",
					dataType : "html",
					data :
					{
						"bno" : "<%= bno %>",
						"sdiv" : "0"
					},
					success : function(data) 
					{
						data = data.trim();
						if(data == "N")
						{
							alert("이미 추천한 글입니다.");
						}else
						{
							$(".getgcount").html(data);
							$("#notig").addClass("show");
							setTimeout(function(){
								$("#notig").removeClass("show");
							},2000);
						}
					}
				});				
			}
		});
		
		$("#btnblind").click(function(){
			if(confirm("게시글을 신고하시겠습니까?") == true)
			{
				if(<%= islogin %> == false)
				{
					if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?") == true)
						{
							document.location = "../user/userlogin.jsp"
							return;
						}
				}
				$.ajax({
					type : "post",
					url : "service.jsp",
					dataType : "html",
					data :
					{
						"bno" : "<%= bno %>",
						"sdiv" : "1"
					},
					success : function(data) 
					{
						data = data.trim();
						if(data == "N")
						{
							alert("이미 신고한 글입니다.");
						}else
						{
							$(".getblcount").html(data);
							$("#notibl").addClass("show");
							setTimeout(function(){
								$("#notibl").removeClass("show");
							},2000);
						}
					}
				});				
			}
		});
		
		replylist();
		

	}
	
	//댓글 관련 ==================================================
	
	//댓글 리스트
	function replylist()
	{
		$.ajax({
			type : "post",
			url : "reply.jsp",
			dataType : "html",
			data : 
			{
				"bno" : <%= bno %>,
				"todo" : "list"
			},
			success : function(data) 
			{
				data = data.trim();
				//alert(data);
				$("#replylist").html(data);
				btnreply();
				//alert("replylist()");
			}
		});		
	}
	
	//댓글 insert
	
	//클릭, 엔터에 댓글 작성 
	function btnreply()
	{
		$("#btnrpwrite").click(function(){
			inputReply();
		});
		
	    $("#rnote").keydown(function(key){
	        if(key.keyCode == 13)
	        {
	        	inputReply();
	        }
	    });
	}
	//댓글 작성 - btnreply와 세트
	function inputReply()
	{
		$.ajax({
			type : "post",
			url : "reply.jsp",
			dataType : "html",
			data : 
			{
				"todo" : "write",
				"bno" : "<%= bno %>",
				"rnote" : $("#rnote").val()
			},
			success : function(data) 
			{	
				$("#rnote").val("");
				replylist();
			}
		});
	}
	
	//댓글 update
	var PreObj = null;  //기존 변경하려는 댓글
	var PreHTML = null; //기존 변경하려는 댓글 내용
	function ReplyModify(obj,rno)
	{
		if(PreObj != null)
		{
			$(PreObj).html(PreHTML);	
		}
		PreObj  = $(obj).parent().parent();
		PreHTML = $(obj).parent().parent().html();
		//alert($(obj).parent().parent().html());
		//if( confirm("해당 댓글을 수정하시겠습니까?") == false) return;	
		
		$.ajax({
			type : "post",
			url: "reply.jsp",
			dataType: "html",
			data:
			{
				"todo" : "modifyfrm",
				"rno" : rno
			},
			success : function(data)
			{
				console.log(data);
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				$(obj).parent().parent().html(data);
			}
		});
		
	}
	
	//댓글 수정 완료
	function ModifyReplyOK(obj,rno)
	{
		rnote = $(obj).parent().find("#rnote").val();
		if( rnote == "")
		{
			alert("댓글을 입력하세요.");
			$(obj).parent().find("#rnote").focus();
			return;
		}
		
		$.ajax({
			type : "post",
			url: "reply.jsp",
			dataType: "html",
			data : 
			{
				"todo" : "modify",
				"rno" : rno,
				"rnote" : rnote
			},
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				replylist();
			}
		});	
	}	
	
	//댓글 delete
	function replydelete(rno)
	{
		if(confirm("댓글을 삭제하시겠습니까?") == true)
		{
			$.ajax({
				type : "post",
				url : "reply.jsp",
				dataType : "html",
				data : 
				{
					"todo" : "delete",
					"rno" : rno,
				},
				success : function(data) 
				{
					$("#notirpdel").addClass("show");
					setTimeout(function(){
						$("#notirpdel").removeClass("show");
					},2000);
					replylist();
				}
			});
		}
	}
	//댓글 신고
	function rpblupdate(bno, rno)
	{
		<% System.out.println("rpblupdate()"); %>
		
		if(confirm("댓글을 신고하시겠습니까?") == true)
		{
			if(<%=islogin %> == false)
			{
				if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?") == true)
					{
						document.location = "../user/userlogin.jsp"
						return;
					}
			}
			
			$.ajax({
				type : "post",
				url : "service.jsp",
				dataType : "html",
				data : 
				{
					"bno" : bno,
					"rno" : rno
				},
				success : function(data) 
				{
					data = data.trim();
					if(data == "N")
					{
						alert("이미 신고한 댓글입니다.")	
					}else
					{
						$(".getrpblcount").html(data);
						$("#notirpbl").addClass("show");
						setTimeout(function(){
							$("#notirpbl").removeClass("show");
						},2000);						
					}
				}
			});
		}
	}
	
	//블라인드 댓글 보이기
	function getblrp(rno)
	{
		$.ajax({
			type : "post",
			url : "reply.jsp",
			dataType : "html",
			data : 
			{
				"todo" : "read",
				"rno" : rno
			},
			success : function(data) 
			{
				data = data.trim();
				var html = "";
				html  = "<button class='btnorange' name='btnrpblind' id='btnrpblind' ";
				html += "onclick='rpblupdate(" + rno + ")'";
				html += "style='display:inline-block;float:right;width:50px;height:30px'>신고</button>";
				$("#rpblind"+rno).html(data+html);
			}
		});		
	}
</script>
<!-- 컨텐츠 영역 시작 ======================================== -->
<div style="margin: 0px 0px 0px 50px"><h1><a href="list.jsp?menu=<%= menu %>" style="color:black;"><%= menuname %></a></h1></div>
<br>
<table class="tableline" align="center" style="width:860px;text-align:center">
	<tr>
		<td style="padding:5px">제목</td>
		<td colspan="4" name="btitle" id="btitle" style="text-align:left;padding:5px"><%= bvo.getBtitle() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td style="padding:5px;vertical-align:top">
			<span class="font<%= bvo.getTeam() %>">[<%= bvo.getTeam() %> <%= bvo.getPosition() %>]</span><%= bvo.getNick() %>
		</td>
		<td>작성일</td>
		<td><%= bvo.getWdate() %></td>
		<td> 추천 : <span class="getgcount"><%= bvo.getGcount() %></span> / 조회수 : <%= bvo.getHit() %> </td>
	</tr>
		<%
		if(!bvo.getBfname().equals(""))
		{
			%>
			<tr>
				<td>첨부파일</td>
				<td colspan="4"><a href="file.jsp?bno=<%= bno %>"><%= bvo.getBfname() %></a></td>
			</tr>
			<%
		}
		%>
	<tr>
		<td colspan="5" style="padding:5px;text-align:left">
			<%
			if(menu.equals("H") && !bvo.getYoutube().equals(""))
			{	
				%>
				<iframe width="560" height="315" src="https://www.youtube.com/embed/<%= bvo.getYoutube() %>" title="YouTube video player" 
				frameborder="0" 
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
				allowfullscreen>
				</iframe><br>
				<%
			}
			if(menu.equals("M") && !bvo.getBfname().equals(""))
			{
				%>
				<img src="file.jsp?bno=<%= bvo.getBno() %>" style="max-width:100%;height:auto"><br>
				<%
			}
			if(menu.equals("N") && bvo.getNewslink() != null && !bvo.getNewslink().equals(""))
			{
				%>
				<a href="<%= bvo.getNewslink() %>"><%= bvo.getNewslink() %></a><br>
				<%
			}
			%>
			<%
			String bnote = bvo.getBnote();
			bnote = bnote.replace("<", "&lt;");
			bnote = bnote.replace(">", "&gt;");
			bnote = bnote.replace("\n", "\n<br>");
			%>
			<%= bnote %>
		</td>
	</tr>
</table>
<br>
<div align="center">
	
	<%

	if( (islogin != false && bvo.getId().equals(login.getId())) || (islogin != false && login.getUserdiv().equals("2")) )
	{
		%>
		<button class="btnblue" id="btnmodify" style="width:80px;height:30px">수정</button>&nbsp; &nbsp;
		<button class="btngray" id="btnlist" style="width:80px;height:30px">글목록</button>&nbsp; &nbsp;
		<button class="btnorange" id="btndelete" style="width:80px;height:30px">삭제</button>
		<% 
	}else
	{
		%>
		<button class="btnblue" id="btngood" style="width:80px;height:30px">추천 (<span class="getgcount"><%= bvo.getGcount() %></span>)</button>&nbsp; &nbsp;
		<button class="btngray" id="btnlist" style="width:80px;height:30px">글목록</button>&nbsp; &nbsp;
		<button class="btnorange" id="btnblind" style="width:80px;height:30px">신고 (<span class="getblcount"><%= bvo.getBlcount() %></span>)</button>
		<%
	}
	%>
</div>
<br>
<div id="replylist"></div>
<!-- 컨텐츠 영역 종료 ======================================== -->
<%@ include file="../include/footer.jsp" %>



