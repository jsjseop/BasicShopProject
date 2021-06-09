package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.CookieGenerator;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
		
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="addProduct", method=RequestMethod.GET  )
	public String addProduct() throws Exception{
		
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product,
												@RequestParam("file") MultipartFile file,
												HttpServletRequest request ) throws Exception {

		System.out.println("/product/addProduct : POST");
		
		String temDir = "C:\\dev\\workspace\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles";
		//String temDir = "/images/uploadFiles/";
		
		String fileName = file.getOriginalFilename();
		
		File file01 = new File(temDir, fileName);
		
		try {
			file.transferTo(file01);
		}catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println(file01.getPath());
		
		product.setFileName(fileName);
		productService.addProduct(product);
		
		return "/product/addProduct.jsp";
		
//		if(FileUpload.isMultipartContent(request)) {
//			//String temDir="C:\\dev\\workspace\\07.Model2MVCShop(URI,pattern)\\src\\main\\webapp\\images\\uploadFiles\\";
//			String temDir="C:\\Users\\jkj76\\git\\07Model2MVCShop\\07.Model2MVCShop(URI,pattern)\\src\\main\\webapp\\images\\uploadFiles";
//			DiskFileUpload fileUpload = new DiskFileUpload();
//			fileUpload.setRepositoryPath(temDir);
//			fileUpload.setSizeMax(1024*1024*10);
//			fileUpload.setSizeThreshold(1024*100);
//			
//			if(request.getContentLength() < fileUpload.getSizeMax()) {
//				List fileItemList = fileUpload.parseRequest(request);
//				int Size = fileItemList.size();
//				for(int i=0; i<Size; i++) {
//					FileItem fileItem = (FileItem)fileItemList.get(i);
//					if(fileItem.isFormField()) {
//						if(fileItem.getFieldName().equals("manuDate")) {
//							product.setManuDate(fileItem.getString("euc-kr"));
//						}else if(fileItem.getFieldName().equals("prodName")) {
//							product.setProdName(fileItem.getString("euc-kr"));
//						}else if(fileItem.getFieldName().equals("prodDetail")) {
//							product.setProdDetail(fileItem.getString("euc-kr"));
//						}else if(fileItem.getFieldName().equals("price")) {
//							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
//						}
//					}else {
//						System.out.println("파일 : "+fileItem.getFieldName()+"="+fileItem.getName());
//						System.out.println("("+fileItem.getSize()+"byte)<br>");
//						
//						if(fileItem.getSize() > 0) {
//							int idx = fileItem.getName().lastIndexOf("\\");
//							if(idx == -1) {
//								idx = fileItem.getName().lastIndexOf("/");
//							}
//							String fileName = fileItem.getName().substring(idx+1);
//							System.out.println("fileName : "+fileName);
//							product.setFileName(fileName);
//							try {
//								File uploadedFile = new File(temDir,fileName);
//								fileItem.write(uploadedFile);
//							}catch(IOException e) {
//								System.out.println(e);
//							}
//						}else {
//							product.setFileName("../../images/empty.GIF");
//						}
//					}//else
//				}//for
//				productService.addProduct(product);
//			}else {
//				int overSize = (request.getContentLength() / 10000000);
//				System.out.println("<script>alert('파일의 크기는 1MB까지 입니다."
//						+ "올리신 파일 용량은"+overSize+"MB입니다.);");
//				System.out.println("history.back();</script>");
//			}
//		}else {
//			System.out.println("인코딩 타입이 multipart/form-data가 아닙니다..");
//		}
		
	}
	
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, Model model,
												HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		System.out.println("prodNo : " + prodNo);
		if(menu != null && menu.equals("manage")) {
			return "redirect:/product/updateProduct?prodNo="+prodNo;
		}
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		String historyName = null;
		String historyNo = null;
		Cookie[] cookies = request.getCookies();

		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("historyName")) {
					historyName = cookie.getValue();
				}else if(cookie.getName().equals("historyNo")) {
					historyNo = cookie.getValue();
				}
			}
		}
		System.out.println("history : "+historyName+" : "+historyNo);
//		CookieGenerator cookie1 = new CookieGenerator();
//		CookieGenerator cookie2 = new CookieGenerator();
//		cookie1.setCookieName("historyNo");
//		cookie2.setCookieName("historyName");
//		cookie1.addCookie(response, historyNo+","+Integer.toString(prodNo));
//		cookie2.addCookie(response, historyName+","+URLEncoder.encode(product.getProdName(), "UTF-8"));
		
		Cookie cookie1 = new Cookie("historyNo",historyNo+","+Integer.toString(prodNo));
		Cookie cookie2 = new Cookie("historyName",historyName+","+URLEncoder.encode(product.getProdName(), "UTF-8"));
		cookie1.setPath("/");
		cookie2.setPath("/");
		response.addCookie(cookie1);
		response.addCookie(cookie2);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		
		return "/product/getProduct.jsp";
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "/product/updateProductView.jsp";
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product , Model model) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		productService.updateProduct(product);
		
		product = productService.getProduct(product.getProdNo());
		model.addAttribute("product", product);
		
		return "/product/getProduct.jsp";
	}

	@RequestMapping( value="listProduct" )
	public String listProduct(@ModelAttribute("search") Search search, @RequestParam("menu") String menu, Model model) throws Exception {
		
		System.out.println("/product/listProduct : GET / POST");
		System.out.println("search : "+search);
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("search : "+search);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "/product/listProduct.jsp";
	}
	
	@RequestMapping( value="deleteProduct", method=RequestMethod.GET )
	public String deleteProduct(@RequestParam("prodNo") int prodNo) throws Exception{
		
		System.out.println("/product/deleteProduct : GET");
		
		productService.deleteProduct(prodNo);
		
		return "/purchase/saleList";
	}
	
}
