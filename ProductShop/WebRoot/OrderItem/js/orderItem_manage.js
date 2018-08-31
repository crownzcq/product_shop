var orderItem_manage_tool = null; 
$(function () { 
	initOrderItemManageTool(); //建立OrderItem管理对象
	orderItem_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#orderItem_manage").datagrid({
		url : 'OrderItem/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "itemId",
		sortOrder : "desc",
		toolbar : "#orderItem_manage_tool",
		columns : [[
			{
				field : "itemId",
				title : "条目id",
				width : 70,
			},
			{
				field : "orderObj",
				title : "所属订单",
				width : 140,
			},
			{
				field : "productObj",
				title : "订单商品",
				width : 140,
			},
			{
				field : "price",
				title : "商品单价",
				width : 70,
			},
			{
				field : "orderNumer",
				title : "购买数量",
				width : 70,
			},
		]],
	});

	$("#orderItemEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#orderItemEditForm").form("validate")) {
					//验证表单 
					if(!$("#orderItemEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#orderItemEditForm").form({
						    url:"OrderItem/" + $("#orderItem_itemId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#orderItemEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#orderItemEditDiv").dialog("close");
			                        orderItem_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#orderItemEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#orderItemEditDiv").dialog("close");
				$("#orderItemEditForm").form("reset"); 
			},
		}],
	});
});

function initOrderItemManageTool() {
	orderItem_manage_tool = {
		init: function() {
			$.ajax({
				url : "OrderInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#orderObj_orderNo_query").combobox({ 
					    valueField:"orderNo",
					    textField:"orderNo",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{orderNo:"",orderNo:"不限制"});
					$("#orderObj_orderNo_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Product/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#productObj_productId_query").combobox({ 
					    valueField:"productId",
					    textField:"productName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{productId:0,productName:"不限制"});
					$("#productObj_productId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#orderItem_manage").datagrid("reload");
		},
		redo : function () {
			$("#orderItem_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#orderItem_manage").datagrid("options").queryParams;
			queryParams["orderObj.orderNo"] = $("#orderObj_orderNo_query").combobox("getValue");
			queryParams["productObj.productId"] = $("#productObj_productId_query").combobox("getValue");
			$("#orderItem_manage").datagrid("options").queryParams=queryParams; 
			$("#orderItem_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#orderItemQueryForm").form({
			    url:"OrderItem/OutToExcel",
			});
			//提交表单
			$("#orderItemQueryForm").submit();
		},
		remove : function () {
			var rows = $("#orderItem_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var itemIds = [];
						for (var i = 0; i < rows.length; i ++) {
							itemIds.push(rows[i].itemId);
						}
						$.ajax({
							type : "POST",
							url : "OrderItem/deletes",
							data : {
								itemIds : itemIds.join(","),
							},
							beforeSend : function () {
								$("#orderItem_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#orderItem_manage").datagrid("loaded");
									$("#orderItem_manage").datagrid("load");
									$("#orderItem_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#orderItem_manage").datagrid("loaded");
									$("#orderItem_manage").datagrid("load");
									$("#orderItem_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#orderItem_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "OrderItem/" + rows[0].itemId +  "/update",
					type : "get",
					data : {
						//itemId : rows[0].itemId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (orderItem, response, status) {
						$.messager.progress("close");
						if (orderItem) { 
							$("#orderItemEditDiv").dialog("open");
							$("#orderItem_itemId_edit").val(orderItem.itemId);
							$("#orderItem_itemId_edit").validatebox({
								required : true,
								missingMessage : "请输入条目id",
								editable: false
							});
							$("#orderItem_orderObj_orderNo_edit").combobox({
								url:"OrderInfo/listAll",
							    valueField:"orderNo",
							    textField:"orderNo",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#orderItem_orderObj_orderNo_edit").combobox("select", orderItem.orderObjPri);
									//var data = $("#orderItem_orderObj_orderNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#orderItem_orderObj_orderNo_edit").combobox("select", data[0].orderNo);
						            //}
								}
							});
							$("#orderItem_productObj_productId_edit").combobox({
								url:"Product/listAll",
							    valueField:"productId",
							    textField:"productName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#orderItem_productObj_productId_edit").combobox("select", orderItem.productObjPri);
									//var data = $("#orderItem_productObj_productId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#orderItem_productObj_productId_edit").combobox("select", data[0].productId);
						            //}
								}
							});
							$("#orderItem_price_edit").val(orderItem.price);
							$("#orderItem_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入商品单价",
								invalidMessage : "商品单价输入不对",
							});
							$("#orderItem_orderNumer_edit").val(orderItem.orderNumer);
							$("#orderItem_orderNumer_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入购买数量",
								invalidMessage : "购买数量输入不对",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
