package kr.board.entity;

import lombok.Data;

@Data
public class Criteria {

	private int page;  // 현재 페이지 번호
	private int perPageNum; //한 페이지에 보여질 게시글의 수
	
	// 생성자 만들어주기
	public Criteria() {
		this.page = 1;
		this.perPageNum = 5; // 한 페이지에 10개씩 보여줄꺼다.(추후 숫자 조정)
	}
	// 현재 페이지의 게시글의 시작번호 
	
	public int getPageStart() {	//  1page  2page  3page
								//   1-10  11-20  21-30
//		return ((page-1) * perPageNum)+1; //여기서 각 게시글 시작번호(1,11,21)가 나오게 계산
		
						//limit기준   0-9   10-19  20-29
		return ((page-1) * perPageNum); //여기서 각 게시글 시작번호(0,10,20)가 나오게 계산(+1없앰) 
	}
	
	
}
