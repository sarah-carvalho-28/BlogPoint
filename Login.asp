<%
  if Session("name") <> "" then
    Response.Redirect("UserPage.asp")
  elseif Request.Cookies("UserName")<>"" then
  	Session("name")=Request.Cookies("UserName")
  	Response.Redirect("UserPage.asp")
  end if  
%>
<%
	Username = Request.Form("txtuname")	
	Password = Request.Form("txtpassword")
	RememberMe=Request.Form("rememberme")
	set conn = server.CreateObject ("ADODB.Connection")		
	conn.Provider=Application("DBProvider")
	conn.Open server.MapPath ("dbBP.mdb")
	set rs = server.CreateObject ("ADODB.Recordset")
	rs.Open "SELECT * FROM tblusers where username='"& Username &"'", conn, 1 
	If rs.recordcount = 0 then
		rs.close
		conn.close
		set rs=nothing
		set conn=nothing
		Response.Redirect("LoginForm.asp?msg=unameinvalid&txtuname="&Username)
	end if
	if rs("password") = Password then
		Session("name") = rs("username")
		if RememberMe="true" then
			Response.Cookies("UserName")=rs("username")
		end if
		rs.Close
		conn.Close
		set rs=nothing
		set conn=nothing
		Response.Redirect("UserPage.asp")
	else
		rs.Close
		conn.Close
		set rs=nothing
		set conn=nothing
		Response.Redirect("LoginForm.asp?msg=passwordinvalid&txtuname="&Username)
	end if	

%>
