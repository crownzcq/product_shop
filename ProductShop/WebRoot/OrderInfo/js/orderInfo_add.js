$(function () {
	$("#orderInfo_orderNo").validatebox({
		required : true, 
		missingMessage : '请输入订单编号',
	});

	$("#orderInfo_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#orderInfo_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#orderInfo_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#orderInfo_totalMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入订单总金额',
		invalidMessage : '订单总金额输入不对',
	});

	$("#orderInfo_payWay").validatebox({
		required : true, 
		missingMessage : '请输入支付方式',
	});

	$("#orderInfo_orderStateObj").validatebox({
		required : true, 
		missingMessage : '请输入订单状态',
	});

	$("#orderInfo_receiveName").validatebox({
		required : true, 
		missingMessage : '请输入收货人',
	});

	$("#orderInfo_telephone").validatebox({
		required : true, 
		missingMessage : '请输入收货人电话',
	});

	$("#orderInfo_address").validatebox({
		required : true, 
		missingMessage : '请输入收货地址',
	});

	$("#orderInfo_sellObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#orderInfo_sellObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#orderInfo_sellObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#orderInfoAddButton").click(function () {
		//验证表单 
		if(!$("#orderInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#orderInfoAddForm").form({
			    url:"OrderInfo/add",
			    onSubmit: function(){
					if($("#orderInfoAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#orderInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#orderInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#orderInfoClearButton").click(function () { 
		$("#orderInfoAddForm").form("clear"); 
	});
});
