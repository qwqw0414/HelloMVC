<%@page import="board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Board b = (Board)request.getAttribute("board");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%=b.getBoardNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%=b.getBoardTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=b.getBoardWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=b.getReadCount() %></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<!-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 -->
				<%if(b.getOriginalFileName() != null) {%>
				<a href="javascript:fileDownload('<%=b.getOriginalFileName()%>','<%=b.getRenamedFileName()%>')">
				<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px>
				<%} %>
				</a><%=(b.getOriginalFileName()==null)?"":b.getOriginalFileName() %>
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td><%=b.getBoardContent() %></td>
		</tr>
		<tr>
			<!-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 -->
			<th colspan="2">
				<%if(memberLoggedIn != null && memberLoggedIn.getMemberId().equals(b.getBoardWriter())){ %>
				<input type="button" value="수정하기" />
				<%} %>
				<input type="button" value="삭제하기" />
			</th>
		</tr>
	</table>
</section>
<script>
function fileDownload(oName,rName){
	//ie대비 한글인코딩 명시적 처리
	oName = encodeURIComponent(oName);
	
	location.href = "<%=request.getContextPath()%>/board/fileDownload?oName="+oName+"&rName="+rName;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
