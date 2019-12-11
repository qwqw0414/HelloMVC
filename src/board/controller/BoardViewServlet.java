package board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.View;

import board.model.service.BoardService;
import board.model.vo.Board;

/**
 * Servlet implementation class BoardViewServlet
 */
@WebServlet("/board/boardView")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		//게시글 상세보기 관련 쿠키처리
		Cookie[] cookies = request.getCookies();
		String boardCookieVal = "";
		boolean hasRead = false;
		
		//첫게시판 방문시, 아무런 쿠키가 없다. jssessionid값도 없다.
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				
				if("boardCookie".equals(name)) {
					
					boardCookieVal = value;
					
					if(value.contains("|"+boardNo+"|")) {
						
						hasRead = true;
						
					}
				}
			}
		}
		
//		쿠키생성
		
		//이 게시글을 읽은 적이 없다면, 쿠키 재생성
		if(!hasRead) {
//			Session cookie
//				setMaxAge를 설정하지 않은 경우. 클라이언트 닫는 경우 소멸.
//				setMaxAge(-1)과 동일. 기본값.
//			persistent cookie :
//				setMaxAge를 설치한 경우, 지정한 시각까지 영속함.
			Cookie boardCookie = new Cookie("boardCookie", boardCookieVal + "|" + boardNo + "|");
			boardCookie.setPath(request.getContextPath()+"/board");
			boardCookie.setMaxAge(365*24*60*60);
			response.addCookie(boardCookie);
		}
		
		Board b = new BoardService().selectOne(boardNo, hasRead);
		
		String view = "";
		
		if(b == null) {
			request.setAttribute("msg", "조회한 게시글이 존재하지 않습니다.");
			request.setAttribute("loc", "/board/boardList");
			view = "/WEB-INF/views/common/msg.jsp";
		}
		else {
			request.setAttribute("board", b);
			view = "/WEB-INF/views/board/boardView.jsp";
		}
		
		request.setAttribute("board",b);
		request.getRequestDispatcher(view)
		       .forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
