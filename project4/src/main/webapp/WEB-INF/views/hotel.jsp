<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--
	Spatial by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<!-- 카카오지도 맵키 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55fd286227a4e6210dc2be181c4c6306&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55fd286227a4e6210dc2be181c4c6306&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55fd286227a4e6210dc2be181c4c6306"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- Scripts -->
<script src="/project4/resources/js/jquery.min.js"></script>
<script src="/project4/resources/js/skel.min.js"></script>
<script src="/project4/resources/js/util.js"></script>
<script src="/project4/resources/js/main.js"></script>
<script src="/project4/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	map = null;

	$(document).ready(function() {
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(33.381788, 126.544377), // 지도의 중심좌표
			level: 9 // 지도의 확대 레벨
		};  
	   
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		var geocoder = new kakao.maps.services.Geocoder();
	    
		$.ajax({ 
			url:"mapAjax.p4",
			type:"GET",
			dataType:"JSON",
			success:function(json){
				if(json.length > 0) {
					content = "";
					
					$.each(json, function(entryIndex, item){
						name = item.name;
						address = item.address;
						site = item.site;
						price = item.price;
						
						geocoder.addressSearch(address, function(result, status) {
							if (status === kakao.maps.services.Status.OK) {
								var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								var marker = new kakao.maps.Marker({
				                    	map: map,
				                        position: coords,
				                        clickable: true
								});
								
								 var iwContent = '<div class="wrap">' + 
                 					'    <div class="info">' + 
                        			'        <div class="title">' + 
                        			'            '+name+ 
			                        '        </div>' + 
			                        '        <div class="body">' + 
			                        '            <div class="desc">' + 
			                        '                <div class="ellipsis">'+price+'</div>' +
			                        '                <div><a href="'+site+'" target="_blank" class="link">상세조회</a></div>' + 
			                        '            </div>' + 
			                        '        </div>' + 
			                        '    </div>' +    
			                         '</div>';
								iwRemoveable = true;
                        
				                 var infowindow = new kakao.maps.InfoWindow({
				                 	content : iwContent,
				                     removable : iwRemoveable
									});
				                        
				                 kakao.maps.event.addListener(marker,'click',function(){
				                 	infowindow.open(map,marker);
				                 })
				                        
				                      
				                 var overlay = new kakao.maps.CustomOverlay({
				                 	content: content,
				                     map: map,
				                     position: marker.getPosition()       
				                 });
				                        
				                 kakao.maps.event.addListener(marker, 'click', function() {
				                     overlay.setMap(map);
				                 });
				                 
							}
							
						});
					});
				}
			},error: function(request, status, error){
		    	console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		
// 		function noEvent() { // 새로 고침 방지
			 
// 	        if ('${check}' == "1") {
// 	            if (event.keyCode == 116) {
// 	                alert("새로고침을 할 수 없습니다.");
// 	                event.keyCode = 2;
// 	                return false;
// 	            } else if (event.ctrlKey
// 	                    && (event.keyCode == 78 || event.keyCode == 82)) {
// 	                return false;
// 	            }
// 	        }
// 	    }
// 	    document.onkeydown = noEvent;
			
		$("#price").keyup(function (key){
			regexp = /^[0-9]*$/;
			if(!regexp.test(document.getElementById("price").value.trim()))
				alert("숫자만 입력하세요");
		});

	});
	
	function findAddress(){ //Find 버튼을 클릭하면
		
		new daum.Postcode({
			oncomplete: function(data) {
			    $("#address").val(data.address); // 큰주소  	예> 서울특별시 종로구 인사로 17 
			}
		}).open();
		
	};
	
	function goReg(){
		frm = document.hotelFrm;
		
		if(frm.name.value.trim()==""){
			alert(">>숙소명<<")
			return;
		} else if(frm.price.value.trim()==""){
			alert(">>가격<<")
			return;
		} else if(frm.site.value.trim()==""){
			alert(">>링크<<")
			return;
		} else if(frm.address.value.trim()==""){
			alert(">>주소<<")
			return;
		}
		
		frm.submit();
	}


</script>
<html>
<head>
	<title>Jeju</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="/project4/resources/css/main.css" />
</head>
	
<body class="landing">

	<!-- Header -->
		<header id="header" class="alt">
			<h1><strong><a href="index.html">Jeju</a></strong> by yujin An</h1>
			<nav id="nav">
				<ul>
					<li><a href="index.p4">Home</a></li>
					<li><a href="hotel.p4">Hotel</a></li>
					<li><a href="attraction.p4">Attraction</a></li>
				</ul>
			</nav>
		</header>

		<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

	<!-- Banner -->
		<section id="banner">
			<h2>Jeju Island</h2>
		</section>

		<!-- One -->
			<section id="one" class="wrapper style1">
				<div class="container 75%">
					<div class="row 200%">
						<div class="col-xl-4 col-lg-4">
							<header class="major">
								<h2>Hotel table</h2>
								<p>
									<a href="https://www.booking.com/searchresults.ko.html?aid=376440&label=bdot-c_zEqfPD8wQmbbXiSmw3iwS267777897793%3Apl%3Ata%3Ap1%3Ap22%2C522%2C000%3Aac%3Aap1t2%3Aneg%3Afi%3Atiaud-793048569031%3Akwd-376789927390%3Alp1009871%3Ali%3Adec%3Adm&sid=4e77c4bbfcb43b7c8982f05bb93b0082&sb=1&src=index&src_elem=sb&error_url=https%3A%2F%2Fwww.booking.com%2Findex.ko.html%3Faid%3D376440%3Blabel%3Dbdot-c_zEqfPD8wQmbbXiSmw3iwS267777897793%253Apl%253Ata%253Ap1%253Ap22%252C522%252C000%253Aac%253Aap1t2%253Aneg%253Afi%253Atiaud-793048569031%253Akwd-376789927390%253Alp1009871%253Ali%253Adec%253Adm%3Bsid%3D4e77c4bbfcb43b7c8982f05bb93b0082%3Bsb_price_type%3Dtotal%26%3B&ss=%EC%A0%9C%EC%A3%BC%EB%8F%84%2C+%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD&is_ski_area=&ssne=%EC%84%9C%EA%B7%80%ED%8F%AC&ssne_untouched=%EC%84%9C%EA%B7%80%ED%8F%AC&checkin_year=2019&checkin_month=9&checkin_monthday=30&checkout_year=2019&checkout_month=10&checkout_monthday=2&group_adults=2&group_children=0&no_rooms=1&b_h4u_keep_filters=&from_sf=1&ss_raw=%EC%A0%9C%EC%A3%BC&ac_position=0&ac_langcode=ko&ac_click_type=b&dest_id=4170&dest_type=region&place_id_lat=33.389214&place_id_lon=126.53866&search_pageview_id=391c5ab7bf3e007a&search_selected=true&region_type=province&search_pageview_id=391c5ab7bf3e007a&ac_suggestion_list_length=5&ac_suggestion_theme_list_length=0&order=">booking.com</a><br>
									<a href="https://www.airbnb.co.kr/s/%EC%A0%9C%EC%A3%BC%EB%8F%84/homes?refinement_paths%5B%5D=%2Fhomes&place_id=ChIJRUDITFTjDDURMb8emNI2vGY&search_type=section_navigation&screen_size=large&checkin=2019-09-30&checkout=2019-10-02&adults=2">airbnb</a><br>
									<a href="https://kr.trip.com/hotels/List?city=-1&checkin=09-30-2019&checkout=10-02-2019&optionId=11176&optionType=Province&optionName=%EC%A0%9C%EC%A3%BC%EB%8F%84&display=%EC%A0%9C%EC%A3%BC%EB%8F%84%20(Jeju-do)%2C%20%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD&markland=%EC%A0%9C%EC%A3%BC%EB%8F%84%20(Jeju-do)&crn=1&adult=2&children=0&ages=&searchboxArg=t&label=BvECI8RczkezhhyQG9-_zw&travelPurpose=0#ctm_ref=ix_sb_dl">trip.com</a><br>
									<a href="https://hotel.naver.com/hotels/list?destination=place:Jeju&checkin=2019-09-30&checkout=2019-10-02&rooms=2">naver hotel</a><br>
									<a href="https://www.agoda.com/ko-kr/pages/agoda/default/DestinationSearchResult.aspx?asq=R2%2BF%2FZ%2FLbxr37Aa3HNMaiFr4S7%2BIe%2FK1POXLFhnOzQJ63J%2BpeXC8r8uVJZUyg%2BsnAm0tzvNTIcO56gQJKv7TXJHLSRCFsftJr8AkC2lJT4q70k6kT14knXbXfSYrWuKPMr84aap2d%2FV0Gn7FCq%2BWi4LatQVvIYrdnHaNpRrsk%2BuRIqDcIAveF6jXCb4c%2BwCB1f4tMtCkUOcG6AQSFmkuYgUnv17YKe93O%2BALeRIJhto%3D&city=16901&cid=1829970&tick=637052109951&languageId=9&userId=d40ee217-1711-4e20-971c-7b5c2520e5b6&sessionId=k0gp0jfxnuj4bq5xxvbohm4c&pageTypeId=103&origin=KR&locale=ko-KR&tag=ac09e330-b22c-3a50-c945-7f4179dacee6&gclid=Cj0KCQjw5rbsBRCFARIsAGEYRweJVNgqC0HyvdkgOkUNBr21z_g-ZhwXZcgtOAG8_BTkLlX_UMSIROkaAqTMEALw_wcB&aid=82361&currencyCode=KRW&htmlLanguage=ko-kr&cultureInfoName=ko-KR&ckuid=d40ee217-1711-4e20-971c-7b5c2520e5b6&prid=0&checkIn=2019-09-30&checkOut=2019-10-02&rooms=1&adults=2&children=0&priceCur=KRW&los=2&textToSearch=%EC%A0%9C%EC%A3%BC%EB%8F%84&productType=-1&travellerType=1&familyMode=off">agoda</a><br>
								</p>
							</header>
						</div>
						<div class="col-xl-8 col-lg-8 ">
							<form name="hotelFrm" method="post" action="hotel.p4">
								<table>
									<thead>
										<tr>
											<th style="width: 200px; text-align: left;">이름</th>
											<th style="width: 150px; text-align: left;">가격</th>
											<th style="width: 110px; text-align: left;">링크</th>
										</tr>
										<tr>
											<th style="width: 200px; text-align: left;"><input type="text" name="name"></th>
											<th style="width: 150px; text-align: left;"><input type="text" name="price" id="price"></th>
											<th style="width: 110px; text-align: left;"><input type="text" name="site"></th>
										</tr>
										<tr>
											<th colspan="3" style="text-align: left;">주소</th>
										</tr>
										<tr>
											<th colspan="3" style="text-align: left;"><input type="text" name="address" id="address" onclick="findAddress()" readonly></th>
										</tr>
										<tr>
											<th colspan="3" style="text-align: left;">메모</th>
										</tr>
										<tr>
											<th colspan="3" style="text-align: left;"><textarea name="content" rows="6"></textarea></th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td style="text-align: right;" ><p id="totalPrice"></p><br>
												<input type="hidden" name="type" value="숙소">
												<button type="button" class="button small" onclick="goReg()">등록</button>
											</td>
										</tr>
									</tfoot>
								</table>
							</form>
						</div>
					</div>
				</div>
			</section>

		<!-- Three -->
			<section id="three" class="wrapper style1">
				<div class="container">
					<h2>Map</h2>
					<div id="map" style="width: 1100px; height: 700px; margin: 0 auto;"></div>
				</div>
			</section>
			
					<!-- Table -->
			<section class="wrapper style1">
				<div style="width: 1000px; margin: 0 auto;">
				<h3>List</h3>
					<div class="table-wrapper">
						<table>
							<thead>
								<tr>
									<th>Name</th>
									<th>Address</th>
									<th>Content</th>
									<th>Price</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${hotelVO!=null}">
									<c:forEach items="${hotelVO}" var="list">
										<tr>
											<td onclick="location.href='${list.site}'">${list.name}</td>
											<td>${list.address }</td>	
											<td>${list.content }</td>
											<td>${list.price }</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>	
			</section>


	<!-- Footer -->
		<footer id="footer">
			<div class="container">
				<ul class="copyright">
					<li>&copy; Untitled</li>
					<li>Design: <a href="http://templated.co">TEMPLATED</a></li>
					<li>Images: <a href="http://unsplash.com">Unsplash</a></li>
				</ul>
			</div>
		</footer>

	

</body>

</html>
