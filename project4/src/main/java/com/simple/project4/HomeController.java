package com.simple.project4;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Component
@Controller
public class HomeController {
	
	@Autowired
	private HomeService service;
	
	@RequestMapping(value = "/index.p4")
	public ModelAndView index(HttpServletRequest request, ModelAndView mv) {
		
		if(request.getMethod().equalsIgnoreCase("post")) {
			
			String[] contentArr = request.getParameterValues("content");
			String[] priceArr = request.getParameterValues("price");
			String[] seqArr = request.getParameterValues("seq");
			
			for(int i=0;i<contentArr.length;i++) {
				FirstVO fvo = new FirstVO();
				fvo.setContent(contentArr[i]);
				fvo.setPrice(Integer.parseInt(priceArr[i]));
				fvo.setSeq(Integer.parseInt(seqArr[i]));
				
				service.setPriceList(fvo);
			}
		}

		List<FirstVO> planVO = service.getPreparedList();
		List<FirstVO> budgetVO = service.getPriceList();
		List<FirstVO> hotelVO = service.getMapList("숙소");
		List<FirstVO> attractionVO = service.getMapList("관광");
		
		mv.addObject("planVO",planVO);
		mv.addObject("attractionVO",attractionVO);
		mv.addObject("hotelVO",hotelVO);
		mv.addObject("budgetVO",budgetVO);
		return mv;
	}
	
	@RequestMapping(value = "/hotel.p4")
	public ModelAndView hotel(HttpServletRequest request, ModelAndView mv, FirstVO fvo) {
		
		if(request.getMethod().equalsIgnoreCase("post")) 
			service.setMap(fvo);
		
		List<FirstVO> hotelVO = service.getMapList("숙소");

		HttpSession session = request.getSession();
		session.setAttribute("mapList",hotelVO);
		
		mv.addObject("hotelVO",hotelVO);
		return mv;
	}
	
	@RequestMapping(value = "/chagePlan.p4", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public void chagePlan(HttpServletRequest request) {
		String[] contentArr = request.getParameterValues("content");
		String[] seqArr = request.getParameterValues("seq");
		for(int i=0; i<contentArr.length;i++) {
			FirstVO fvo = new FirstVO();
			fvo.setContent(contentArr[i]);
			fvo.setSeq(Integer.parseInt(seqArr[i]));
			service.setPlan(fvo);
		}
	}
		
	@RequestMapping(value = "/mapAjax.p4", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String mapAjax(HttpServletRequest request) {
		
		JSONArray jsonArr = new JSONArray();
		
		HttpSession session = request.getSession();
		List<FirstVO> mapList = (List<FirstVO>) session.getAttribute("mapList");
		session.removeAttribute("mapList");
		
		if(mapList!=null) {
			for(FirstVO list : mapList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("name", list.getName());
				jsonObj.put("address", list.getAddress());
				jsonObj.put("price", list.getPrice());
				jsonObj.put("site", list.getSite());
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/attraction.p4")
	public ModelAndView attraction(HttpServletRequest request, ModelAndView mv, FirstVO fvo) {
		
		if(request.getMethod().equalsIgnoreCase("post"))
			service.setMap(fvo);
		
		List<FirstVO> attractionVO = service.getMapList("관광");
		
		HttpSession session = request.getSession();
		session.setAttribute("mapList",attractionVO);
		
		mv.addObject("attractionVO",attractionVO);
		return mv;
	}
	
	
}
