package hjb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public final static int LOGIN = 1;
	public final static int NO_ID = -1;
	public final static int WRONG_PW = -2;

	private String name = ""; // DTO.name

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int delete(String id, String pw) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("delete from member where id=? and pw=?");
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			printErr("delete", e);
		} finally {
			close();
		}
		return result;
	} // delete

	public int update(MemberDTO dto) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement(
					"update member set pw=?,name=?,birth=?,gender=?,email=?,tel=?,address=?,detailAddr=? where id=?");
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getBirth());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getAddress());
			pstmt.setString(8, dto.getDetailAddr());
			pstmt.setString(9, dto.getId());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			printErr("update", e);
		} finally {
			close();
		}
		return result;
	} // select update

	public MemberDTO select(String id) { // select *-pw
		MemberDTO dto = new MemberDTO();
		try {
			connect();
			name = "";
			pstmt = conn.prepareStatement(
					"select id,name,birth,gender,email,tel,address,detailAddr from member where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setId(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setBirth(rs.getString(3));
				dto.setGender(rs.getString(4));
				dto.setEmail(rs.getString(5));
				dto.setTel(rs.getString(6));
				dto.setAddress(rs.getString(7));
				dto.setDetailAddr(rs.getString(8));
			}
		} catch (Exception e) {
			printErr("select *-pw", e);
		} finally {
			close();
		}
		return dto;
	} // select *-pw

	public int select(String id, String pw) {
		int result = 0;
		try {
			connect();
			name = "";
			pstmt = conn.prepareStatement("select id from member where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (!rs.next()) {
				result = NO_ID;
			}
			if (result != NO_ID) {
				pstmt = conn.prepareStatement("select name from member where id=? and pw=?");
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					result = LOGIN;
					setName(rs.getString(1));
				} else {
					result = WRONG_PW;
				}
			}
		} catch (Exception e) {
			printErr("select id,pw", e);
		} finally {
			close();
		}
		return result;
	} // select id,pw

	public String selectAll() { // id모두 조회, 자바스크립트에서 조회용
		StringBuilder stB = new StringBuilder();
		try {
			connect();
			pstmt = conn.prepareStatement("select id from member");
			rs = pstmt.executeQuery();
			while (rs.next())
				stB.append("," + rs.getString(1));
		} catch (Exception e) {
			printErr("selectAll", e);
		} finally {
			close();
		}
		return stB.toString().substring(1);
	} // selectAll

	public int insert(MemberDTO dto) {
		int result = 0;
		try {
			connect();
			pstmt = conn.prepareStatement("insert into member (id,pw,name,birth,gender,email,tel,address,detailAddr) "
					+ "values(?,?,?,?,?,?,?,?,?) ");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getGender());
			pstmt.setString(6, dto.getEmail());
			pstmt.setString(7, dto.getTel());
			pstmt.setString(8, dto.getAddress());
			pstmt.setString(9, dto.getDetailAddr());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			printErr("insert", e);
		} finally {
			close();
		}
		return result;
	} // insert

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
		System.err.println(this.getClass().getName() + "." + methodName + "() ERROR");
		e.printStackTrace();
	} // printErr
}
