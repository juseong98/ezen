<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <style>
    .listtitlepop
{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 380px;
  height: 35px;
}
    </style>
					<div class="teamtable" style="margin-top:50px">
						<table align="center">
							<tr>
								<td><a href="https://www.gengshop.com/geng" target="_blank"><img id="teamicon" src="../images/team/GENG.png"></a></td>
								<td><a href="https://shop-t1.gg/" target="_blank"><img id="teamicon" src="../images/team/T1.png"></a></td>
								<td><a href="https://ktrolster.com/" target="_blank"><img id="teamicon" src="../images/team/KT.png"></a></td>
								<td><a href="https://lckshop.com/collections/team/HLE" target="_blank"><img id="teamicon" src="../images/team/HLE.png"></a></td>
								<td><a href="https://shop.dpluskia.gg/" target="_blank"><img id="teamicon" src="../images/team/DK.png"></a></td>
								<td><a href="https://lsbshop.com/" target="_blank"><img id="teamicon" src="../images/team/LSB.png"></a></td>
								<td><a href="https://freecs.shop/" target="_blank"><img id="teamicon" src="../images/team/KDF.png"></a></td>
								<td><a href="https://brionesports.gg/50BROSHOP" target="_blank"><img id="teamicon" src="../images/team/BRO.png"></a></td>
								<td><a href="https://www.drxglobal.shop/" target="_blank"><img id="teamicon" src="../images/team/DRX.png"></a></td>
								<td><a href="https://ns-esports.fan/shop/kr" target="_blank"><img id="teamicon" src="../images/team/NS.png"></a></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="divright">
					<hr style="border:solid 2px black">
					<div class="hotpost">
						<ul>
							<li>
								<span class="menuhead">인기 게시글</span>
							</li>
							<%
							blist = bdto.ListPopular();
							for(BoardVO vopop : blist)
							{
								String menunamepop = "";
								switch(vopop.getMenu())
								{
									case "N" :
										menunamepop = "뉴스 기사";
										break;
									case "T" :
										menunamepop = "대회 이야기";
										break;
									case "H" :
										menunamepop = "대회 영상";
										break;
									case "F" :
										menunamepop = "자유 주제";
										break;
									case "Q" :
										menunamepop = "질문 & 답변";
										break;
									case "I" :
										menunamepop = "정보 & 팁";
										break;
									case "P" :
										menunamepop = "파티 모집";
										break;
									case "M" :
										menunamepop = "이미지";
										break;
								}
								%>
								<div class="listtitlepop">
									<a href="../board/view.jsp?menu=<%= vopop.getMenu() %>&bno=<%= vopop.getBno() %>">
										<span class="fontcolor">[<%= menunamepop %>]</span> <%= vopop.getBtitle() %>
									</a>
								</div>
								<%
							}
							%>
						</ul>
					</div>
					<hr style="border:solid 2px black">
					<div class="esportslink">
						<ul>
							<li>
								<span class="menuhead">외부링크</span>
							</li>
							<li>
								<a href="https://game.naver.com/esports/League_of_Legends/record/lck/team/lck_2023_summer" target="_blank">
									팀 순위표
								</a>
							</li>
							<li>
								<a href="https://game.naver.com/esports/League_of_Legends/schedule/lck" target="_blank">
									경기 일정
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div>
					<div class="notig" id="notig">추천되었습니다.</div>
					<div class="notibl" id="notibl">신고되었습니다.</div>
					<div class="notirpbl" id="notirpbl">댓글이 신고되었습니다.</div>
					<div class="notirpdel" id="notirpdel">댓글이 삭제되었습니다.</div>
				</div>
			</div>
		</div>
	</body>
</html>