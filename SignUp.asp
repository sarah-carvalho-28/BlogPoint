<%
  if Session("name") <> "" then
    Response.Redirect("UserPage.asp")
  elseif Request.Cookies("UserName")<>"" then
  	Session("name")=Request.Cookies("UserName")
  	Response.Redirect("UserPage.asp")
  end if  
	Firstname=Request.Form("txtfname")
	Lastname=Request.Form("txtlname")
	Username = Request.Form("txtuname")
	Email=Request.Form("txtemail")
	Password = Request.Form("txtpassword")
	set conn = server.CreateObject ("ADODB.Connection")
	conn.Provider=Application("DBProvider")	
	conn.Open server.MapPath ("dbBP.mdb")
	set rs = server.CreateObject ("ADODB.Recordset")
	rs.Open "SELECT * FROM tblusers", conn, 3, 3
	do while not rs.EOF
		if rs("username") = Username then
			rs.Close
			conn.Close
			set rs=nothing
			set conn=nothing
			Response.Redirect("SignUpForm.asp?msg=unameinvalid&fn="&Firstname&"&ln="&Lastname&"&un="&Username&"&e="&Email)
		end if
		rs.MoveNext
	loop
	rs.AddNew 
	rs("firstname")=Firstname
	rs("lastname")=Lastname
	rs("username")=Username
	rs("email")=Email
	rs("password")=Password
	rs.Update 
	rs.Close
	conn.Close
	set rs=nothing
	set conn=nothing
	Response.Redirect("LoginForm.asp?msg=newuser")
%>
