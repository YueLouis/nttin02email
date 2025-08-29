<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Survey</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    :root{
      --bg:#0e0e0e;
      --card:#141414;
      --text:#e8e8e8;
      --muted:#b9b9b9;
      --accent:#ffa31a;   /* cam */
      --accent-2:#ff3b00; /* đỏ nhấn */
      --input:#1f1f1f;
      --ring:#2d2d2d;
      --radius:24px;
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0;
      font:16px/1.5 system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Segoe UI Emoji";
      color:var(--text);
      background:
        radial-gradient(1200px 600px at 15% -10%, #ffffff22, transparent 60%),
        radial-gradient(1000px 500px at 90% 110%, #ffffff15, transparent 60%),
        linear-gradient(180deg, #2a2a2a 0%, #1e1e1e 30%, #121212 100%);
      min-height:100%;
      padding:48px 16px;
      display:flex; align-items:center; justify-content:center;
    }
    .frame{ width:min(1020px, 100%); }
    .card{
      background:var(--card);
      border-radius:48px;
      padding:56px 48px;
      box-shadow:
        0 30px 80px rgba(0,0,0,.6),
        inset 0 1px 0 #ffffff14;
      position:relative;
    }
    .card:before{
      content:"";
      position:absolute; inset:-2px;
      border-radius:50px;
      background:linear-gradient(135deg, #ffffff10, transparent 40%);
      pointer-events:none;
    }
    .header{
      display:flex; align-items:center; gap:24px; margin-bottom:28px;
    }
    .logo{
      width:92px; height:92px;
      border-radius:20px;
      background:#b40000;
      display:grid; place-items:center;
      overflow:hidden;
      box-shadow:0 10px 30px rgba(180,0,0,.35);
    }
    .logo img{ width:80%; height:auto; display:block; }
    .title h1{
      margin:0 0 6px; font-size:40px; letter-spacing:.5px;
      color:var(--accent);
    }
    .title p{ margin:0; color:var(--muted) }

    .grid{ display:grid; gap:14px 24px; grid-template-columns: 180px 1fr; }
    .label{ color:var(--muted); padding-top:12px }
    input[type="text"], input[type="email"], input[type="date"], select{
      width:100%;
      background:var(--input);
      border:1px solid var(--ring);
      color:var(--text);
      padding:12px 14px;
      border-radius:12px;
      outline:none;
      transition:.15s border-color, .15s box-shadow;
    }
    input:focus, select:focus{
      border-color:#676767;
      box-shadow:0 0 0 3px #ffffff10;
    }

    .group{ grid-column:1/-1; margin-top:8px; }
    .group h3{ margin:8px 0 8px; color:var(--text) }
    .radios, .checks{ display:flex; flex-wrap:wrap; gap:16px 24px; }
    .radios label, .checks label{
      display:inline-flex; align-items:center; gap:8px; color:var(--text);
    }
    .muted{ color:var(--muted); }

    .actions{
      margin-top:24px; display:flex; gap:16px; align-items:center;
    }
    .btn{
      background:linear-gradient(180deg, var(--accent) 0%, #ff6f00 100%);
      border:none; color:#111; font-weight:700;
      padding:12px 28px; border-radius:14px; cursor:pointer;
      box-shadow:0 10px 24px rgba(255,163,26,.35);
      transition:transform .07s ease, box-shadow .2s ease;
    }
    .btn:hover{ transform:translateY(-1px); box-shadow:0 16px 28px rgba(255,163,26,.45); }
    .btn:active{ transform:translateY(0) scale(.99); }
    .error{
      grid-column:1/-1;
      background:#5b0000; color:#ffdede; border:1px solid #ffbaba44;
      padding:10px 12px; border-radius:10px; margin-bottom:8px;
    }

    @media (max-width: 760px){
      .grid{ grid-template-columns: 1fr; }
      .label{ padding-top:0 }
      .header{ flex-direction:column; align-items:flex-start }
    }
  </style>
</head>
<body>
  <div class="frame">
    <div class="card">

      <div class="header">
        <div class="logo">
          <img src="${pageContext.request.contextPath}/images/murach.png" alt="Murach" class="logo"/>
        </div>
        <div class="title">
          <h1>Survey</h1>
          <p>If you have a moment, we'd appreciate it if you would fill out this survey.</p>
        </div>
      </div>

      <form action="${pageContext.request.contextPath}/survey" method="post">
        <%-- lỗi --%>
        <c:if test="${not empty error}">
          <div class="error">${error}</div>
        </c:if>

        <div class="label">First Name:</div>
        <div><input type="text" name="firstName" required value="${firstName}"></div>

        <div class="label">Last Name:</div>
        <div><input type="text" name="lastName" required value="${lastName}"></div>

        <div class="label">Email:</div>
        <div><input type="email" name="email" required value="${email}"></div>

        <div class="label">Date Of Birth</div>
        <div><input type="date" name="dob" required value="${dob}"></div>

        <div class="group">
          <h3>How did you hear about us?</h3>
          <div class="radios">
            <label><input type="radio" name="hearAbout" value="search" ${hearAbout=='search'?'checked':''}> Search engine</label>
            <label><input type="radio" name="hearAbout" value="word"   ${hearAbout=='word'?'checked':''}> Word of mouth</label>
            <label><input type="radio" name="hearAbout" value="social" ${hearAbout=='social'?'checked':''}> Social media</label>
            <label><input type="radio" name="hearAbout" value="other"  ${hearAbout=='other'?'checked':''}> Other</label>
          </div>
        </div>

        <div class="group">
          <h3>Would you like to receive announcements about new CDs and special offers?</h3>
          <div class="checks muted">
            <label><input type="checkbox" name="likeOffers"   ${likeOffers?'checked':''}> YES, I'd like that.</label>
            <label><input type="checkbox" name="emailUpdates" ${emailUpdates?'checked':''}> YES, please send me email announcements.</label>
          </div>
        </div>

        <div class="label">Please contact me by:</div>
        <div>
          <select name="contactBy">
            <option value="both"  ${contactBy=='both'?'selected':''}>Email or postal mail</option>
            <option value="email" ${contactBy=='email'?'selected':''}>Email only</option>
            <option value="postal"${contactBy=='postal'?'selected':''}>Postal mail only</option>
          </select>
          <div class="actions">
            <button class="btn" type="submit">Submit</button>
          </div>
        </div>

      </form>
    </div>
  </div>

  <%-- dùng JSTL <c:if> thì thêm taglib (đặt ngay đầu body hay head đều được) --%>
  <%-- Nếu project chưa dùng JSTL, thay <c:if> bằng điều kiện EL đơn giản hoặc bỏ khối đó --%>
</body>
</html>
