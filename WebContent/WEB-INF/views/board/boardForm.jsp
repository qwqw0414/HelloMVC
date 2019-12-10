<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" 
	  href="<%=request.getContextPath()%>/css/board.css" />

<section id="board-container">
	<h2>게시판 작성</h2>
	<form action="<%=request.getContextPath()%>/board/boardFormEnd"
		  method="post"
		  enctype="multipart/form-data">
		<table id="tbl-board-view">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="boardTitle" required/>
				</td>
			</tr>		
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" 
						   name="boardWriter"
						   value="<%=memberLoggedIn.getMemberId() %>"
						   readonly 
						   required/>
				</td>
			</tr>		
			<tr>
				<th>첨부파일</th>
				<td>
					<input type="file" name="upFile"/>
				</td>
			</tr>		
			<tr>
				<th>내 용</th>
				<td>
					<textarea name="boardContent" 
							  cols="50" 
							  rows="5"></textarea>
				</td>
			</tr>		
			<tr>
				<th colspan="2">
					<input type="submit"
						   onclick="return boardValidate();" 
						   value="등록하기" />
				</th>
			</tr>
		</table>
	</form>
	

</section>
<script>
function boardValidate(){
	//제목검사
	var $title = $("[name=boardTitle]");
	if($title.val().trim().length == 0){
		alert("제목을 입력하세요.");
		return false;
	}
	
	//내용검사
	var $content = $("[name=boardContent]");
	if($content.val().trim().length == 0){
		alert("내용을 입력하세요.");
		return false;
	}
	
	return true;
}

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>