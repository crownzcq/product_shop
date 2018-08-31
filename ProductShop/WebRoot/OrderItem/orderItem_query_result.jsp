<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderItem.css" /> 

<div id="orderItem_manage"></div>
<div id="orderItem_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="orderItem_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="orderItem_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="orderItem_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="orderItem_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="orderItem_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="orderItemQueryForm" method="post">
			所属订单：<input class="textbox" type="text" id="orderObj_orderNo_query" name="orderObj.orderNo" style="width: auto"/>
			订单商品：<input class="textbox" type="text" id="productObj_productId_query" name="productObj.productId" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="orderItem_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="orderItemEditDiv">
	<form id="orderItemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">条目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_itemId_edit" name="orderItem.itemId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">所属订单:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderItem_orderObj_orderNo_edit" name="orderItem.orderObj.orderNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">订单商品:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderItem_productObj_productId_edit" name="orderItem.productObj.productId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_price_edit" name="orderItem.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">购买数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_orderNumer_edit" name="orderItem.orderNumer" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="OrderItem/js/orderItem_manage.js"></script> 
