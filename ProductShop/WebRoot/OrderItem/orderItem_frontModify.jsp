<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OrderItem" %>
<%@ page import="com.shuangyulin.po.OrderInfo" %>
<%@ page import="com.shuangyulin.po.Product" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的orderObj信息
    List<OrderInfo> orderInfoList = (List<OrderInfo>)request.getAttribute("orderInfoList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    OrderItem orderItem = (OrderItem)request.getAttribute("orderItem");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改订单条目信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">订单条目信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="orderItemEditForm" id="orderItemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="orderItem_itemId_edit" class="col-md-3 text-right">条目id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="orderItem_itemId_edit" name="orderItem.itemId" class="form-control" placeholder="请输入条目id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="orderItem_orderObj_orderNo_edit" class="col-md-3 text-right">所属订单:</label>
		  	 <div class="col-md-9">
			    <select id="orderItem_orderObj_orderNo_edit" name="orderItem.orderObj.orderNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderItem_productObj_productId_edit" class="col-md-3 text-right">订单商品:</label>
		  	 <div class="col-md-9">
			    <select id="orderItem_productObj_productId_edit" name="orderItem.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderItem_price_edit" class="col-md-3 text-right">商品单价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderItem_price_edit" name="orderItem.price" class="form-control" placeholder="请输入商品单价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderItem_orderNumer_edit" class="col-md-3 text-right">购买数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderItem_orderNumer_edit" name="orderItem.orderNumer" class="form-control" placeholder="请输入购买数量">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOrderItemModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#orderItemEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改订单条目界面并初始化数据*/
function orderItemEdit(itemId) {
	$.ajax({
		url :  basePath + "OrderItem/" + itemId + "/update",
		type : "get",
		dataType: "json",
		success : function (orderItem, response, status) {
			if (orderItem) {
				$("#orderItem_itemId_edit").val(orderItem.itemId);
				$.ajax({
					url: basePath + "OrderInfo/listAll",
					type: "get",
					success: function(orderInfos,response,status) { 
						$("#orderItem_orderObj_orderNo_edit").empty();
						var html="";
		        		$(orderInfos).each(function(i,orderInfo){
		        			html += "<option value='" + orderInfo.orderNo + "'>" + orderInfo.orderNo + "</option>";
		        		});
		        		$("#orderItem_orderObj_orderNo_edit").html(html);
		        		$("#orderItem_orderObj_orderNo_edit").val(orderItem.orderObjPri);
					}
				});
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#orderItem_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#orderItem_productObj_productId_edit").html(html);
		        		$("#orderItem_productObj_productId_edit").val(orderItem.productObjPri);
					}
				});
				$("#orderItem_price_edit").val(orderItem.price);
				$("#orderItem_orderNumer_edit").val(orderItem.orderNumer);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交订单条目信息表单给服务器端修改*/
function ajaxOrderItemModify() {
	$.ajax({
		url :  basePath + "OrderItem/" + $("#orderItem_itemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#orderItemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#orderItemQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    orderItemEdit("<%=request.getParameter("itemId")%>");
 })
 </script> 
</body>
</html>

