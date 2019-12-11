package board.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import board.model.dao.BoardDAO;
import board.model.vo.Board;

public class BoardService {

	public List<Board> selectBoardList(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<Board> list = new BoardDAO().selectBoardList(conn, cPage, numPerPage);
		close(conn);

		return list;
	}

	public int selectBoardCount() {
		Connection conn = getConnection();
		int totalContent = new BoardDAO().selectBoardCount(conn);
		close(conn);
		return totalContent;
	}

	public int insertBoard(Board b) {
		Connection conn = getConnection();
		int result = new BoardDAO().insertBoard(conn, b);
		// 트랜잭션 처리
		if (result > 0)
			commit(conn);
		else
			rollback(conn);

		close(conn);

		return result;
	}

	public Board selectOne(int boardNo, boolean hasRead) {
		Connection conn = getConnection();
		int result = 0;
		
		if(!hasRead) {
			result = new BoardDAO().increaseReadCount(conn, boardNo);
		}

		Board b = new BoardDAO().selectOne(conn, boardNo);

		if (result > 0)
			commit(conn);
		else
			rollback(conn);

		close(conn);

		return b;
	}
}
