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
  <title>bookList</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
    		</div>
    		<div class = "col-lg-7">
    			<div class = "card">
					<div class = "card-body">
						<h4 class = "card-title">Book</h4>
						<p class = "card-text">책 목록</p>
						<table class = "table table-bordered table-hover">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작가</th>
										<th>출판사</th>
										<th>LSBN</th>
										<th>보유도서수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var = "book" items="${booklist}">
										<tr>
											<td>${book.num}</td>
											<td>${book.title}</td>
											<td>${book.author}</td>
											<td>${book.company}</td>
											<td>${book.lsbn}</td> 
											<td>${book.count}</td> 
										</tr>
									</c:forEach>
								
								</tbody>
							</table>
					</div>
				</div>
			</div>
    		<div class = "col-lg-3">
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
