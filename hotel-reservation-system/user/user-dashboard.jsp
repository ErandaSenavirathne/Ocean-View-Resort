<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    String user = (String) session.getAttribute("username");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Ocean View</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; text-align: center; }
        .menu { width: 300px; margin: 40px auto; }
        .welcome-msg { color: #2980b9; margin-top: 20px; }
        button { width: 100%; padding: 12px; margin: 8px 0; font-size: 16px; cursor: pointer; border: none; background: #2980b9; color: white; border-radius: 5px; }
        button:hover { background: #1f6391; }
        .logout-btn { background: #c0392b; }
    </style>
</head>
<body>

    <h2>Staff Reservation Portal</h2>
    <h3 class="welcome-msg">Hello, <%= user %>!</h3>
     <p>Role: <span style="color: #27ae60;">USER</span></p>

    <div class="menu">
        <button onclick="location.href='../user/search-guest.jsp'">Make a Reservation</button>
        <button onclick="location.href='<%=request.getContextPath()%>/ViewAvailableRooms'">
            Check Room Availability
        </button>
        <button onclick="location.href='../reservation/view-bookings.jsp'">View All Reservations</button>
        <button class="logout-btn" onclick="location.href='../logout'">Logout</button>
    </div>

</body>
</html>