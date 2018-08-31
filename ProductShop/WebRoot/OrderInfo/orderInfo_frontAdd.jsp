<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.UserInfo" %>
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
<title>订单添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>OrderInfo/frontlist">订单列表</a></li>
			    	<li role="presentation" class="active"><a href="#orderInfoAdd" aria-controls="orderInfoAdd" role="tab" data-toggle="tab">添加订单</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="orderInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="orderInfoAdd"> 
				      	<form class="form-horizontal" name="orderInfoAddForm" id="orderInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="orderInfo_orderNo" class="col-md-2 text-right">订单编号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="orderInfo_orderNo" name="orderInfo.orderNo" class="form-control" placeholder="请输入订单编号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="orderInfo_userObj_user_name" class="col-md-2 text-right">下单用户:</label>
						  	 <div class="col-md-8">
							    <select id="orderInfo_userObj_user_name" name="orderInfo.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_totalMoney" class="col-md-2 text-right">订单总金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_totalMoney" name="orderInfo.totalMoney" class="form-control" placeholder="请输入订单总金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_payWay" class="col-md-2 text-right">支付方式:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_payWay" name="orderInfo.payWay" class="form-control" placeholder="请输入支付方式">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderStateObj" class="col-md-2 text-right">订单状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_orderStateObj" name="orderInfo.orderStateObj" class="form-control" placeholder="请输入订单状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderTime" class="col-md-2 text-right">下单时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_orderTime" name="orderInfo.orderTime" class="form-control" placeholder="请输入下单时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_receiveName" class="col-md-2 text-right">收货人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_receiveName" name="orderInfo.receiveName" class="form-control" placeholder="请输入收货人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_telephone" class="col-md-2 text-right">收货人电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_telephone" name="orderInfo.telephone" class="form-control" placeholder="请输入收货人电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_address" class="col-md-2 text-right">收货地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_address" name="orderInfo.address" class="form-control" placeholder="请输入收货地址">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderMemo" class="col-md-2 text-right">订单备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="orderInfo_orderMemo" name="orderInfo.orderMemo" rows="8" class="form-control" placeholder="请输入订单备注"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_sellObj_user_name" class="col-md-2 text-right">商家:</label>
						  	 <div class="col-md-8">
							    <select id="orderInfo_sellObj_user_name" name="orderInfo.sellObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxOrderInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#orderInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加订单信息
	function ajaxOrderInfoAdd() { 
		//提交之前先验证表单
		$("#orderInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#orderInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "OrderInfo/add",
			dataType : "json" , 
			data: new FormData($("#orderInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#orderInfoAddForm").find("input").val("");
					$("#orderInfoAddForm").find("textarea").val("");
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
	//验证订单添加表单字段
	$('#orderInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"orderInfo.orderNo": {
				validators: {
					notEmpty: {
						message: "订单编号不能为空",
					}
				}
			},
			"orderInfo.totalMoney": {
				validators: {
					notEmpty: {
						message: "订单总金额不能为空",
					},
					numeric: {
						message: "订单总金额不正确"
					}
				}
			},
			"orderInfo.payWay": {
				validators: {
					notEmpty: {
						message: "支付方式不能为空",
					}
				}
			},
			"orderInfo.orderStateObj": {
				validators: {
					notEmpty: {
						message: "订单状态不能为空",
					}
				}
			},
			"orderInfo.receiveName": {
				validators: {
					notEmpty: {
						message: "收货人不能为空",
					}
				}
			},
			"orderInfo.telephone": {
				validators: {
					notEmpty: {
						message: "收货人电话不能为空",
					}
				}
			},
			"orderInfo.address": {
				validators: {
					notEmpty: {
						message: "收货地址不能为空",
					}
				}
			},
		}
	}); 
	//初始化下单用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#orderInfo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#orderInfo_userObj_user_name").html(html);
    	}
	});
	//初始化商家下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#orderInfo_sellObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#orderInfo_sellObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
