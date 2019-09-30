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
<!-- Scripts -->
<script src="/project4/resources/js/jquery.min.js"></script>
<script src="/project4/resources/js/skel.min.js"></script>
<script src="/project4/resources/js/util.js"></script>
<script src="/project4/resources/js/main.js"></script>
<script src="/project4/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		totalPrice();
		
		$(".plan").keyup(function (key){
			var queryString = $("form[name=planFrm]").serialize();
			$.ajax({
				url:"chagePlan.p4",
				type:"POST",
				data:queryString,
				success:function(){

				},error: function(request, status, error){alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);}
			});
		});
		
		$(".price").keyup(function (key){
			regexp = /^[0-9]*$/;
			totalPrice = 0;
			
			for(i=0;i<6;i++){
				if(!regexp.test(document.getElementById("price"+i).value.trim())){
					alert("숫자만 입력하세요");
				} else {
					totalPrice += parseInt(document.getElementById("price"+i).value.trim());
				}
			}
			
			document.getElementById("totalPrice").innerText = totalPrice;
		});
		
	});
	
	function totalPrice(){
		regexp = /^[0-9]*$/;
		totalPrice = 0;
		
		for(i=0;i<6;i++){
			if(!regexp.test(document.getElementById("price"+i).value.trim())){
				alert("숫자만 입력하세요");
			} else {
				totalPrice += parseInt(document.getElementById("price"+i).value.trim());
			}
		}
		
		document.getElementById("totalPrice").innerText = totalPrice;
	};

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
								<h2>Budget table</h2>
								<p>190930-191002</p>
							</header>
						</div>
						<div class="col-xl-8 col-lg-8 ">
							<form method="post" action="index.p4">
								<table>
									<thead>
										<tr>
											<th style="width: 80px; text-align: center;">항목</th>
											<th style="width: 280px; text-align: center;">내용</th>
											<th style="width: 100px; text-align: center;">비용</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${budgetVO!=null}">
											<c:forEach items="${budgetVO}" var="list" varStatus="status">
												<tr>
													<td style="text-align: center;">${list.name}<input type="hidden" name="seq" value="${list.seq}"></td>
													<td><input type="text" value="${list.content}" name="content"></td>
													<td><input type="text" value="${list.price}" name="price" id="price${status.index}" class="price" style="width: 100px; text-align: right;"></td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td style="text-align: right;" >2인 기준 금액 : <p id="totalPrice"></p><br>
												<button class="button small">변경</button>
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
					<header class="major special">
						<h2>Jeju Island Plan</h2>
					</header>
					<form name="planFrm" >
						<div class="feature-grid">
							<c:if test="${planVO!=null }">
								<c:forEach items="${planVO}" var="list">
									<div class="feature">
										<div class="image rounded"><img src="/project4/resources/images/pic0${list.seq+3}.jpg" alt="" /></div>
										<div class="content">
											<header><input type="hidden" name="seq" value="${list.seq }">
												<h4>${list.name }</h4>
											</header>
											<p><textarea name="content" rows="4" class="plan">${list.content }</textarea></p>
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</form>
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
