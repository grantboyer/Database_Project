
<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<title>My Transactions</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session"/>


<table style="text-align: center; width: 100%; margin-left: auto; margin-right: auto;" border="1";cellpadding="2"; cellspacing="2">
  <tbody>
    <tr>
      	<td style="vertical-align: top;">User Id<br> 
      	</td>
      	<td style="vertical-align: top;">Username<br>
      	</td>
     	 <td style="vertical-align:top;">First Name<br>
      	</td>
      	<td style="vertical-align: top;">Last Name<br>
      	</td>
      	<td style="vertical-align: top;">Email Address<br>
      	</td>
      	<td style="vertical-align: top;">Seller Rating<br>
      	</td>
      	<td style="vertical-align: top;">Commissions<br>
      	</td>
   </tr>

    <% try{
    ResultSet rs = user.getAllUserInfo();
    while (rs.next()) {
	%>
	<tr>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<input type="text" readonly name = "user_id" value="<%=rs.getString("USER_ID")%>"><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<input type="text" readonly name = "username" value="<%=rs.getString("USERNAME")%>"><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<input type="text" readonly name = "first_n" value="<%=rs.getString("FIRST_N")%>"><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<input type="text" readonly name = "last_n" value="<%=rs.getString("LAST_N")%>"><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<input type="text" readonly name = "email" value="<%=rs.getString("EMAIL")%>"><br>
     	</td>
     	
    </tr>
    <%} rs.close();}

    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }

	%>
    
    <tr>
      	<td style="vertical-align: top;">-<br> 
      	</td>
      	<td style="vertical-align: top;">Total Commissions<br>
      	</td>
     	 <td style="vertical-align:top;">-<br>
      	</td>
      	<td style="vertical-align: top;">-<br>
      	</td>
      	<td style="vertical-align: top;">-<br>
      	</td>
      	<td style="vertical-align: top;">-<br>
      	</td>
      	<td style="vertical-align: top;"><br>
      	</td>
   </tr>
    
    
  </tbody>
</table>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>

</body>
</html>