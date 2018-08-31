package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.ProductClass;
import com.shuangyulin.po.UserInfo;
import com.shuangyulin.po.Product;

import com.shuangyulin.mapper.ProductMapper;
@Service
public class ProductService {

	@Resource ProductMapper productMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加商品记录*/
    public void addProduct(Product product) throws Exception {
    	productMapper.addProduct(product);
    }

    /*按照查询条件分页查询商品记录*/
    public ArrayList<Product> queryProduct(ProductClass productClassObj,String productName,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productClassObj && productClassObj.getClassId()!= null && productClassObj.getClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getClassId();
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_product.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_product.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return productMapper.queryProduct(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Product> queryProduct(ProductClass productClassObj,String productName,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productClassObj && productClassObj.getClassId()!= null && productClassObj.getClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getClassId();
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_product.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_product.addTime like '%" + addTime + "%'";
    	return productMapper.queryProductList(where);
    }

    /*查询所有商品记录*/
    public ArrayList<Product> queryAllProduct()  throws Exception {
        return productMapper.queryProductList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(ProductClass productClassObj,String productName,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != productClassObj && productClassObj.getClassId()!= null && productClassObj.getClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getClassId();
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_product.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_product.addTime like '%" + addTime + "%'";
        recordNumber = productMapper.queryProductCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商品记录*/
    public Product getProduct(int productId) throws Exception  {
        Product product = productMapper.getProduct(productId);
        return product;
    }

    /*更新商品记录*/
    public void updateProduct(Product product) throws Exception {
        productMapper.updateProduct(product);
    }

    /*删除一条商品记录*/
    public void deleteProduct (int productId) throws Exception {
        productMapper.deleteProduct(productId);
    }

    /*删除多条商品信息*/
    public int deleteProducts (String productIds) throws Exception {
    	String _productIds[] = productIds.split(",");
    	for(String _productId: _productIds) {
    		productMapper.deleteProduct(Integer.parseInt(_productId));
    	}
    	return _productIds.length;
    }
}
