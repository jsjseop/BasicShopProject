package com.model2.mvc.web.product;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping( value="json/listProduct",method=RequestMethod.POST  )
	public Map<String, Object> listProduct( @RequestBody Search search ) throws Exception{
		
		System.out.println("/product/json/listProduct : POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println(search);
		
		Map<String,Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping( value="json/listProduct/{currentPage}",method=RequestMethod.GET  )
	public Map<String, Object> listProduct( @PathVariable("currentPage") int currentPage ) throws Exception{
		
		System.out.println("/product/json/listProduct : GET");
		
		Search search = new Search();
		
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		System.out.println(search);
		
		Map<String,Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		
		return map;
	}

}
