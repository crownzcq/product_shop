package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.OrderInfo;

public interface OrderInfoMapper {
	/*添加订单信息*/
	public void addOrderInfo(OrderInfo orderInfo) throws Exception;

	/*按照查询条件分页查询订单记录*/
	public ArrayList<OrderInfo> queryOrderInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有订单记录*/
	public ArrayList<OrderInfo> queryOrderInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的订单记录数*/
	public int queryOrderInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条订单记录*/
	public OrderInfo getOrderInfo(String orderNo) throws Exception;

	/*更新订单记录*/
	public void updateOrderInfo(OrderInfo orderInfo) throws Exception;

	/*删除订单记录*/
	public void deleteOrderInfo(String orderNo) throws Exception;

}
