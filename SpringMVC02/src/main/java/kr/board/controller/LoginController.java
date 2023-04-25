package kr.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.entity.Member;
import kr.board.mapper.BoardMapper;

@Controller
public class LoginController {

	@Autowired // == Inject
			// 외부에 만들어진 객체를 주입하여 연결하는 방법(의존성 주입 : DI(dependency injection))
	private BoardMapper mapper;	
	
	@RequestMapping("/login") // username,password --> User(X), Member(O)
	public String login(Member mvo,HttpSession session) {
		Member vo = mapper.login(mvo);
		if(vo != null) {
			// 회원 인증 성공
			session.setAttribute("mvo", vo);
			// 왜 세션에 바인딩? 특정 JSP에서 가져가는게 아니라 모든 JSP에서 가져가야하기 때문에
			// 세션에 바인딩을 해둬야한다.
		}
		return "redirect:/list";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate(); //세션을 무효화
		
		return "redirect:/list";
	}
	
	
}
