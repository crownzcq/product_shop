$(function () {
	$.ajax({
		url : "Comment/" + $("#comment_commentId_edit").val() + "/update",
		type : "get",
		data : {
			//commentId : $("#comment_commentId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (comment, response, status) {
			$.messager.progress("close");
			if (comment) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#commentModifyButton").click(function(){ 
		if ($("#commentEditForm").form("validate")) {
			$("#commentEditForm").form({
			    url:"Comment/" +  $("#comment_commentId_edit").val() + "/update",
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
			$("#commentEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
