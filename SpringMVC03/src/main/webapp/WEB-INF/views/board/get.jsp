 <!-- 템플릿을 잘 만들어둬야지 나중에 뒷 탈이 없어요^^! -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> <!--core-->
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %><!--fmt(포멧팅)-->
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %><!--fn(함수)-->
    
<!-- contextpath를 가져오는 방법 -->
<c:set var ="cpath" value = "${pageContext.request.contextPath}"/> <!-- /root 그대로 가져와짐 -->
 
<!-- 함수 쓰면서 오류나는 "\n"을 바인딩 해주겠다 => 변수로 바꿔주겠다.
(이거 컨트롤러에서 하는건데 여기서도 할 수 있나봄) --> 
<% pageContext.setAttribute("newLineChar", "\n"); %>
 
<!DOCTYPE html>
<html lang="en">
<head>
  <title>나는 상세페이지,,</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel = "stylesheet" href="${cpath}/resources/css/style.css">


  <script type = "text/javascript">
	$(document).ready(function(){
		// 4개의 버튼을 클릭하면 처리하는 부분을 코딩
		$("button").on("click",function(e){	
			
			var btn = $(this).data("btn"); // 아래에서 정의해준 data-btn이라는 말
			var formData = $("#frm");
			 alert(btn);  // 각 버튼을 누르면 그 버튼에 적힌 data-btn = "?" 그 값을 가져오고 있음
			if(btn == "list"){
				formData.find("#num").remove(); // url에 표시되는 숫자를 제거시킴
				formData.attr("action","${cpath}/list");
				formData.attr("method","get"); // post로 하면 url에 표시없이 넘겨짐
				// 원래 이렇게 함 => location.href = "${cpath}/list" ; 
			}else if (btn == "modify"){
				formData.attr("action","${cpath}/modify?num"+${vo.num});
				formData.attr("method","get");
				
				
			}else if (btn == "remove"){
				formData.attr("action","${cpath}/remove?num"+${vo.num}); //  ?num = ${vo.num}
				formData.attr("method","get");
				
				// location.href = "${cpath}/remove?num="+${vo.num};
			}else if (btn == "reply"){
				formData.attr("action","${cpath}/reply");
				formData.attr("method","get")
			}
			formData.submit(); // 전송
		});

		
		
	});
  
  
  </script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>


</head>
<body>
 


  <div class="card">
  	<!-- 헤더 시작 -->
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
	    	<div class = container>
			  <h1>Spring BOARD Project</h1>
			  <p> Spring WEB MVC, MySQL, jQeury(Ajax), JSON </p>
		  	</div>
		</div>
    </div>
    
    <!-- 게시판 -->
    <div class="card-body">
    	<div class = "row">
    		<div class = "col-lg-2">
    			<jsp:include page="left.jsp"/>
    		</div>
    		<div class = "col-lg-7">
    			<div class = "card">
					<div class = "card-body">
						<h4 class = "card-title">BOARD</h4>
						<p class = "card-text">상세보기</p>
							<table class= "table">
								<tr>
									<td style = "width : 100px">제목</td>
									<td>${vo.title}</td>
								</tr>
								<tr>
									<td >내용</td>
									<td>${fn:replace(vo.content,newLineChar,"<br/>")} </td>
								</tr>
								<tr>
									<td >작성자</td>
									<td>${vo.writer}</td>
								</tr>
								<tr>
									<td >작성일</td>
									<td><fmt:formatDate value = "${vo.indate}" pattern = "yyyy-MM-dd"/></td>
								</tr>
								<td colspan ="2" style ="text-align :center;">
								<!-- 이렇게 버튼이 많을땐 어떻게 해야하는지 -> 자바스크립트로 버튼을 관리해줄꺼다. -->																				
									<button data-btn ="list" class="btn btn-success btn-sm" >목록</button>
									
									<c:if test ="${mvo.username eq vo.username}"> <!-- 로그인한 mvo와 게시물의 username이 같냐? -->
									<button data-btn ="modify" class="btn btn-success btn-sm" >수정</button>
									<button data-btn ="remove" class="btn btn-success btn-sm" >삭제</button>
									</c:if>
									
									<c:if test = "${!empty mvo}">
									<button data-btn ="reply" class="btn btn-success btn-sm" >댓글</button>
									</c:if>
								</td>
							</table>
							<!-- 가짜폼을 만들어줌 -->
							<form id = "frm" >
								<!-- 현재 게시물의 번호를 hidden으로 담아줌(쿼리스트링 대신 위에서 사용할 친구) 
								얘를 사용하면 쿼리스트링 사용없이 더 깔끔하게 넘겨줄 수 있다.-->
								<input type = "hidden" name ="num" id = "num" value ="${vo.num}"/>
								<input type = "hidden" name ="page" value ="${cri.page}"/>
								
								
							</form>
						
					</div>
				</div>
			</div>
    		<div class = "col-lg-3">
				<jsp:include page="right.jsp"/>
			</div>
    	</div>
    </div> 
    
    <!-- footer 시작 -->
    <div class="card-footer">
    빅데이터 분석서비스 개발자 양성과정(구소현)
    </div>
    
  </div>

</body>
</html>
