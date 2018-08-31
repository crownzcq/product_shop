package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ProductClass {
    /*类别id*/
    private Integer classId;
    public Integer getClassId(){
        return classId;
    }
    public void setClassId(Integer classId){
        this.classId = classId;
    }

    /*类别名称*/
    @NotEmpty(message="类别名称不能为空")
    private String className;
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }

    /*类别描述*/
    @NotEmpty(message="类别描述不能为空")
    private String classDesc;
    public String getClassDesc() {
        return classDesc;
    }
    public void setClassDesc(String classDesc) {
        this.classDesc = classDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProductClass=new JSONObject(); 
		jsonProductClass.accumulate("classId", this.getClassId());
		jsonProductClass.accumulate("className", this.getClassName());
		jsonProductClass.accumulate("classDesc", this.getClassDesc());
		return jsonProductClass;
    }}