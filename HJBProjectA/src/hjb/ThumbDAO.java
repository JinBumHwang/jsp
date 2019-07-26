package hjb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ThumbDAO {
	// DTO (board_num,id)가 전부라서 클래스 정의하지 않음
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	public boolean select(int board_num,String id) {
		try {
			connect();
			pstmt = conn.prepareStatement("select board_num from thumb where board_num=? and id=?");
			pstmt.setInt(1, board_num);
			pstmt.setString(2, id);
			rs=pstmt.executeQuery();
			return rs.next();
		} catch (Exception e) {
			printErr("insert", e);
		} finally {
			close();
		}
		return false;
	} // insert
	public int insert(int board_num,String id) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("insert into thumb (board_num,id) values(?,?)");
			pstmt.setInt(1, board_num);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("insert", e);
		} finally {
			close();
		}
		return result;
	} // insert
	public int delete(int board_num,String id) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("delete from thumb where board_num=? and id=?");
			pstmt.setInt(1, board_num);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("insert", e);
		} finally {
			close();
		}
		return result;
	} // delete
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
