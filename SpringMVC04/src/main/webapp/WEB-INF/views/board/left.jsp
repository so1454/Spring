 <!-- 템플릿을 잘 만들어둬야지 나중에 뒷 탈이 없어요^^! -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> <!--core-->
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %><!--fmt(포멧팅)-->
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %><!--fn(함수)-->
<!-- contextpath를 가져오는 방법 -->
<c:set var ="cpath" value = "${pageContext.request.contextPath}"/> <!-- /root 그대로 가져와짐 -->

	<div class = "card" style = "min-height:500px; max-height : 1000px;">
		<div class = "card-body">
		
		<c:if test ="${empty mvo}">  <!-- 회원인증이 실패한사람 -->
		
			<h4 class= "card-title">GUEST</h4>
			<p class = "card-text">회원님! Welcome</p>
			<form action ="${cpath}/login" mehtod = "post">
				<div class="form-group">
			
					<label>아이디:</label>
					<input type = "text" name = "username" class = "form-control"/>
				</div>
				<div class="form-group">
			
					<label>비밀번호 : </label>
					<input type = "password" name = "password" class = "form-control"/>
				</div>
				<button class = "btn btn-sm btn-primary form-control">로그인</button>
			</form>
			
			</c:if>
			<c:if test="${!empty mvo}">
				<h4 class= "card-title">${mvo.name}</h4>
				<p class = "card-text"> 회원님! Welcome</p>
				<form action ="${cpath}/logout" method = "post">
				<button class = "btn btn-sm btn-primary form-control">로그아웃</button>
				</form>
			
			</c:if>
			
			
			
		</div>
	</div>



