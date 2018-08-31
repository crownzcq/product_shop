<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" />
<div id="orderInfo_editDiv">
	<form id="orderInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderNo_edit" name="orderInfo.orderNo" value="<%=request.getParameter("orderNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">下单用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderInfo_userObj_user_name_edit" name="orderInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">订单总金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_totalMoney_edit" name="orderInfo.totalMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">支付方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_payWay_edit" name="orderInfo.payWay" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderStateObj_edit" name="orderInfo.orderStateObj" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderTime_edit" name="orderInfo.orderTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收货人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_receiveName_edit" name="orderInfo.receiveName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收货人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_telephone_edit" name="orderInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收货地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_address_edit" name="orderInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">订单备注:</span>
			<span class="inputControl">
				<textarea id="orderInfo_orderMemo_edit" name="orderInfo.orderMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">商家:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderInfo_sellObj_user_name_edit" name="orderInfo.sellObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="orderInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderInfo/js/orderInfo_modify.js"></script> 
