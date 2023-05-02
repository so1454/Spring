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
  <title>나는 템플릿,,</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <link rel = "stylesheet" href="${cpath}/resources/css/style.css">
  
    <script type="text/javascript">
  	$(document).ready(function(){
  		
  		$("#list").click(function(){  // 함수안에 함수가 있는 것을 익명함수라고함
  			var frm = $("#frm");
  			frm.attr("action","${cpath}/list"); // ?num=1&page=1&type=writer&keyword=XXX 이런식으로 넘어감
  			frm.submit();
  			
  		});

  	});
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
						<p class = "card-text">답글쓰기</p>
							<form id = "frm" action = "${cpath}/reply" method = "post">
							<input type = "hidden" name ="page" value ="${cri.page}"/>
							<input type = "hidden" name ="num" value ="${vo.num}"/> <!-- 부모글의 넘버를 넘겨야지 -->
							<input type = "hidden" name ="username" value ="${mvo.username}"/> <!-- 부모글의 작성자(id)를 넘겨야지 -->
							<input type = "hidden" name = "type" value = "${cri.type}"/>
							<input type = "hidden" name = "keyword" value = "${cri.keyword}"/>
								
								<div class = "form-group">
									<label>제목 : </label>
									<input type = "text" name = "title" class = "form-control" value = "${vo.title}"/>
									
								</div>
								<div class = "form-group">
									<label>답글 : </label>									
									<textarea rows = "10" name = "content" class= "form-control"></textarea>
								</div>
								<div class = "form-group">
									<label>작성자 : </label>
									<input type = "text" name = "writer" class = "form-control" value = "${mvo.name}" readonly="readonly"/>
								</div>
							<button id = list type = "button" class="btn btn-primary btn-sm">목록</button>
							<button type = "submit" class="btn btn-primary btn-sm">답글</button>
							<button type = "reset" class="btn btn-primary btn-sm" >취소</button>
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
