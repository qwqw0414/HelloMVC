<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = request.getParameter("memberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호변경</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<style>
div#updatePassword-container{
    background:red;
}
div#updatePassword-container table {
    margin:0 auto;
    border-spacing: 20px;
}
div#updatePassword-container table tr:last-of-type td {
    text-align:center;
}
</style>
<script>
function password_validate(){
    var pwd_new = $("#password_new").val().trim();
    var pwd_chk = $("#password_chk").val().trim();
    
    if(pwd_new!=pwd_chk){
        alert("입력한 비밀번호가 일치하지 않습니다.");
        $("#password_new").select();
        return false;
    }
    
    return true;	
}
</script>

</head>
<body>
   

    <div id="updatePassword-container">
		<form name="updatePwdFrm" action="<%=request.getContextPath()%>/member/updatePasswordEnd" method="post" >
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="password" id="password" required></td>
				</tr>
				<tr>
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="password_new" id="password_new" required>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>	
						<input type="password" id="password_chk" required><br>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" onclick="return password_validate();" value="변경" />&nbsp;
						<input type="button" onclick="self.close();" value="닫기" />						
					</td>
				</tr>
			</table>
			<input type="hidden" name="memberId" value="<%=memberId %>" />
		</form>
	</div>

</body>
</html>