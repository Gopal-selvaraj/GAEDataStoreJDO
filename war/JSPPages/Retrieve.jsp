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
<title>Retrieval Page</title>
<%
	if (session.getAttribute("Username") == null
			|| session.getAttribute("Username") == "") {
		response.sendRedirect("/JSPPages/Index.jsp");
	} else {
		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
%>
<script type="text/javascript">
	function Enable() {
		document.getElementById("userName").disabled = false;
		document.getElementById("dateOfBirth").disabled = false;
		document.getElementById("dateOfRegistration").disabled = false;
		document.getElementById("companyName").disabled = false;
		document.getElementById("emailId").disabled = false;
		document.getElementById("mobileNo").disabled = false;
		document.getElementById("password").disabled = false;
		document.getElementById("reTypePassword").disabled = false;
		document.getElementById("update").disabled = false;
	}
	function uploadEnable(){
		var a=document.getElementById("image").value;
		if(document.getElementById("image")!=0){
			document.getElementById("upload").disabled = false;
			//alert("Your File is  Uploaded Successfully.");
		}
	}
	function updateCalled(){
		var a=document.getElementById("image").value;
		if(document.getElementById("image")!=0){
			document.getElementById("upload").disabled = false;
			//alert("Your File is  Uploaded Successfully.");
		}
	}
	
	function userNameValidation() {
		var userName = document.getElementById("userName").value;
		var userNamePattern = /^[A-Z]+[a-z0-9]/;
		if (userName.match(userNamePattern) && userName !== "") {
			return true;
		} else {
			alert("UserName should be in the format of; \n Abc123 \n [1.Start with Capital letters]\n [2.Use Small letters and Use numbers(0-9)]");
			document.getElementById("userName").focus();
		}
	}

	function companyNameValidation() {
		var companyName = document.getElementById("companyName").value;
		var companyNamePattern = /^[A-Z]+[a-z0-9]/;
		if (companyName.match(companyNamePattern) && companyName !== "") {
			return true;
		} else {
			alert("CompanyName should be in the format of; \n Adaptavant \n [1.Start with Captial letters(A-Z)] \n [2.Use Small letters (a-z)]");
			document.getElementById("companyName").focus();
		}
	}
	function emailIdValidation() {
		var emailId = document.getElementById("emailId").value;
		var emailIdPattern = /^[a-zA-Z]+[~!#$%^&*()_+0-9]+@[a-zA-Z]+.[a-zA-Z]{2,4}$/;
		if (emailId.match(emailIdPattern) && emailId !== "") {
			return true;
		} else {
			alert("EmailId should be in the format of; \n Abc$123@abc.com \n [1.Start with Alphabets [caps or small] \n [2.Use the Combination of symbols except @ and numbers(0-9)]\n [3.Use @ here ] \n [4.Use your mail domain name [a-z] here ] \n [5.Use . with [com,org,....] ]");
			document.getElementById("emailId").focus();
		}
	}
	function mobileNoValidation() {
		var mobileNo = document.getElementById("mobileNo").value;
		var mobileNoPattern = /[0-9]{10}$/;
		if (mobileNo.match(mobileNoPattern) && mobileNo !== "") {
			return true;
		} else {
			alert("MobileNo should be in the format of; \n 9766554433 \n [1.It not goes more than 10(0-9) numbers]");
			document.getElementById("mobileNo").focus();
		}
	}
	function passwordValidation() {
		var password = document.getElementById("password").value;
		var passwordPattern = /^[a-zA-Z]+[@~!#$%^&*()_+]+[0-9]{2,4}$/;
		if (password.match(passwordPattern) && password !== "") {
			return true;
		} else {
			alert("Password should be in the format of; \n acti@003 \n [1.Start with Alphabets(a-zA-Z)] \n [2.Use Symbols]\n [3.End with numbers(0-9)]");
			document.getElementById("password").focus();
		}
	}
	function reTypePasswordValidation() {
		var password = document.getElementById("password").value;
		var reTypePassword = document.getElementById("reTypePassword").value;
		var reTypePasswordPattern = /^[a-zA-Z]+[@~!#$%^&*()_+]+[0-9]{2,4}$/;
		if (reTypePassword.match(reTypePasswordPattern)
				&& reTypePassword !== "" && reTypePassword === password) {
			return true;
		} else {
			alert("Password MisMatch and ReTypePassword should be in the format of; \n acti@003 \n [1.Start with Alphabets(a-zA-Z)] \n [2.Use Symbols]\n [3.End with numbers(0-9)]");
			document.getElementById("reTypePassword").focus();
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
		<div class="Menu">

			<a href="/JSPPages/Registration.jsp">Registration</a>

		</div>

		<%
			if (session.getAttribute("Username") != null) {
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
				<br> <span>Retrival Form</span>
			</p><div class="design1">
<form  action="/updateServlet" method="post" >
			
				<table style="margin-top: 10px;margin-left:25px;">
					<tr><td>Username</td><td>:<input disabled id="userName" maxlength="30" name="UserName"
						size="20" type="text"
						value="<%=session.getAttribute("Username")%>"
						onblur="userNameValidation()" required></td></tr>
				
					<tr><td>DateOfBirth </td><td>:<input disabled id="dateOfBirth" maxlength="30" name="DateOfBirth"
						size="20" type="date"
						value="<%=session.getAttribute("DateofBirth")%>" required>
				<tr><td>DateOfRegistration</td><td> :<input disabled maxlength="30"
						id="dateOfRegistration" name="DateOfRegistration" size="20"
						type="date"
						value="<%=session.getAttribute("DateofRegistration")%>" required></td></tr>
				<tr><td>UserId</td><td>:<input readonly id="userId" maxlength="10" name="UserId" size="20"
						type="text" value="<%=session.getAttribute("Userid")%>" required></td></tr>
			<tr><td>Company
					</td><td>:<input disabled id="companyName" maxlength="30" name="Company"
						size="20" type="text" value="<%=session.getAttribute("Company")%>"
						onblur="companyNameValidation()"></td></tr>
				<tr><td>EmailId
					</td><td>:<input disabled id="emailId" maxlength="30" name="EmailId"
						size="20" type="email"
						value="<%=session.getAttribute("Emailid")%>"
						onblur="emailIdValidation()" required></td></tr>
				<tr><td>MobileNo
					</td><td>:<input disabled maxlength="10" id="mobileNo" name="MobileNo"
						size="20" type="text"
						value="<%=session.getAttribute("Mobileno")%>"
						onblur="mobileNoValidation()"></td></tr>
			<tr><td>Password
					</td><td>:<input disabled id="password" maxlength="10" name="Password"
						size="20" type="password"
						value="<%=session.getAttribute("Password")%>"
						onblur="passwordValidation()" required></td></tr>
				<tr><td>ReTypePassword</td><td>:<input disabled id="reTypePassword"
						maxlength="10" name="ReTypePassword" size="20" type="password"
						value="<%=session.getAttribute("Password")%>"
						onblur="reTypePasswordValidation()" required></td></tr>
				</table><div class="profilebutton" style="margin-top:-2px;height:25px;width:470px;" >
					<table style="margin-left:18px;"><tr><td><button type="button" onClick="Enable()">EnableText
						Fields</button></td><td><input name="Update" type="submit" value="Update" id="update"
						onclick="updateCalled()" disabled > <a href="/JSPPages/UserProfile.jsp"><input
						name="ViewProfile" type="button" value="ViewProfile" ></a></td></tr></table>
				</div></form>
				<div style="margin-left:0px;margin-top:0px;height:70px;width:470px;background-color:#22CCFF">
				<form action="<%=blobstoreService.createUploadUrl("/uploadImageServlet") %>" method="post" enctype="multipart/form-data">
				<table style="margin-left:18px;"><tr><td><img style="margin-top:2px;margin-left:2px;"class="image"  src="<%=session.getAttribute("Image")%>" /></td><td>
				Image</td><td>:<input type="file" name="Image" id="image" value="" onclick="uploadEnable()"></td>
				<td><input disabled type="submit" name="Upload" id="upload" value ="Upload"></td></tr></table></form><form name="form1">
				
			</form>
</div></div>
		</div>
</body>
</html>

