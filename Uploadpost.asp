
<%
  if Request.Cookies("UserName")<>"" then
  	Session("name")=Request.Cookies("UserName")
  elseif Session("name") = "" then
    Response.Redirect("LoginForm.asp")
  end if  
%>
<%
	Username = Session("name")
	Content = Request.Form("txtcontent")
	ContentType=Request.Form("contenttype")
	if Content="" then
		Response.Redirect("Userpage.asp?msg=nocontent")
	end if
	if ContentType="Default" then
		Response.Redirect("Userpage.asp?msg=nocontenttype&txtcontent="&Content)
	end if
	set conn = server.CreateObject ("ADODB.Connection")		
	conn.Provider=Application("DBProvider")
	conn.Open server.MapPath ("dbBP.mdb")
	set rs = server.CreateObject ("ADODB.Recordset")
	'Open all records
	rs.Open "SELECT * FROM tblposts", conn, 3, 3
	'Check if message doesn't already exist
	do while not rs.EOF
		if rs("content")=Content then
			set rs=nothing
			set conn=nothing
			Response.Redirect("UserPage.asp?msg=duplicate&txtcontent="&Content&"&contenttype="&ContentType)
		end if
		rs.MoveNext
	loop

	'Add a record
	rs.AddNew 
	rs("username")=Username
	rs("content")=Content
	rs("contenttype")=ContentType
	rs("postdate")=date
	rs("posttime")=time
	'Save record
	rs.Update

	set rs=nothing
	set conn=nothing

	Response.Redirect("UserPage.asp?msg=success")
	
%>