package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Product {
    /*商品编号*/
    private Integer productId;
    public Integer getProductId(){
        return productId;
    }
    public void setProductId(Integer productId){
        this.productId = productId;
    }

    /*商品类别*/
    private ProductClass productClassObj;
    public ProductClass getProductClassObj() {
        return productClassObj;
    }
    public void setProductClassObj(ProductClass productClassObj) {
        this.productClassObj = productClassObj;
    }

    /*商品名称*/
    @NotEmpty(message="商品名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /*商品主图*/
    private String mainPhoto;
    public String getMainPhoto() {
        return mainPhoto;
    }
    public void setMainPhoto(String mainPhoto) {
        this.mainPhoto = mainPhoto;
    }

    /*商品价格*/
    @NotNull(message="必须输入商品价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*商品描述*/
    @NotEmpty(message="商品描述不能为空")
    private String productDesc;
    public String getProductDesc() {
        return productDesc;
    }
    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    /*发布用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*试看视频*/
    private String sksp;
    public String getSksp() {
        return sksp;
    }
    public void setSksp(String sksp) {
        this.sksp = sksp;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProduct=new JSONObject(); 
		jsonProduct.accumulate("productId", this.getProductId());
		jsonProduct.accumulate("productClassObj", this.getProductClassObj().getClassName());
		jsonProduct.accumulate("productClassObjPri", this.getProductClassObj().getClassId());
		jsonProduct.accumulate("productName", this.getProductName());
		jsonProduct.accumulate("mainPhoto", this.getMainPhoto());
		jsonProduct.accumulate("price", this.getPrice());
		jsonProduct.accumulate("productDesc", this.getProductDesc());
		jsonProduct.accumulate("userObj", this.getUserObj().getName());
		jsonProduct.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonProduct.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		jsonProduct.accumulate("sksp", this.getSksp());
		return jsonProduct;
    }}