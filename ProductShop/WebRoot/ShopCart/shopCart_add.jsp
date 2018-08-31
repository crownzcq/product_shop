<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopCart.css" />
<div id="shopCartAddDiv">
	<form id="shopCartAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_productObj_productId" name="shopCart.productObj.productId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_userObj_user_name" name="shopCart.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_price" name="shopCart.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">购买数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shopCart_buyNum" name="shopCart.buyNum" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="shopCartAddButton" class="easyui-linkbutton">添加</a>
			<a id="shopCartClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ShopCart/js/shopCart_add.js"></script> 
