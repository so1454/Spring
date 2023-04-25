package kr.board.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 게시판(Object) : 번호 , 제목, 내용, 작성자, 작성일, 조회수 ..
@Data//-> lombok anotation으로 생성자 대신 해주기
@AllArgsConstructor  // 모든 매개변수를 전부 받아서 초기화 할 수 있는 생성자를 만들고 싶다!(기본생성자)
@NoArgsConstructor
public class Board {

	private int num;
	private String username;
	private String title;
	private String content;
	private String writer;
	private Date indate;  // util꺼 임포트하기!
	private int count;
	// 답변형 게시판 추가
	private int bgroup;
	private int bseq;
	private int blevel;
	private int bdelete;
	
	// Lombok API 다운로드 받자(Maven Repository에서 다운로드 받음)
	
	
	
}
