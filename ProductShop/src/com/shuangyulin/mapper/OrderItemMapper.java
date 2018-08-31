package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.OrderItem;

public interface OrderItemMapper {
	/*添加订单条目信息*/
	public void addOrderItem(OrderItem orderItem) throws Exception;

	/*按照查询条件分页查询订单条目记录*/
	public ArrayList<OrderItem> queryOrderItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有订单条目记录*/
	public ArrayList<OrderItem> queryOrderItemList(@Param("where") String where) throws Exception;

	/*按照查询条件的订单条目记录数*/
	public int queryOrderItemCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条订单条目记录*/
	public OrderItem getOrderItem(int itemId) throws Exception;

	/*更新订单条目记录*/
	public void updateOrderItem(OrderItem orderItem) throws Exception;

	/*删除订单条目记录*/
	public void deleteOrderItem(int itemId) throws Exception;

}
