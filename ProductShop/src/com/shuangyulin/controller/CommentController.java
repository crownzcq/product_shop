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
import com.shuangyulin.service.CommentService;
import com.shuangyulin.po.Comment;
import com.shuangyulin.service.ProductService;
import com.shuangyulin.po.Product;
import com.shuangyulin.service.UserInfoService;
import com.shuangyulin.po.UserInfo;

//Comment管理控制层
@Controller
@RequestMapping("/Comment")
public class CommentController extends BaseController {

    /*业务层对象*/
    @Resource CommentService commentService;

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
	@InitBinder("comment")
	public void initBinderComment(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("comment.");
	}
	/*跳转到添加Comment视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Comment());
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Comment_add";
	}

	/*客户端ajax方式提交添加商品评论信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Comment comment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        commentService.addComment(comment);
        message = "商品评论添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询商品评论信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (commentTime == null) commentTime = "";
		if(rows != 0)commentService.setRows(rows);
		List<Comment> commentList = commentService.queryComment(productObj, userObj, commentTime, page);
	    /*计算总的页数和总的记录数*/
	    commentService.queryTotalPageAndRecordNumber(productObj, userObj, commentTime);
	    /*获取到总的页码数目*/
	    int totalPage = commentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = commentService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Comment comment:commentList) {
			JSONObject jsonComment = comment.getJsonObject();
			jsonArray.put(jsonComment);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询商品评论信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Comment> commentList = commentService.queryAllComment();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Comment comment:commentList) {
			JSONObject jsonComment = new JSONObject();
			jsonComment.accumulate("commentId", comment.getCommentId());
			jsonComment.accumulate("content", comment.getContent());
			jsonArray.put(jsonComment);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询商品评论信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (commentTime == null) commentTime = "";
		List<Comment> commentList = commentService.queryComment(productObj, userObj, commentTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    commentService.queryTotalPageAndRecordNumber(productObj, userObj, commentTime);
	    /*获取到总的页码数目*/
	    int totalPage = commentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = commentService.getRecordNumber();
	    request.setAttribute("commentList",  commentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("commentTime", commentTime);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Comment/comment_frontquery_result"; 
	}

     /*前台查询Comment信息*/
	@RequestMapping(value="/{commentId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer commentId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键commentId获取Comment对象*/
        Comment comment = commentService.getComment(commentId);

        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("comment",  comment);
        return "Comment/comment_frontshow";
	}

	/*ajax方式显示商品评论修改jsp视图页*/
	@RequestMapping(value="/{commentId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer commentId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键commentId获取Comment对象*/
        Comment comment = commentService.getComment(commentId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonComment = comment.getJsonObject();
		out.println(jsonComment.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新商品评论信息*/
	@RequestMapping(value = "/{commentId}/update", method = RequestMethod.POST)
	public void update(@Validated Comment comment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			commentService.updateComment(comment);
			message = "商品评论更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "商品评论更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除商品评论信息*/
	@RequestMapping(value="/{commentId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer commentId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  commentService.deleteComment(commentId);
	            request.setAttribute("message", "商品评论删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "商品评论删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条商品评论记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String commentIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = commentService.deleteComments(commentIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出商品评论信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(commentTime == null) commentTime = "";
        List<Comment> commentList = commentService.queryComment(productObj,userObj,commentTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Comment信息记录"; 
        String[] headers = { "评论id","被评商品","评论内容","评论用户","评论时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<commentList.size();i++) {
        	Comment comment = commentList.get(i); 
        	dataset.add(new String[]{comment.getCommentId() + "",comment.getProductObj().getProductName(),comment.getContent(),comment.getUserObj().getName(),comment.getCommentTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Comment.xls");//filename是下载的xls的名，建议最好用英文 
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
