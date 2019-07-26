package hjb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	final int OPTION_TITLE = 1;
	final int OPTION_CONTENT = 2;

	// selectviewed
	public BoardDTO selectviewed() {
		BoardDTO dto = null;
		try {
			connect();
			pstmt = conn.prepareStatement(
					"select num,title,content from board order by readcount desc, reg_date desc limit 0,1;");

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				String[] strArr = rs.getString(3).split("\n");
				int length = strArr.length > 3 ? 3 : strArr.length;
				String str = "";
				for (int i = 0; i < length; i++) {
					str += strArr[i] + "<br>";
				}
				dto.setContent(str);
			}
		} catch (Exception e) {
			printErr("selectviewed", e);
		} finally {
			close();
		}
		return dto;
	} // selectviewed
	// selectrecommended

	public BoardDTO selectrecommended() {
		BoardDTO dto = null;
		try {
			connect();
			pstmt = conn.prepareStatement(
					"select num,title,content from board order by (select count(board_num) from thumb where board_num=num) desc,reg_date desc limit 0,1;");

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				String[] strArr = rs.getString(3).split("\n");
				int length = strArr.length > 3 ? 3 : strArr.length;
				String str = "";
				for (int i = 0; i < length; i++) {
					str += strArr[i] + "<br>";
				}
				dto.setContent(str);
			}
		} catch (Exception e) {
			printErr("selectrecommended", e);
		} finally {
			close();
		}
		return dto;
	} // selectrecommended
	// selectRecent

	public BoardDTO selectRecnt() {
		BoardDTO dto = null;
		try {
			connect();
			pstmt = conn.prepareStatement("select num,title,content from board order by reg_date desc limit 0,1");

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				String[] strArr = rs.getString(3).split("\n");
				int length = strArr.length > 3 ? 3 : strArr.length;
				String str = "";
				for (int i = 0; i < length; i++) {
					str += strArr[i] + "<br>";
				}
				dto.setContent(str);
			}
		} catch (Exception e) {
			printErr("selectRecent", e);
		} finally {
			close();
		}
		return dto;
	} // selectRecent

	public int countAll(String[] str, int option) {
		int count = 0;
		try {
			connect();
			String sql = "select num from board where";
			switch (option) {
			case OPTION_TITLE:
				for (int i = 0; i < str.length; i++) {
					sql += " title like '%" + str[i] + "%' or";
				}
				break;
			case OPTION_CONTENT:
				for (int i = 0; i < str.length; i++) {
					sql += " content like '%" + str[i] + "%' or";
				}
				break;
			default:
				for (int i = 0; i < str.length; i++) {
					sql += " title like '%" + str[i] + "%' or content like '%" + str[i] + "%' or";
				}
				break;
			}

			pstmt = conn.prepareStatement(sql.substring(0, sql.length() - 2));
			rs = pstmt.executeQuery();
			rs.last();
			count = rs.getRow();
		} catch (Exception e) {
			printErr("countAll(str)", e);
		} finally {
			close();
		}
		return count;
	} // countAll

	public int countAll() {
		int count = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("select num from board");
			rs = pstmt.executeQuery();
			rs.last();
			count = rs.getRow();
		} catch (Exception e) {
			printErr("countAll", e);
		} finally {
			close();
		}
		return count;
	} // countAll

	public int insert(BoardDTO dto) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("insert into board (id,name,title,content,fileAddr) values(?,?,?,?,?)");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFileAddr());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("insert", e);
		} finally {
			close();
		}
		return result;
	} // insert

	public int delete(String num, String id) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("delete from board where num=? and id=?");
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
			if (result > 0) {
				pstmt = conn.prepareStatement("delete from reply where board_num=?");
				pstmt.setInt(1, Integer.parseInt(num));
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			printErr("delete", e);
		} finally {
			close();
		}
		return result;
	} // delete

	public void updateReadcount(int num) {
		try {
			connect();
			pstmt = conn.prepareStatement("update board set readcount=readcount+1 where num=?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("updateReadCouny", e);
		} finally {
			close();
		}
	} // updateReadCouny

	public int update(BoardDTO dto) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("update board set title=?,content=?,fileAddr=?  where num=? and id=?");
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFileAddr());
			pstmt.setInt(4, dto.getNum());
			pstmt.setString(5, dto.getId());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("update", e);
		} finally {
			close();
		}
		return result;
	} // update

	// 게시글 클릭
	public BoardDTO select(int num) {
		BoardDTO dto = null;
		try {
			connect();
			pstmt = conn.prepareStatement("select * from board where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setTitle(rs.getString(4));
				dto.setContent(rs.getString(5));
				dto.setReadcount(rs.getInt(6));
				// dto.setThumbcount(rs.getInt(7));
				// dto.setReplycount(rs.getInt(8));
				dto.setReg_date(rs.getTimestamp(7));
				dto.setFileAddr(rs.getString(8));
			}
		} catch (Exception e) {
			printErr("select", e);
		} finally {
			close();
		}
		return dto;
	} // select Title

	// 게시글 찾기 with 검색
	public ArrayList<BoardDTO> select(int pageNum, int pageSize, String[] str, int option) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		BoardDTO dto;
		try {
			connect();
			String sql = "select num,name,title,readcount,(select count(board_num) from thumb where board_num=num),"
					+ "(select count(board_num) from reply where board_num=num),reg_date,fileAddr"
					+ " from board where";
			switch (option) {
			case OPTION_TITLE:
				for (int i = 0; i < str.length; i++) {
					sql += " title like '%" + str[i] + "%' or";
				}
				break;
			case OPTION_CONTENT:
				for (int i = 0; i < str.length; i++) {
					sql += " content like '%" + str[i] + "%' or";
				}
				break;
			default:
				for (int i = 0; i < str.length; i++) {
					sql += " title like '%" + str[i] + "%' or content like '%" + str[i] + "%' or";
				}
				break;
			}

			pstmt = conn.prepareStatement(sql.substring(0, sql.length() - 2) + " ORDER BY num desc LIMIT "
					+ (pageNum - 1) * pageSize + "," + pageSize);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				// dto.setId(rs.getString(-));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				// dto.setContent(rs.getString(-));
				dto.setReadcount(rs.getInt(4));
				dto.setThumbcount(rs.getInt(5));
				dto.setReplycount(rs.getInt(6));
				dto.setReg_date(rs.getTimestamp(7));
				dto.setFileAddr(rs.getString(8));
				list.add(dto);
			}
		} catch (Exception e) {
			printErr("selectPageSize", e);
		} finally {
			close();
		}
		return list;
	} // select Page

	// 게시글 찾기
	public ArrayList<BoardDTO> select(int pageNum, int pageSize) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		BoardDTO dto;
		try {
			// "select num,name,title,readcount,thumbcount,replycount,reg_date
			// from board ORDER BY num desc LIMIT "
			// + (pageNum - 1) * pageSize + "," + pageSize);
			connect();
			pstmt = conn.prepareStatement(
					"select num,name,title,readcount,(select count(board_num) from thumb where board_num=num),"
							+ "(select count(board_num) from reply where board_num=num),reg_date,fileAddr"
							+ " from board ORDER BY num desc LIMIT " + (pageNum - 1) * pageSize + "," + pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				// dto.setId(rs.getString(-));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				// dto.setContent(rs.getString(-));
				dto.setReadcount(rs.getInt(4));
				dto.setThumbcount(rs.getInt(5));
				dto.setReplycount(rs.getInt(6));
				dto.setReg_date(rs.getTimestamp(7));
				dto.setFileAddr(rs.getString(8));
				list.add(dto);
			}
		} catch (Exception e) {
			printErr("selectPageSize", e);
		} finally {
			close();
		}
		return list;
	} // select Page

	// public share method
	public void connect() throws Exception {
		conn = ((DataSource) new InitialContext().lookup("java:comp/env/jdbc/hjb")).getConnection();
	} // connect

	public void close() {
		try {
			if (conn != null) {
				conn.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			printErr("close", e);
		}
	} // close

	public void printErr(String methodName, Exception e) {
		System.out.println(this.getClass().getName() + "." + methodName + "() ERROR");
		e.printStackTrace();
	} // printErr
}
