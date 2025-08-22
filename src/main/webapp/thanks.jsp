<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thanks for joining our email list</title>
<style>
  body{font-family:sans-serif;margin:40px;}
  h1{color:#00796b;font-size:42px;margin-bottom:14px;}
  label{display:inline-block;width:120px;margin:8px 0;}
  .btn{margin-top:16px;padding:4px 10px;}
</style>
</head>
<body>
  <h1>Thanks for joining our email list</h1>

  <p>Here is the information that you entered:</p>
  <p><label>Email:</label> ${email}</p>
  <p><label>First Name:</label> ${firstName}</p>
  <p><label>Last Name:</label> ${lastName}</p>

  <form action="${pageContext.request.contextPath}/emailList" method="get">
    <input type="hidden" name="action" value="join" />
    <input class="btn" type="submit" value="Return" />
  </form>
</body>
</html>
