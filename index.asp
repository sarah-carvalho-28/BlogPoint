<%
Application("DBProvider")="Microsoft.Jet.OLEDB.4.0"
  if Session("name") <> "" then
    Response.Redirect("UserPage.asp")
  elseif Request.Cookies("UserName")<>"" then
  	Session("name")=Request.Cookies("UserName")
  	Response.Redirect("UserPage.asp")
  end if  
%>
<!DOCTYPE html>
<html>
<head>
	<title>BlogPoint</title>
	<link rel="icon" href="images/Icon.png">
	<link rel="stylesheet" href="css/main.css" />
	<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
</head>
<body>
	<div class="header">
		<a href="index.asp"><img src="images/icon.png" alt="Logo" width="60" height="60"></a>
		<div class="buttons">
				<a href="LoginForm.asp">Login</a>&nbsp;
				<div class = "vertical"></div>&nbsp;
				<a href="SignUpForm.asp">Sign Up</a>
		</div>	
	</div>
	<div class="frontpage">
		<p style="font-family: 'Mansalva', cursive;color: #00B8FF;">BlogPoint</p>
	</div>	
</body>
</html>