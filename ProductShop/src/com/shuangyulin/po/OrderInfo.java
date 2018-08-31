package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderInfo {
    /*订单编号*/
    @NotEmpty(message="订单编号不能为空")
    private String orderNo;
    public String getOrderNo(){
        return orderNo;
    }
    public void setOrderNo(String orderNo){
        this.orderNo = orderNo;
    }

    /*下单用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*订单总金额*/
    @NotNull(message="必须输入订单总金额")
    private Float totalMoney;
    public Float getTotalMoney() {
        return totalMoney;
    }
    public void setTotalMoney(Float totalMoney) {
        this.totalMoney = totalMoney;
    }

    /*支付方式*/
    @NotEmpty(message="支付方式不能为空")
    private String payWay;
    public String getPayWay() {
        return payWay;
    }
    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    /*订单状态*/
    @NotEmpty(message="订单状态不能为空")
    private String orderStateObj;
    public String getOrderStateObj() {
        return orderStateObj;
    }
    public void setOrderStateObj(String orderStateObj) {
        this.orderStateObj = orderStateObj;
    }

    /*下单时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    /*收货人*/
    @NotEmpty(message="收货人不能为空")
    private String receiveName;
    public String getReceiveName() {
        return receiveName;
    }
    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    /*收货人电话*/
    @NotEmpty(message="收货人电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*收货地址*/
    @NotEmpty(message="收货地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*订单备注*/
    private String orderMemo;
    public String getOrderMemo() {
        return orderMemo;
    }
    public void setOrderMemo(String orderMemo) {
        this.orderMemo = orderMemo;
    }

    /*商家*/
    private UserInfo sellObj;
    public UserInfo getSellObj() {
        return sellObj;
    }
    public void setSellObj(UserInfo sellObj) {
        this.sellObj = sellObj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderInfo=new JSONObject(); 
		jsonOrderInfo.accumulate("orderNo", this.getOrderNo());
		jsonOrderInfo.accumulate("userObj", this.getUserObj().getName());
		jsonOrderInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOrderInfo.accumulate("totalMoney", this.getTotalMoney());
		jsonOrderInfo.accumulate("payWay", this.getPayWay());
		jsonOrderInfo.accumulate("orderStateObj", this.getOrderStateObj());
		jsonOrderInfo.accumulate("orderTime", this.getOrderTime());
		jsonOrderInfo.accumulate("receiveName", this.getReceiveName());
		jsonOrderInfo.accumulate("telephone", this.getTelephone());
		jsonOrderInfo.accumulate("address", this.getAddress());
		jsonOrderInfo.accumulate("orderMemo", this.getOrderMemo());
		jsonOrderInfo.accumulate("sellObj", this.getSellObj().getName());
		jsonOrderInfo.accumulate("sellObjPri", this.getSellObj().getUser_name());
		return jsonOrderInfo;
    }}