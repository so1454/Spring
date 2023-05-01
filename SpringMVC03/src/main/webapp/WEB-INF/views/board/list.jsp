 <!-- 템플릿을 잘 만들어둬야지 나중에 뒷 탈이 없어요^^! -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> <!--core-->
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %><!--fmt(포멧팅)-->
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %><!--fn(함수)-->

<!-- contextpath를 가져오는 방법 -->
<c:set var ="cpath" value = "${pageContext.request.contextPath}"/> <!-- /root 그대로 가져와짐 -->

<!DOCTYPE html>
<html lang="en">
<head>
  <title>나는 게시판,,</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel = "stylesheet" href="${cpath}/resources/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
	  	$(document).ready(function(){
	  		var pageForm= $("#pageForm")  // 폼의 아이디를 담아준 변수
	  		
	  		$(".pagination a").on("click",  // 페이징의 앵커태그 클릭 시 
	  			function(e){
	  				e.preventDefault(); // a tag의 고유한 기능을 막는 방법(이게 없으면 a태그의 기능으로 넘어가버림)
	  				var page = $(this).attr("href")  // href라는 속성을 가지고옴
	  				// location.href = "${cpath}/list?page"+page+"$aaa=aaa"; / form 이용
	  				$("#page").val(page);  // hidden
	  				
	  				pageForm.submit(); 	// 폼의 아이디를 담아준 변수를 이용해서 폼을 전송
	  				
	  		});
	  			// 상세보기로 이동
	  			$(".move").on("click", function(e){
	  				e.preventDefault();
	  				var num = $(this).attr("href");
	  				var tag = "<input type = 'hidden' name = 'num' value = '"+num+"'>";
	  				pageForm.append(tag);
	  				pageForm.attr("action", "${cpath}/get");
	  				pageForm.attr("method","get");
	  				pageForm.submit(); // 폼을 전송
	  			});
	  		
	  	  	
	  	});
	
	
		function goMsg(){
			$("#myModal").modal("show");			

		}
	</script>


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
						<p class = "card-text">게시판 리스트</p>
							<table class = "table table-bordered table-hover">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var = "vo" items="${list}">
										<tr>
											<td>${vo.num}</td>
											
											<td> <!-- td for if문 시작 -->
											<!-- 대댓글 하나이면 한번/그 밑에 하나 더 써지면 들여쓰기 한번 더 이런식으로 만들어주기 -->
											<c:if test = "${vo.blevel==0}"> <!-- 0 -->
												<c:if test = "${vo.bdelete == 0}">
													<a class = "move" href = "${vo.num}">${vo.title}</a>
												</c:if>
												
												<c:if test = "${vo.bdelete == 1}">
													<a href = "javascript:goMsg()">삭제된 게시물입니다.</a>
												</c:if>
											</c:if>								
														
														
														
											<c:if test = "${vo.blevel > 0}"> 
											
												<c:forEach begin = "1" end = "${vo.blevel}">
													<!-- 1부터 level까지 for문을 돌린다. -->
													<span style = "padding-left : 10px"></span>
												</c:forEach>
												
												<i class = "bi bi-arrow-return-right"></i>
												
												<c:if test = "${vo.bdelete==0}">
													<a class = "move" href = "${vo.num}">[Re] ${vo.title}</a>
												</c:if>
												
												<c:if test = "${vo.bdelete == 1}">
													<a href = "javascript:goMsg()">삭제된 게시물입니다.</a>
												</c:if>			
																					
											</c:if>
											
											</td><!-- td for if문 끝 -->
											
											<td>${vo.writer}</td>
											<td><fmt:formatDate value = "${vo.indate}" pattern = "yyyy-MM-dd"/></td>
											<td>${vo.count}</td> <!-- 조회수는 상세보기 들어갔다 나오면 +1 되는걸로 해서 따로 만들어줌 -->
										</tr>
									</c:forEach>
									
								
								</tbody>
							</table>
							
							
							<!-- 페이지 리스트 출력 시작 -->
							<ul class="pagination justify-content-center">
								<!-- 페이지가 pageEnd의 이상인 True인 경우만 '이전'버튼이 나와야하니까 if문으로 -->
								<c:if test = "${pm.prev}">
									<li class = "page-item"><a class="page-link" href= "${pm.startPage-1}">◀</a></li>
								</c:if>
   								 <c:forEach var= "pageNum" begin = "${pm.startPage}" end = "${pm.endPage}">
	   								 <li class="page-item ${pm.cri.page == pageNum ? 'active' : ''}">
	   								 <a class="page-link" href= "${pageNum}">${pageNum}</a>
	   								 </li>
   								 </c:forEach>
   								<c:if test = "${pm.next}">
									<li class = "page-item"><a class="page-link" href= "${pm.endPage+1}">▶</a></li>
								</c:if>
  							</ul>					
  							<form id = "pageForm" action = "${cpath}/list" method = post>
  								<input type = "hidden" id = page name = page value = "${pm.cri.page}"/>
  							</form>
							<!-- 페이지 리스트 출력 끝 -->
							
							
							
							<!-- contextpath를 가져오는 방법 
							위에 c:set으로 path를 가져와줄 수 있도록 함 
							여기에 있는 로케이션 href에서 원래'/mvc01/register'이건데
							이걸 server.xml에서 자동으로 받아와주는 c:set 덕분에 그냥 밑처럼 적어주면 끝
							아님 아예 안적던가!-->
						<c:if test ="${!empty mvo}"> <!-- 로그인을 했을때 글쓰기 버튼이 나오도록함 -->
						<button class="btn btn-success btn-sm" onclick = "location.href = '${cpath}/register'">글쓰기</button>
						</c:if>
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



<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Message<button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <font color = "red">😥삭제된 게시물입니다.😥</font>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>




</body>
</html>
