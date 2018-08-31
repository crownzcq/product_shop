<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OrderInfo" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    OrderInfo orderInfo = (OrderInfo)request.getAttribute("orderInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改订单信息</TITLE>
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
  		<li class="active">订单信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="orderInfoEditForm" id="orderInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="orderInfo_orderNo_edit" class="col-md-3 text-right">订单编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="orderInfo_orderNo_edit" name="orderInfo.orderNo" class="form-control" placeholder="请输入订单编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="orderInfo_userObj_user_name_edit" class="col-md-3 text-right">下单用户:</label>
		  	 <div class="col-md-9">
			    <select id="orderInfo_userObj_user_name_edit" name="orderInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_totalMoney_edit" class="col-md-3 text-right">订单总金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_totalMoney_edit" name="orderInfo.totalMoney" class="form-control" placeholder="请输入订单总金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_payWay_edit" class="col-md-3 text-right">支付方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_payWay_edit" name="orderInfo.payWay" class="form-control" placeholder="请输入支付方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_orderStateObj_edit" class="col-md-3 text-right">订单状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_orderStateObj_edit" name="orderInfo.orderStateObj" class="form-control" placeholder="请输入订单状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_orderTime_edit" class="col-md-3 text-right">下单时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_orderTime_edit" name="orderInfo.orderTime" class="form-control" placeholder="请输入下单时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_receiveName_edit" class="col-md-3 text-right">收货人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_receiveName_edit" name="orderInfo.receiveName" class="form-control" placeholder="请输入收货人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_telephone_edit" class="col-md-3 text-right">收货人电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_telephone_edit" name="orderInfo.telephone" class="form-control" placeholder="请输入收货人电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_address_edit" class="col-md-3 text-right">收货地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_address_edit" name="orderInfo.address" class="form-control" placeholder="请输入收货地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_orderMemo_edit" class="col-md-3 text-right">订单备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="orderInfo_orderMemo_edit" name="orderInfo.orderMemo" rows="8" class="form-control" placeholder="请输入订单备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_sellObj_user_name_edit" class="col-md-3 text-right">商家:</label>
		  	 <div class="col-md-9">
			    <select id="orderInfo_sellObj_user_name_edit" name="orderInfo.sellObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOrderInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#orderInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改订单界面并初始化数据*/
function orderInfoEdit(orderNo) {
	$.ajax({
		url :  basePath + "OrderInfo/" + orderNo + "/update",
		type : "get",
		dataType: "json",
		success : function (orderInfo, response, status) {
			if (orderInfo) {
				$("#orderInfo_orderNo_edit").val(orderInfo.orderNo);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#orderInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#orderInfo_userObj_user_name_edit").html(html);
		        		$("#orderInfo_userObj_user_name_edit").val(orderInfo.userObjPri);
					}
				});
				$("#orderInfo_totalMoney_edit").val(orderInfo.totalMoney);
				$("#orderInfo_payWay_edit").val(orderInfo.payWay);
				$("#orderInfo_orderStateObj_edit").val(orderInfo.orderStateObj);
				$("#orderInfo_orderTime_edit").val(orderInfo.orderTime);
				$("#orderInfo_receiveName_edit").val(orderInfo.receiveName);
				$("#orderInfo_telephone_edit").val(orderInfo.telephone);
				$("#orderInfo_address_edit").val(orderInfo.address);
				$("#orderInfo_orderMemo_edit").val(orderInfo.orderMemo);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#orderInfo_sellObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#orderInfo_sellObj_user_name_edit").html(html);
		        		$("#orderInfo_sellObj_user_name_edit").val(orderInfo.sellObjPri);
					}
				});
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交订单信息表单给服务器端修改*/
function ajaxOrderInfoModify() {
	$.ajax({
		url :  basePath + "OrderInfo/" + $("#orderInfo_orderNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#orderInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#orderInfoQueryForm").submit();
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
    orderInfoEdit("<%=request.getParameter("orderNo")%>");
 })
 </script> 
</body>
</html>

