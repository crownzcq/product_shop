$(function () {
	$("#orderItem_orderObj_orderNo").combobox({
	    url:'OrderInfo/listAll',
	    valueField: "orderNo",
	    textField: "orderNo",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#orderItem_orderObj_orderNo").combobox("getData"); 
            if (data.length > 0) {
                $("#orderItem_orderObj_orderNo").combobox("select", data[0].orderNo);
            }
        }
	});
	$("#orderItem_productObj_productId").combobox({
	    url:'Product/listAll',
	    valueField: "productId",
	    textField: "productName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#orderItem_productObj_productId").combobox("getData"); 
            if (data.length > 0) {
                $("#orderItem_productObj_productId").combobox("select", data[0].productId);
            }
        }
	});
	$("#orderItem_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入商品单价',
		invalidMessage : '商品单价输入不对',
	});

	$("#orderItem_orderNumer").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入购买数量',
		invalidMessage : '购买数量输入不对',
	});

	//单击添加按钮
	$("#orderItemAddButton").click(function () {
		//验证表单 
		if(!$("#orderItemAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#orderItemAddForm").form({
			    url:"OrderItem/add",
			    onSubmit: function(){
					if($("#orderItemAddForm").form("validate"))  { 
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
                        $("#orderItemAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#orderItemAddForm").submit();
		}
	});

	//单击清空按钮
	$("#orderItemClearButton").click(function () { 
		$("#orderItemAddForm").form("clear"); 
	});
});
