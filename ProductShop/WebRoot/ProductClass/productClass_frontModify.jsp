<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.ProductClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    ProductClass productClass = (ProductClass)request.getAttribute("productClass");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改商品分类信息</TITLE>
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
  		<li class="active">商品分类信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="productClassEditForm" id="productClassEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="productClass_classId_edit" class="col-md-3 text-right">类别id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="productClass_classId_edit" name="productClass.classId" class="form-control" placeholder="请输入类别id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="productClass_className_edit" class="col-md-3 text-right">类别名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="productClass_className_edit" name="productClass.className" class="form-control" placeholder="请输入类别名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productClass_classDesc_edit" class="col-md-3 text-right">类别描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="productClass_classDesc_edit" name="productClass.classDesc" rows="8" class="form-control" placeholder="请输入类别描述"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxProductClassModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#productClassEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改商品分类界面并初始化数据*/
function productClassEdit(classId) {
	$.ajax({
		url :  basePath + "ProductClass/" + classId + "/update",
		type : "get",
		dataType: "json",
		success : function (productClass, response, status) {
			if (productClass) {
				$("#productClass_classId_edit").val(productClass.classId);
				$("#productClass_className_edit").val(productClass.className);
				$("#productClass_classDesc_edit").val(productClass.classDesc);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交商品分类信息表单给服务器端修改*/
function ajaxProductClassModify() {
	$.ajax({
		url :  basePath + "ProductClass/" + $("#productClass_classId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#productClassEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "ProductClass/frontlist";
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
    productClassEdit("<%=request.getParameter("classId")%>");
 })
 </script> 
</body>
</html>

