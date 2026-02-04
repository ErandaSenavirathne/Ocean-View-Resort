<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Room Availability - Ocean View</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f6; padding: 30px; }
        .container { max-width: 950px; margin: auto; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        h2 { color: #2c3e50; text-align: center; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        
        /* Filter Form Styling */
        .filter-box { background: #ebf5fb; padding: 20px; border-radius: 8px; margin-bottom: 20px; display: flex; justify-content: center; align-items: center; gap: 20px; }
        .filter-box input { padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .filter-box button { background: #3498db; color: white; border: none; padding: 8px 20px; border-radius: 4px; cursor: pointer; }
        
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background-color: #3498db; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background-color: #f9f9f9; }
        .price-tag { font-weight: bold; color: #27ae60; }
        .type-badge { padding: 5px 10px; border-radius: 20px; font-size: 0.85em; background: #fff; border: 1px solid #2980b9; color: #2980b9; }
        .back-btn { display: inline-block; margin-bottom: 20px; text-decoration: none; color: #3498db; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <a href="user/user-dashboard.jsp" class="back-btn">← Back to Dashboard</a>
    <h2>Check Room Availability</h2>
    
    <div class="filter-box">
        <form action="${pageContext.request.contextPath}/ViewAvailableRooms" method="get" style="display:flex; gap:15px; align-items:center;">
            <label>Check-in:</label>
            <input type="date" name="filterIn" value="${param.filterIn}" required>
            <label>Check-out:</label>
            <input type="date" name="filterOut" value="${param.filterOut}" required>
            <button type="submit">Filter Results</button>
            <a href="${pageContext.request.contextPath}/ViewAvailableRooms" style="font-size: 0.8em; color: #7f8c8d;">Clear</a>
        </form>
    </div>

    <c:if test="${not empty param.filterIn}">
        <p style="text-align: center; color: #34495e;">Showing available rooms from <strong>${param.filterIn}</strong> to <strong>${param.filterOut}</strong></p>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Price Per Night</th>
                <th>Current Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${allRooms}">
                <tr>
                    <td><strong>${room.number}</strong></td>
                    <td><span class="type-badge">${room.type}</span></td>
                    <td class="price-tag">Rs. ${room.price}</td>
                    <td>
                        <span style="color: ${room.status == 'AVAILABLE' ? '#27ae60' : '#e67e22'}">
                            ${room.status}
                        </span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty allRooms}">
        <p style="text-align:center; color: #7f8c8d; margin-top: 20px;">No rooms found for these criteria.</p>
    </c:if>
</div>

</body>
</html>