<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="card" style="min-height: 500px; max-height: 1000px">
  <div class="card-body">
    <h4 class="card-title">BOOK SEARCH</h4>
    <div class="input-group mb-3">
       <input type="text" class="form-control" id="bookname" placeholder="Search"/>
       <div class="input-group-append">
         <a type="button" class="btn btn-secondary" id = "search">Go</a>
       </div>
    </div>
    <div id="bookList" style="overflow: scroll; height: 300px; padding: 10px">
       여기에 검색된 책 목록을 출력하세요.
    </div>
    
    <form enctype="multipart/form-data" method = "post" id = "fileFrm">
    	<div class = "form-group">
    		<label>이미지 이름 : </label>
    		<input type = "text" name ="data" class = "form-control"/>
    	</div>
    	<div class = "form-group" >
			<label>파일 : </label>    	
    		<input type = "file" name = "file" class = "form-control"/>
    	</div>
    	<button type = "button" id = "python" class = "btn btn-sm btn-primary form-control">Python연동</button>
    </form>
    
    <div id = "result">여기에 결과 이미지를 출력</div>
  </div>
</div>