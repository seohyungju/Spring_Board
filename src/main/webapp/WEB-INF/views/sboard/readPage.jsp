<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<form role="form" method="post" action="modifyPage">
	<input type="hidden" name="bno" value="${boardVO.bno}">
	<input type="hidden" name="page" value="${cri.page }">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
	<input type="hidden" name="searchType" value="${cri.searchType }">
	<input type="hidden" name="keyword" value="${cri.keyword}">
</form>

<div class="box-body">
	<div class="form-group">
		<label for="exampleInputEmail">Title</label>
		<input type="text" name="title" class="form-control" value="${boardVO.title}" readonly="readonly">
	</div>
	
	<div class="form-group">
		<label for="exampleInputPassword1">Content</label>
		<textarea rows="3" class="form-control" name="content" readonly="readonly">${boardVO.content}</textarea>
	</div>
	
	<div class="form-group">
		<label for="exampleInputEmail1">Writer</label>
		<input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly="readonly">
	</div>
</div>

<div class="box-footer">
	<button type="submit" class="btn btn-warning modifyBtn">Modify</button>
	<button type="submit" class="btn btn-danger removeBtn">REMOVE</button>
	<button type="submit" class="btn btn-primary goListBtn">GO LIST</button>
</div>

<form role="form" action="modifyPage" method="post">
	<input type="hidden" name="bno" value="${boardVO.bno }">
	<input type="hidden" name="page" value="${cri.page }">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
</form>

<div class="row">
	<div class="col-md-12">
		<div class="box box-success">
			<div class="box-header">
				<h3 class="box-title">ADD NEW REPLY</h3>
			</div>
			
			<div class="box-body">
				<label for="newReplyWriter">Writer</label>
					<input class="form-control" type="text" placeholer="USER ID" id="newReplyWriter">
				<label for="newReplyText">ReplyText</label>
					<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
			</div>
			
			<div class="box-footer">
				<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
			</div>
		</div>
		
		<ul class="timeline">
			<li class="time-label" id="repliesDiv"><span class="bg-green">Replies List</span></li>
		<!-- replies body -->
		<script id="template" type="text/x-handlebars-template">
		{{#each.}}
		<li class="replyLi" data-rno={{rno}}>		
		<i class="fa fa-comments bg-blue"></i>
			<div class="timeline-item">
				<span class="time">
					<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
				</span>
				<h3 class="timeline-header"><strong>{{rno}}</strong> - {{replyer}}</h3>
				<div class="timeline-body">{{replytext}}</div>
				<div class="timeline-footer">
					<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
				</div>
			</div>
		</li>
		{{/each}}
		</script>	
			
			<div class="text-center">
				<ul id="pagination" class="pagination pagination-sm no-margin"></ul>
			</div>
		</ul>
	</div>
</div>


<script>
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$(".modifyBtn").on("click", function(){
		formObj.attr("action", "/sboard/modifyPage");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$(".removeBtn").on("click", function(){
		formObj.attr("action", "/sboard/removePage");
		formObj.submit();
	})
	
	$(".goListBtn").on("click", function(){
		formObj.attr("method", "get");
		formObj.attr("action", "/sboard/list");
		formObj.submit();
	})
	
	//handlebars 
	
	Handlebars.registerHelper("prettifyDate", function(timeValue){
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});
	
	var printData = function (replyArr, target, templateObject){
		var template = Handlebars.compile(templateObject.html());
		
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	}
	//handlebars end
	
	//replies paging
	
	var bno = ${boardVO.bno};
	var replyPage = 1;
	
	function getPage(pageInfo){
		$.getJSON(pageInfo, function(data){
			printData(data.list, $("#repliesDiv"), $("#template"));
			printPaging(data.pageMaker, $(".pagination"));
			
			$("#modifyModal").modal('hide');
		});
	}
	
	var printPaging = function(pageMaker, target){
		
		var str = "";
		
		if(pageMaker.prev){
			str += "<li><a href='" + (pageMaker.startPage -1) +"'> << </a><li>";
		}
		
		for(var i = pageMaker.startPage, len = pageMaker.endPage; i<= len; i++){
			var strClass = pageMaker.cri.page == i ?'class=active' : '';
			str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
		}
		
		target.html(str);
		
	}
	
	$('#repliesDiv').on("click", function(){
		if($(".timeline li").size() > 1){
			return;
		}
		
		getPage("/replies/" + bno + "/1");
	})
	
	$(".pagination").on("click", "li a", function(event){
		event.preventDefault();
		replyPage = $(this).attr("href");
		getPage("/replies/" + bno + "/" + replyPage);
	});
	//replies paging end
</script>


<%@include file="../include/footer.jsp"%>