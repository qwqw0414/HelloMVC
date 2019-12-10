package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdatePasswordEndServlet
 */
@WebServlet(name="UpdatePasswordEndServlet",urlPatterns="/member/updatePasswordEnd")
public class UpdatePasswordEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePasswordEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 전송값 꺼내서 변수에 기록하기.
		//String javax.servlet.ServletRequest.getParameter(String arg0)
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String password_new = request.getParameter("password_new");
		
//		System.out.println(memberId);
//		System.out.println(password);
//		System.out.println(password_new);
		
		
		
		//2.서비스로직호출
		Member m = memberService.selectOne(memberId);
		
		//3. 현재패스워드를 맞게 입력했으면, 비밀번호를 업데이트함. 
		//그렇지 않으면, 다시 팝업창 url을 호출함.
		String msg = "";
		String loc = "";
		String view = "/WEB-INF/views/common/msg.jsp";
		if(m != null && m.getPassword().equals(password)){
			Member member = new Member();
			member.setMemberId(memberId);
			//현재 member객체에 갱신할 비밀번호를 업데이트
			member.setPassword(password_new);
			
			int result = memberService.updatePassword(member);
			if(result>0){
				msg = "패스워드 변경 성공";
				String script = "self.close()";
				//팝업창을 닫기위한 코드 추가
				request.setAttribute("script",script);
			}
				
		}
		else {
			msg = "패스워드를 잘못 입력하셨습니다.";
			loc = "/member/updatePassword?memberId="+memberId;
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		RequestDispatcher reqDispatcher = request.getRequestDispatcher(view);
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
