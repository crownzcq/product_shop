var comment_manage_tool = null; 
$(function () { 
	initCommentManageTool(); //建立Comment管理对象
	comment_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#comment_manage").datagrid({
		url : 'Comment/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "commentId",
		sortOrder : "desc",
		toolbar : "#comment_manage_tool",
		columns : [[
			{
				field : "commentId",
				title : "评论id",
				width : 70,
			},
			{
				field : "productObj",
				title : "被评商品",
				width : 140,
			},
			{
				field : "content",
				title : "评论内容",
				width : 140,
			},
			{
				field : "userObj",
				title : "评论用户",
				width : 140,
			},
			{
				field : "commentTime",
				title : "评论时间",
				width : 140,
			},
		]],
	});

	$("#commentEditDiv").dialog({
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
				if ($("#commentEditForm").form("validate")) {
					//验证表单 
					if(!$("#commentEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#commentEditForm").form({
						    url:"Comment/" + $("#comment_commentId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#commentEditForm").form("validate"))  {
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
			                        $("#commentEditDiv").dialog("close");
			                        comment_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#commentEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#commentEditDiv").dialog("close");
				$("#commentEditForm").form("reset"); 
			},
		}],
	});
});

function initCommentManageTool() {
	comment_manage_tool = {
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
			$("#comment_manage").datagrid("reload");
		},
		redo : function () {
			$("#comment_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#comment_manage").datagrid("options").queryParams;
			queryParams["productObj.productId"] = $("#productObj_productId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["commentTime"] = $("#commentTime").val();
			$("#comment_manage").datagrid("options").queryParams=queryParams; 
			$("#comment_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#commentQueryForm").form({
			    url:"Comment/OutToExcel",
			});
			//提交表单
			$("#commentQueryForm").submit();
		},
		remove : function () {
			var rows = $("#comment_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var commentIds = [];
						for (var i = 0; i < rows.length; i ++) {
							commentIds.push(rows[i].commentId);
						}
						$.ajax({
							type : "POST",
							url : "Comment/deletes",
							data : {
								commentIds : commentIds.join(","),
							},
							beforeSend : function () {
								$("#comment_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#comment_manage").datagrid("loaded");
									$("#comment_manage").datagrid("load");
									$("#comment_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#comment_manage").datagrid("loaded");
									$("#comment_manage").datagrid("load");
									$("#comment_manage").datagrid("unselectAll");
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
			var rows = $("#comment_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Comment/" + rows[0].commentId +  "/update",
					type : "get",
					data : {
						//commentId : rows[0].commentId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (comment, response, status) {
						$.messager.progress("close");
						if (comment) { 
							$("#commentEditDiv").dialog("open");
							$("#comment_commentId_edit").val(comment.commentId);
							$("#comment_commentId_edit").validatebox({
								required : true,
								missingMessage : "请输入评论id",
								editable: false
							});
							$("#comment_productObj_productId_edit").combobox({
								url:"Product/listAll",
							    valueField:"productId",
							    textField:"productName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#comment_productObj_productId_edit").combobox("select", comment.productObjPri);
									//var data = $("#comment_productObj_productId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#comment_productObj_productId_edit").combobox("select", data[0].productId);
						            //}
								}
							});
							$("#comment_content_edit").val(comment.content);
							$("#comment_content_edit").validatebox({
								required : true,
								missingMessage : "请输入评论内容",
							});
							$("#comment_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#comment_userObj_user_name_edit").combobox("select", comment.userObjPri);
									//var data = $("#comment_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#comment_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#comment_commentTime_edit").val(comment.commentTime);
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
