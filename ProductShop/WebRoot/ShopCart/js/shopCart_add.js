$(function () {
	$("#shopCart_productObj_productId").combobox({
	    url:'Product/listAll',
	    valueField: "productId",
	    textField: "productName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#shopCart_productObj_productId").combobox("getData"); 
            if (data.length > 0) {
                $("#shopCart_productObj_productId").combobox("select", data[0].productId);
            }
        }
	});
	$("#shopCart_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#shopCart_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#shopCart_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#shopCart_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入单价',
		invalidMessage : '单价输入不对',
	});

	$("#shopCart_buyNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入购买数量',
		invalidMessage : '购买数量输入不对',
	});

	//单击添加按钮
	$("#shopCartAddButton").click(function () {
		//验证表单 
		if(!$("#shopCartAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#shopCartAddForm").form({
			    url:"ShopCart/add",
			    onSubmit: function(){
					if($("#shopCartAddForm").form("validate"))  { 
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
                        $("#shopCartAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#shopCartAddForm").submit();
		}
	});

	//单击清空按钮
	$("#shopCartClearButton").click(function () { 
		$("#shopCartAddForm").form("clear"); 
	});
});
