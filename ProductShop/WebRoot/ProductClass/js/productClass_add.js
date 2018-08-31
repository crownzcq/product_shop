$(function () {
	$("#productClass_className").validatebox({
		required : true, 
		missingMessage : '请输入类别名称',
	});

	$("#productClass_classDesc").validatebox({
		required : true, 
		missingMessage : '请输入类别描述',
	});

	//单击添加按钮
	$("#productClassAddButton").click(function () {
		//验证表单 
		if(!$("#productClassAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#productClassAddForm").form({
			    url:"ProductClass/add",
			    onSubmit: function(){
					if($("#productClassAddForm").form("validate"))  { 
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
                        $("#productClassAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#productClassAddForm").submit();
		}
	});

	//单击清空按钮
	$("#productClassClearButton").click(function () { 
		$("#productClassAddForm").form("clear"); 
	});
});
