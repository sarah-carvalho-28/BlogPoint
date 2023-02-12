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
	<title>BlogPoint | Login</title>
	<link rel="icon" href="images/Icon.png">
	<link rel="stylesheet" href="css/main.css" />
	<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
	<meta http-equiv="x-ua-compatible" content="IE=10">
	<script type="text/vbscript">
		Function validate()
			Dim uname:uname=login.txtuname.value
			Dim pass:pass=login.txtpassword.value
			if uname="" then
				Msgbox("Please enter Username!")
			elseif pass="" then
				Msgbox("Please enter Password!")
			else
				document.login.submit()
			end if
		End Function
	</script>
</head>
<body>
	<% QSMsg = Request.QueryString("msg")
		un=Request.QueryString("txtuname")
	 %>
	<div class="header">
		<a href="index.asp"><img src="images/icon.png" alt="Logo" width="60" height="60" border="0"></a>
		<div class="buttons">
				<a href="LoginForm.asp" style="color:white;text-shadow: 1px 1px 4px grey,1px 1px 4px white;">Login</a>&nbsp;
				<div class = "vertical"></div>&nbsp;
				<a href="SignUpForm.asp">Sign Up</a>
		</div>	
	</div>
	<div class="pages">
		<table>
		<tr>
			<th colspan="2" style="font-family: 'Mansalva', cursive;color:#1a1a1a;font-size: 35px;border-bottom: 2px solid #1a1a1a;">Login</th>
		</tr>
		<tr>
		<% if QSMsg="newuser" then %>
			<td style="text-align:center;color:green;background-color: rgba(0,255,0,0.2)">
			  	<i class="material-icons">how_to_reg</i>
			  	<label for="userName">Successfully Signed Up.<br>Login to get started.</label>
		<% elseif QSMsg="unameinvalid" then %>
			<td style="text-align:center;color:red;background-color: rgba(255,0,0,0.2)">
			  	<i class="material-icons">report_problem</i>
			  	<label for="userName">Incorrect Username!</label>
		<% elseif QSMsg="passwordinvalid" then %>
			<td style="text-align:center;color:red;background-color: rgba(255,0,0,0.2)">
			  	<i class="material-icons">report_problem</i>
			  	<label for="password">Incorrect Password!</label>
		<% end if %>
		</td></tr>
		<form name="login" action="Login.asp" method="post">
			  <tr><td><label for="userName">Username</label></td></tr>
			  <tr><td>
			  <%if QSMsg="unameinvalid" then%>
			  	<input style="background-color: rgba(255,0,0,0.2)" type="text" id="userName" name="txtuname" value="<%if un<>"" then%><%=un%><%end if%>">
			  <%else%>
			  	<input type="text" id="userName" name="txtuname" value="<%if un<>"" then%><%=un%><%end if%>">
			  <%end if%>
			  </td></tr>
			  <tr><td><label for="password">Password</label></td></tr>
			  <tr><td>
			  <%if QSMsg="passwordinvalid" then%>
			  	<input style="background-color: rgba(255,0,0,0.2)" type="password" id="password" name="txtpassword">
			  <%else%>
			  	<input type="password" id="password" name="txtpassword">
			  <%end if%>
			  </td></tr>
			  <tr><td><input id="rememberme" name="rememberme" type="checkbox" checked> &nbsp;<label for="rememberme" style="font-family: 'Times New Roman', cursive;font-size: 20px;">Remember me</label> </td></tr>
			  <tr><td><input style="margin-top:10px;" type="button" value="Log In" onclick="validate()"></td></tr>
			</form>
	</div>	
</body>
</html>