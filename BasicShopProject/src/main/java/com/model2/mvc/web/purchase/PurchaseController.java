package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseController() {
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
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET )
	public String addPurchaseView(@RequestParam("prodNo") int prodNo, HttpSession session) throws Exception{
		
		System.out.println("/purchase/addPurchase : GET");
		
		Product product = productService.getProduct(prodNo);
		
		session.setAttribute("product", product);
		
		return "/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping( value="addPurchase", method=RequestMethod.POST )
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, HttpSession session, Model model) throws Exception{
		
		System.out.println("/purchase/addPurchase : POST");
		
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setPurchaseProd((Product)session.getAttribute("product"));
		purchase.setTranCode("1");
		
		System.out.println(purchase);
		purchaseService.addPurchase(purchase);
		model.addAttribute("purchase", purchase);
		
		return "/purchase/addPurchase.jsp";
	}
	
	@RequestMapping( value="getPurchase", method=RequestMethod.GET )
	public String getPurchase(@RequestParam("tranNo") int tranNo,
												Model model) throws Exception{
		
		System.out.println("/purchase/getPurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		purchase.setPurchaseProd(product);
		model.addAttribute("purchase", purchase);
		
		return "/purchase/getPurchase.jsp";
	}
	
	@RequestMapping( value="/purchase/listPurchase")
	public String listPurchase(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ((User)session.getAttribute("user")).getUserId();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("buyerId", buyerId);
		
		return "/purchase/listPurchase.jsp";
	}
	
	@RequestMapping( value="saleList")
	public String saleList(@ModelAttribute("search") Search search, Model model) throws Exception{
		
		System.out.println("/purchase/saleList : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		
		return "/purchase/listSale.jsp";
	}
	
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET )
	public String updatePurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception{
		
		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		model.addAttribute("purchase", purchase);
		
		return "/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase) throws Exception{
		
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
	
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public String updateTranCode(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode) throws Exception{
		
		System.out.println("/purchase/updateTranCode : GET");
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "/purchase/listPurchase";
	}
	
	@RequestMapping( value="updateTranCodeByProd", method=RequestMethod.GET )
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo,
																	@RequestParam("tranCode") String tranCode) throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		Purchase purchase = purchaseService.getPurchase2(prodNo);
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "/product/listProduct?menu=manage";
	}
	
	@RequestMapping( value="deletePurchase", method=RequestMethod.GET )
	public String deletePurchase(@RequestParam("prodNo") int prodNo) throws Exception{
		
		System.out.println("/product/deletePurchase : GET");
		
		purchaseService.deletePurchase(prodNo);
		
		return "/product/deleteProduct?prodNo="+prodNo;
	}

}
