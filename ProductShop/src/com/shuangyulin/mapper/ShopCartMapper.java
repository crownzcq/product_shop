package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.ShopCart;

public interface ShopCartMapper {
	/*添加购物车信息*/
	public void addShopCart(ShopCart shopCart) throws Exception;

	/*按照查询条件分页查询购物车记录*/
	public ArrayList<ShopCart> queryShopCart(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有购物车记录*/
	public ArrayList<ShopCart> queryShopCartList(@Param("where") String where) throws Exception;

	/*按照查询条件的购物车记录数*/
	public int queryShopCartCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条购物车记录*/
	public ShopCart getShopCart(int cartId) throws Exception;

	/*更新购物车记录*/
	public void updateShopCart(ShopCart shopCart) throws Exception;

	/*删除购物车记录*/
	public void deleteShopCart(int cartId) throws Exception;

}
