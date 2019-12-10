package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberViewServlet
 */
@WebServlet(urlPatterns="/member/memberView", name="MemberViewServlet")
public class MemberViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1.encoding
		request.setCharacterEncoding("utf-8");
		
		//2.parameter handling
		String memberId = request.getParameter("memberId");
		
		//3.business logic
		Member m = new MemberService().selectOne(memberId);
		System.out.println("member@memberViewServlet="+m);
		
		//4.view단
		String view = "";
		
		//조회된 회원이 있는 경우
		if(m != null) {
			view = "/WEB-INF/views/member/memberView.jsp";
			//조회된 회원 속성으로 저장
			request.setAttribute("member", m);
		}
		//조회된 회원이 없는 경우
		else {
			view = "/WEB-INF/views/common/msg.jsp";
			
			String loc = "/";
			String msg = "해당회원이 없습니다.";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
		}
		
		RequestDispatcher reqDispatcher 
			= request.getRequestDispatcher(view);
		reqDispatcher.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
