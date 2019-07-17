package hjb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	public final static int LOGIN=1;
	public final static int NO_ID=-1;
	public final static int WRONG_PW=-2;
	
	private String name=""; // DTO.name
	

	public MemberDAO(){}
//	public void printLn(){ // println(selectQuery);
//		try{
//			connect();
//			pstmt=conn.prepareStatement("select * from member");
//			rs=pstmt.executeQuery();
//			while(rs.next()){
//				System.err.println("num :"+rs.getInt(1));
//				System.err.println("id :"+rs.getString(2));
//				System.err.println("pw :"+rs.getString(3));
//				System.err.println("name :"+rs.getString(4));
//				System.err.println("birth :"+rs.getString(5));
//				System.err.println("gender :"+rs.getString(6));
//				System.err.println("email :"+rs.getString(7));
//				System.err.println("tel :"+rs.getString(8));
//				System.err.println("address :"+rs.getString(9));
//				System.err.println("detailAddr :"+rs.getString(10));
//			}
//			
//		}catch(Exception e){
//			printErr("selectPrintln",e);
//		}finally{
//				close();
//		}
//	} // selectPrintln
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name=name;
	}
	public int update(MemberDTO dto){ // select id,pw
		int result=0;
		try{
			connect();
			pstmt=conn.prepareStatement
					("update member set pw=?,name=?,birth=?,gender=?,email=?,tel=?,address=?,detailAddr=? where id=?");
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getBirth());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getAddress());
			pstmt.setString(8, dto.getDetailAddr());
			pstmt.setString(9, dto.getId());
			result=pstmt.executeUpdate();
			
		}catch(Exception e){
			printErr("update",e);
		}finally{
				close();
		}
		return result;
	} // select id,pw
	public MemberDTO select(String id){// select *-id,pw
		MemberDTO dto=new MemberDTO();
		try{
			connect();
			name="";
			pstmt=conn.prepareStatement
					("select id,name,birth,gender,email,tel,address,detailAddr from member where id=?");
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto.setId(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setBirth(rs.getString(3));
				dto.setGender(rs.getString(4));
				dto.setEmail(rs.getString(5));
				dto.setTel(rs.getString(6));
				dto.setAddress(rs.getString(7));
				dto.setDetailAddr(rs.getString(8));
			}
		}catch(Exception e){
			printErr("selectOthers",e);
		}finally{
				close();
		}
		return dto;
	} // select *-id,pw
	public int select(String id,String pw){ // select id,pw
		int result=0;
		try{
			connect();
			name="";
			pstmt=conn.prepareStatement("select id from member where id=?");
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(!rs.next()){
				result=NO_ID;
			}
			if(result!=NO_ID){
				pstmt=conn.prepareStatement("select name from member where id=? and pw=?");
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				rs=pstmt.executeQuery();
				if(rs.next()){
					result=LOGIN;
					setName(rs.getString(1));
				}else{
					result=WRONG_PW;
				}
			}
		}catch(Exception e){
			printErr("selectID_PW",e);
		}finally{
				close();
		}
		return result;
	} // select id,pw
	public String selectAll(){ // id以묐났泥댄겕, js �쟾�떖�슜
		StringBuilder stB=new StringBuilder();
		try{
			connect();
			pstmt=conn.prepareStatement("select id from board");
			rs=pstmt.executeQuery();
			while(rs.next())
			stB.append(","+rs.getString(1));
		}catch(Exception e){
			printErr("selectPrintln",e);
		}finally{
				close();
		}
		return stB.toString().substring(1);
	} // selectAll
	
	public int insert(MemberDTO dto){
		int result=0;
		try{
			connect();
			pstmt=conn.prepareStatement
					("insert into member (id,pw,name,birth,gender,email,tel,address,detailAddr) "
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
			result=pstmt.executeUpdate();
			
		}catch(Exception e){
			printErr("insert",e);
		}finally{
			close();
		}
		return result;
	} // insert
	public void insert10(){ // test
		try{
			connect();
			pstmt=conn.prepareStatement("insert into member (id,pw,name,birth,gender) "
					+ "values(?,?,?,?,?)");
			String tmp=String.format("%06d",System.currentTimeMillis()%1000000);
			for(int i = 1 ; i<11;i++){
				pstmt.setString(1, "id"+tmp+i);
				pstmt.setString(2, "pw"+i);
				pstmt.setString(3, "name"+i);
				pstmt.setString(4, "birth"+i);
				pstmt.setString(5, "gender"+i);
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			printErr("insert10",e);
		}
	} // test
	
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
		System.err.println(this.getClass().getName()+"."+methodName+"()�뿉�꽌 �삤瑜�");
		e.printStackTrace();
	} // printErr
}
