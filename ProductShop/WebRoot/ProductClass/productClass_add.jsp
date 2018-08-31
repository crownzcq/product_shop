<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productClass.css" />
<div id="productClassAddDiv">
	<form id="productClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productClass_className" name="productClass.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">类别描述:</span>
			<span class="inputControl">
				<textarea id="productClass_classDesc" name="productClass.classDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="productClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="productClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ProductClass/js/productClass_add.js"></script> 
