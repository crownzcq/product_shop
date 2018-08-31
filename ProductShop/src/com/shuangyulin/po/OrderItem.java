package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderItem {
    /*条目id*/
    private Integer itemId;
    public Integer getItemId(){
        return itemId;
    }
    public void setItemId(Integer itemId){
        this.itemId = itemId;
    }

    /*所属订单*/
    private OrderInfo orderObj;
    public OrderInfo getOrderObj() {
        return orderObj;
    }
    public void setOrderObj(OrderInfo orderObj) {
        this.orderObj = orderObj;
    }

    /*订单商品*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*商品单价*/
    @NotNull(message="必须输入商品单价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*购买数量*/
    @NotNull(message="必须输入购买数量")
    private Integer orderNumer;
    public Integer getOrderNumer() {
        return orderNumer;
    }
    public void setOrderNumer(Integer orderNumer) {
        this.orderNumer = orderNumer;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderItem=new JSONObject(); 
		jsonOrderItem.accumulate("itemId", this.getItemId());
		jsonOrderItem.accumulate("orderObj", this.getOrderObj().getOrderNo());
		jsonOrderItem.accumulate("orderObjPri", this.getOrderObj().getOrderNo());
		jsonOrderItem.accumulate("productObj", this.getProductObj().getProductName());
		jsonOrderItem.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonOrderItem.accumulate("price", this.getPrice());
		jsonOrderItem.accumulate("orderNumer", this.getOrderNumer());
		return jsonOrderItem;
    }}