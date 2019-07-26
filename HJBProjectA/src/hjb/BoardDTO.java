package hjb;

import java.sql.Timestamp;

public class BoardDTO {
	private int num;
	private String id;
	private String name;
	private String title;
	private String content;
	private int readcount;
	private int thumbcount;
	private int replycount; // db에 없는 항목 reply테이블 참조하여 값 설정
	private Timestamp reg_date;
	private String fileAddr;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getThumbcount() {
		return thumbcount;
	}
	public void setThumbcount(int thumbcount) {
		this.thumbcount = thumbcount;
	}
	public int getReplycount() {
		return replycount;
	}
	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getFileAddr() {
		return fileAddr;
	}
	public void setFileAddr(String fileAddr) {
		this.fileAddr = fileAddr;
	}
}
