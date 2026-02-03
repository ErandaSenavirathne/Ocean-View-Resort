<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Guest</title>
    <style>
        body {
            font-family: Arial;
            background: linear-gradient(to right, #74ebd5, #9face6);
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
        }

        h2 {
            text-align: center;
        }

        input {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 25px 40px;
            border-radius: 10px;
            color: white;
            text-align: center;
            z-index: 1000;
        }

        .success { background-color: #28a745; }
        .error { background-color: #dc3545; }
    </style>
</head>
<body>

<div class="container">
    <h2>Register New Guest</h2>
    <form action="${pageContext.request.contextPath}/registerGuest" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="text" name="nic" placeholder="NIC / Passport" required>
        <input type="text" name="phone" placeholder="Phone Number">
        <input type="email" name="email" placeholder="Email Address">
        <button type="submit">Register Guest</button>
    </form>
</div>

<%
    String message = (String) request.getAttribute("message");
    String status = (String) request.getAttribute("status");
    if (message != null) {
%>
    <div class="popup <%= status %>">
        <p><%= message %></p>
        <button onclick="goDashboard()">OK</button>
    </div>
<%
    }
%>

<script>
function goDashboard() {
    window.location.href = "<%=request.getContextPath()%>/user/user-dashboard.jsp";
}
</script>

</body>
</html>
