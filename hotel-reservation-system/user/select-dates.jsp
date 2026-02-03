<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Dates - Ocean View</title>
</head>
<body>
    <h2>Step 1: Select Stay Dates</h2>
    <form action="../CheckAvailabilityServlet" method="post">
        <label>Check-in Date:</label>
        <input type="date" name="checkIn" required id="checkIn">
        <br><br>
        <label>Check-out Date:</label>
        <input type="date" name="checkOut" required id="checkOut">
        <br><br>
        <button type="submit">Find Available Rooms</button>
    </form>
</body>
</html>