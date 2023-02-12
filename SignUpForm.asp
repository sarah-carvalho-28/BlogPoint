<%
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
	<title>BlogPoint | Sign Up</title>
	<link rel="icon" href="images/Icon.png">
	<link rel="stylesheet" href="css/main.css" />
	<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
	<meta http-equiv="x-ua-compatible" content="IE=10">
	<script type="text/vbscript">
		Function validate()
			Dim fname:fname=registration.txtfname.value
			Dim lname:lname=registration.txtlname.value
			Dim uname:uname=registration.txtuname.value
			Dim email:email=registration.txtemail.value
			Dim pass:pass=registration.txtpassword.value
			Dim cnfpass:cnfpass=registration.txtcnfpassword.value
			if fname="" then
				Msgbox("First Name cannot be empty!")
			elseif lname="" then
				Msgbox("Last Name cannot be empty!")
			elseif uname="" then
				Msgbox("Username cannot be empty!")
			elseif email="" then
				Msgbox("Email cannot be empty!")
			elseif pass="" then
				Msgbox("Password cannot be empty!")
			elseif cnfpass="" then
				Msgbox("Please confirm your password!")
			elseif instr(email,"@")=0 Or instr(email,".")=0 then
				Msgbox("Invalid Email Id!")
			elseif instr(email,"@")=1 Or instr(email,"@")=len(email) then
				Msgbox(" '@' cannot be at the beginning or end!")
			elseif instr(email,".")=1 Or instr(email,".")=len(email) then
				Msgbox(" '.' cannot be at the beginning or end!")
			elseif len(pass)<8 then
				Msgbox("Password cannot be less than 8 characters!")
			elseif pass<>cnfpass then
				Msgbox("Password does not match!")
			else
				document.registration.submit()
			end if
		End Function
	</script>
</head>
<body>
	<% ErrMsg = Request.QueryString("msg") 
		fn = Request.QueryString("fn") 
		ln = Request.QueryString("ln")
		un = Request.QueryString("un")
		e = Request.QueryString("e")
	%>
	<div class="header">
		<a href="index.asp"><img src="images/icon.png" alt="Logo" width="60" height="60" border="0"></a>
		<div class="buttons">
				<a href="LoginForm.asp">Login</a>&nbsp;
				<div class = "vertical"></div>&nbsp;
				<a href="SignUpForm.asp" style="color:white;text-shadow: 1px 1px 4px grey,1px 1px 4px white;">Sign Up</a>
		</div>	
	</div>
	<div class="pages" style="position:static;">
		<table style="margin-top:60px;">
			<tr>
				<th  colspan="2" style="font-family: 'Mansalva', cursive;color:#1a1a1a;font-size: 35px;border-bottom: 2px solid #1a1a1a;">Sign Up</th>
			</tr>
			<% if ErrMsg="unameinvalid" then %>
			  	<tr><td style="text-align:center;color:red;background-color: rgba(255,0,0,0.2)">
			  		<i class="material-icons">report_problem</i>
			  		<label for="userName">Username not available!</label>
			  	</td></tr>
			 <% end if %>
			<form name="registration" method="post" action="SignUp.asp">
			  <tr><td>
			  	<label for="firstName">First name</label>
			  </td></tr>
			  <tr><td>
			  	<input type="text" id="firstName" name="txtfname" value="<%if fn<>"" then%><%=fn%><%end if%>">
			  </td></tr>
			  <tr><td>
			  	<label for="lastName">Last name</label>
			  </td></tr>
			  <tr><td>
			  	<input type="text" id="lastName" name="txtlname" value="<%if ln<>"" then%><%=ln%><%end if%>">
			  </td></tr>
			  <tr><td>
			  	<label for="userName">Username</label></td></tr>
			  <tr><td>
			  <% if ErrMsg="unameinvalid" then %>
			  	<input style="background-color: rgba(255,0,0,0.2)" type="text" id="userName" name="txtuname" value="<%if un<>"" then%><%=un%><%end if%>">
			  <%else%>
			  	<input type="text" id="userName" name="txtuname" value="<%if un<>"" then%><%=un%><%end if%>">
			  <%end if%>
			  </td></tr>
			  <tr><td>
			  	<label for="email">Email address</label>
			  </td></tr>
			  <tr><td>
			  	<input type="email" id="email" name="txtemail" value="<%if e<>"" then%><%=e%><%end if%>">
			  </td></tr>
			  <tr><td>
			  	<label for="password">Create password</label>
			  </td></tr>
			  <tr><td>
			  	<input type="password" id="password" name="txtpassword" placeholder="Must be atleast 8 characters"></td></tr>
			  <tr><td>
			  	<label for="cnfpassword">Confirm password</label>
			  </td></tr>
			  <tr><td>
			  	<input type="password" id="cnfpassword" name="txtcnfpassword">
			  </td></tr>
			  <tr><td>
			  	<input style="margin-top:10px;" type="button" value="Sign Up" onclick="validate()">
			  </td></tr>
			</form>
		</table>
	</div>	
</body>
</html>