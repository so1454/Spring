package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.board.entity.Board;
import kr.board.entity.Criteria;
import kr.board.entity.PageMaker;
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
	public String list(Criteria cri , Model model) { // spring은 model로 해서 요청을 받아올꺼 
		
		
		
		//model에서 받아준 데이터를 여기로 불러와줌(return으로 view로 이동을 해줘야하니까)
		
		// 위의 mapper에서 받아오면 됨 (아주 간단해짐)
		List<Board> list = mapper.getLists(cri);

		// 응답을 보여주려면 view가 필요 jsp와 연결이 필요하다!
		// return은 여기에서 가지고 있었던 데이터로 어떤 페이지(뷰, jsp)를 보여줄 것인지 
		
		// 객체 바인딩			// 여기 "list"는 arraylist의 번지값이 들어가있음 

		model.addAttribute("list",list); //set은 list에서 get으로 받을 수 있지
		
		// 페이징 처리에 필요한 부분
		PageMaker pm = new PageMaker();
		// 현재 위 매개변수가 받아온 cri 값을 pm에 넣어줘야지 굴러가니까
		pm.setCri(cri); 
		// 전체 게시물의 레코드 수를 구해야한다.
		pm.setTotalCount(mapper.totalCount(cri));  // 여기에서 검색조건인 cri를 넣어줘야지 검색 레코드 수를 구할 수 있으니까
		// 들어있는 값을보고 pm을 넣어준다
		model.addAttribute("pm",pm);
		
		
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
	public String get(int num, Model model, @ModelAttribute("cri") Criteria cri) { // num을 받아서 해당 게시글을 인식할꺼기 때문에
 		
		Board vo = mapper.get(num);
		//객체 바인딩
		model.addAttribute("vo",vo);
		mapper.count(num);  // 조회수
		
//		model.addAttribute("cri",cri);
		
		return "board/get" ; // get.jsp로 이동시켜줄꺼임 => 상세 보기 페이지!
	}
	
	@RequestMapping("/remove")
	public String remove(int num, Criteria cri , RedirectAttributes rttr) {
		mapper.remove(num);
		rttr.addAttribute("page",cri.getPage());
		return "redirect:/list";
	}
	
	@GetMapping("/modify")
	public String modify(int num, Model model,@ModelAttribute("cri") Criteria cri) {
		System.out.println("수정화면");
		Board vo = mapper.get(num);
		model.addAttribute("vo", vo);
		return "board/modify";  //modify.jsp
	}
	
	@PostMapping("/modify") // post방식 db로 등록을 시키려고 할때
	public String modify(Board vo,RedirectAttributes rttr,Criteria cri) {		// num, title, content 세 가지의 파라미터가 넘어옴
											// 이 세가지를 Board vo에 알아서 담아줌
		mapper.modify(vo);
		System.out.println("수정하기");
		// 수정 성공 후 다시 리스트 페이지(/list)로 경로를 변경해줘야함 
		//return "redirect:/list"; // 그냥 list로 가라 이게 아니라 위의 /list로 보내주는 거임(redirect해줌)
		// 수정 성공 후에 다시 상세페이지로 이동(/get?num = 10) 요런식으로 알아야함
		
		rttr.addAttribute("num",vo.getNum()); //num이 get 방식으로 넘어간다 
		rttr.addAttribute("page",cri.getPage());
		//return "redirect:/get?num="+vo.getNum() ; " 원래 이렇게 길게 적을꺼 위에처럼 num을 getnum으로 받는다
//													이런식으로 잡아주니까 위에서 다 쓰고 리턴값은 저것만 쓰면됨
		
		return "redirect:/get";     //원래 했던 방식 
	
	}
	
	// 해당 부모글의 댓글을 달 수 있게 숫자랑 같이 넘기는 컨트롤러
	@GetMapping("/reply") // ?num = 10
	public String reply(int num, Model model, @ModelAttribute("cri") Criteria cri){
		
		Board vo = mapper.get(num); // num을 가지고 가라!
		// 객체 바인딩까지!
		model.addAttribute("vo",vo);
		
		return "board/reply"; // reply.jsp 답글페이지로 이동하게끔
	}
	
	@PostMapping("/reply") // num,username,title, centent,writer,bgroup,bseq,blevel,bdelete
	public String reply(Board vo,Criteria cri,RedirectAttributes rttr) {
		// 답글에 필요한 정보 만들기
		// 1. 부모글(원글)의 정보를 가져오기 
		Board parent = mapper.get(vo.getNum());
		
		// 2. 부모글의 bgroup을 답글의 bgroup에 저장
		vo.setBgroup(parent.getBgroup());
		
		// 3. 부모글의 bseq에 +1을 해서 답글의 bseq에 저장
		vo.setBseq(parent.getBseq()+1);
		
		// 4. 부모글의 Blevel에 +1을 해서 답글의 Blevel에 저장
		vo.setBlevel(parent.getBlevel()+1);
		
		// 5. 부모의 bgroup과 같고 부모의 bseq보다 < 큰 답글의 bseq를 모두 1을 더하는 작업
		mapper.replySeqUp(parent);
		
		// 6. 답글을 저장하기
		mapper.replyInsert(vo);
		
		// 답글 달고 현재페이지 유지시킬 수 있게 해주기
		rttr.addAttribute("page", cri.getPage());
		
		return "redirect:/list";
	}
	
	
}
