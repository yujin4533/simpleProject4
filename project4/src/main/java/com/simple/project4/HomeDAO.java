package com.simple.project4;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HomeDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	public List<FirstVO> getPriceList() {
		List<FirstVO> list = sql.selectList("JejuMapper.getPriceList");
		return list;
	}

	public void setPriceList(FirstVO fvo) {
		sql.update("JejuMapper.setPriceList",fvo);
	}
	
	public List<FirstVO> getMapList(String string) {
		List<FirstVO> list = sql.selectList("JejuMapper.getMapList",string);
		return list;
	}

	public void setMap(FirstVO fvo) {
		int n = sql.selectOne("JejuMapper.getMap",fvo);
		if(n==0)
			sql.update("JejuMapper.setMap",fvo);
	}

	public List<FirstVO> getPreparedList() {
		List<FirstVO> list = sql.selectList("JejuMapper.getPreparedList");
		return list;
	}

	public void setPlan(FirstVO fvo) {
		sql.update("JejuMapper.setPlan",fvo);
	}


}
