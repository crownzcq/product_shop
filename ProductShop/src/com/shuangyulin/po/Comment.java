package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Comment {
    /*评论id*/
    private Integer commentId;
    public Integer getCommentId(){
        return commentId;
    }
    public void setCommentId(Integer commentId){
        this.commentId = commentId;
    }

    /*被评商品*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*评论内容*/
    @NotEmpty(message="评论内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*评论用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*评论时间*/
    private String commentTime;
    public String getCommentTime() {
        return commentTime;
    }
    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonComment=new JSONObject(); 
		jsonComment.accumulate("commentId", this.getCommentId());
		jsonComment.accumulate("productObj", this.getProductObj().getProductName());
		jsonComment.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonComment.accumulate("content", this.getContent());
		jsonComment.accumulate("userObj", this.getUserObj().getName());
		jsonComment.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonComment.accumulate("commentTime", this.getCommentTime());
		return jsonComment;
    }}