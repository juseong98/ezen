<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../include/header.jsp" %>
<%
String menu = "";
String menuname = "";

%>
<script>
	//채팅 불러올때 이용
	var lastCno = 0;	

	window.onload = function()
	{
		//lastCno 이후의 채팅 불러옴
		getChat();
		
		sendChat();
		//1초 간격 실행
		setInterval(function(){
			getChat();
		}, 1000);
		
	}
	
	function testChat()
	{
		$.ajax({
			type : "post",
			url : "chat.jsp",
			dataType : "html",
			data :
			{
				"todo" : "test",
				"cno" : "1"
			},
			success : function(data) 
			{	
				data = data.trim();
				alert(data);
			}
		});		
	}
	
	function getChat()
	{
		//console.log("getChat()");
		
		var sendData =
		
		$.ajax({
			type : "post",
			url : "chat.jsp",
			dataType : "html",
			data :
			{
				"todo" : "get",
				"cno" : lastCno
			},
			success : function(data) 
			{	
				console.log("function : " + data);
				//console.log(data[0].cnote);
				
				//console.log(Object.values(data));
				//json 변환
				data = JSON.parse(data);
				
				//data = JSON.stringify(data);
				//console.log(Object.values(data));
				//채팅내용출력
				console.log(typeof data, data);
				$("#chatbox").html("");
				$.each(data,function(index,object){
					//object = JSON.parse(object);
					//console.log("each : " + object);
					
					var append = '';
					append += "[ " + object.nick + " ] : ";
					append += object.cnote + "<br>";
					$("#chatbox").append(append);
					console.log(object.cnote);
					
				});
				
				$("#chatbox").scrollTop($("#chatbox").prop("scrollHeight"));
			}
		});
	}
	
	function sendChat()
	{
		console.log("sendChat()");
		$("#btnchat").click(function(){
			//alert("클릭");
			inputChat();
		});
		
	    $("#cnote").keydown(function(key){
	        if (key.keyCode == 13)
	        {
	        	inputChat();
	        }
	    });
	}
	function inputChat()
	{
		console.log("inputChat()");
		$.ajax({
			type : "post",
			url : "chat.jsp",
			dataType : "html",
			data : 
			{
				"todo" : "send",
				"cnote" : $("#cnote").val()
			},
			success : function(data) 
			{	
				$("#cnote").val("");
				$("#cnote").focus();
				getChat();
			}
		});
		
	}
</script>
<!-- 컨텐츠 영역 시작 ======================================== -->

<style>
.listtitle
{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 370px;
  height: 25px;
}
</style>
<div name="chatbox" id="chatbox" class="chatbox"></div>
<table border="0" align="center" style="width:860px">
	<tr>
		<td style="align:center;height:35px">
			<%
			if(login != null)
			{
				%>
				<input type="text" name="cnote" id="cnote" class="verticalmiddle" style="width:785px;height:30px;font-size:13pt;margin:0;">
				<input type="button" id="btnchat" class="btnblue" value="전송" style="width:50px;height:35px;padding:0;font-size:13pt;margin-left:1px">
				<%
			}else
			{
				%>
				<input type="text" name="cnote" id="cnote" value="로그인이 필요합니다." disabled class="verticalmiddle" style="width:840px;height:30px;font-size:13pt;margin:0;">
				<%
			}
			%>
		</td>
	</tr>
</table>
<table align="center" style="width:860px">
	<tr>
		<td style="text-align:center;border:1px solid #868E96;width:50%; vertical-align:top;">
			<div class="newpostesports">
				<ul>
					<li><span class="menuhead">대회 최신글</span></li>
					<hr style="border:solid 2px black;">
					<%
					blist = bdto.ListRecent("1");
					for(BoardVO vo : blist)
					{
						menu = vo.getMenu();
						switch(menu)
						{
							case "N" :
								menuname = "뉴스 기사";
								break;
							case "T" :
								menuname = "대회 이야기";
								break;
							case "H" :
								menuname = "대회 영상";
								break;
						}
						%>
						<li>

							<%
							if(vo.getBtitle().length() >= 20)
							{
								%>
								<div style="display:flex;">
									<div class="listtitle">
										<a href="../board/view.jsp?menu=<%= vo.getMenu() %>&bno=<%= vo.getBno() %>">
											<span class="fontcolor">[<%= menuname %>]</span> <%= vo.getBtitle() %>
										</a>
									</div>
									<%
									if(!vo.getRcount().equals("0"))
									{
										%><span class="fontcolor" >&nbsp;(<%= vo.getRcount() %>)</span><%
									}
									%>
								</div>
								<%
							}else
							{
								%>
								<div style="display:flex;">
									<div>
										<a href="../board/view.jsp?menu=<%= vo.getMenu() %>&bno=<%= vo.getBno() %>">
											<span class="fontcolor">[<%= menuname %>]</span> <%= vo.getBtitle() %>
										</a>
									</div>
									<%
									if(!vo.getRcount().equals("0"))
									{
										%><span class="fontcolor" >&nbsp;(<%= vo.getRcount() %>)</span><%
									}
									%>
								</div>
								<%
							}
							%>
						</li>
						<%
					}
					%>
				</ul>
			</div>
		</td>
		<td style="text-align:center;border:1px solid #868E96; vertical-align:top;">
			<div class="newpostcommu">
				<ul>
					<li><span class="menuhead">커뮤니티 최신글</span></li>
					<hr style="border:solid 2px black;">
					<%
					blist = bdto.ListRecent("2");
					for(BoardVO vo : blist)
					{
						menu = vo.getMenu();
						switch(menu)
						{
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
						%>
						<li>
							<%
							if(vo.getBtitle().length() >= 20)
							{
								%>
								<div style="display:flex;">
									<div class="listtitle">
										<a href="../board/view.jsp?menu=<%= vo.getMenu() %>&bno=<%= vo.getBno() %>">
											<span class="fontcolor">[<%= menuname %>]</span> <%= vo.getBtitle() %>
										</a>
									</div>
									<%
									if(!vo.getRcount().equals("0"))
									{
										%><span class="fontcolor" >&nbsp;(<%= vo.getRcount() %>)</span><%
									}
									%>
								</div>
								<%
							}else
							{
								%>
								<div style="display:flex;">
									<div>
										<a href="../board/view.jsp?menu=<%= vo.getMenu() %>&bno=<%= vo.getBno() %>">
											<span class="fontcolor">[<%= menuname %>]</span> <%= vo.getBtitle() %>
										</a>
									</div>
									<%
									if(!vo.getRcount().equals("0"))
									{
										%><span class="fontcolor" >&nbsp;(<%= vo.getRcount() %>)</span><%
									}
									%>
								</div>
								<%
							}
							%>
						</li>
						<%
					}
					%>
				</ul>
			</div>
		</td>
	</tr>
</table>	
<!-- 컨텐츠 영역 종료 ======================================== -->
<%@ include file="../include/footer.jsp" %>
