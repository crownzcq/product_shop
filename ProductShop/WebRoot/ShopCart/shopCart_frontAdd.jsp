<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Product" %>
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
<title>购物车添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>ShopCart/frontlist">购物车列表</a></li>
			    	<li role="presentation" class="active"><a href="#shopCartAdd" aria-controls="shopCartAdd" role="tab" data-toggle="tab">添加购物车</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="shopCartList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="shopCartAdd"> 
				      	<form class="form-horizontal" name="shopCartAddForm" id="shopCartAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="shopCart_productObj_productId" class="col-md-2 text-right">商品:</label>
						  	 <div class="col-md-8">
							    <select id="shopCart_productObj_productId" name="shopCart.productObj.productId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="shopCart_userObj_user_name" class="col-md-2 text-right">用户:</label>
						  	 <div class="col-md-8">
							    <select id="shopCart_userObj_user_name" name="shopCart.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="shopCart_price" class="col-md-2 text-right">单价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="shopCart_price" name="shopCart.price" class="form-control" placeholder="请输入单价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="shopCart_buyNum" class="col-md-2 text-right">购买数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="shopCart_buyNum" name="shopCart.buyNum" class="form-control" placeholder="请输入购买数量">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxShopCartAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#shopCartAddForm .form-group {margin:10px;}  </style>
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
	//提交添加购物车信息
	function ajaxShopCartAdd() { 
		//提交之前先验证表单
		$("#shopCartAddForm").data('bootstrapValidator').validate();
		if(!$("#shopCartAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ShopCart/add",
			dataType : "json" , 
			data: new FormData($("#shopCartAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#shopCartAddForm").find("input").val("");
					$("#shopCartAddForm").find("textarea").val("");
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
	//验证购物车添加表单字段
	$('#shopCartAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"shopCart.price": {
				validators: {
					notEmpty: {
						message: "单价不能为空",
					},
					numeric: {
						message: "单价不正确"
					}
				}
			},
			"shopCart.buyNum": {
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
	//初始化商品下拉框值 
	$.ajax({
		url: basePath + "Product/listAll",
		type: "get",
		success: function(products,response,status) { 
			$("#shopCart_productObj_productId").empty();
			var html="";
    		$(products).each(function(i,product){
    			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
    		});
    		$("#shopCart_productObj_productId").html(html);
    	}
	});
	//初始化用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#shopCart_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#shopCart_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
