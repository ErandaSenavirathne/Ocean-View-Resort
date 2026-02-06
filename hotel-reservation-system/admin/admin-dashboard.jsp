<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security and Cache Control
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    String user = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (user == null || !"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Console | Ocean View Resort</title>
    <style>
        :root {
            --admin-dark: #1a1c23;
            --admin-sidebar: #24262d;
            --ocean-primary: #3f83f8;
            --text-gray: #9e9e9e;
            --white: #ffffff;
            --bg-light: #f4f5f7;
        }

        body { font-family: 'Inter', sans-serif; background: var(--bg-light); margin: 0; display: flex; }
        
        .sidebar {
            width: 260px;
            height: 100vh;
            background: var(--admin-sidebar);
            color: var(--white);
            position: fixed;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding: 25px;
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--ocean-primary);
            border-bottom: 1px solid #373a46;
        }

        .nav-links { list-style: none; padding: 20px 0; margin: 0; flex-grow: 1; }
        .nav-links li { padding: 12px 25px; cursor: pointer; transition: 0.3s; color: var(--text-gray); }
        .nav-links li:hover { background: #373a46; color: var(--white); }
        .nav-links li.active { background: #373a46; border-left: 4px solid var(--ocean-primary); color: var(--white); }

        .main-content { margin-left: 260px; width: calc(100% - 260px); padding: 30px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .user-info { display: flex; align-items: center; gap: 15px; }

        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .stat-card { background: var(--white); padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .stat-card h4 { margin: 0; color: var(--text-gray); font-size: 0.85rem; text-transform: uppercase; }
        .stat-card .value { font-size: 1.8rem; font-weight: bold; margin: 10px 0; color: var(--admin-dark); }

        .action-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
        .action-card { 
            background: var(--white); 
            padding: 25px; 
            border-radius: 12px; 
            border: 1px solid #e5e7eb;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .action-card:hover { transform: translateY(-5px); border-color: var(--ocean-primary); }
        
        .logout-btn { 
            background: #f05252; color: white; border: none; padding: 10px 20px; 
            border-radius: 6px; cursor: pointer; text-decoration: none; font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">OCEAN VIEW ADMIN</div>
        <ul class="nav-links">
            <li class="active" onclick="location.href='${pageContext.request.contextPath}/AdminDashboardServlet'">Dashboard Overview</li>
            <li onclick="location.href='${pageContext.request.contextPath}/AdminManageUsersServlet'">Staff Management</li>
            <li onclick="location.href='${pageContext.request.contextPath}/AdminManageRoomsServlet'">Room Inventory</li>
            <li onclick="location.href='${pageContext.request.contextPath}/AdminReportsServlet'">Financial Reports</li>
            <li onclick="location.href='${pageContext.request.contextPath}/admin/settings.jsp'">General Settings</li>
        </ul>
        <div style="padding: 20px;">
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn" style="display: block; text-align: center;">Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h2 style="margin: 0;">Dashboard Overview</h2>
            <div class="user-info">
                <span>Welcome, <strong><%= user %></strong></span>
                <span style="background: #e1effe; color: #1e429f; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: bold;">ADMIN</span>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h4>Total Revenue</h4>
                <div class="value">Rs. ${rev != null ? rev : '0.00'}</div>
                <span style="color: #057a55; font-size: 0.8rem;">Lifetime Earnings</span>
            </div>
            
            <div class="stat-card">
                <h4>Current Occupancy</h4>
                <div class="value">${occ != null ? occ : '0'} Rooms</div>
                <span style="color: #c27803; font-size: 0.8rem;">Active Bookings</span>
            </div>
            
            <div class="stat-card">
                <h4>Database Size</h4>
                <div class="value">${gst != null ? gst : '0'} Guests</div>
                <span style="color: #3f83f8; font-size: 0.8rem;">Total Registered</span>
            </div>
        </div>

        <h3 style="margin-bottom: 20px; color: var(--admin-dark);">Administrative Actions</h3>
        
        <div class="action-grid">
            <div class="action-card" onclick="location.href='${pageContext.request.contextPath}/AdminManageUsersServlet'">
                <span style="font-size: 2em;">👥</span>
                <h3>Manage Staff Users</h3>
                <p>Add new receptionists, reset passwords, and update permissions.</p>
            </div>

            <div class="action-card" onclick="location.href='${pageContext.request.contextPath}/AdminManageRoomsServlet'">
    <span style="font-size: 2em;">🏨</span>
    <h3>Room Inventory</h3>
    <p>Update room rates, add new suites, or mark rooms for maintenance.</p>
</div>

            <div class="action-card" onclick="location.href='${pageContext.request.contextPath}/AdminReportsServlet'">
                <span style="font-size: 2em;">📊</span>
                <h3>Business Insights</h3>
                <p>View daily, weekly, and monthly revenue analytics and guest trends.</p>
            </div>
        </div>
    </div>

</body>
</html>