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
import com.shuangyulin.service.ProductClassService;
import com.shuangyulin.po.ProductClass;

//ProductClass管理控制层
@Controller
@RequestMapping("/ProductClass")
public class ProductClassController extends BaseController {

    /*业务层对象*/
    @Resource ProductClassService productClassService;

	@InitBinder("productClass")
	public void initBinderProductClass(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productClass.");
	}
	/*跳转到添加ProductClass视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ProductClass());
		return "ProductClass_add";
	}

	/*客户端ajax方式提交添加商品分类信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ProductClass productClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        productClassService.addProductClass(productClass);
        message = "商品分类添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询商品分类信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)productClassService.setRows(rows);
		List<ProductClass> productClassList = productClassService.queryProductClass(page);
	    /*计算总的页数和总的记录数*/
	    productClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = productClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = productClassService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ProductClass productClass:productClassList) {
			JSONObject jsonProductClass = productClass.getJsonObject();
			jsonArray.put(jsonProductClass);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询商品分类信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ProductClass> productClassList = productClassService.queryAllProductClass();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ProductClass productClass:productClassList) {
			JSONObject jsonProductClass = new JSONObject();
			jsonProductClass.accumulate("classId", productClass.getClassId());
			jsonProductClass.accumulate("className", productClass.getClassName());
			jsonArray.put(jsonProductClass);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询商品分类信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<ProductClass> productClassList = productClassService.queryProductClass(currentPage);
	    /*计算总的页数和总的记录数*/
	    productClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = productClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = productClassService.getRecordNumber();
	    request.setAttribute("productClassList",  productClassList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "ProductClass/productClass_frontquery_result"; 
	}

     /*前台查询ProductClass信息*/
	@RequestMapping(value="/{classId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer classId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键classId获取ProductClass对象*/
        ProductClass productClass = productClassService.getProductClass(classId);

        request.setAttribute("productClass",  productClass);
        return "ProductClass/productClass_frontshow";
	}

	/*ajax方式显示商品分类修改jsp视图页*/
	@RequestMapping(value="/{classId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer classId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键classId获取ProductClass对象*/
        ProductClass productClass = productClassService.getProductClass(classId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonProductClass = productClass.getJsonObject();
		out.println(jsonProductClass.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新商品分类信息*/
	@RequestMapping(value = "/{classId}/update", method = RequestMethod.POST)
	public void update(@Validated ProductClass productClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			productClassService.updateProductClass(productClass);
			message = "商品分类更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "商品分类更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除商品分类信息*/
	@RequestMapping(value="/{classId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer classId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  productClassService.deleteProductClass(classId);
	            request.setAttribute("message", "商品分类删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "商品分类删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条商品分类记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String classIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = productClassService.deleteProductClasss(classIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出商品分类信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<ProductClass> productClassList = productClassService.queryProductClass();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ProductClass信息记录"; 
        String[] headers = { "类别id","类别名称","类别描述"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<productClassList.size();i++) {
        	ProductClass productClass = productClassList.get(i); 
        	dataset.add(new String[]{productClass.getClassId() + "",productClass.getClassName(),productClass.getClassDesc()});
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
			response.setHeader("Content-disposition","attachment; filename="+"ProductClass.xls");//filename是下载的xls的名，建议最好用英文 
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
