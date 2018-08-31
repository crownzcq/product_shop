<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productClass.css" /> 

<div id="productClass_manage"></div>
<div id="productClass_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="productClass_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="productClass_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="productClass_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="productClass_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="productClass_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="productClassQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="productClassEditDiv">
	<form id="productClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productClass_classId_edit" name="productClass.classId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="ProductClass/js/productClass_manage.js"></script> 
