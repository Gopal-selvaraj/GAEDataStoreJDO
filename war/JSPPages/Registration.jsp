<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%
	BlobstoreService blobstoreService = BlobstoreServiceFactory
			.getBlobstoreService();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
<title>Registration Page</title>
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
<script type="text/javascript">
		function userNameValidation() {
		var userName=document.getElementById("userName").value;
		var userNamePattern=/^[A-Z]+[a-z0-9]/;
			if (userName.match(userNamePattern)&& userName !== "") {
					return  true;
			} else {
					alert("UserName should be in the format of; \n Abc123 \n [1.Start with Capital letters]\n [2.Use Small letters and Use numbers(0-9)]");
			}
		}
		function userIdValidation() {
		var userId=document.getElementById("userId").value;
		var userIdPattern=/^[0-9]+[A-Za-z]+[0-9]{2,4}$/;
		if (userId.match(userIdPattern)&& userId !== "") {
					return  true;
			} else {
					alert("UserId should be in the format of; \n 2014acti0003 \n [1.Start with numbers(0-9)2 to 4 digits] \n [2.Use Alphabets(a-zA-Z)]\n [3.End with numbers(0-9)2 to 4 digits]");
			}
		}
		function dateOfBirthValidation() {
		var dateOfBirth=document.getElementById("dateOfBirth").value;
		if (dateOfBirth !== "") {
					return  true;
			} else {
					alert("DateOfBirth should be in the format of; \n MM/DD/YYYY \n [1.Start Month with numbers(0-9)2 digits] \n [2.Day with numbers(0-9)2 digits] \n [3.End Year with numbers(0-9)4 digits]");
			}
		}
		function dateOfRegistrationValidation() {
		var dateOfRegistration=document.getElementById("dateOfRegistration").value;
		if (dateOfRegistration !== "") {
					return  true;
			} else {
					alert("DateOfRegistration should be in the format of; \n MM/DD/YYYY \n [1.Start Month with numbers(0-9)2 digits] \n [2.Day with numbers(0-9)2 digits] \n [3.End Year with numbers(0-9)4 digits]");
			}
		}
		function companyNameValidation() {
		var companyName=document.getElementById("companyName").value;
		var companyNamePattern=/^[A-Z]+[a-z0-9]/;
		if (companyName.match(companyNamePattern) && companyName !== "") {
					return  true;
			} else {
					alert("CompanyName should be in the format of; \n Adaptavant \n [1.Start with Captial letters(A-Z)] \n [2.Use Small letters (a-z)]");
			}
		}
		function emailIdValidation(){
		var emailId=document.getElementById("emailId").value;
		var emailIdPattern=/^[a-zA-Z]+[~!#$%^&*()_+0-9]+@[a-zA-Z]+.[a-zA-Z]{2,4}$/;
		if (emailId.match(emailIdPattern) && emailId !== "") {
					return  true;
			} else {
					alert("EmailId should be in the format of; \n Abc$123@abc.com \n [1.Start with Alphabets [caps or small] \n [2.Use the Combination of symbols except @ and numbers(0-9)]\n [3.Use @ here ] \n [4.Use your mail domain name [a-z] here ] \n [5.Use . with [com,org,....] ]");
			}
		}
		function mobileNoValidation(){
		var mobileNo=document.getElementById("mobileNo").value;
		var mobileNoPattern=/[0-9]{10}$/;
		if (mobileNo.match(mobileNoPattern) && mobileNo !== "") {
					return  true;
			} else {
					alert("MobileNo should be in the format of; \n 9766554433 \n [1.It not goes more than 10(0-9) numbers]");
			}
		}
		function passwordValidation(){
		var password=document.getElementById("password").value;
		var passwordPattern=/^[a-zA-Z]+[@~!#$%^&*()_+]+[0-9]{2,4}$/;
		if (password.match(passwordPattern) && password !== "") {
					return  true;
			} else {
					alert("Password should be in the format of; \n acti@003 \n [1.Start with Alphabets(a-zA-Z)] \n [2.Use Symbols]\n [3.End with numbers(0-9)]");
			}
		}
		function reTypePasswordValidation(){
		var password=document.getElementById("password").value;
		var reTypePassword=document.getElementById("reTypePassword").value;
		var reTypePasswordPattern=/^[a-zA-Z]+[@~!#$%^&*()_+]+[0-9]{2,4}$/;
		if (reTypePassword.match(reTypePasswordPattern) && reTypePassword !== "" && reTypePassword === password) {
					return  true;
			} else {
					alert("Password MisMatch and ReTypePassword should be in the format of; \n acti@003 \n [1.Start with Alphabets(a-zA-Z)] \n [2.Use Symbols]\n [3.End with numbers(0-9)]");
			}
		}
	</script>
</head>
<body bgcolor="Teal">
	<div id="header">
		<h1>Welcome to Adaptavant Technologies</h1>
		<div class="Menu">

			<a href="/JSPPages/Index.jsp">Home</a>

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
	<form action="<%=blobstoreService.createUploadUrl("/registrationServlet")%>"
		method="post" enctype="multipart/form-data">
		<div class="design">
			<p>
				<br> <span>Registration Form</span>
			</p>

			<div class="design1">
				<br> <br>
				<table>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Username</td>
						<td>:<input maxlength="30" placeholder="Abc123"
							name="UserName" size="20" type="text" id="userName" value="" onblur= "userNameValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Userid</td>
						<td>:<input maxlength="12" placeholder="2013Abcd0003"
							name="UserId" size="20" type="text" id="userId" value="" onblur="userIdValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DateOfBirth</td>
						<td>:<input maxlength="10" placeholder="MM/DD/YYYY" value=""
							name="DateOfBirth" size="20" type="date" id="dateOfBirth" value="" onblur="dateOfBirthValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DateOfRegistration</td>
						<td>:<input maxlength="10" placeholder="MM/DD/YYYY"
							name="DateOfRegistration" size="20" type="date" value=""
							id="dateOfRegistration" onBlur="dateOfRegistrationValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CompanyName</td>
						<td>:<input maxlength="30" placeholder="Abcdef" value=""
							name="Company" size="20" type="text" id="companyName"
							onblur="companyNameValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EmailId</td>
						<td>:<input maxlength="30" placeholder="abc*88@gmail.com"
							name="EmailId" size="20" type="email" id="emailId" value=""
							onblur="emailIdValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MobileNo</td>
						<td>:<input maxlength="10" placeholder="9988771123"
							name="MobileNo" size="20" type="text" id="mobileNo" value=""
							onblur="mobileNoValidation()" ></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Password</td>
						<td>:<input maxlength="10" placeholder="Abc@123" value=""
							name="Password" size="20" type="password" id="password"	onblur="passwordValidation()" required>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ReTypePassword</td>
						<td>:<input maxlength="10" placeholder="Abc@123" value=""
							name="ReTypePassword" size="20" type="password" id="reTypePassword"	onblur="reTypePasswordValidation()" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
							Your Image File</td>
						<td>:<input id="image" type="file" name="Image" onBlur="imageValidation()" value="" required></td>
					</tr>
				</table>
			</div>
			<div class="button">
				<table>
					<tr>
						<td><input name="Registration" type="submit" id="register" value="Register" ></td>
						<td><input name="Reset" type="reset" value="Reset"></td>

					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
</html>
