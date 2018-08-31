<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderItem.css" />
<div id="orderItem_editDiv">
	<form id="orderItemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">条目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_itemId_edit" name="orderItem.itemId" value="<%=request.getParameter("itemId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="orderItemModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderItem/js/orderItem_modify.js"></script> 
