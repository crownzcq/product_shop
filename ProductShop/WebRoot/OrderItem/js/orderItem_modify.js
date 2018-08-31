$(function () {
	$.ajax({
		url : "OrderItem/" + $("#orderItem_itemId_edit").val() + "/update",
		type : "get",
		data : {
			//itemId : $("#orderItem_itemId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (orderItem, response, status) {
			$.messager.progress("close");
			if (orderItem) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#orderItemModifyButton").click(function(){ 
		if ($("#orderItemEditForm").form("validate")) {
			$("#orderItemEditForm").form({
			    url:"OrderItem/" +  $("#orderItem_itemId_edit").val() + "/update",
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
			$("#orderItemEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
