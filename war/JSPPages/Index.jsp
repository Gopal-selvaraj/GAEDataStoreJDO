<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<!DOCTYPE html>
<html>
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

		</div><% }else{%>
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
		<br> <br> <br> <span
			style="font-size: 26px; color: maroon;">Welcome to Adaptavant
			Techologies</span> <br> <br> <br> <br>
		<div class="image" style="text-align:center;margin-left:125px;" >
			<img style=" height: 180px; width: 250px" src="../Images/AdaptavantTechnologies.jpg" />
		</div>
	</div>

</body>
</html>
