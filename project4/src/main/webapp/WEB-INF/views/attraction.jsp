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
			                        '                <div class="ellipsis">'+price+'원</div>' +
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
				                 
				                 marker.setMap(map);
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
		frm = document.attractionFrm;
		
		if(frm.name.value.trim()==""){
			alert(">>관광지명<<")
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
								<h2>Attraction</h2><br>
								<p>
									<a href="https://www.visitjeju.net/kr">Visit Jeju</a><br>
								</p>
							</header>
						</div>
						<div class="col-xl-8 col-lg-8 ">
							<form name="attractionFrm" method="post" action="attraction.p4">
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
												<input type="hidden" name="type" value="관광">
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
								<c:if test="${attractionVO!=null}">
									<c:forEach items="${attractionVO}" var="list">
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
