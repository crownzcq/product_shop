package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ShopCart {
    /*购物车id*/
    private Integer cartId;
    public Integer getCartId(){
        return cartId;
    }
    public void setCartId(Integer cartId){
        this.cartId = cartId;
    }

    /*商品*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*单价*/
    @NotNull(message="必须输入单价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*购买数量*/
    @NotNull(message="必须输入购买数量")
    private Integer buyNum;
    public Integer getBuyNum() {
        return buyNum;
    }
    public void setBuyNum(Integer buyNum) {
        this.buyNum = buyNum;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonShopCart=new JSONObject(); 
		jsonShopCart.accumulate("cartId", this.getCartId());
		jsonShopCart.accumulate("productObj", this.getProductObj().getProductName());
		jsonShopCart.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonShopCart.accumulate("userObj", this.getUserObj().getName());
		jsonShopCart.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonShopCart.accumulate("price", this.getPrice());
		jsonShopCart.accumulate("buyNum", this.getBuyNum());
		return jsonShopCart;
    }}