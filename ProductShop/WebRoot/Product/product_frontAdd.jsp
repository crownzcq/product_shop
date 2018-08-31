<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.ProductClass" %>
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
<title>商品添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Product/frontlist">商品管理</a></li>
  			<li class="active">添加商品</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="productAddForm" id="productAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="product_productClassObj_classId" class="col-md-2 text-right">商品类别:</label>
				  	 <div class="col-md-8">
					    <select id="product_productClassObj_classId" name="product.productClassObj.classId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_productName" class="col-md-2 text-right">商品名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_productName" name="product.productName" class="form-control" placeholder="请输入商品名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_mainPhoto" class="col-md-2 text-right">商品主图:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="product_mainPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="product_mainPhoto" name="product.mainPhoto"/>
					    <input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_price" class="col-md-2 text-right">商品价格:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_price" name="product.price" class="form-control" placeholder="请输入商品价格">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_productDesc" class="col-md-2 text-right">商品描述:</label>
				  	 <div class="col-md-8">
							    <textarea name="product.productDesc" id="product_productDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_userObj_user_name" class="col-md-2 text-right">发布用户:</label>
				  	 <div class="col-md-8">
					    <select id="product_userObj_user_name" name="product.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_addTimeDiv" class="col-md-2 text-right">发布时间:</label>
				  	 <div class="col-md-8">
		                <div id="product_addTimeDiv" class="input-group date product_addTime col-md-12" data-link-field="product_addTime">
		                    <input class="form-control" id="product_addTime" name="product.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_sksp" class="col-md-2 text-right">试看视频:</label>
				  	 <div class="col-md-8">
					    <a id="product_skspImg" border="0px"></a><br/>
					    <input type="hidden" id="product_sksp" name="product.sksp"/>
					    <input id="skspFile" name="skspFile" type="file" size="50" />
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxProductAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#productAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var product_productDesc_editor = UE.getEditor('product_productDesc'); //商品描述编辑器
var basePath = "<%=basePath%>";
	//提交添加商品信息
	function ajaxProductAdd() { 
		//提交之前先验证表单
		$("#productAddForm").data('bootstrapValidator').validate();
		if(!$("#productAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(product_productDesc_editor.getContent() == "") {
			alert('商品描述不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Product/add",
			dataType : "json" , 
			data: new FormData($("#productAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#productAddForm").find("input").val("");
					$("#productAddForm").find("textarea").val("");
					product_productDesc_editor.setContent("");
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
	//验证商品添加表单字段
	$('#productAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"product.productName": {
				validators: {
					notEmpty: {
						message: "商品名称不能为空",
					}
				}
			},
			"product.price": {
				validators: {
					notEmpty: {
						message: "商品价格不能为空",
					},
					numeric: {
						message: "商品价格不正确"
					}
				}
			},
			"product.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化商品类别下拉框值 
	$.ajax({
		url: basePath + "ProductClass/listAll",
		type: "get",
		success: function(productClasss,response,status) { 
			$("#product_productClassObj_classId").empty();
			var html="";
    		$(productClasss).each(function(i,productClass){
    			html += "<option value='" + productClass.classId + "'>" + productClass.className + "</option>";
    		});
    		$("#product_productClassObj_classId").html(html);
    	}
	});
	//初始化发布用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#product_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#product_userObj_user_name").html(html);
    	}
	});
	//发布时间组件
	$('#product_addTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#productAddForm').data('bootstrapValidator').updateStatus('product.addTime', 'NOT_VALIDATED',null).validateField('product.addTime');
	});
})
</script>
</body>
</html>
