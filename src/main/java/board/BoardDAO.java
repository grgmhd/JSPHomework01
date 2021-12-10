package board;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import connect.ConnOracle;

public class BoardDAO extends ConnOracle {
	
	public BoardDAO() {
		super();
	}
	
	public List<BoardDTO> selectList(Map<String, Object> map) {		
		List<BoardDTO> sltResult = new Vector<BoardDTO>();
		
		String query = "SELECT * FROM board";
		
		if(map.get("srchWord") !=null) {
			query += " WHERE "+ map.get("srchField") + " "
					+ " LIKE '%" + map.get("srchWord") + "%' ";
		}
		
		query += " ORDER BY num DESC";
		
		try {
			stmt = conn.createStatement();
			rSet = stmt.executeQuery(query);
			
			while(rSet.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rSet.getString("num"));
				dto.setTitle(rSet.getString("title"));
				dto.setContent(rSet.getString("content"));
				dto.setId(rSet.getString("id"));
				dto.setPostdate(rSet.getDate("postdate"));
				dto.setVisitcount(rSet.getString("visitcount"));
				
				//리스트 컬렉션에 DTO 객체를 추가한다.
				sltResult.add(dto);
			}		
		}
		catch(Exception err) {
			System.out.println("게시물 조회 중 예외발생");
			err.printStackTrace();
		}
		return sltResult;
	}
	
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		
		String query = "SELECT board.*, member.name FROM member INNER JOIN board "
						+ " ON member.id=board.id WHERE num=?";
		
		try {
			psmt = conn.prepareStatement(query);
			psmt.setString(1, num);
			rSet = psmt.executeQuery();
			
			if(rSet.next()) {
				dto.setNum(rSet.getString("num"));
				dto.setTitle(rSet.getString("title"));
				dto.setContent(rSet.getString("content"));
				dto.setId(rSet.getString("id"));
				dto.setPostdate(rSet.getDate("postdate"));
				dto.setVisitcount(rSet.getString("visitcount"));
				dto.setName(rSet.getString("name"));
			}
		}
		catch(Exception err) {
			System.out.println("게시물 상세보기 중 예외발생");
			err.printStackTrace();
		}
		return dto;
	}
	
	public void updateVisitCount(String num) {
		String query = "UPDATE board SET visitcount=visitcount+1 WHERE num=?";
		
		try {
			psmt = conn.prepareStatement(query);
			psmt.setString(1, num);
			psmt.executeQuery();
		}
		catch(Exception err) {
			System.out.println("게시물 조회수 증가 중 예외발생");
			err.printStackTrace();
		}
	}
	
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			String query = "INSERT INTO board (num, title, content, id, visitcount) "
						+ " VALUES (seq_board_num.NEXTVAL, ?, ?, ?, 0)";
			
			psmt = conn.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			result = psmt.executeUpdate();			
		}
		catch(Exception err) {
			System.out.println("게시물 입력 중 예외발생");
			err.printStackTrace();
		}
		
		return result;
	}
	
	
}














