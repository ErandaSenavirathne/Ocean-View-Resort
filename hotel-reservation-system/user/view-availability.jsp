<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Room Inventory - Ocean View</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f6; padding: 30px; }
        .container { max-width: 900px; margin: auto; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        h2 { color: #2c3e50; text-align: center; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background-color: #3498db; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background-color: #f9f9f9; }
        .price-tag { font-weight: bold; color: #27ae60; }
        .type-badge { padding: 5px 10px; border-radius: 20px; font-size: 0.85em; background: #ebf5fb; color: #2980b9; }
        .back-btn { display: inline-block; margin-bottom: 20px; text-decoration: none; color: #3498db; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <a href="user-dashboard.jsp" class="back-btn">← Back to Dashboard</a>
    <h2>Ocean View Room Inventory</h2>
    
    <table>
        <thead>
            <tr>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Price Per Night</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${allRooms}">
                <tr>
                    <td><strong>${room.number}</strong></td>
                    <td><span class="type-badge">${room.type}</span></td>
                    <td class="price-tag">Rs. ${room.price}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty allRooms}">
        <p style="text-align:center; color: #7f8c8d; margin-top: 20px;">No rooms found in the system.</p>
    </c:if>
</div>

</body>
</html>