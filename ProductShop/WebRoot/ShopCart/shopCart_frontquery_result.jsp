<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.ShopCart" %>
<%@ page import="com.shuangyulin.po.Product" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ShopCart> shopCartList = (List<ShopCart>)request.getAttribute("shopCartList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Product productObj = (Product)request.getAttribute("productObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>购物车查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#shopCartListPanel" aria-controls="shopCartListPanel" role="tab" data-toggle="tab">购物车列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ShopCart/shopCart_frontAdd.jsp" style="display:none;">添加购物车</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="shopCartListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>购物车id</td><td>商品</td><td>用户</td><td>单价</td><td>购买数量</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<shopCartList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		ShopCart shopCart = shopCartList.get(i); //获取到购物车对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=shopCart.getCartId() %></td>
 											<td><%=shopCart.getProductObj().getProductName() %></td>
 											<td><%=shopCart.getUserObj().getName() %></td>
 											<td><%=shopCart.getPrice() %></td>
 											<td><%=shopCart.getBuyNum() %></td>
 											<td>
 												<a href="<%=basePath  %>ShopCart/<%=shopCart.getCartId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="shopCartEdit('<%=shopCart.getCartId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="shopCartDelete('<%=shopCart.getCartId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>购物车查询</h1>
		</div>
		<form name="shopCartQueryForm" id="shopCartQueryForm" action="<%=basePath %>ShopCart/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="productObj_productId">商品：</label>
                <select id="productObj_productId" name="productObj.productId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Product productTemp:productList) {
	 					String selected = "";
 					if(productObj!=null && productObj.getProductId()!=null && productObj.getProductId().intValue()==productTemp.getProductId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=productTemp.getProductId() %>" <%=selected %>><%=productTemp.getProductName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">用户：</label>
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
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="shopCartEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;购物车信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#shopCartEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxShopCartModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.shopCartQueryForm.currentPage.value = currentPage;
    document.shopCartQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.shopCartQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.shopCartQueryForm.currentPage.value = pageValue;
    documentshopCartQueryForm.submit();
}

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
				$('#shopCartEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除购物车信息*/
function shopCartDelete(cartId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ShopCart/deletes",
			data : {
				cartIds : cartId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#shopCartQueryForm").submit();
					//location.href= basePath + "ShopCart/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

