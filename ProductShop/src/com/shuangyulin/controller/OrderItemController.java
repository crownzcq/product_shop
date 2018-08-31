package com.shuangyulin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.shuangyulin.utils.ExportExcelUtil;
import com.shuangyulin.utils.UserException;
import com.shuangyulin.service.OrderItemService;
import com.shuangyulin.po.OrderItem;
import com.shuangyulin.service.OrderInfoService;
import com.shuangyulin.po.OrderInfo;
import com.shuangyulin.service.ProductService;
import com.shuangyulin.po.Product;

//OrderItem管理控制层
@Controller
@RequestMapping("/OrderItem")
public class OrderItemController extends BaseController {

    /*业务层对象*/
    @Resource OrderItemService orderItemService;

    @Resource OrderInfoService orderInfoService;
    @Resource ProductService productService;
	@InitBinder("orderObj")
	public void initBinderorderObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderObj.");
	}
	@InitBinder("productObj")
	public void initBinderproductObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productObj.");
	}
	@InitBinder("orderItem")
	public void initBinderOrderItem(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderItem.");
	}
	/*跳转到添加OrderItem视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new OrderItem());
		/*查询所有的OrderInfo信息*/
		List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
		request.setAttribute("orderInfoList", orderInfoList);
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		return "OrderItem_add";
	}

	/*客户端ajax方式提交添加订单条目信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated OrderItem orderItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        orderItemService.addOrderItem(orderItem);
        message = "订单条目添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询订单条目信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("orderObj") OrderInfo orderObj,@ModelAttribute("productObj") Product productObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)orderItemService.setRows(rows);
		List<OrderItem> orderItemList = orderItemService.queryOrderItem(orderObj, productObj, page);
	    /*计算总的页数和总的记录数*/
	    orderItemService.queryTotalPageAndRecordNumber(orderObj, productObj);
	    /*获取到总的页码数目*/
	    int totalPage = orderItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderItemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(OrderItem orderItem:orderItemList) {
			JSONObject jsonOrderItem = orderItem.getJsonObject();
			jsonArray.put(jsonOrderItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询订单条目信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<OrderItem> orderItemList = orderItemService.queryAllOrderItem();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(OrderItem orderItem:orderItemList) {
			JSONObject jsonOrderItem = new JSONObject();
			jsonOrderItem.accumulate("itemId", orderItem.getItemId());
			jsonArray.put(jsonOrderItem);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询订单条目信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("orderObj") OrderInfo orderObj,@ModelAttribute("productObj") Product productObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<OrderItem> orderItemList = orderItemService.queryOrderItem(orderObj, productObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    orderItemService.queryTotalPageAndRecordNumber(orderObj, productObj);
	    /*获取到总的页码数目*/
	    int totalPage = orderItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderItemService.getRecordNumber();
	    request.setAttribute("orderItemList",  orderItemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("orderObj", orderObj);
	    request.setAttribute("productObj", productObj);
	    List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
	    request.setAttribute("orderInfoList", orderInfoList);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
		return "OrderItem/orderItem_frontquery_result"; 
	}

     /*前台查询OrderItem信息*/
	@RequestMapping(value="/{itemId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer itemId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键itemId获取OrderItem对象*/
        OrderItem orderItem = orderItemService.getOrderItem(itemId);

        List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
        request.setAttribute("orderInfoList", orderInfoList);
        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        request.setAttribute("orderItem",  orderItem);
        return "OrderItem/orderItem_frontshow";
	}

	/*ajax方式显示订单条目修改jsp视图页*/
	@RequestMapping(value="/{itemId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer itemId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键itemId获取OrderItem对象*/
        OrderItem orderItem = orderItemService.getOrderItem(itemId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOrderItem = orderItem.getJsonObject();
		out.println(jsonOrderItem.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新订单条目信息*/
	@RequestMapping(value = "/{itemId}/update", method = RequestMethod.POST)
	public void update(@Validated OrderItem orderItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			orderItemService.updateOrderItem(orderItem);
			message = "订单条目更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "订单条目更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除订单条目信息*/
	@RequestMapping(value="/{itemId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer itemId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  orderItemService.deleteOrderItem(itemId);
	            request.setAttribute("message", "订单条目删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "订单条目删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条订单条目记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String itemIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = orderItemService.deleteOrderItems(itemIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出订单条目信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("orderObj") OrderInfo orderObj,@ModelAttribute("productObj") Product productObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<OrderItem> orderItemList = orderItemService.queryOrderItem(orderObj,productObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "OrderItem信息记录"; 
        String[] headers = { "条目id","所属订单","订单商品","商品单价","购买数量"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<orderItemList.size();i++) {
        	OrderItem orderItem = orderItemList.get(i); 
        	dataset.add(new String[]{orderItem.getItemId() + "",orderItem.getOrderObj().getOrderNo(),orderItem.getProductObj().getProductName(),orderItem.getPrice() + "",orderItem.getOrderNumer() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"OrderItem.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
