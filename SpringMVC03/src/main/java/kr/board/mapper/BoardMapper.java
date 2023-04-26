package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;
import kr.board.entity.Criteria;
import kr.board.entity.Member;

// 요런 흐름으로 배우고 있다.
// JDBC -> MyBatis -> Mybatis-spring -? spring JPA

	// 인터페이스로 변경 -> 암튼 인터페이스 기반에 프로그램이 스프링이라고
public interface BoardMapper { //Dao말고 연결한다는거 -> mapper라고 해야함
							

	// 데이터베이스 연결작업은 여기서 (X) -> 설정에서 해줄꺼임
	// 게시판 전체 리스트 가져오기
	public List<Board> getLists(Criteria cri);
	
		// 연결 객체(Connection, = mybatis -> sqlSession)를 가져오기
		// SQL문장 전송 : PreparedStatement(?) -> #{ }
		// SQL결과 집합 : ResultSet, next()
		// 레코드 한개 씩--> Board --> List<Board> : while( )
		// return list;
			
//		//이게 마이바티스
//		sqlSession session = sqlSessionFactory.openSession();
//		List<Board> list = session.selectList("getLists");
//		session.close();
		
		// 스프링은 마이바티스에서 해야하는 작업을 API에서 다 해줌
		// 그래서 여기는 없어도 되는 공간이 됨
	
	
	//게시물을 등록하는 메서드 정의
	public void register(Board vo);
	
	// 선택한 번호에 해당하는 게시물 1개를 가져오는 메서드를 정의해야한다.
	public Board get(int num); // Board에서 num을 가져오니까 리턴타입이 Board임
	
	// 간단한 sql문의 경우 이런식으로 어노테이션을 사용해서 적어주면 됨
	@Update("update reply set bdelete = 1 where num = #{num}")
	public void remove(int num);
	
	// 게시물 수정하기
	public void modify(Board vo);
	
	
	// 조회수 +1 시켜주기
	@Update("update reply set count=count+1 where num = #{num}")
	public void count(int num);
	
	//-----------------------------
	// 회원 로그인 처리 메서드 정의
	// 아이디와 패스워드가 일치하는 회원이 있으면 성공한 회원의 Member정보가 넘어감
	@Select("select * from Member where username = #{username} and password=#{password}")
	public Member login(Member mvo);
	
	// 시퀀스 +1씩 추가해주는거
	public void replySeqUp(Board parent);
	
	
	public void replyInsert(Board vo);
	
}


