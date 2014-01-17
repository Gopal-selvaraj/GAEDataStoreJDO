<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="stylesheet.css" />
<title>Login Page</title>
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

			<a href="Index.jsp">Home</a>

		</div>
		<div class="Menu">

			<a href="Registration.jsp">Registration</a>

		</div>
		
		<%
			if (session.getAttribute("Username") == null) {
		 }else{%>
		<div class="Menu" style="width: 200px;">
			<a href="/JSPPages/UserProfile.jsp"><%=session.getAttribute("Username")%></a>
		</div>
		<div class="Menu" style="width: 50px;">
			<%=session.getAttribute("Count")%>
		</div>
		<div class="Menu">
			<a href="/logoutServlet">Logout</a>
		</div>
		<%
			}
		%>
		<div class="Menu">

			<a href="Contactus.jsp">ContactUs</a>

		</div>
	</div>
	<div></div>
	<div class="break"></div>
	<form name="Login" action="/loginServlet" method="post">

		<div class="design">
			<p>
				<br> <span>Login Form</span>
			</p>

			<div class="design1">
				<br> <br> <br> <br> <br> <br>
				<table>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Username</td>
						<td>:<input maxlength="30" name="UserName" size="20"
							type="text"></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Password</td>
						<td>:<input maxlength="10" name="Password" size="20"
							type="password"></td>
					</tr>
				</table><br>
					<table style="height: 70px; width: 319px">
						<tr style="height: 50px; width: 450px">
								
						<td  align="right" style="height: 40px; width: 244px"><input name="Login"type="submit" value="login"></td>
					<td align="left" style="height: 40px; width: 79px"><a href="https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile&response_type=code&access_type=offline&redirect_uri=http://localhost:8888/oAuthLoginServlet&approval_prompt=force&client_id=531458892127-mspjpjjj1ckjq7hlhbndqvqvjulfd4lp.apps.googleusercontent.com"><img src="../Images/gp.jpg" alt="GooglePlus login" style="height: 25px; width: 50px; margin-top: 0px;"/></a></td>
					</tr></table>
				</div>
			</div>
	</form>

</body>
</html>


