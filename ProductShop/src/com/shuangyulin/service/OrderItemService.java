package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.OrderInfo;
import com.shuangyulin.po.Product;
import com.shuangyulin.po.OrderItem;

import com.shuangyulin.mapper.OrderItemMapper;
@Service
public class OrderItemService {

	@Resource OrderItemMapper orderItemMapper;
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

    /*添加订单条目记录*/
    public void addOrderItem(OrderItem orderItem) throws Exception {
    	orderItemMapper.addOrderItem(orderItem);
    }

    /*按照查询条件分页查询订单条目记录*/
    public ArrayList<OrderItem> queryOrderItem(OrderInfo orderObj,Product productObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != orderObj &&  orderObj.getOrderNo() != null  && !orderObj.getOrderNo().equals(""))  where += " and t_orderItem.orderObj='" + orderObj.getOrderNo() + "'";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_orderItem.productObj=" + productObj.getProductId();
    	int startIndex = (currentPage-1) * this.rows;
    	return orderItemMapper.queryOrderItem(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<OrderItem> queryOrderItem(OrderInfo orderObj,Product productObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != orderObj &&  orderObj.getOrderNo() != null && !orderObj.getOrderNo().equals(""))  where += " and t_orderItem.orderObj='" + orderObj.getOrderNo() + "'";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_orderItem.productObj=" + productObj.getProductId();
    	return orderItemMapper.queryOrderItemList(where);
    }

    /*查询所有订单条目记录*/
    public ArrayList<OrderItem> queryAllOrderItem()  throws Exception {
        return orderItemMapper.queryOrderItemList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(OrderInfo orderObj,Product productObj) throws Exception {
     	String where = "where 1=1";
    	if(null != orderObj &&  orderObj.getOrderNo() != null && !orderObj.getOrderNo().equals(""))  where += " and t_orderItem.orderObj='" + orderObj.getOrderNo() + "'";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_orderItem.productObj=" + productObj.getProductId();
        recordNumber = orderItemMapper.queryOrderItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取订单条目记录*/
    public OrderItem getOrderItem(int itemId) throws Exception  {
        OrderItem orderItem = orderItemMapper.getOrderItem(itemId);
        return orderItem;
    }

    /*更新订单条目记录*/
    public void updateOrderItem(OrderItem orderItem) throws Exception {
        orderItemMapper.updateOrderItem(orderItem);
    }

    /*删除一条订单条目记录*/
    public void deleteOrderItem (int itemId) throws Exception {
        orderItemMapper.deleteOrderItem(itemId);
    }

    /*删除多条订单条目信息*/
    public int deleteOrderItems (String itemIds) throws Exception {
    	String _itemIds[] = itemIds.split(",");
    	for(String _itemId: _itemIds) {
    		orderItemMapper.deleteOrderItem(Integer.parseInt(_itemId));
    	}
    	return _itemIds.length;
    }
}
