<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<html style="height: 570px;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
<title>Welcome Page</title>
<%
	if (session.getAttribute("Username") == null
			|| session.getAttribute("Username") == "") {

	} else {
		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
%>
</head>
<body bgcolor="Teal">
	<div id="header">
		<h1>Welcome to Adaptavant Technologies</h1>
		<div class="Menu">

			<a href="/JSPPages/Index.jsp">Home</a>

		</div>
		<div class="Menu">

			<a href="/JSPPages/Registration.jsp">Registration</a>

		</div>

		<%
			if (session.getAttribute("Username") == null) {
		%>
		<div class="Menu">

			<a href="/JSPPages/Login.jsp">Login</a>

		</div>
		<%
			} else {
		%>
		<div class="Menu" style="width: 200px;">
			<a href="/JSPPages/UserProfile.jsp"><%=session.getAttribute("Username")%></a>
		</div>
		<%
			if (session.getAttribute("Count") != null) {
		%>
		<div class="Menu" style="width: 50px;">
			<%=session.getAttribute("Count")%>
		</div><%} %>
		<div class="Menu">
			<a href="/logoutServlet">Logout</a>
		</div>
		<%
			}
		%>

		<div class="Menu">

			<a href="/JSPPages/Contactus.jsp">ContactUs</a>

		</div>
	</div>
	<div></div>
	<div class="break"></div>
	<div class="design">
		<p>
			<br> <span>Adaptavant Techologies</span>
		</p>
		<div class="design1">
			<br>
			<h2>Adaptavant Technology Solutions Pvt Ltd.</h2>
			<h3>Ascendas International IT Park,</h3>
			<h3>Phase I,</h3>
			<h3>4th Floor,</h3>
			<h3>Pinnacle Building,</h3>
			<h3>Taramani Road,</h3>
			<h3>Chennai,</h3>
			<h3>Tamil Nadu-600 113.</h3>
			<h3>Phone No: 044 4392 9106.</h3>
		</div>
	</div>
</body>
</html>
