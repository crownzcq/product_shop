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
<title>商品评论添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Comment/frontlist">商品评论列表</a></li>
			    	<li role="presentation" class="active"><a href="#commentAdd" aria-controls="commentAdd" role="tab" data-toggle="tab">添加商品评论</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="commentList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="commentAdd"> 
				      	<form class="form-horizontal" name="commentAddForm" id="commentAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="comment_productObj_productId" class="col-md-2 text-right">被评商品:</label>
						  	 <div class="col-md-8">
							    <select id="comment_productObj_productId" name="comment.productObj.productId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="comment_content" class="col-md-2 text-right">评论内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="comment_content" name="comment.content" rows="8" class="form-control" placeholder="请输入评论内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="comment_userObj_user_name" class="col-md-2 text-right">评论用户:</label>
						  	 <div class="col-md-8">
							    <select id="comment_userObj_user_name" name="comment.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="comment_commentTime" class="col-md-2 text-right">评论时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="comment_commentTime" name="comment.commentTime" class="form-control" placeholder="请输入评论时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxCommentAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#commentAddForm .form-group {margin:10px;}  </style>
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
	//提交添加商品评论信息
	function ajaxCommentAdd() { 
		//提交之前先验证表单
		$("#commentAddForm").data('bootstrapValidator').validate();
		if(!$("#commentAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Comment/add",
			dataType : "json" , 
			data: new FormData($("#commentAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#commentAddForm").find("input").val("");
					$("#commentAddForm").find("textarea").val("");
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
	//验证商品评论添加表单字段
	$('#commentAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"comment.content": {
				validators: {
					notEmpty: {
						message: "评论内容不能为空",
					}
				}
			},
		}
	}); 
	//初始化被评商品下拉框值 
	$.ajax({
		url: basePath + "Product/listAll",
		type: "get",
		success: function(products,response,status) { 
			$("#comment_productObj_productId").empty();
			var html="";
    		$(products).each(function(i,product){
    			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
    		});
    		$("#comment_productObj_productId").html(html);
    	}
	});
	//初始化评论用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#comment_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#comment_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
