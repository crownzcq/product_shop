<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/comment.css" /> 

<div id="comment_manage"></div>
<div id="comment_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="comment_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="comment_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="comment_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="comment_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="comment_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="commentQueryForm" method="post">
			被评商品：<input class="textbox" type="text" id="productObj_productId_query" name="productObj.productId" style="width: auto"/>
			评论用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			评论时间：<input type="text" class="textbox" id="commentTime" name="commentTime" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="comment_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="commentEditDiv">
	<form id="commentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">评论id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="comment_commentId_edit" name="comment.commentId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Comment/js/comment_manage.js"></script> 
