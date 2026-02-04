<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Prevent back-button access after logout
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
        body { font-family: Arial, sans-serif; background: #f4f6f8; text-align: center; margin: 0; padding: 0; }
        .dashboard-container { padding: 40px; }
        .menu { width: 320px; margin: 20px auto; }
        .welcome-msg { color: #2980b9; margin-top: 20px; }
        
        /* Success/Error Message Styling */
        .alert {
            max-width: 400px;
            margin: 20px auto;
            padding: 15px;
            border-radius: 5px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeInDown 0.5s ease;
        }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .close-alert { cursor: pointer; font-size: 20px; margin-left: 10px; }

        button { width: 100%; padding: 12px; margin: 8px 0; font-size: 16px; cursor: pointer; border: none; background: #2980b9; color: white; border-radius: 5px; transition: 0.3s; }
        button:hover { background: #1f6391; transform: scale(1.02); }
        .logout-btn { background: #c0392b; margin-top: 20px; }
        .logout-btn:hover { background: #a93226; }
        
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <h2>Staff Reservation Portal</h2>
        <h3 class="welcome-msg">Hello, <%= user %>!</h3>
        <p>Role: <span style="color: #27ae60;">USER</span></p>

        <c:if test="${param.reservation == 'success'}">
            <div class="alert alert-success" id="msg">
                <span>✔ Reservation Saved & Rooms Booked!</span>
                <span class="close-alert" onclick="this.parentElement.style.display='none'">&times;</span>
            </div>
        </c:if>
        
        <c:if test="${param.reservation == 'error'}">
            <div class="alert alert-error" id="msg">
                <span>✖ Database Error. Please try again.</span>
                <span class="close-alert" onclick="this.parentElement.style.display='none'">&times;</span>
            </div>
        </c:if>

        <div class="menu">
        	 <button onclick="location.href='add-guest.jsp'">
                Register a Client
            </button>
        
            <button onclick="location.href='search-guest.jsp'">Make a Reservation</button>
            
            <button onclick="location.href='${pageContext.request.contextPath}/ViewAvailableRooms'">
                Check Room Availability
            </button>
            
            <button style="background: #f39c12;" onclick="location.href='${pageContext.request.contextPath}/ManageOccupancy'">
                Process Check-Out (Reset Rooms)
            </button>
            
            <button onclick="location.href='../reservation/view-bookings.jsp'">View All Reservations</button>
            
            <button class="logout-btn" onclick="location.href='../logout'">Logout</button>
        </div>
    </div>

    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const msg = document.getElementById('msg');
            if(msg) msg.style.opacity = '0';
            setTimeout(() => { if(msg) msg.style.display = 'none'; }, 500);
        }, 5000);
    </script>

</body>
</html>