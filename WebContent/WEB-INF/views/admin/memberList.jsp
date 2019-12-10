<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
    List<Member> list = (List<Member>)request.getAttribute("list");
	String pageBar = (String)request.getAttribute("pageBar");	
%>
   
<!-- 관리자용 css link -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style>
#search-container{
	margin: 0 0 10px 0; 
	padding: 3px;
	background-color: rgba(0,188,212,.3);
}
#search-memberId {display: inline-block;}
#search-memberName {display: none;}
#search-gender {display: none;}
</style>
<script>
$(()=>{
	var $searchMemberId = $("#search-memberId");
	var $searchMemberName = $("#search-memberName");
	var $searchGender = $("#search-gender");
	
	$("#searchType").change(function(){
		$searchMemberId.hide();
		$searchMemberName.hide();
		$searchGender.hide();
		
		$("#search-"+$(this).val()).css("display", "inline-block");
	});
	
});

</script>
<section id="memberList-container">
	<h2>회원관리</h2>
	<div id="search-container">
		<label for="searchType">검색타입 : </label>
		<select id="searchType">
			<option value="memberId">아이디</option>
			<option value="memberName">이름</option>
			<option value="gender">성별</option>
		</select>
		<div id="search-memberId">
			<form action="<%=request.getContextPath()%>/admin/memberFinder">
				<input type="hidden" name="searchType" value="memberId" />
				<input type="search" name="searchKeyword" 
					   size="25" 
					   placeholder="검색할 아이디를 입력하세요"/>
				<input type="submit" value="검색" />
			</form>
		</div>
		<div id="search-memberName">
			<form action="<%=request.getContextPath()%>/admin/memberFinder">
				<input type="hidden" name="searchType" value="memberName" />
				<input type="search" name="searchKeyword" 
					   size="25" 
					   placeholder="검색할 회원명을 입력하세요"/>
				<input type="submit" value="검색" />
			</form>
		</div>
		<div id="search-gender">
			<form action="<%=request.getContextPath()%>/admin/memberFinder">
				<input type="hidden" name="searchType" value="gender" />
				<input type="radio" name="searchKeyword" value="M" checked/>
				남
				<input type="radio" name="searchKeyword" value="F"/>
				여
				<input type="submit" value="검색" />
			</form>
		</div>
		
		
	
	</div>
	
	
	<table id="tbl-member">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>성별</th>
				<th>나이</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>취미</th>
				<th>가입일자</th>
			</tr>
		</thead>
		<tbody>
		<% if(list==null || list.isEmpty()){ %>
            <tr>
                <td colspan="9" align="center"> 검색 결과가 없습니다. </td>
            </tr>
        <% 
            } 
            else {
                for(Member m : list){ 
        %>
            <tr>
                <td>
	                <a href="<%=request.getContextPath()%>/member/memberView?memberId=<%=m.getMemberId()%>">
		                <%=m.getMemberId()%>
	                </a>
	            </td>
                <td><%=m.getMemberName()%></td>
                <td><%="M".equals(m.getGender())?"남":"여"%></td>
                <td><%=m.getAge()%></td>
                <td><%=m.getEmail()!=null?m.getEmail():""%></td>
                <td><%=m.getPhone()%></td>
                <td><%=m.getAddress()!=null?m.getAddress():""%></td>
                <td><%=m.getHobby()!=null?m.getHobby():""%></td>
                <td><%=m.getEnrollDate()%></td>		
            </tr>		
        <%		} 
            }
        %>
		
		</tbody>
	</table>
	
	<div id="pageBar">
		<%=pageBar %>
	</div>
	
</section>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>