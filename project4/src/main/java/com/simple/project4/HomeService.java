package com.simple.project4;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomeService {
	
	@Autowired
	private HomeDAO dao;

	public List<FirstVO> getPriceList() {
		return dao.getPriceList();
	}

	public void setPriceList(FirstVO fvo) {
		dao.setPriceList(fvo);
	}

	public List<FirstVO> getMapList(String string) {
		return dao.getMapList(string);
	}

	public void setMap(FirstVO fvo) {
		dao.setMap(fvo);
	}

	public List<FirstVO> getPreparedList() {
		return dao.getPreparedList();
	}

	public void setPlan(FirstVO fvo) {
		dao.setPlan(fvo);
	}



}
