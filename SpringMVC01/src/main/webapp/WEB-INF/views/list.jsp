<%@page import="java.util.List"%>
<%@page import="kr.board.entity.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 이 친구는 이제 jsp 할때만 필요한거지 이제 필요XX -->
<%
//set 했을때의 이름으로 꺼내오기 필요
// list와 board를 임포트 해줘야함
List<Board> list = (List<Board>) request.getAttribute("list");
%>


<!-- 이 세개는 항상 필요함 -->
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> <!--core-->
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %><!--fmt(포멧팅)-->
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %><!--fn(함수)-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		
		<!-- 스크립트릿을 사용하지 않고 어떻게 하는가 =>JSTL로 -->
		<c:forEach var = "vo" items="${list}"> <!-- 컨트롤러의 보내준 list값을 여기서 가져오는거임  -->
				<!-- 여러개의 항목을 받는거 -> items// 가져오고자하는 데이터는 EL형태로 "" 안에 써줘야함 -->
			<tr>
				<td>${vo.num}</td>
				<td>${vo.title}</td>
				<td>${vo.writer}</td>
				<td>${vo.indate}</td>
				<td>${vo.count}</td>
			</tr>
		</c:forEach>
		
	</table>
	<!-- jstl +el로 태그 기반으로 코드를 짤 수 있다. -->
</body>
</html>