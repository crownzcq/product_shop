<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopCart.css" /> 

<div id="shopCart_manage"></div>
<div id="shopCart_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="shopCart_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="shopCart_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="shopCart_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="shopCart_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="shopCart_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="shopCartQueryForm" method="post">
			商品：<input class="textbox" type="text" id="productObj_productId_query" name="productObj.productId" style="width: auto"/>
			用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="shopCart_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="shopCartEditDiv">
	<form id="shopCartEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">购物车id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_cartId_edit" name="shopCart.cartId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">商品:</span>
			<span class="inputControl">
				<input class="textbox"  id="shopCart_productObj_productId_edit" name="shopCart.productObj.productId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="shopCart_userObj_user_name_edit" name="shopCart.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_price_edit" name="shopCart.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">购买数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_buyNum_edit" name="shopCart.buyNum" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="ShopCart/js/shopCart_manage.js"></script> 
