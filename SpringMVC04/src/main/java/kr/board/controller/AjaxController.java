package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RestController  //json응답
public class AjaxController {

	@Autowired
	private BoardMapper mapper;
	
	
	//BoardController에 있던거 가지고옴
	@RequestMapping("/ajaxlist")
	public @ResponseBody List<Board> ajaxList(){
		// Request 요청이 오면 @ResponseBody가 응답을 해주겠다. 요청받은 곳으로 바로(foward/redirect로 가지 않고)
				// ajax라는 함수에 적인 success 시 ajaxList라는 함수를 실행시키고, dataType은 json으로 응답을 해주겠다.
		
		List<Board> list = mapper.ajaxList();

		
		return list;  // jsp(forward), Controller(redirect) 경로가 바뀜
					// ajax는 경로가 바뀌지 않고 그대로 넘어가야하니까 list그대로 넘겨줌
				// 이 list가 넘어가는 과정
				// list -> json변환 (API)  ==> ajax가 해주는일 // @ResponseBody 라는 것을 붙혀주면 바로 이 API를 실행 => 이 API는 jackson Databind를 다운받으면 잘됨
				// 이제 넘어가서 변환된 json 객체를 응답 
	}
	
	
	
}
