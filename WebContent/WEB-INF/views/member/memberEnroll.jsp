<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<script>
	$(()=>{
		$("#password_2").blur(function(){
			var $pwd1 = $("#password_");
			var $pwd2 = $("#password_2");
			
			if($pwd1.val() != $pwd2.val()){
				alert("패스워드가 일치하지 않습니다.");
				$pwd1.val('').focus();
				$pwd2.val('');
			}
		});
		
		//아이디 중복검사 이후 아이디를 변경한 경우
		//change이벤트는 blur할 경우, 값변경 내역을 감지한다.
		$("#memberId_").change(function(){
			$("#idValid").val(0);
		});
		
	});
	
	/*
	* 회원가입 유효성 검사함수
	*/
	function enrollValidate(){
		var $memberId = $("#memberId_");
		if($memberId.val().trim().length < 4){
			alert("아이디는 4글자 이상 가능합니다.");
			return false;
		}
		
		var $idValid = $("#idValid");
		if($idValid.val() == 0){
			alert("아이디 중복 검사 해주세요.");
			return false;
		}
		
		return true;
	}
	
	/*
	* 아이디 중복검사 함수: 팝업창
	*/
	function checkIdDuplicate(){
		var $memberId = $("#memberId_");
		//유효성검사
		if($memberId.val().trim().length < 4){
			alert("아이디는 4글자 이상이어야 합니다.");
			return;
		}
		
		//폼을 팝업창에 제출
		//frm.target = 팝업창이름
		var url = "<%=request.getContextPath()%>/member/checkIdDuplicate";
		var title = "checkIdDuplicatePopup";
		var spec = "left=500px, top=100px, width=300px, height=200px";
		var popup = open("", title, spec);
		
		var frm = document.checkIdDuplicateFrm;
		frm.action = url;
		frm.target = title;
		frm.method = "POST";
		frm.memberId.value = $memberId.val().trim();
		frm.submit();
		
	}
	</script>
	<!-- 아이디중복검사폼 -->
	<form name="checkIdDuplicateFrm">
		<input type="hidden" name="memberId" />
	</form>
	
    <section id=enroll-container>
        <h2>회원 가입 정보 입력</h2>
        <form action="memberEnrollEnd" 
        	  name="memberEnrollFrm" 
        	  method="post" 
        	  onsubmit="return enrollValidate();" >
        <table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" placeholder="4글자이상" 
						   name="memberId" 
						   id="memberId_" required>
					<input type="button" value="아이디 중복검사"
						   onclick="checkIdDuplicate();" />
					<%-- 아이디 중복검사후 사용가능한 아이디를 선택했을때,value=1 --%>
					<input type="hidden" id="idValid" value="0"/>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="password" id="password_" required><br>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" id="password_2" required><br>
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
				<input type="text"  name="memberName" id="memberName" required><br>
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>	
				<input type="number" name="age" id="age"><br>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" placeholder="abc@xyz.com" name="email" id="email"><br>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required><br>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" placeholder="" name="address" id="address"><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<input type="radio" name="gender" id="gender0" value="M" checked>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F">
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동"><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산"><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서"><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임"><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행"><label for="hobby4">여행</label><br />
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
        </form>
    </section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>