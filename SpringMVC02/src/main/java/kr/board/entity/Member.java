package kr.board.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private int idx ; // 일련번호(자동증가 컬럼)
	private String username; // 아이디
	private String password; // 비밀번호 : 12345(평문) =>DB에 a#12ssaa(암호화해서 넣어야함 : api존재)
	private String name ; // 이름
	private String email; // 이메일 주소
	
	
	
	
}
