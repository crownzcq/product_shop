<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/comment.css" />
<div id="comment_editDiv">
	<form id="commentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">评论id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="comment_commentId_edit" name="comment.commentId" value="<%=request.getParameter("commentId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被评商品:</span>
			<span class="inputControl">
				<input class="textbox"  id="comment_productObj_productId_edit" name="comment.productObj.productId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论内容:</span>
			<span class="inputControl">
				<textarea id="comment_content_edit" name="comment.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">评论用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="comment_userObj_user_name_edit" name="comment.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="comment_commentTime_edit" name="comment.commentTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="commentModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Comment/js/comment_modify.js"></script> 
