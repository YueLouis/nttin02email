<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<title>Thanks</title>
<style>
  body{margin:0;min-height:100dvh;display:grid;place-items:center;
       background:linear-gradient(180deg,#2a2a2a,#121212);color:#eee;
       font:16px/1.6 system-ui, Segoe UI, Roboto, Helvetica, Arial}
  .box{background:#141414;border-radius:28px;padding:36px 40px; width:min(720px,92vw);
       box-shadow:0 24px 80px rgba(0,0,0,.55)}
  h1{margin:0 0 8px;color:#ffa31a}
  a{color:#ffa31a;text-decoration:none}
  a:hover{text-decoration:underline}
  ul{margin:16px 0 0}
</style>
</head>
<body>
  <div class="box">
    <h1>Thanks for your submission!</h1>
    <p>Here’s what we received:</p>
    <ul>
      <li>Name: ${r.firstName} ${r.lastName}</li>
      <li>Email: ${r.email}</li>
      <li>Date of birth: ${r.dob}</li>
      <li>Heard about us via: ${r.hearAbout}</li>
      <li>Like offers: ${r.likeOffers}</li>
      <li>Email updates: ${r.emailUpdates}</li>
      <li>Preferred contact: ${r.contactBy}</li>
    </ul>
    <p style="margin-top:16px"><a href="${pageContext.request.contextPath}/survey">Return</a></p>
  </div>
</body>
</html>
