package com.model2.mvc.service.product.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void insertProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 1. addProduct(INSERT)  ? ");
		sqlSession.insert("ProductMapper.insertProduct",product);
		System.out.println("\n");
	}

	@Override
	public Product getProduct(int no) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 2. findProduct(INSERT)  ? ");
		return sqlSession.selectOne("ProductMapper.getProduct",no);
	}

	@Override
	public List<Product> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 3. getProductList(SELECT)  ? ");
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 4. updateProduct(UPDATE)  ? ");
		System.out.println(":: "+ sqlSession.update("ProductMapper.updateProduct", product));
		System.out.println("\n");
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	@Override
	public void deleteProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 5. deleteProduct(DELETE) ? ");
		System.out.println(":: "+sqlSession.delete("ProductMapper.deleteProduct", prodNo));
		System.out.println("\n");
	}

}
