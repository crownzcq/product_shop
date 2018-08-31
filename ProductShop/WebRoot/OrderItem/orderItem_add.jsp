<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderItem.css" />
<div id="orderItemAddDiv">
	<form id="orderItemAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">所属订单:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_orderObj_orderNo" name="orderItem.orderObj.orderNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">订单商品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_productObj_productId" name="orderItem.productObj.productId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_price" name="orderItem.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">购买数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderItem_orderNumer" name="orderItem.orderNumer" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="orderItemAddButton" class="easyui-linkbutton">添加</a>
			<a id="orderItemClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderItem/js/orderItem_add.js"></script> 
