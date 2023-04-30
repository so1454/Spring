package kr.board.entity;

import lombok.Data;

// 페이징 처리를 만드는 클래스(< 1 2 3 4 5 >)
// 되게 중요한 클래스
@Data
public class PageMaker {

	private Criteria cri ;
	private int totalCount; // 총 게시글의 수 (이걸 어떤식으로 찾을 수 있을까)
					// 총 게시글 수 가 31개 라고 하면
	private int displayPageNum = 5; // 화면에 보여질 페이지의 수
	private int startPage; // 시작 페이지 번호(조정)
			// 해당 페이지가 3페이지야 근데 스타트 번호는 1이야 / 2페이지도 1 / 4페이지도 1 이런식으로 된다는 걸 얘가 표현해주는 거임
	private int endPage ; // 끝 페이지 번호(조정)
			// 해당 페이지가 3이야 끝이 페이지 번호는 5야/해당 페이지 2 끝 5 / 위랑 같음!
	private boolean prev; // 이전 버튼(true, false)
	private boolean next; // 다음 버튼(true, false)
	
	// 총 게시글의 수를 저장하는 메소드
	public void setTotalCount( int totalCount) {
		this.totalCount = totalCount; // 전체 레코드 수가 구해져야지 다른 아이들이 구해지니까 만들어주는 거라고
		pageCalc();
	
	}
	private void pageCalc() {
		// 여기서 계산을 다 할꺼다.
		
		// 1. 화면에 보여질 마지막 페이지 번호 계산
		endPage=(int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum); 
//			EX. 만약 5페이지를 클릭했는데 보여질 페이지가 10이라면/ 5/10 = 0.5에서 ceil하면 1.0으로 감-> * displayPageNum인 10을 곱해주면 10!
				// 이런식으로 마지막 페이지를 구한다.
		
		// 2. 화면에 보여질 시작 페이지 번호
		startPage=(endPage-displayPageNum)+1;
		if(startPage<=0) startPage=1;
		
		
		// 3. 전체 마지막 페이지 계산
		int tempEndPage=(int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		
		// 4. 화면에 보여질 마지막 페이지 유효성 검사(조정단계) 이게 해당 페이지의 endPage가 진짜로 맞는지 따져봄
		// 그리고 만약 진짜 끝페이지가 아니라면 endPage를 tempEndPage로 바꿔주라!(집어넣어 줘서 조정)
		if(tempEndPage<endPage) {
		endPage=tempEndPage;
		}
		
		// 5.이전페이지 버튼의 존재 여부
		// 삼항 연산자 start페이지가 1이 맞으면 false(이전 버튼이 안나옴) 거짓이면 true(이전 버튼이 나옴)이다.
		// 1 페이지 이후에 10페이지 이상부터 이전 버튼이 필요하니까
		prev=(startPage==1) ? false : true;
		
		
		// 6.다음페이지 버튼의 존재 여부
		next=(endPage<tempEndPage) ? true : false;
		
	}
	
}
