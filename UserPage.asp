<%
  if Request.Cookies("UserName")<>"" then
  	Session("name")=Request.Cookies("UserName")
  elseif Session("name") = "" then
    Response.Redirect("LoginForm.asp")
  end if
  QStr = Request.QueryString("msg")   
%>
<!DOCTYPE html>
<html>
<head>
	<title>BlogPoint | <%=Session("name")%></title>
	<meta http-equiv="x-ua-compatible" content="IE=10">
	<link rel="icon" href="images/Icon.png">
	<link rel="stylesheet" href="css/main.css" />
	<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
</head>
<body>
	<% QSMsg = Request.QueryString("msg") 
		cnt = Request.QueryString("txtcontent")
	%>
	<div class="header">
		<a href="index.asp"><img src="images/icon.png" alt="Logo" width="60" height="60" border="0"></a>
		<div class="buttons">
				<a href="UserPage.asp" title="<%=Session("name")%>" style="color:white;text-shadow: 1px 1px 4px grey,1px 1px 4px white;">My posts</a>&nbsp;
				<div class = "vertical"></div>&nbsp;
				<a href="Home.asp">Home</a>&nbsp;
				<div class = "vertical"></div>&nbsp;
				<a href="Logout.asp">Log Out</a>
		</div>	
	</div>
	<div class="pages" style="position:static;">
		<table style="padding:30px;background-color:white;width: 60%">
			<form name="NewPost" action="Uploadpost.asp" method="post">
			<% if QSMsg="nocontenttype" then %>
			  	<tr><td style="text-align:center;color:green;background-color: rgba(0,255,0,0.2)">
			  		<i class="material-icons">info</i>
			  		<label for="contenttype">Increase post reach by selecting content type.</label>
			  	</td></tr>
			 <% end if %>
			 <% if QSMsg="nocontent" then %>
			  	<tr><td style="text-align:center;color:green;background-color: rgba(0,255,0,0.2)">
			  		<i class="material-icons">info</i>
			  		<label for="txtcontent">Write something...</label>
			  	</td></tr>
			 <% end if %>
			 <% if QSMsg="duplicate" then %>
			  	<tr><td style="text-align:center;color:green;background-color: rgba(0,255,0,0.2)">
			  		<i class="material-icons">info</i>
			  		<label for="txtcontent">You have already posted this recently.</label>
			  	</td></tr>
			 <% end if %>
			<tr>
				<th style="text-align:left;color:#00B8FF">
					<%=Session("name")%>
				</th>
			</tr>
			<tr>
				<td>
					<%if QSMsg="nocontent" then%>
						<textarea wrap="off" name="txtcontent" id="txtcontent" style="resize:auto;overflow:auto;background-color:rgba(0,255,0,0.2);"></textarea>
					<%else%>
						<textarea wrap="off" name="txtcontent" style="resize:auto;overflow:auto;"><%if cnt<>"" then%><%=cnt%><%end if%></textarea>
					<%end if%>
				</td>
			</tr>
			<tr>
				<td>
					<%if QSMsg="nocontenttype" then%>
					<select name="contenttype" id="contenttype" width="100%" style="background-color:background-color: rgba(0,255,0,0.2) ">
					<%else%>
	                <select name="contenttype" style="width:absolute;">
	                <%end if%>
	                    <option value="Default">Click here to select Content Type</option>
	                    <option value="Animals and pets">Animals and pets</option>
	                    <option value="Art">Art</option>
	                    <option value="Cars">Cars</option>
	                    <option value="DIY and crafts">DIY and crafts</option>
	                    <option value="Design">Design</option>
	                    <option value="Education">Education</option>
	                    <option value="Film">Film</option>
	                    <option value="Food">Food</option>
	                    <option value="Hair and beauty">Hair and beauty</option>
	                    <option value="Health and fitness">Health and fitness</option>
	                    <option value="Humor">Humor</option>
	                    <option value="Motivational">Motivational</option>
	                    <option value="Photography">Photography</option>
	                    <option value="Quotes">Quotes</option>
	                    <option value="Technology">Technology</option>
	                    <option value="Travel">Travel</option>
	                </select>
				</td>
			</tr>
			<tr>
				<td>
					<input style="margin-top:10px;" type="submit" value="Post">
				</td>
			</tr>
			</form>
		</table>
	</div>
	<% if Request.Querystring("del")="true" then %>
	<div class="pages" style="position:static;">
		<table style="padding:30px;background-color:white;width: 60%">
			  	<tr><td style="text-align:center;color:green;background-color: rgba(0,255,0,0.2)">
			  		<i class="material-icons">info</i>
			  		<label>Successfully deleted!</label>
			  	</td></tr>
		</table>
	</div>
	<% end if %>
		<%
		set conn = server.CreateObject ("ADODB.Connection")		
		conn.Provider=Application("DBProvider")
		conn.Open server.MapPath ("dbBP.mdb")
		if Request.Querystring("delid")<>"" then
			sql="DELETE FROM tblposts WHERE postid=" & Request.Querystring("delid")
  			conn.Execute sql
  			if err<>0 then
			    response.write("No update permissions!")
			else
			    Response.Redirect("UserPage.asp?del=true")
			end if
		end if
		set rs = server.CreateObject ("ADODB.Recordset")
		rs.Open "SELECT * FROM tblposts where username='"&Session("name")&"' ORDER BY postid desc", conn
		if rs.EOF<>True then
			do while not rs.EOF %>
				<div class="pages" style="position:static;">
				<table style="padding:30px;background-color:white;width: 60%">
				<tr id="post">
					<td style="text-align:left;color:#00B8FF;border-bottom:1px solid grey;">
						<%=Session("name")%>
						<a href="UserPage.asp?delid=<%=rs("postid")%>"><i class="material-icons" style="float:right;color:#1a1a1a;">delete</i></a>
						<pre style="font-size:15px;color:grey;"><%=rs("posttime")%> <div class="vertical"></div> <%=rs("postdate")%></pre>
					</td>
				</tr>
				<tr>
					<td>
						<%=rs("content")%>
					</td>
				</tr>
				</table>
				</div>	
			<%
				rs.MoveNext
			loop
		end if
		rs.close
		conn.close
		%>
</body>
</html>