<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Prevent caching so the back button doesn't show sensitive data after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    // Safety check: If session is null or username is missing, send them to login
    String user = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (user == null || !"ADMIN".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Ocean View</title>
    <style>
        body { font-family: Arial, sans-serif; background: #eef2f3; text-align: center; }
        .menu { width: 300px; margin: 40px auto; }
        .welcome-msg { color: #2c3e50; margin-top: 20px; }
        button { width: 100%; padding: 12px; margin: 8px 0; font-size: 16px; cursor: pointer; border: none; background: #34495e; color: white; border-radius: 5px; }
        button:hover { background: #2c3e50; }
        .logout-btn { background: #e74c3c; }
    </style>
</head>
<body>

    <h2>Admin Control Panel</h2>
    <h3 class="welcome-msg">Welcome back, <%= user %>!</h3>
    <p>Role: <span style="color: #27ae60;"><%= role %></span></p>

    <div class="menu">
        <button onclick="location.href='manage-users.jsp'">Manage Users</button>
        <button onclick="location.href='../room/manage-rooms.jsp'">Manage Rooms</button>
        <button onclick="location.href='../reports/reports.jsp'">View Reports</button>
        <button class="logout-btn" onclick="location.href='../logout'">Logout</button>
    </div>

</body>
</html>