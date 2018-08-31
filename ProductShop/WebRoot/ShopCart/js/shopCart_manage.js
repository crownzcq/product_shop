var shopCart_manage_tool = null; 
$(function () { 
	initShopCartManageTool(); //建立ShopCart管理对象
	shopCart_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#shopCart_manage").datagrid({
		url : 'ShopCart/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "cartId",
		sortOrder : "desc",
		toolbar : "#shopCart_manage_tool",
		columns : [[
			{
				field : "cartId",
				title : "购物车id",
				width : 70,
			},
			{
				field : "productObj",
				title : "商品",
				width : 140,
			},
			{
				field : "userObj",
				title : "用户",
				width : 140,
			},
			{
				field : "price",
				title : "单价",
				width : 70,
			},
			{
				field : "buyNum",
				title : "购买数量",
				width : 70,
			},
		]],
	});

	$("#shopCartEditDiv").dialog({
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
				if ($("#shopCartEditForm").form("validate")) {
					//验证表单 
					if(!$("#shopCartEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#shopCartEditForm").form({
						    url:"ShopCart/" + $("#shopCart_cartId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#shopCartEditForm").form("validate"))  {
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
			                        $("#shopCartEditDiv").dialog("close");
			                        shopCart_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#shopCartEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#shopCartEditDiv").dialog("close");
				$("#shopCartEditForm").form("reset"); 
			},
		}],
	});
});

function initShopCartManageTool() {
	shopCart_manage_tool = {
		init: function() {
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
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#shopCart_manage").datagrid("reload");
		},
		redo : function () {
			$("#shopCart_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#shopCart_manage").datagrid("options").queryParams;
			queryParams["productObj.productId"] = $("#productObj_productId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#shopCart_manage").datagrid("options").queryParams=queryParams; 
			$("#shopCart_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#shopCartQueryForm").form({
			    url:"ShopCart/OutToExcel",
			});
			//提交表单
			$("#shopCartQueryForm").submit();
		},
		remove : function () {
			var rows = $("#shopCart_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var cartIds = [];
						for (var i = 0; i < rows.length; i ++) {
							cartIds.push(rows[i].cartId);
						}
						$.ajax({
							type : "POST",
							url : "ShopCart/deletes",
							data : {
								cartIds : cartIds.join(","),
							},
							beforeSend : function () {
								$("#shopCart_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#shopCart_manage").datagrid("loaded");
									$("#shopCart_manage").datagrid("load");
									$("#shopCart_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#shopCart_manage").datagrid("loaded");
									$("#shopCart_manage").datagrid("load");
									$("#shopCart_manage").datagrid("unselectAll");
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
			var rows = $("#shopCart_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ShopCart/" + rows[0].cartId +  "/update",
					type : "get",
					data : {
						//cartId : rows[0].cartId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (shopCart, response, status) {
						$.messager.progress("close");
						if (shopCart) { 
							$("#shopCartEditDiv").dialog("open");
							$("#shopCart_cartId_edit").val(shopCart.cartId);
							$("#shopCart_cartId_edit").validatebox({
								required : true,
								missingMessage : "请输入购物车id",
								editable: false
							});
							$("#shopCart_productObj_productId_edit").combobox({
								url:"Product/listAll",
							    valueField:"productId",
							    textField:"productName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#shopCart_productObj_productId_edit").combobox("select", shopCart.productObjPri);
									//var data = $("#shopCart_productObj_productId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#shopCart_productObj_productId_edit").combobox("select", data[0].productId);
						            //}
								}
							});
							$("#shopCart_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#shopCart_userObj_user_name_edit").combobox("select", shopCart.userObjPri);
									//var data = $("#shopCart_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#shopCart_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#shopCart_price_edit").val(shopCart.price);
							$("#shopCart_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入单价",
								invalidMessage : "单价输入不对",
							});
							$("#shopCart_buyNum_edit").val(shopCart.buyNum);
							$("#shopCart_buyNum_edit").validatebox({
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
