<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Management - Ocean View</title>
    <style>
        :root { 
            --primary: #2980b9; 
            --dark: #2c3e50; 
            --success: #27ae60; 
            --danger: #c0392b; 
            --light-bg: #f4f7f6;
        }
        
        body { font-family: 'Segoe UI', sans-serif; background: var(--light-bg); margin: 0; padding: 20px; }
        .container { max-width: 1200px; margin: auto; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        /* Header Section */
        .filter-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 15px; }
        
        /* Filter Form Layout */
        .filter-form { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 15px; background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 25px; align-items: flex-end; border: 1px solid #eee; }
        
        .filter-group { display: flex; flex-direction: column; gap: 5px; }
        label { font-size: 0.75em; font-weight: bold; color: #7f8c8d; text-transform: uppercase; }
        input, select { padding: 10px; border: 1px solid #ddd; border-radius: 6px; font-size: 0.9em; }
        
        /* Buttons */
        .btn { padding: 10px 15px; border-radius: 6px; cursor: pointer; font-weight: 600; border: none; transition: 0.2s; text-align: center; }
        .btn-filter { background: var(--primary); color: white; }
        .btn-filter:hover { background: #1f6391; }
        
        .btn-reset { background: #ecf0f1; color: #7f8c8d; border: 1px solid #ccc; }
        .btn-reset:hover { background: #bdc3c7; color: white; }
        
        .btn-dash { background: white; border: 1px solid var(--primary); color: var(--primary); }
        .btn-dash:hover { background: var(--primary); color: white; }

        /* Statistics Cards */
        .stats-container { display: flex; gap: 20px; margin-bottom: 25px; }
        .stat-card { background: white; border: 1px solid #eee; padding: 15px 20px; border-radius: 8px; flex: 1; border-top: 4px solid var(--primary); }
        .stat-val { font-size: 1.4em; font-weight: bold; color: var(--dark); }
        .stat-label { font-size: 0.75em; color: #7f8c8d; }

        /* Table Styling */
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 12px; border-bottom: 2px solid #eee; color: var(--dark); font-size: 0.9em; }
        td { padding: 15px 12px; border-bottom: 1px solid #f1f1f1; font-size: 0.95em; }
        
        .badge { padding: 5px 12px; border-radius: 4px; font-size: 0.75em; font-weight: bold; display: inline-block; }
        .status-BOOKED { background: #e3f2fd; color: #1976d2; }
        .status-COMPLETED { background: #e8f5e9; color: #2e7d32; }
        .status-CANCELLED { background: #ffebee; color: #c62828; }

        .room-tag { background: #f4f4f4; padding: 2px 6px; border-radius: 4px; font-family: monospace; font-size: 0.9em; }
    </style>
</head>
<body>

<div class="container">
    <div class="filter-header">
        <h2 style="margin:0; color: var(--dark);">Reservations Registry</h2>
        <button type="button" class="btn btn-dash" 
                onclick="location.href='${pageContext.request.contextPath}/user/user-dashboard.jsp'">
            ← Dashboard
        </button>
    </div>

    <form action="${pageContext.request.contextPath}/ViewBookingsServlet" method="get" class="filter-form">
        <div class="filter-group">
            <label>Search NIC / Passport</label>
            <input type="text" name="nicSearch" placeholder="Enter NIC..." value="${param.nicSearch}">
        </div>
        
        <div class="filter-group">
            <label>From (Check-In)</label>
            <input type="date" name="startDate" value="${param.startDate}">
        </div>
        
        <div class="filter-group">
            <label>To (Check-In)</label>
            <input type="date" name="endDate" value="${param.endDate}">
        </div>
        
        <div class="filter-group">
            <label>Status</label>
            <select name="status">
                <option value="ALL">All Bookings</option>
                <option value="BOOKED" ${param.status == 'BOOKED' ? 'selected' : ''}>Active</option>
                <option value="CHECKED_OUT" ${param.status == 'COMPLETED' ? 'selected' : ''}>Paid</option>
            </select>
        </div>
        
        <div style="display: flex; flex-direction: column; gap: 8px;">
            <button type="submit" class="btn btn-filter">Search & Filter</button>
            <button type="button" class="btn btn-reset" 
                    onclick="location.href='${pageContext.request.contextPath}/ViewBookingsServlet'">
                Reset Filters
            </button>
        </div>
    </form>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-label">TOTAL BOOKINGS FOUND</div>
            <div class="stat-val">${bookings.size()}</div>
        </div>
        <div class="stat-card" style="border-top-color: var(--success);">
            <div class="stat-label">REVENUE (FOR SELECTION)</div>
            <div class="stat-val">Rs. ${totalRevenue}</div>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Guest Information</th>
                <th>Stay Dates</th>
                <th>Rooms</th>
                <th>Total Bill</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="b" items="${bookings}">
                <tr>
                    <td><strong>#${b.resId}</strong></td>
                    <td>
                        <div style="font-weight: 600;">${b.name}</div>
                        <div style="font-size: 0.8em; color: #7f8c8d;">NIC: ${b.nic}</div>
                    </td>
                    <td>
                        <span style="color: var(--success); font-size: 0.85em;">IN: ${b.checkIn}</span><br>
                        <span style="color: var(--danger); font-size: 0.85em;">OUT: ${b.checkOut}</span>
                    </td>
                    <td><span class="room-tag">${b.rooms}</span></td>
                    <td style="font-weight: bold;">Rs. ${b.bill}</td>
                    <td><span class="badge status-${b.status}">${b.status}</span></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty bookings}">
        <div style="padding: 60px; text-align: center; color: #95a5a6;">
            <p>No records found for the selected filters.</p>
        </div>
    </c:if>
</div>

</body>
</html>