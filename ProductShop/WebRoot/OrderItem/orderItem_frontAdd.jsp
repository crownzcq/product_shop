<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OrderInfo" %>
<%@ page import="com.shuangyulin.po.Product" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>订单条目添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>OrderItem/frontlist">订单条目列表</a></li>
			    	<li role="presentation" class="active"><a href="#orderItemAdd" aria-controls="orderItemAdd" role="tab" data-toggle="tab">添加订单条目</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="orderItemList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="orderItemAdd"> 
				      	<form class="form-horizontal" name="orderItemAddForm" id="orderItemAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="orderItem_orderObj_orderNo" class="col-md-2 text-right">所属订单:</label>
						  	 <div class="col-md-8">
							    <select id="orderItem_orderObj_orderNo" name="orderItem.orderObj.orderNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderItem_productObj_productId" class="col-md-2 text-right">订单商品:</label>
						  	 <div class="col-md-8">
							    <select id="orderItem_productObj_productId" name="orderItem.productObj.productId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderItem_price" class="col-md-2 text-right">商品单价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderItem_price" name="orderItem.price" class="form-control" placeholder="请输入商品单价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderItem_orderNumer" class="col-md-2 text-right">购买数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderItem_orderNumer" name="orderItem.orderNumer" class="form-control" placeholder="请输入购买数量">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxOrderItemAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#orderItemAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加订单条目信息
	function ajaxOrderItemAdd() { 
		//提交之前先验证表单
		$("#orderItemAddForm").data('bootstrapValidator').validate();
		if(!$("#orderItemAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "OrderItem/add",
			dataType : "json" , 
			data: new FormData($("#orderItemAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#orderItemAddForm").find("input").val("");
					$("#orderItemAddForm").find("textarea").val("");
				} else {
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
	//验证订单条目添加表单字段
	$('#orderItemAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"orderItem.price": {
				validators: {
					notEmpty: {
						message: "商品单价不能为空",
					},
					numeric: {
						message: "商品单价不正确"
					}
				}
			},
			"orderItem.orderNumer": {
				validators: {
					notEmpty: {
						message: "购买数量不能为空",
					},
					integer: {
						message: "购买数量不正确"
					}
				}
			},
		}
	}); 
	//初始化所属订单下拉框值 
	$.ajax({
		url: basePath + "OrderInfo/listAll",
		type: "get",
		success: function(orderInfos,response,status) { 
			$("#orderItem_orderObj_orderNo").empty();
			var html="";
    		$(orderInfos).each(function(i,orderInfo){
    			html += "<option value='" + orderInfo.orderNo + "'>" + orderInfo.orderNo + "</option>";
    		});
    		$("#orderItem_orderObj_orderNo").html(html);
    	}
	});
	//初始化订单商品下拉框值 
	$.ajax({
		url: basePath + "Product/listAll",
		type: "get",
		success: function(products,response,status) { 
			$("#orderItem_productObj_productId").empty();
			var html="";
    		$(products).each(function(i,product){
    			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
    		});
    		$("#orderItem_productObj_productId").html(html);
    	}
	});
})
</script>
</body>
</html>
