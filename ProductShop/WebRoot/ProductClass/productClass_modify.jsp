<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productClass.css" />
<div id="productClass_editDiv">
	<form id="productClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productClass_classId_edit" name="productClass.classId" value="<%=request.getParameter("classId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productClass_className_edit" name="productClass.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">类别描述:</span>
			<span class="inputControl">
				<textarea id="productClass_classDesc_edit" name="productClass.classDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="productClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ProductClass/js/productClass_modify.js"></script> 
