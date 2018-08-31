$(function () {
	$.ajax({
		url : "ShopCart/" + $("#shopCart_cartId_edit").val() + "/update",
		type : "get",
		data : {
			//cartId : $("#shopCart_cartId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (shopCart, response, status) {
			$.messager.progress("close");
			if (shopCart) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#shopCartModifyButton").click(function(){ 
		if ($("#shopCartEditForm").form("validate")) {
			$("#shopCartEditForm").form({
			    url:"ShopCart/" +  $("#shopCart_cartId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#shopCartEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
