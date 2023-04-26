package kr.board.entity;

// 페이징 처리를 만드는 클래스(< 1 2 3 4 5 >)
// 되게 중요한 클래스
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
	
	
	
}
