<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join our email list</title>
<style>
  body{font-family:sans-serif;margin:40px;}
  h1{color:#00796b;font-size:42px;margin-bottom:14px;}
  label{display:inline-block;width:120px;margin:8px 0;}
  input[type=text]{width:320px;padding:6px;}
  .btn{margin-top:12px;padding:4px 10px;}
</style>
</head>
<body>
  <h1>Join our email list</h1>
  <p>To join our email list, enter your name and email address below.</p>

  <form action="${pageContext.request.contextPath}/emailList" method="post">
    <input type="hidden" name="action" value="add" />
    <label>Email:</label>
    <input type="text" name="email" value=""><br>
    <label>First Name:</label>
    <input type="text" name="firstName" value=""><br>
    <label>Last Name:</label>
    <input type="text" name="lastName" value=""><br>
    <input class="btn" type="submit" value="Join Now">
  </form>
</body>
</html>
