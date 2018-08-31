$(function () {
	$.ajax({
		url : "OrderInfo/" + $("#orderInfo_orderNo_edit").val() + "/update",
		type : "get",
		data : {
			//orderNo : $("#orderInfo_orderNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (orderInfo, response, status) {
			$.messager.progress("close");
			if (orderInfo) { 
				$("#orderInfo_orderNo_edit").val(orderInfo.orderNo);
				$("#orderInfo_orderNo_edit").validatebox({
					required : true,
					missingMessage : "请输入订单编号",
					editable: false
				});
				$("#orderInfo_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#orderInfo_userObj_user_name_edit").combobox("select", orderInfo.userObjPri);
						//var data = $("#orderInfo_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#orderInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#orderInfo_totalMoney_edit").val(orderInfo.totalMoney);
				$("#orderInfo_totalMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入订单总金额",
					invalidMessage : "订单总金额输入不对",
				});
				$("#orderInfo_payWay_edit").val(orderInfo.payWay);
				$("#orderInfo_payWay_edit").validatebox({
					required : true,
					missingMessage : "请输入支付方式",
				});
				$("#orderInfo_orderStateObj_edit").val(orderInfo.orderStateObj);
				$("#orderInfo_orderStateObj_edit").validatebox({
					required : true,
					missingMessage : "请输入订单状态",
				});
				$("#orderInfo_orderTime_edit").val(orderInfo.orderTime);
				$("#orderInfo_receiveName_edit").val(orderInfo.receiveName);
				$("#orderInfo_receiveName_edit").validatebox({
					required : true,
					missingMessage : "请输入收货人",
				});
				$("#orderInfo_telephone_edit").val(orderInfo.telephone);
				$("#orderInfo_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入收货人电话",
				});
				$("#orderInfo_address_edit").val(orderInfo.address);
				$("#orderInfo_address_edit").validatebox({
					required : true,
					missingMessage : "请输入收货地址",
				});
				$("#orderInfo_orderMemo_edit").val(orderInfo.orderMemo);
				$("#orderInfo_sellObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#orderInfo_sellObj_user_name_edit").combobox("select", orderInfo.sellObjPri);
						//var data = $("#orderInfo_sellObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#orderInfo_sellObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#orderInfoModifyButton").click(function(){ 
		if ($("#orderInfoEditForm").form("validate")) {
			$("#orderInfoEditForm").form({
			    url:"OrderInfo/" +  $("#orderInfo_orderNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#orderInfoEditForm").form("validate"))  {
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
			$("#orderInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
