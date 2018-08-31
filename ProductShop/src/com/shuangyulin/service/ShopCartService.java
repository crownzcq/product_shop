package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Product;
import com.shuangyulin.po.UserInfo;
import com.shuangyulin.po.ShopCart;

import com.shuangyulin.mapper.ShopCartMapper;
@Service
public class ShopCartService {

	@Resource ShopCartMapper shopCartMapper;
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

    /*添加购物车记录*/
    public void addShopCart(ShopCart shopCart) throws Exception {
    	shopCartMapper.addShopCart(shopCart);
    }

    /*按照查询条件分页查询购物车记录*/
    public ArrayList<ShopCart> queryShopCart(Product productObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_shopCart.productObj=" + productObj.getProductId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_shopCart.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return shopCartMapper.queryShopCart(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ShopCart> queryShopCart(Product productObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_shopCart.productObj=" + productObj.getProductId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_shopCart.userObj='" + userObj.getUser_name() + "'";
    	return shopCartMapper.queryShopCartList(where);
    }

    /*查询所有购物车记录*/
    public ArrayList<ShopCart> queryAllShopCart()  throws Exception {
        return shopCartMapper.queryShopCartList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Product productObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_shopCart.productObj=" + productObj.getProductId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_shopCart.userObj='" + userObj.getUser_name() + "'";
        recordNumber = shopCartMapper.queryShopCartCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取购物车记录*/
    public ShopCart getShopCart(int cartId) throws Exception  {
        ShopCart shopCart = shopCartMapper.getShopCart(cartId);
        return shopCart;
    }

    /*更新购物车记录*/
    public void updateShopCart(ShopCart shopCart) throws Exception {
        shopCartMapper.updateShopCart(shopCart);
    }

    /*删除一条购物车记录*/
    public void deleteShopCart (int cartId) throws Exception {
        shopCartMapper.deleteShopCart(cartId);
    }

    /*删除多条购物车信息*/
    public int deleteShopCarts (String cartIds) throws Exception {
    	String _cartIds[] = cartIds.split(",");
    	for(String _cartId: _cartIds) {
    		shopCartMapper.deleteShopCart(Integer.parseInt(_cartId));
    	}
    	return _cartIds.length;
    }
}
