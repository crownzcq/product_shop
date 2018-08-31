<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OrderItem" %>
<%@ page import="com.shuangyulin.po.OrderInfo" %>
<%@ page import="com.shuangyulin.po.Product" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<OrderItem> orderItemList = (List<OrderItem>)request.getAttribute("orderItemList");
    //获取所有的orderObj信息
    List<OrderInfo> orderInfoList = (List<OrderInfo>)request.getAttribute("orderInfoList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    OrderInfo orderObj = (OrderInfo)request.getAttribute("orderObj");
    Product productObj = (Product)request.getAttribute("productObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>订单条目查询</title>
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
			    	<li role="presentation" class="active"><a href="#orderItemListPanel" aria-controls="orderItemListPanel" role="tab" data-toggle="tab">订单条目列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>OrderItem/orderItem_frontAdd.jsp" style="display:none;">添加订单条目</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="orderItemListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>条目id</td><td>所属订单</td><td>订单商品</td><td>商品单价</td><td>购买数量</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<orderItemList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		OrderItem orderItem = orderItemList.get(i); //获取到订单条目对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=orderItem.getItemId() %></td>
 											<td><%=orderItem.getOrderObj().getOrderNo() %></td>
 											<td><%=orderItem.getProductObj().getProductName() %></td>
 											<td><%=orderItem.getPrice() %></td>
 											<td><%=orderItem.getOrderNumer() %></td>
 											<td>
 												<a href="<%=basePath  %>OrderItem/<%=orderItem.getItemId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="orderItemEdit('<%=orderItem.getItemId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="orderItemDelete('<%=orderItem.getItemId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>订单条目查询</h1>
		</div>
		<form name="orderItemQueryForm" id="orderItemQueryForm" action="<%=basePath %>OrderItem/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="orderObj_orderNo">所属订单：</label>
                <select id="orderObj_orderNo" name="orderObj.orderNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(OrderInfo orderInfoTemp:orderInfoList) {
	 					String selected = "";
 					if(orderObj!=null && orderObj.getOrderNo()!=null && orderObj.getOrderNo().equals(orderInfoTemp.getOrderNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=orderInfoTemp.getOrderNo() %>" <%=selected %>><%=orderInfoTemp.getOrderNo() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="productObj_productId">订单商品：</label>
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
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="orderItemEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;订单条目信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="orderItemEditForm" id="orderItemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="orderItem_itemId_edit" class="col-md-3 text-right">条目id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="orderItem_itemId_edit" name="orderItem.itemId" class="form-control" placeholder="请输入条目id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="orderItem_orderObj_orderNo_edit" class="col-md-3 text-right">所属订单:</label>
		  	 <div class="col-md-9">
			    <select id="orderItem_orderObj_orderNo_edit" name="orderItem.orderObj.orderNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderItem_productObj_productId_edit" class="col-md-3 text-right">订单商品:</label>
		  	 <div class="col-md-9">
			    <select id="orderItem_productObj_productId_edit" name="orderItem.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderItem_price_edit" class="col-md-3 text-right">商品单价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderItem_price_edit" name="orderItem.price" class="form-control" placeholder="请输入商品单价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderItem_orderNumer_edit" class="col-md-3 text-right">购买数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderItem_orderNumer_edit" name="orderItem.orderNumer" class="form-control" placeholder="请输入购买数量">
			 </div>
		  </div>
		</form> 
	    <style>#orderItemEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOrderItemModify();">提交</button>
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
    document.orderItemQueryForm.currentPage.value = currentPage;
    document.orderItemQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.orderItemQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.orderItemQueryForm.currentPage.value = pageValue;
    documentorderItemQueryForm.submit();
}

/*弹出修改订单条目界面并初始化数据*/
function orderItemEdit(itemId) {
	$.ajax({
		url :  basePath + "OrderItem/" + itemId + "/update",
		type : "get",
		dataType: "json",
		success : function (orderItem, response, status) {
			if (orderItem) {
				$("#orderItem_itemId_edit").val(orderItem.itemId);
				$.ajax({
					url: basePath + "OrderInfo/listAll",
					type: "get",
					success: function(orderInfos,response,status) { 
						$("#orderItem_orderObj_orderNo_edit").empty();
						var html="";
		        		$(orderInfos).each(function(i,orderInfo){
		        			html += "<option value='" + orderInfo.orderNo + "'>" + orderInfo.orderNo + "</option>";
		        		});
		        		$("#orderItem_orderObj_orderNo_edit").html(html);
		        		$("#orderItem_orderObj_orderNo_edit").val(orderItem.orderObjPri);
					}
				});
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#orderItem_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#orderItem_productObj_productId_edit").html(html);
		        		$("#orderItem_productObj_productId_edit").val(orderItem.productObjPri);
					}
				});
				$("#orderItem_price_edit").val(orderItem.price);
				$("#orderItem_orderNumer_edit").val(orderItem.orderNumer);
				$('#orderItemEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除订单条目信息*/
function orderItemDelete(itemId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "OrderItem/deletes",
			data : {
				itemIds : itemId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#orderItemQueryForm").submit();
					//location.href= basePath + "OrderItem/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交订单条目信息表单给服务器端修改*/
function ajaxOrderItemModify() {
	$.ajax({
		url :  basePath + "OrderItem/" + $("#orderItem_itemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#orderItemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#orderItemQueryForm").submit();
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

