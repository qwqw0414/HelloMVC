package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.service.AdminService;
import member.model.vo.Member;

/**
 * Paging Recipe
 * 
 * 
 * 공식1: 
 * 공식2: 
 * 공식3: 
 * 
 * 
 * -Contents영역
 * 1. cPage 현재페이지번호
 * 2. numPerPage 페이지당게시물수  10
 * 
 * -PagingBar영역
 * 3.totalContents 총게시물수 115
 * 4.totalPage 총페이지수  115/10 -> 올림(11.5)
 * 5.pageBarSize
 * 5.pageStart/pageEnd 
 * 6.pageNo
 * 
 * 
 */
@WebServlet("/admin/memberList")
public class AdminMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자입력값 처리
		int cPage = 1;//초기값 설정
		final int numPerPage = 10; 
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));			
		} catch(NumberFormatException e) {
			//cPage입력값이 없거나, 부정입력한 경우 기본값으로 처리된다.
		}
//		System.out.println("cPage@list="+cPage);
		
		//페이징바영역처리
		int totalContent = new AdminService().selectTotalContent();
		int totalPage = (int)Math.ceil((double)totalContent/numPerPage);//(공식2)
//		System.out.printf("totalContent=%s, totalPage=%s%n", totalContent, totalPage);
		
		String pageBar = "";
		int pageBarSize = 5;
		// 	   1 2 3 4 5(다음)
		//(이전)6 7 8 9 10(다음)
		//(이전)11 12 
		//cPage, pageBarSize => pageStart
		//1, 5 => 1 => (5*0)+1
		//2, 5 => 1
		//3, 5 => 1
		//6, 5 => 6 => (5*1)+1
		//7, 5 => 6
		//8, 5 => 6
		//11, 5 => 11 => (5*2)+1
		//12, 5 => 11
		//(공식3)
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize + 1;
		int pageEnd = pageStart+pageBarSize-1;
		
		//증감변수 pageNo
		int pageNo = pageStart;
		
		//1.이전
		if(pageNo != 1) {
			pageBar += "<a href='"+request.getContextPath()+"/admin/memberList?cPage="+(pageNo-1)+"'>[이전]</a>\n";
		}
		
		//2.pageNo
		while(pageNo<=pageEnd && pageNo<=totalPage) {
			//현재페이지인 경우
			if(cPage == pageNo) {
				pageBar += "<span class='cPage'>"+pageNo+"</span>\n";
			}
			else {
				pageBar += "<a href='"+request.getContextPath()+"/admin/memberList?cPage="+pageNo+"'>"+pageNo+"</a>\n";				
			}
			
			pageNo++;
		}
		
		//3.다음
		if(pageNo <= totalPage) {
			pageBar += "<a href='"+request.getContextPath()+"/admin/memberList?cPage="+pageNo+"'>[다음]</a>\n";							
		}
		
		//3.업무로직
		List<Member> list = new AdminService().selectMemberList(cPage, numPerPage);
		request.setAttribute("list",list);
		request.setAttribute("pageBar", pageBar);
		
		//4.view단처리
		request.getRequestDispatcher("/WEB-INF/views/admin/memberList.jsp")
			   .forward(request, response);
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
