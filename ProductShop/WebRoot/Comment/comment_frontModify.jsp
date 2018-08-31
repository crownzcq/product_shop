<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Comment" %>
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
    Comment comment = (Comment)request.getAttribute("comment");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改商品评论信息</TITLE>
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
  		<li class="active">商品评论信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="commentEditForm" id="commentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="comment_commentId_edit" class="col-md-3 text-right">评论id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="comment_commentId_edit" name="comment.commentId" class="form-control" placeholder="请输入评论id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="comment_productObj_productId_edit" class="col-md-3 text-right">被评商品:</label>
		  	 <div class="col-md-9">
			    <select id="comment_productObj_productId_edit" name="comment.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="comment_content_edit" class="col-md-3 text-right">评论内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="comment_content_edit" name="comment.content" rows="8" class="form-control" placeholder="请输入评论内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="comment_userObj_user_name_edit" class="col-md-3 text-right">评论用户:</label>
		  	 <div class="col-md-9">
			    <select id="comment_userObj_user_name_edit" name="comment.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="comment_commentTime_edit" class="col-md-3 text-right">评论时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="comment_commentTime_edit" name="comment.commentTime" class="form-control" placeholder="请输入评论时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCommentModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#commentEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改商品评论界面并初始化数据*/
function commentEdit(commentId) {
	$.ajax({
		url :  basePath + "Comment/" + commentId + "/update",
		type : "get",
		dataType: "json",
		success : function (comment, response, status) {
			if (comment) {
				$("#comment_commentId_edit").val(comment.commentId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#comment_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#comment_productObj_productId_edit").html(html);
		        		$("#comment_productObj_productId_edit").val(comment.productObjPri);
					}
				});
				$("#comment_content_edit").val(comment.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#comment_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#comment_userObj_user_name_edit").html(html);
		        		$("#comment_userObj_user_name_edit").val(comment.userObjPri);
					}
				});
				$("#comment_commentTime_edit").val(comment.commentTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交商品评论信息表单给服务器端修改*/
function ajaxCommentModify() {
	$.ajax({
		url :  basePath + "Comment/" + $("#comment_commentId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#commentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#commentQueryForm").submit();
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
    commentEdit("<%=request.getParameter("commentId")%>");
 })
 </script> 
</body>
</html>

