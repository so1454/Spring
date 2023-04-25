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
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel = "stylesheet" href="${cpath}/resources/css/style.css">
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
											<td><a href = "${cpath}/get?num=${vo.num}">${vo.title}</td>
											<td>${vo.writer}</td>
											<td><fmt:formatDate value = "${vo.indate}" pattern = "yyyy-MM-dd"/></td>
											<td>${vo.count}</td> <!-- 조회수는 상세보기 들어갔다 나오면 +1 되는걸로 해서 따로 만들어줌 -->
										</tr>
									</c:forEach>
								
								</tbody>
							</table>
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

</body>
</html>