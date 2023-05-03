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
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=601c55e649e826d085e921f3e54e4c7a"></script>
	
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
	  		// 책 검색 버튼이 클릭되었을때 처리
			$("#search").click(function(){
			         var bookname= $("#bookname").val();
			         if(bookname ==""){
			            alert("책 제목을 입력하세요.");
			            return false;
			         }
			         // kakao Daum OpenAPI 이용해서 책을 검색 (요청---AJAX---> 응답)
			         $.ajax({
			            url:"https://dapi.kakao.com/v3/search/book?target=title",  
			            headers : {"Authorization":"KakaoAK 5774cbdd574806114184a39be7c839b8"},  // 내 토큰 값 적어주기
			            type:"GET",
			            data:{"query":bookname},  // 
			            dataType:"json",
			            success : bookPrint,  // callback함수
			            error : function(){alert("error");}
			         });
			         
			  });
	  		
	  		
			// 주소를 입력하여 위도와 경도를 뽑아서 지도를 출력하는 기능 만들기
	  		
			$("#mapsearch").click(function(){
		         var address=$("#address").val();
		         if(address==""){
		            alert("주소를 입력하세요.");
		            return false;
		         }
		         $.ajax({
		            url:"https://dapi.kakao.com/v2/local/search/address.json",
		            headers : {"Authorization":"KakaoAK d4b0460dee59cba9c2e29c509d714add"},
		            type:"GET",
		            data:{"query": address},
		            dataType:"json",
		            success : mapPrint,
		            error : function(){alert("error");}
		         });
		      });
		         
			
			// 버튼을 클릭해서 서버로 게시판 리스트 가져오기 요청을 하고, 
			// 응답받은 데이터를 이용해서 게시판 리스트를 출력
			
			$("#ajaxList").click(function(){
				  $.ajax({ 
					  url : "${cpath}/ajaxlist",  // 어디에서 받아올껀지 (Boardcontroller부분)
					  type : "get",    // 요청 타입
					  dataType : "json",  // 받는 타임 HTML, xml 형식 가능
					  success : ajaxList,  // 밑의 함수
					  error : function(){
						  alert("error");
					  }
					  
					  
				  });
				 
			});
			
			
			//Python과 연동하는 부분
			 $("#python").click(function(){
		           var form=$("#fileFrm")[0]; // form data의 0번 폼을 가지고옴
		            var data=new FormData(form); // name=data(text), name=file(binary) 
		            $.ajax({
		               url : "http://127.0.0.1:5000/test", // flask server연동 url
		               type : "post",
		               data : data,    // var data 되어있는 위의 formData!를 데이터로 받아줌
		               processData : false,
		               contentType : false,
		               cache : false,
		               timeout : 60000, // 서버에 업로드될떄 업로드의 시간을 이정도를 넘어가면 timeout이 걸리도록 해주는거
						// 1000=> 1초 60000=> 60초
		               
		               success : function(data){ 
		                  $("#result").html("<img width='200px' height='200px' src='data:image/png;base64," + data.file + "'>");                                 
		               },
		               error : function(){ alert("error"); }
		            });
		        });
			

		   });
	  		
	  		function ajaxList(data){
				var aList = "<table class = 'table table-hover'>";
				aList +="<thead>";
				aList +="<tr>";
				aList +="<th>번호</th>";
				aList +="<th>제목</th>";
				aList +="<th>작성자</th>";
				aList +="<th>조회수</th>";
				aList +="</tr>";
				aList +="</thead>";
				
				$.each(data, function(index,board){
					aList +="<tr>";
					aList +="<td>"+board.num+"</td>";
					aList +="<td>"+board.title+"</td>";
					aList +="<td>"+board.wirter+"</td>";
					aList +="<td>"+board.indate+"</td>";
					aList +="<td>"+board.count+"</td>";
					aList +="</tr>";
				});
				
				aList +="</table>";
	  			$("#boardList").html(aList);
	  			if($("#boardList").css("display") == "none"){
	  				$("#boardList").css("display","block");
	  			}else{
	  				$("#boardList").css("display","none");
	  			}
	  		}
	  	
		   function mapPrint(data){
		      console.log(data);
		      var x= data.documents[0].x; //경도
		      var y = data.documents[0].y; // 위도
		      var location = data.documents[0].address_name;
		      console.log(x);
		      console.log(y);

			  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			  mapOption = { 
			      center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
			      level: 3 // 지도의 확대 레벨
			  };

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			  var map = new kakao.maps.Map(mapContainer, mapOption); 
		      
		      // 여기서 주의할점은 우리 ip 주로 해서 사이트를 들어가서 검색해줘야함
		      
		      
			// 마커가 표시될 위치입니다 
			  var markerPosition  = new kakao.maps.LatLng(y, x); 

			  // 마커를 생성합니다
			  var marker = new kakao.maps.Marker({
			      position: markerPosition,
			      clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
			  });

			  // 마커가 지도 위에 표시되도록 설정합니다
			  marker.setMap(map);
		      
			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			  var iwContent = '<div style="padding:5px;"> 주소 : '+ location +'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			      iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			  // 인포윈도우를 생성합니다
			  var infowindow = new kakao.maps.InfoWindow({
			      content : iwContent,
			      removable : iwRemoveable
			  });

			  // 마커에 클릭이벤트를 등록합니다
			  kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커 위에 인포윈도우를 표시합니다
			        infowindow.open(map, marker);  
			  });
			  
		
		   };
		   
		   
	
	  	function bookPrint(data){  // 위 callback함수를 밑에 만들어줌
	  		console.log(data);  // 구조 어떻게 프린트 되는지 확인
	  		var bList = "<table class = 'table table-hover'>";
	  		bList += "<thead>";
	  		
	  		bList +="<tr>";
	  		bList += "<th>책이미지</th>"
	  		bList += "<th>제목</th>"
	  		bList += "<th>가격</th>"
	  		bList += "<th>출판사</th>"
	  		bList +="</tr>";
	  		
	  		bList += "</thead>";
	  		
	  		$.each(data.documents, function(index, book){
	  	         var image = book.thumbnail;
	  	         var title = book.title;
	  	         var price = book.price;
	  	         var url = book.url;
	  	         var publisher = book.publisher;
	  	         bList+="<tbody>";
	  	         bList+="<tr>";
	  	         bList+="<td><a href = '"+url+"'><img src='"+image+"' width='50px' heiht='60px'/></a></td>";
	  	         bList+="<td>"+title+"</td>";
	  	         bList+="<td>"+price+"</td>";
	  	         bList+="<td>"+publisher+"</td>";
	  	         bList+="</tr>";
	  	         bList+="</tbody>";

	  	      });  // each함수(반복문) 반복문으로 돌면서 하나씩 가져와줌 => data의 documents에 검색되어있는 여러개의 책들을 가져와야함
	 	  		
	  	      bList += "</table>";
	  		
	  		
	  		$("#bookList").html(bList);
	  		
	  	}
	  	
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
							<!-- 검색 메뉴  -->
							
							<form class = "form-inline" action = "${cpath}/list" method = "post">
								<div class = "container">
									<div class ="input-group mb-3">
										<div class = "input-group-append">
											<select name = "type" class = "form-control">
												<option value = "writer" ${pm.cri.type == 'writer' ? 'selected' : ''}>이름</option>  
																										<!-- writer이면 ~ selected는 기본 선택임 -->
												<option value = "title" ${pm.cri.type == 'title' ? 'selected' : ''}>제목</option>
												<option value = "content" ${pm.cri.type == 'content' ? 'selected' : ''}>내용</option>
											</select>
										</div>
										<input type = "text" name = "keyword" class = "form-control" value = "${pm.cri.keyword}"/>
										<div class = "input-group-append">
											<button class = "btn btn-success btn-sm">Search</button>
										</div>
									</div>
								
								</div>
							</form>
							
							
							
							
							
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
  								<input type = "hidden" id = "page" name = "page" value = "${pm.cri.page}"/>
  								<input type = "hidden" id = "type" name = "type" value = "${pm.cri.type}"/>
  								<input type = "hidden" id = "keyword" name = "keyword" value = "${pm.cri.keyword}"/>
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
						<button id = "ajaxList" class = "btn btn-warning btn-sm">데이터 가져오기(Ajax_JSON)</button>
					</div> 
				</div>
				
				<!-- Ajax 게시판 출력부분 -->
				<div id = "boardList" style = "display:none"></div>
				
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
