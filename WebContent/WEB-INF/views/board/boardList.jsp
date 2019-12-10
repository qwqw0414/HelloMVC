<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.vo.Board, java.util.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Board> list = (List<Board>)request.getAttribute("list");
	String pageBar = (String)request.getAttribute("pageBar");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />

<section id="board-container">
	<h2>게시판 </h2>
	<%-- 로그인한 경우만 글쓰기 버튼 보이기 --%>
	<% if(memberLoggedIn != null){ %>
	<input type="button" value="글쓰기" id="btn-add" 
		   onclick="location.href='<%=request.getContextPath() %>/board/boardForm';" />
	<% } %>
	<table id="tbl-board">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>조회수</th>
		</tr>
		<% for(Board b : list){ %>
		<tr>
			<td><%= b.getBoardNo() %></td>
			<td><%= b.getBoardTitle() %></td>
			<td><%= b.getBoardWriter() %></td>
			<td><%= b.getBoardDate() %></td>
			<td>
			<% if(b.getOriginalFileName() != null){ %>
			<img alt="첨부파일" 
				 src="<%=request.getContextPath() %>/images/file.png" 
				 width=16px>
			<% }%>
			</td>
			<td><%=b.getReadCount() %></td>
		</tr>
		<% } %>
	</table>

	<div id='pageBar'>
		<%=pageBar %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>