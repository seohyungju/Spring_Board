<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<div class="box-body">
	<select name="searchType">
		<option value="n"
			<c:out value="${cri.searchType == null? 'selected' : '' }"/>>---
		</option>
		<option value="t"
			<c:out value="${cri.searchType eq 't' ? 'selected' : '' }"/>>Title
		</option>
		<option value="c"
			<c:out value="${cri.searchType eq 'c' ? 'selected' : '' }"/>>Content
		</option>
		<option value="w"
			<c:out value="${cri.searchType eq 'w' ? 'selected' : '' }"/>>Writer
		</option>
		<option value="tc"
			<c:out value="${cri.searchType eq 'tc' ? 'selected' : '' }"/>>Title or Content
		</option>
		<option value="cw"
			<c:out value="${cri.searchType eq 'cw' ? 'selected' : '' }"/>>Content or Writer
		</option>
		<option value="tcw"
			<c:out value="${cri.searchType eq 'tcw' ? 'selected' : '' }"/>>Title or Content or Writer
		</option>
	</select>
	
	<input type="text" name="keyword" id="keywordInput" value="${cri.keyword }">
	<button id="searchBtn">Search</button>
	<button id="newBtn">New Btn</button>
</div>

<table class="table table-boardered">
	<tr>
		<th style="width: 10px;">BNO</th>
		<th>TITLE</th>
		<th>WRITER</th>
		<th>REGDATE</th>
		<th style="widows: 40px;">VIEWCNT</th>
	</tr>
	
	<c:forEach items="${list}" var="boardVO">
		<tr>
			<td>${boardVO.bno}</td>
<%-- 			<td><a href='/board/read?bno=${boardVO.bno}'>${boardVO.title}</a></td> --%>
			<td>
				<a href="/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno }">
					${boardVO.title } <strong>[ ${boardVO.replycnt } ]</strong>
				</a>
			</td>
			<td>${boardVO.writer}</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
			<td><span class="badge bg-red">${boardVO.viewcnt }</span>
		</tr>
	</c:forEach>
	
</table>

<div class="text-center">
	<ul class="pagination">
		<c:if test="${pageMaker.prev}">
<%-- 			<li><a href="listPage?page=${pageMaker.startPage-1}">&laquo;</a></li> --%>
<%-- 			<li><a href="listPage${pageMaker.makeQuery(pageMaker.startPage-1) }">&laquo;</a></li> --%>
			<li><a href="list${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a></li>
		</c:if>
		
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
			<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : '' }" />>
<%-- 			<a href="listPage?page=${idx }">${idx }</a> --%>
<%-- 				<a href="listPage${pageMaker.makeQuery(idx) }">${idx }</a> --%>
				<a href="list${pageMaker.makeSearch(idx) }">${idx }</a>
			</li>
		</c:forEach>
		<c:if test = "${pageMaker.next && pageMaker.endPage > 0 }">
<%-- 			<li><a href="listPage?page=${pageMaker.endPage+1}">&raquo;</a> --%>
<%-- 			<li><a href="listPage${pageMaker.makeQuery(pageMaker.endPage-1) }">&raquo;</a></li> --%>
			<li><a href="list${pageMaker.makeSearch(pageMaker.endPage-1) }">&raquo;</a></li>
		</c:if>
	</ul>
</div>
<%@include file="../include/footer.jsp"%>
<script>
	var result = '${msg}';
	
	if(result == 'SUCCESS'){
		alert('처리가 완료되었습니다.');
	}	
	
	$(document).ready(
		function(){
			$('#searchBtn').on("click", function(event){
				self.location = "list" + '${pageMaker.makeQuery(1)}'
										+ "&searchType="
										+ $("select option:selected").val()
										+ "&keyword=" +encodeURIComponent($("#keywordInput").val());
			});
			
			$('#newBtn').on("click", function(evt){
				self.location = "register";
			});
		}		
	)
</script>
