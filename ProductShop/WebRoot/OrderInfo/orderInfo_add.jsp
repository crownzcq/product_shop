<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" />
<div id="orderInfoAddDiv">
	<form id="orderInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderNo" name="orderInfo.orderNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">下单用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_userObj_user_name" name="orderInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">订单总金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_totalMoney" name="orderInfo.totalMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">支付方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_payWay" name="orderInfo.payWay" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderStateObj" name="orderInfo.orderStateObj" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderTime" name="orderInfo.orderTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收货人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_receiveName" name="orderInfo.receiveName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收货人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_telephone" name="orderInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收货地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_address" name="orderInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">订单备注:</span>
			<span class="inputControl">
				<textarea id="orderInfo_orderMemo" name="orderInfo.orderMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">商家:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_sellObj_user_name" name="orderInfo.sellObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="orderInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="orderInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderInfo/js/orderInfo_add.js"></script> 
