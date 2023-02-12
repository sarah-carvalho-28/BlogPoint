<%
	Response.Cookies("UserName")=""
	Session("name") = ""
	Response.Redirect("index.asp")
%>