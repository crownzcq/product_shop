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
import com.shuangyulin.service.ShopCartService;
import com.shuangyulin.po.ShopCart;
import com.shuangyulin.service.ProductService;
import com.shuangyulin.po.Product;
import com.shuangyulin.service.UserInfoService;
import com.shuangyulin.po.UserInfo;

//ShopCart管理控制层
@Controller
@RequestMapping("/ShopCart")
public class ShopCartController extends BaseController {

    /*业务层对象*/
    @Resource ShopCartService shopCartService;

    @Resource ProductService productService;
    @Resource UserInfoService userInfoService;
	@InitBinder("productObj")
	public void initBinderproductObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("shopCart")
	public void initBinderShopCart(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shopCart.");
	}
	/*跳转到添加ShopCart视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ShopCart());
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "ShopCart_add";
	}

	/*客户端ajax方式提交添加购物车信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ShopCart shopCart, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        shopCartService.addShopCart(shopCart);
        message = "购物车添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询购物车信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)shopCartService.setRows(rows);
		List<ShopCart> shopCartList = shopCartService.queryShopCart(productObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    shopCartService.queryTotalPageAndRecordNumber(productObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = shopCartService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shopCartService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ShopCart shopCart:shopCartList) {
			JSONObject jsonShopCart = shopCart.getJsonObject();
			jsonArray.put(jsonShopCart);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询购物车信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ShopCart> shopCartList = shopCartService.queryAllShopCart();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ShopCart shopCart:shopCartList) {
			JSONObject jsonShopCart = new JSONObject();
			jsonShopCart.accumulate("cartId", shopCart.getCartId());
			jsonArray.put(jsonShopCart);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询购物车信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<ShopCart> shopCartList = shopCartService.queryShopCart(productObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    shopCartService.queryTotalPageAndRecordNumber(productObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = shopCartService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shopCartService.getRecordNumber();
	    request.setAttribute("shopCartList",  shopCartList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("userObj", userObj);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "ShopCart/shopCart_frontquery_result"; 
	}

     /*前台查询ShopCart信息*/
	@RequestMapping(value="/{cartId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer cartId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键cartId获取ShopCart对象*/
        ShopCart shopCart = shopCartService.getShopCart(cartId);

        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("shopCart",  shopCart);
        return "ShopCart/shopCart_frontshow";
	}

	/*ajax方式显示购物车修改jsp视图页*/
	@RequestMapping(value="/{cartId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer cartId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键cartId获取ShopCart对象*/
        ShopCart shopCart = shopCartService.getShopCart(cartId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonShopCart = shopCart.getJsonObject();
		out.println(jsonShopCart.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新购物车信息*/
	@RequestMapping(value = "/{cartId}/update", method = RequestMethod.POST)
	public void update(@Validated ShopCart shopCart, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			shopCartService.updateShopCart(shopCart);
			message = "购物车更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "购物车更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除购物车信息*/
	@RequestMapping(value="/{cartId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer cartId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  shopCartService.deleteShopCart(cartId);
	            request.setAttribute("message", "购物车删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "购物车删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条购物车记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String cartIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = shopCartService.deleteShopCarts(cartIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出购物车信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<ShopCart> shopCartList = shopCartService.queryShopCart(productObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ShopCart信息记录"; 
        String[] headers = { "购物车id","商品","用户","单价","购买数量"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<shopCartList.size();i++) {
        	ShopCart shopCart = shopCartList.get(i); 
        	dataset.add(new String[]{shopCart.getCartId() + "",shopCart.getProductObj().getProductName(),shopCart.getUserObj().getName(),shopCart.getPrice() + "",shopCart.getBuyNum() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"ShopCart.xls");//filename是下载的xls的名，建议最好用英文 
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
