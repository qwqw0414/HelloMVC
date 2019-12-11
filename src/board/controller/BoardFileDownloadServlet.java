package board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/fileDownload")
public class BoardFileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 파라미터 핸들링
		String rName = request.getParameter("rName");
		String oName = request.getParameter("oName");
		System.out.println("rName:"+rName+", oName:"+oName);
		//2. 파일 입출력스트림
		//입력스트림: 서버pc에 renamedFileName으로 저장된 파일을 읽어온다
		//출력스트림: 응답객체에 읽어온 파일을 쓴다
		String saveDirectory = getServletContext().getRealPath("/upload/board");
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(saveDirectory+File.separator+rName));
		ServletOutputStream sos = response.getOutputStream();//d응답객체의 출력스트림
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		//3. response헤더 작성
		String resFileName = "";
		boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE")!=-1
				|| request.getHeader("user-agent").indexOf("Trident")!=-1 ;
		if(isMSIE) {
			resFileName = URLEncoder.encode(oName, "utf-8");//유니코드 %문자로 변경
			//공백이 +로 치환됨 -> 이를 다시 %20으로 변경
			resFileName = resFileName.replaceAll("\\+", "%20");
		} else {
			resFileName = new String(oName.getBytes("utf-8"), "iso-8859-1");
		}
		response.setContentType("application/octet-stream");//이진데이터를 가리키는 MIME타입
		response.setHeader("Content-Disposition", "attachment;filename="+resFileName);
		//4. 파일 입출력&자원반납
		int read = -1;
		while((read=bis.read())!=-1) {
			bos.write(read);
		}
		bos.close();
		bis.close();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
