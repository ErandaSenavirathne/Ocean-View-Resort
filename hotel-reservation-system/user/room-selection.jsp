<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Rooms</title>
</head>
<body>
    <h2>Step 2: Select One or More Rooms</h2>
    <form action="${pageContext.request.contextPath}/CalculateBillServlet" method="post">
        <input type="hidden" name="checkIn" value="${checkIn}">
        <input type="hidden" name="checkOut" value="${checkOut}">
        
        <table border="1">
            <tr><th>Select</th><th>Room #</th><th>Type</th><th>Rate</th></tr>
            <c:forEach var="room" items="${rooms}">
                <tr>
                    <td><input type="checkbox" name="selectedRoomIds" value="${room.id}"></td>
                    <td>${room.number}</td>
                    <td>${room.type}</td>
                    <td>${room.price}</td>
                </tr>
            </c:forEach>
        </table>
        <br>
        <button type="submit">Calculate Total Bill</button>
    </form>
</body>
</html>