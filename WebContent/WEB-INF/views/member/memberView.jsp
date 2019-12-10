<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.*" %>
<%
	Member m = (Member)request.getAttribute("member");
	
	//필드가 not null이 아닌 경우(선택) null값 출력방지
	String email = m.getEmail()!=null?m.getEmail():"";
	String address = m.getAddress()!=null?m.getAddress():"";

	//취미체크박스 처리1:contains
	String hobby = m.getHobby()!=null?m.getHobby():"";
	
	//취미체크박스 처리2
	String[] hobbyChecked = {"","","","",""};
	
	if(m.getHobby() != null){
		String[] hobbies = m.getHobby().split(",");//["운동","독서","등산"]
				
		for(String h : hobbies){
			switch(h){
			case "운동": hobbyChecked[0] = "checked"; break;
			case "등산": hobbyChecked[1] = "checked"; break;
			case "독서": hobbyChecked[2] = "checked"; break;
			case "게임": hobbyChecked[3] = "checked"; break;
			case "여행": hobbyChecked[4] = "checked"; break;
			}
		}
		
	}
	
%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<section id=enroll-container>
        <h2>회원 정보 보기 및 수정</h2>
        <form name="memberUpdateFrm" 
        	  action="<%=request.getContextPath() %>/member/memberUpdate"
        	  method="post" 
        	  onsubmit="return updateValidate();" >
        <table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" placeholder="4글자이상" 
						   name="memberId" 
						   id="memberId_" 
						   value="<%=m.getMemberId() %>"
						   required readonly>
				</td>
			</tr>
			<%-- <tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="password" id="password_" 
						   value="<%=m.getPassword() %>" required><br>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" id="password_2" 
						   value="<%=m.getPassword() %>"
						   required><br>
				</td>
			</tr>  --%> 
			<tr>
				<th>이름</th>
				<td>	
				<input type="text"  name="memberName" id="memberName" 
					   value="<%=m.getMemberName() %>" required><br>
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>	
				<input type="number" name="age" id="age"
					   value="<%=m.getAge() %>"><br>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" placeholder="abc@xyz.com" 
						   name="email" id="email"
						   value="<%=email %>"><br>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" 
						   name="phone" id="phone" maxlength="11" 
						   value="<%=m.getPhone()%>"
						   required><br>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text"
						   name="address" 
						   value="<%=address %>"
						   id="address"><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<input type="radio" name="gender" id="gender0" value="M" 
						   <%="M".equals(m.getGender())?"checked":"" %>>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F"
						   <%="F".equals(m.getGender())?"checked":"" %>>
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<%-- <td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동" <%=hobby.contains("운동")?"checked":""%>><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산" <%=hobby.contains("등산")?"checked":""%>><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서" <%=hobby.contains("독서")?"checked":""%>><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임" <%=hobby.contains("게임")?"checked":""%>><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행" <%=hobby.contains("여행")?"checked":""%>><label for="hobby4">여행</label><br />
				</td> --%>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동" <%=hobbyChecked[0] %>><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산" <%=hobbyChecked[1] %>><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서" <%=hobbyChecked[2] %>><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임" <%=hobbyChecked[3] %>><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행" <%=hobbyChecked[4] %>><label for="hobby4">여행</label><br />
				</td>
			</tr>
		</table>
		<input type="submit" value="정보수정" >
		<input type="button" value="비밀번호 변경" onclick="updatePassword();" >
		<input type="reset" value="초기화">
		<input type="button" value="탈퇴" onclick="confirmDelete();">
        </form>
    </section>
<script>
function updatePassword(){
	var url = "<%=request.getContextPath()%>/member/updatePassword?memberId=<%=m.getMemberId()%>";
	var title = "updatePasswordPopup";
	var spec = "left=500px, top=200px, width=400px, height=210px";
	
	open(url, title, spec);
}


function confirmDelete(){
    var bool = confirm("정말로 탈퇴하시겠습니까?");
    if(bool)
        location.href = "<%=request.getContextPath() %>/member/memberDelete?memberId=<%=m.getMemberId()%>";
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>




