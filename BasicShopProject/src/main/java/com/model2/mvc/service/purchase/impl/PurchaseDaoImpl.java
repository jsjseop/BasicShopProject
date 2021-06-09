package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PurchaseDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 1. addPurchase(INSERT)  ? ");
		sqlSession.insert("PurchaseMapper.addPurchase",purchase);
		System.out.println("\n");
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 2. findPurchase(SELECT)  ? ");
		return sqlSession.selectOne("PurchaseMapper.getPurchase",tranNo);
	}

	@Override
	public Purchase getPurchase2(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 2. findPurchase(SELECT)  ? ");
		return sqlSession.selectOne("PurchaseMapper.getPurchase2",prodNo);
	}

	@Override
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 3. getPurchaseList(SELECT)  ? ");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", buyerId);
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}

	@Override
	public List<Purchase> getSaleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: getSaleList(SELECT) ? ");
		
		return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 4. updatePurchase(UPDATE)  ? ");
		System.out.println(":: "+ sqlSession.update("PurchaseMapper.updatePurchase", purchase));
		System.out.println("\n");
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 5. updatePurchase(UPDATE)  ? ");
		System.out.println(":: "+ sqlSession.update("PurchaseMapper.updateTranCode", purchase));
		System.out.println("\n");
	}

	@Override
	public int getTotalCount(String buyerId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", buyerId);
	}

	@Override
	public int getSaleCount() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.getSaleCount");
	}

	@Override
	public void deletePurchase(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(":: 6. deletePurchase(DELETE)  ? ");
		System.out.println(":: "+ sqlSession.delete("PurchaseMapper.deletePurchase", prodNo));
		System.out.println("\n");
	}

}
