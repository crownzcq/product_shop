<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Product" %>
<%@ page import="com.shuangyulin.po.ProductClass" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ProductClass productClassObj = (ProductClass)request.getAttribute("productClassObj");
    String productName = (String)request.getAttribute("productName"); //商品名称查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商品查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Product/frontlist">商品信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Product/product_frontAdd.jsp" style="display:none;">添加商品</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<productList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Product product = productList.get(i); //获取到商品对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Product/<%=product.getProductId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=product.getMainPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		商品编号:<%=product.getProductId() %>
			     	</div>
			     	<div class="field">
	            		商品类别:<%=product.getProductClassObj().getClassName() %>
			     	</div>
			     	<div class="field">
	            		商品名称:<%=product.getProductName() %>
			     	</div>
			     	<div class="field">
	            		商品价格:<%=product.getPrice() %>
			     	</div>
			     	<div class="field">
	            		发布用户:<%=product.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=product.getAddTime() %>
			     	</div>
			     	<div class="field">
	            		试看视频:<%=product.getSksp().equals("")?"暂无文件":"<a href='" + basePath + product.getSksp() + "' target='_blank'>" + product.getSksp() + "</a>"%>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Product/<%=product.getProductId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="productEdit('<%=product.getProductId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="productDelete('<%=product.getProductId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>商品查询</h1>
		</div>
		<form name="productQueryForm" id="productQueryForm" action="<%=basePath %>Product/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="productClassObj_classId">商品类别：</label>
                <select id="productClassObj_classId" name="productClassObj.classId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ProductClass productClassTemp:productClassList) {
	 					String selected = "";
 					if(productClassObj!=null && productClassObj.getClassId()!=null && productClassObj.getClassId().intValue()==productClassTemp.getClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=productClassTemp.getClassId() %>" <%=selected %>><%=productClassTemp.getClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="productName">商品名称:</label>
				<input type="text" id="productName" name="productName" value="<%=productName %>" class="form-control" placeholder="请输入商品名称">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">发布用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="productEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;商品信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="productEditForm" id="productEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="product_productId_edit" class="col-md-3 text-right">商品编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="product_productId_edit" name="product.productId" class="form-control" placeholder="请输入商品编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="product_productClassObj_classId_edit" class="col-md-3 text-right">商品类别:</label>
		  	 <div class="col-md-9">
			    <select id="product_productClassObj_classId_edit" name="product.productClassObj.classId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productName_edit" class="col-md-3 text-right">商品名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_productName_edit" name="product.productName" class="form-control" placeholder="请输入商品名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_mainPhoto_edit" class="col-md-3 text-right">商品主图:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="product_mainPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="product_mainPhoto" name="product.mainPhoto"/>
			    <input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_price_edit" class="col-md-3 text-right">商品价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_price_edit" name="product.price" class="form-control" placeholder="请输入商品价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productDesc_edit" class="col-md-3 text-right">商品描述:</label>
		  	 <div class="col-md-9">
			 	<textarea name="product.productDesc" id="product_productDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_userObj_user_name_edit" class="col-md-3 text-right">发布用户:</label>
		  	 <div class="col-md-9">
			    <select id="product_userObj_user_name_edit" name="product.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date product_addTime_edit col-md-12" data-link-field="product_addTime_edit">
                    <input class="form-control" id="product_addTime_edit" name="product.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_sksp_edit" class="col-md-3 text-right">试看视频:</label>
		  	 <div class="col-md-9">
			    <a id="product_skspA" target="_blank"></a><br/>
			    <input type="hidden" id="product_sksp" name="product.sksp"/>
			    <input id="skspFile" name="skspFile" type="file" size="50" />
		  	 </div>
		  </div>
		</form> 
	    <style>#productEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxProductModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var product_productDesc_edit = UE.getEditor('product_productDesc_edit'); //商品描述编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.productQueryForm.currentPage.value = currentPage;
    document.productQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.productQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.productQueryForm.currentPage.value = pageValue;
    documentproductQueryForm.submit();
}

/*弹出修改商品界面并初始化数据*/
function productEdit(productId) {
	$.ajax({
		url :  basePath + "Product/" + productId + "/update",
		type : "get",
		dataType: "json",
		success : function (product, response, status) {
			if (product) {
				$("#product_productId_edit").val(product.productId);
				$.ajax({
					url: basePath + "ProductClass/listAll",
					type: "get",
					success: function(productClasss,response,status) { 
						$("#product_productClassObj_classId_edit").empty();
						var html="";
		        		$(productClasss).each(function(i,productClass){
		        			html += "<option value='" + productClass.classId + "'>" + productClass.className + "</option>";
		        		});
		        		$("#product_productClassObj_classId_edit").html(html);
		        		$("#product_productClassObj_classId_edit").val(product.productClassObjPri);
					}
				});
				$("#product_productName_edit").val(product.productName);
				$("#product_mainPhoto").val(product.mainPhoto);
				$("#product_mainPhotoImg").attr("src", basePath +　product.mainPhoto);
				$("#product_price_edit").val(product.price);
				product_productDesc_edit.setContent(product.productDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#product_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#product_userObj_user_name_edit").html(html);
		        		$("#product_userObj_user_name_edit").val(product.userObjPri);
					}
				});
				$("#product_addTime_edit").val(product.addTime);
				$("#product_sksp").val(product.sksp);
				$("#product_skspA").text(product.sksp);
				$("#product_skspA").attr("href", basePath +　product.sksp);
				$('#productEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除商品信息*/
function productDelete(productId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Product/deletes",
			data : {
				productIds : productId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#productQueryForm").submit();
					//location.href= basePath + "Product/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交商品信息表单给服务器端修改*/
function ajaxProductModify() {
	$.ajax({
		url :  basePath + "Product/" + $("#product_productId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#productEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#productQueryForm").submit();
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

    /*发布时间组件*/
    $('.product_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

