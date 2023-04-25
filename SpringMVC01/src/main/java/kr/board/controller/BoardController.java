package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller // pojo를 컨트롤러로 인식을 시키려면 이 annotation이 꼭 필요! -> 이게 있어야 스프링은 컨트롤러로 인식한다.
public class BoardController {  
	// Service (X) -> Controller(POJO 일반 자바로 만들어진 컨트롤러) ex) 실제로 일처리를 하는 알바생들
	// 프론트 컨트롤러는 서블릿 => 스프링에서 사용(x) -> pojo


	@Autowired
	// 메모리에 만들어진 것중에서 자동으로 해당하는 것에 연결을 해줌
	// 이 AUtowired해줘야지 구현체와 객체가 연결이됨
	private BoardMapper mapper;
	
	
//	/list라는 요청이 들어오면 밑에 있는 'list'라는 메소드를 실행시킬꺼다.
	@RequestMapping("/list")  // 알바생이 해야할 일을 알려주는거 -> mapping --- HandlerMapping이라고 한다 --> list()
//	public String list(HttpServletRequest request) {  // 여기 있는 메소드 이름은 내 맘대로 해도 된다. 근데 가급적 요청(/list)와 이름을 같게 해주면 좋음
	public String list(Model model) { // spring은 model로 해서 요청을 받아올꺼 
		
		
		
		//model에서 받아준 데이터를 여기로 불러와줌(return으로 view로 이동을 해줘야하니까)
		
		// 위의 mapper에서 받아오면 됨 (아주 간단해짐)
		List<Board> list = mapper.getLists();

		// 응답을 보여주려면 view가 필요 jsp와 연결이 필요하다!
		// return은 여기에서 가지고 있었던 데이터로 어떤 페이지(뷰, jsp)를 보여줄 것인지 
		
		// 객체 바인딩			// 여기 "list"는 arraylist의 번지값이 들어가있음 

		model.addAttribute("list",list); //set은 list에서 get으로 받을 수 있지
		return "board/list";  			// /WEB-INF/views/list.jsp가 정확한 경로임 근데 그냥 이름만 적어줘도 됨
										// -> servlet-context에 접두사 접미사가 이미 붙어있기때문에
					// 이 경로에서 벗어난다면 -> board/list이런식으로 앞에 폴더명을 적어줘야함
		
	}
	
	@GetMapping("/register")  //get방식 글쓰기
	public String register() {
		
		return "board/register";
	}
	
	
	@PostMapping("/register") // post방식 db로 등록을 시키려고 할때
	public String register(Board vo) {		//title, content writer 세 가지의 파라미터가 넘어옴
											// 이 세가지를 Board vo에 알아서 담아줌
		mapper.register(vo);
		// 등록성공 후 다시 리스트 페이지(/list)로 경로를 변경해줘야함 
		return "redirect:/list"; // 그냥 list로 가라 이게 아니라 위의 /list로 보내주는 거임(redirect해줌)
	}
	
	@GetMapping("/get") // RequestMapping도 상관없대
	public String get(int num, Model model) { // num을 받아서 해당 게시글을 인식할꺼기 때문에
 		
		Board vo = mapper.get(num);
		//객체 바인딩
		model.addAttribute("vo",vo);
		mapper.count(num);  // 조회수
		System.out.println("상세보기");
		return "board/get" ; // get.jsp로 이동시켜줄꺼임 => 상세 보기 페이지!
	}
	
	@RequestMapping("/remove")
	public String remove(int num) {
		System.out.println("삭제");
		mapper.remove(num);
		return "redirect:/list";
	}
	
	@GetMapping("/modify")
	public String modify(int num, Model model) {
		System.out.println("수정화면");
		Board vo = mapper.get(num);
		model.addAttribute("vo", vo);
		return "board/modify";  //modify.jsp
	}
	
	@PostMapping("/modify") // post방식 db로 등록을 시키려고 할때
	public String modify(Board vo,RedirectAttributes rttr) {		// num, title, content 세 가지의 파라미터가 넘어옴
											// 이 세가지를 Board vo에 알아서 담아줌
		mapper.modify(vo);
		System.out.println("수정하기");
		// 수정 성공 후 다시 리스트 페이지(/list)로 경로를 변경해줘야함 
		//return "redirect:/list"; // 그냥 list로 가라 이게 아니라 위의 /list로 보내주는 거임(redirect해줌)
		// 수정 성공 후에 다시 상세페이지로 이동(/get?num = 10) 요런식으로 알아야함
		
		rttr.addAttribute("num",vo.getNum()); //num이 get 방식으로 넘어간다 
		
		//return "redirect:/get?num="+vo.getNum() ; " 원래 이렇게 길게 적을꺼 위에처럼 num을 getnum으로 받는다
//													이런식으로 잡아주니까 위에서 다 쓰고 리턴값은 저것만 쓰면됨
		
		return "redirect:/get";     //원래 했던 방식 
	
	}
	

	
	
}
