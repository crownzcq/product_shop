<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" /> 

<div id="product_manage"></div>
<div id="product_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="product_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="product_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="product_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="product_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="product_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="productQueryForm" method="post">
			商品类别：<input class="textbox" type="text" id="productClassObj_classId_query" name="productClassObj.classId" style="width: auto"/>
			商品名称：<input type="text" class="textbox" id="productName" name="productName" style="width:110px" />
			发布用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="product_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="productEditDiv">
	<form id="productEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productId_edit" name="product.productId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">商品类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="product_productClassObj_classId_edit" name="product.productClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productName_edit" name="product.productName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商品主图:</span>
			<span class="inputControl">
				<img id="product_mainPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="product_mainPhoto" name="product.mainPhoto"/>
				<input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">商品价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_price_edit" name="product.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">商品描述:</span>
			<span class="inputControl">
				<script name="product.productDesc" id="product_productDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="product_userObj_user_name_edit" name="product.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_addTime_edit" name="product.addTime" />

			</span>

		</div>
		<div>
			<span class="label">试看视频:</span>
			<span class="inputControl">
				<a id="product_skspA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="product_sksp" name="product.sksp"/>
				<input id="skspFile" name="skspFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var product_productDesc_editor = UE.getEditor('product_productDesc_edit'); //商品描述编辑器
</script>
<script type="text/javascript" src="Product/js/product_manage.js"></script> 
