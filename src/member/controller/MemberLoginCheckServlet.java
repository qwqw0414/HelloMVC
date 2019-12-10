package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * servlet3.x부터 지원하는 어노테이션 등록방식
 * <br>
 * 
 * <h2>servlet&jsp 내장객체 scope</h2>
 * <hr>
 * 
 *     type                        			jsp         	servlet
 * ------------------------------------------------------------------------------
 * javax.servlet.jsp.PageContext       		pageContext       X
 * javax.servlet.http.HttpServletRequest    request         request(doGet/doPost메소드의 파라미터로 전달)
 * javax.servlet.http.HttpSession      		session         request.getSession()
 * javax.servlet.ServletContext        		application     getServletContext()(GenericServlet메소드)
 * 
 * <hr>
 * 
 * 세션:
 * 관련자원은 모두 서버에서 관리하고, sessionId값만 쿠키를 통해 브라우져에게 전달
 * 
 * 쿠키:
 * 쿠키생성만 서버에서 관여, 모든 자원은 브라우져에서 관리.
 * 쿠키최대용량은 브라우져별로 상이하지만, 모든 브라우져에서 호환되려면,
 * 도메인당 50개, 개당크기는 4kb를 넘지 않도록 해야한다.
 *
 */
@WebServlet(name="MemberLoginCheckServlet",
			urlPatterns="/member/loginCheck")
public class MemberLoginCheckServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, 
					   HttpServletResponse response) 
						throws ServletException, IOException{
		//1.encoding
		request.setCharacterEncoding("utf-8");
		
		//2.parameter
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		System.out.println("memberId="+memberId);
		System.out.println("password="+password);
		
		//3.businessLogic
		Member m = new MemberService().selectOne(memberId);
//		System.out.println("member@loginServlet="+m);
		
		String msg = "";
		String loc = "/";
		RequestDispatcher reqDispatcher 
			= request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		
		//아이디가 존재하지 않는 경우 => 로그인 실패
		if(m == null) {
			msg = "존재하지 않는 아이디입니다.";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			reqDispatcher.forward(request, response);
			
		}
		else {
			//사용자입력비번과 db회원정보비번 비교
			//비번이 틀린 경우 =>  로그인 실패
			if(!m.getPassword().equals(password)) {
				msg = "비밀번호가 틀렸습니다.";
				request.setAttribute("msg", msg);
				request.setAttribute("loc", loc);
				reqDispatcher.forward(request, response);
				
			}
			//아이디/비번이 모두 일치한 경우 => 로그인 성공
			else {
				//세션이 있으면, 해당세션을 리턴하고, 없으면, 새로생성해서 리턴
				HttpSession session = request.getSession(true);
				System.out.println("SESSIONID="+session.getId());
				//세션에 로그인한 회원객체 속성으로 저장
				session.setAttribute("memberLoggedIn", m);
				
				//session유효시간 설정: 초단위
				session.setMaxInactiveInterval(60*30);
				
				//아이디저장 쿠키관련
				//체크된경우:"on", 체크되지 않은 경우:null
				String saveId = request.getParameter("saveId");
//				System.out.println("saveId@loginServlet="+saveId);
				
				//체크한경우
				if(saveId != null) {
					Cookie c = new Cookie("saveId", memberId);
					c.setMaxAge(7*24*60*60);//7일후 소멸
					c.setPath("/");//쿠키사용디렉토리. 도메인 전역에서 사용함.
					response.addCookie(c);
				}
				//체크하지 않은 경우
				else {
					Cookie c = new Cookie("saveId", memberId);
					c.setMaxAge(0);//삭제를 위해 유효기간을 0으로 설정
					c.setPath("/");
					response.addCookie(c);
				}
				
				
				
				
				//포워딩이아닌 리다이렉트처리
				//3xx status code를 리턴.
				//클라이언트에게 해당주소로 재요청하게 함.
				response.sendRedirect(request.getContextPath());
				
			}
			
		}
		
		
		//4.view
	}
	
	public void doGet(HttpServletRequest request, 
			   HttpServletResponse response) 
				throws ServletException, IOException{
		doPost(request, response);
	}
	
}






