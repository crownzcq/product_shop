<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" /> 

<div id="orderInfo_manage"></div>
<div id="orderInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="orderInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="orderInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="orderInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="orderInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="orderInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="orderInfoQueryForm" method="post">
			订单编号：<input type="text" class="textbox" id="orderNo" name="orderNo" style="width:110px" />
			下单用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			订单状态：<input type="text" class="textbox" id="orderStateObj" name="orderStateObj" style="width:110px" />
			下单时间：<input type="text" class="textbox" id="orderTime" name="orderTime" style="width:110px" />
			收货人：<input type="text" class="textbox" id="receiveName" name="receiveName" style="width:110px" />
			收货人电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			商家：<input class="textbox" type="text" id="sellObj_user_name_query" name="sellObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="orderInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="orderInfoEditDiv">
	<form id="orderInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderNo_edit" name="orderInfo.orderNo" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="OrderInfo/js/orderInfo_manage.js"></script> 
