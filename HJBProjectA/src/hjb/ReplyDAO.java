package hjb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReplyDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public int insert(ReplyDTO dto) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("insert into reply (board_num,id,name,reply) values(?,?,?,?)");
			pstmt.setInt(1, dto.getBoard_num());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getReply());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("insert", e);
		} finally {
			close();
		}
		return result;
	} // insert

	public int delete(int reply_num, int board_num, String id) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("delete from reply where reply_num=? and id=?");
			pstmt.setInt(1, reply_num);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("delete", e);
		} finally {
			close();
		}
		return result;
	} // delete


	public ArrayList<ReplyDTO> select(int board_num) {
		ArrayList<ReplyDTO> list=new ArrayList<ReplyDTO>();
		ReplyDTO dto;
		try {
			connect();
			pstmt = conn.prepareStatement("select * from reply where board_num=? order by reply_num desc");
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto= new ReplyDTO();
				dto.setReply_num(rs.getInt(1));
				dto.setBoard_num(rs.getInt(2));
				dto.setId(rs.getString(3));
				dto.setName(rs.getString(4));
				dto.setReply(rs.getString(5));
				dto.setReg_date(rs.getTimestamp(6));
				list.add(dto);
			}
		} catch (Exception e) {
			printErr("select", e);
		} finally {
			close();
		}
		return list;
	} // select Title

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
