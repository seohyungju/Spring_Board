<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>

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
			<td><a href='/board/read?bno=${boardVO.bno}'>${boardVO.title}</a></td>
			<td>${boardVO.writer}</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
			<td><span class="badge bg-red">${boardVO.viewcnt }</span>
		</tr>
	</c:forEach>
	
</table>
<%@include file="../include/footer.jsp"%>

<script>
	var result = '${msg}';
	
	if(result == 'success'){
		alert('처리가 완료되었습니다.');
	}
</script>