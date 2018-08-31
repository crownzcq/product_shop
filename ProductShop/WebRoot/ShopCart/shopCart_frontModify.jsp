<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.ShopCart" %>
<%@ page import="com.shuangyulin.po.Product" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    ShopCart shopCart = (ShopCart)request.getAttribute("shopCart");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改购物车信息</TITLE>
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
  		<li class="active">购物车信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="shopCartEditForm" id="shopCartEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="shopCart_cartId_edit" class="col-md-3 text-right">购物车id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="shopCart_cartId_edit" name="shopCart.cartId" class="form-control" placeholder="请输入购物车id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="shopCart_productObj_productId_edit" class="col-md-3 text-right">商品:</label>
		  	 <div class="col-md-9">
			    <select id="shopCart_productObj_productId_edit" name="shopCart.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shopCart_userObj_user_name_edit" class="col-md-3 text-right">用户:</label>
		  	 <div class="col-md-9">
			    <select id="shopCart_userObj_user_name_edit" name="shopCart.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shopCart_price_edit" class="col-md-3 text-right">单价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="shopCart_price_edit" name="shopCart.price" class="form-control" placeholder="请输入单价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shopCart_buyNum_edit" class="col-md-3 text-right">购买数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="shopCart_buyNum_edit" name="shopCart.buyNum" class="form-control" placeholder="请输入购买数量">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxShopCartModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#shopCartEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改购物车界面并初始化数据*/
function shopCartEdit(cartId) {
	$.ajax({
		url :  basePath + "ShopCart/" + cartId + "/update",
		type : "get",
		dataType: "json",
		success : function (shopCart, response, status) {
			if (shopCart) {
				$("#shopCart_cartId_edit").val(shopCart.cartId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#shopCart_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#shopCart_productObj_productId_edit").html(html);
		        		$("#shopCart_productObj_productId_edit").val(shopCart.productObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#shopCart_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#shopCart_userObj_user_name_edit").html(html);
		        		$("#shopCart_userObj_user_name_edit").val(shopCart.userObjPri);
					}
				});
				$("#shopCart_price_edit").val(shopCart.price);
				$("#shopCart_buyNum_edit").val(shopCart.buyNum);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交购物车信息表单给服务器端修改*/
function ajaxShopCartModify() {
	$.ajax({
		url :  basePath + "ShopCart/" + $("#shopCart_cartId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#shopCartEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#shopCartQueryForm").submit();
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
    shopCartEdit("<%=request.getParameter("cartId")%>");
 })
 </script> 
</body>
</html>

