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
	public int countAll(){
		int count=0;
		try{
			connect();
			pstmt=conn.prepareStatement("select num from board");
			rs=pstmt.executeQuery();
			rs.last();
			count=rs.getRow();
		}catch(Exception e){
			printErr("selectAll",e);
		}finally{
				close();
		}
		return count;
	}
	public int insert(BoardDTO dto){
		int result=0;
		try{
			connect();
			pstmt=conn.prepareStatement("insert into board (id,name,title,content) values(?,?,?,?)");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			result=pstmt.executeUpdate();
		}catch(Exception e){
			printErr("update",e);
		}finally{
				close();
		}
		return result;
	}
	public void updateReadcount(int num){
		try{
			connect();
			pstmt=conn.prepareStatement("update board set readcount=readcount+1 where num=?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(Exception e){
			printErr("update",e);
		}finally{
				close();
		}
	}
	public int update(BoardDTO dto){
		int result=0;
		try{
			connect();
			pstmt=conn.prepareStatement("update board set title=?,content=? where num=? and id=?");
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			pstmt.setString(4, dto.getId());
			result=pstmt.executeUpdate();
		}catch(Exception e){
			printErr("update",e);
		}finally{
				close();
		}
		return result;
	}
	public BoardDTO select(int num){
		BoardDTO dto=null;
		try{
			connect();
			pstmt=conn.prepareStatement("select * from board where num=?");
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setTitle(rs.getString(4));
				dto.setContent(rs.getString(5));
				dto.setReadcount(rs.getInt(6));
				dto.setLikes(rs.getInt(7));
				dto.setReply(rs.getInt(8));
				dto.setReg_date(rs.getTimestamp(9));
			}
		}catch(Exception e){
			printErr("selectAll",e);
		}finally{
				close();
		}
		return dto;
	}
	public ArrayList<BoardDTO> select(int pageNum,int pageSize){
		ArrayList<BoardDTO> list=new ArrayList<BoardDTO>();
		BoardDTO dto;
		try{
			connect();
			pstmt=conn.prepareStatement("select num,name,title,readcount,likes,reply,reg_date from board ORDER BY num desc LIMIT "+(pageNum-1)*pageSize+","+pageSize);
			rs=pstmt.executeQuery();
			while(rs.next()){
				dto=new BoardDTO();
				dto.setNum(rs.getInt(1));
//				dto.setId(rs.getString(-));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
//				dto.setContent(rs.getString(-));
				dto.setReadcount(rs.getInt(4));
				dto.setLikes(rs.getInt(5));
				dto.setReply(rs.getInt(6));
				dto.setReg_date(rs.getTimestamp(7));
				list.add(dto);
			}
		}catch(Exception e){
			printErr("selectPageSize",e);
		}finally{
				close();
		}
		return list;
	} // selectAll
	public void connect() throws Exception{ // share
		conn=((DataSource)new InitialContext()
				.lookup("java:comp/env/jdbc/hjb"))
				.getConnection();
	} // connect
	public void close(){
		try{
		if(conn!=null){conn.close();}
		if(pstmt!=null){pstmt.close();}
		if(rs!=null){rs.close();}
		}catch(Exception e){
			printErr("DAO.closeErr",e);
		}
	} // close
	public void printErr(String methodName,Exception e){
		System.out.println(this.getClass().getName()+"."+methodName+"()�뿉�꽌 �뿉�윭");
		e.printStackTrace();
	} // printErr
}
