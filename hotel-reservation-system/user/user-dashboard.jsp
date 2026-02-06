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
    <title>Dashboard - Ocean View Resort</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --soft-gray: #f4f7f6;
            --dark-blue: #2c3e50;
            --success-green: #27ae60;
            --danger-red: #c0392b;
            --warning-gold: #f39c12;
            --help-purple: #8e44ad;
        }

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--soft-gray); 
            margin: 0; 
            color: var(--dark-blue);
        }

        /* Header Area */
        .header {
            background: var(--dark-blue);
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }

        .dashboard-container { 
            max-width: 1000px; 
            margin: 40px auto; 
            padding: 20px;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .welcome-msg { color: var(--ocean-blue); font-size: 1.8em; margin: 0; }
        .role-badge { 
            background: #eafaf1; 
            color: var(--success-green); 
            padding: 5px 15px; 
            border-radius: 20px; 
            font-size: 0.85em; 
            font-weight: bold; 
            border: 1px solid var(--success-green);
        }

        /* Menu Grid */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .menu-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: 0.3s;
            cursor: pointer;
            border: 1px solid transparent;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .menu-card:hover {
            transform: translateY(-5px);
            border-color: var(--ocean-blue);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .menu-card .icon {
            font-size: 2.8em;
            margin-bottom: 15px;
        }

        .menu-card h3 { margin: 10px 0; font-size: 1.2em; color: var(--dark-blue); }
        .menu-card p { color: #7f8c8d; font-size: 0.9em; margin: 0; }

        /* Alert Styling */
        .alert {
            max-width: 600px;
            margin: 0 auto 30px auto;
            padding: 15px 25px;
            border-radius: 8px;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeInDown 0.5s ease;
        }
        .alert-success { background: #d4edda; color: #155724; border-left: 5px solid var(--success-green); }
        .alert-error { background: #f8d7da; color: #721c24; border-left: 5px solid var(--danger-red); }

        .logout-btn {
            background: var(--danger-red);
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }
        .logout-btn:hover { background: #a93226; }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="header">
        <div style="font-weight: bold; font-size: 1.4em; letter-spacing: 1px;">OCEAN VIEW <span style="font-weight: 300;">RESORT</span></div>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">Logout</a>
        
    </div>

    <div class="dashboard-container">
        
        <div class="welcome-section">
            <h2 class="welcome-msg">Welcome, <%= user %>!</h2>
            <span class="role-badge">STAFF ACCESS</span>
        </div>

        <c:if test="${param.reservation == 'success'}">
            <div class="alert alert-success" id="msg">
                <span>✔ Reservation successfully confirmed and rooms assigned.</span>
                <span style="cursor:pointer" onclick="this.parentElement.style.display='none'">&times;</span>
            </div>
        </c:if>
        
        <c:if test="${param.reservation == 'error'}">
            <div class="alert alert-error" id="msg">
                <span>✖ System Error: Could not process booking. Please check database connection.</span>
                <span style="cursor:pointer" onclick="this.parentElement.style.display='none'">&times;</span>
            </div>
        </c:if>

        <div class="menu-grid">
            <div class="menu-card" onclick="location.href='add-guest.jsp'">
                <div class="icon" style="color: var(--ocean-blue);">👤</div>
                <h3>Register Guest</h3>
                <p>Add a new client to the system database.</p>
            </div>

            <div class="menu-card" onclick="location.href='search-guest.jsp'">
                <div class="icon" style="color: var(--success-green);">🔑</div>
                <h3>New Reservation</h3>
                <p>Start the booking process for an existing guest.</p>
            </div>

            <div class="menu-card" onclick="location.href='${pageContext.request.contextPath}/ViewAvailableRooms'">
                <div class="icon" style="color: var(--ocean-blue);">📋</div>
                <h3>Room Status</h3>
                <p>Check live occupancy and available room types.</p>
            </div>

            <div class="menu-card" onclick="location.href='manage-occupancy.jsp'">
                <div class="icon" style="color: var(--warning-gold);">🚪</div>
                <h3>Process Check-Out</h3>
                <p>Release rooms and finalize guest departures.</p>
            </div>

            <div class="menu-card" onclick="location.href='${pageContext.request.contextPath}/ViewBookingsServlet'">
                <div class="icon" style="color: var(--dark-blue);">📅</div>
                <h3>View Bookings</h3>
                <p>Access and filter the full list of reservations.</p>
            </div>

            <div class="menu-card" onclick="location.href='help.jsp'">
                <div class="icon" style="color: var(--help-purple);">💡</div>
                <h3>Help & Guidelines</h3>
                <p>Instructions and FAQs for new staff members.</p>
            </div>
        </div>
    </div>

    <script>
        // Auto-fade alerts
        setTimeout(() => {
            const msg = document.getElementById('msg');
            if(msg) {
                msg.style.transition = 'opacity 0.5s ease';
                msg.style.opacity = '0';
                setTimeout(() => msg.style.display = 'none', 500);
            }
        }, 5000);
    </script>

</body>
</html>