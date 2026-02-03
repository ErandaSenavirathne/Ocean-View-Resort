<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security check: Ensure guest and bill data are present
    String guestName = (String) session.getAttribute("guestName");
    if (guestName == null || request.getAttribute("finalBill") == null) {
        response.sendRedirect("search-guest.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Summary - Ocean View</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; padding: 40px; }
        .summary-card { max-width: 600px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { border-bottom: 2px solid #3498db; padding-bottom: 10px; color: #2c3e50; }
        .detail-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #eee; }
        .total-row { display: flex; justify-content: space-between; padding: 20px 0; font-weight: bold; font-size: 1.2em; color: #27ae60; }
        .btn-confirm { background-color: #27ae60; color: white; border: none; padding: 15px 30px; border-radius: 5px; cursor: pointer; width: 100%; font-size: 1.1em; }
        .btn-confirm:hover { background-color: #219150; }
        .btn-cancel { background: none; border: none; color: #e74c3c; cursor: pointer; display: block; margin: 15px auto; text-decoration: underline; }
    </style>
</head>
<body>

<div class="summary-card">
    <h2>Booking Confirmation</h2>
    
    <div class="detail-row">
        <span>Guest Name:</span>
        <span><%= guestName %></span>
    </div>
    <div class="detail-row">
        <span>Check-in:</span>
        <span>${checkIn}</span>
    </div>
    <div class="detail-row">
        <span>Check-out:</span>
        <span>${checkOut}</span>
    </div>
    <div class="detail-row">
        <span>Room IDs:</span>
        <span>${selectedRoomIds}</span>
    </div>
    
    <hr>
    
    <div class="detail-row">
        <span>Base Total:</span>
        <span>Rs. ${finalBill + discount}</span>
    </div>
    <div class="detail-row" style="color: #e67e22;">
        <span>Discount Applied:</span>
        <span>- Rs. ${discount}</span>
    </div>
    
    <div class="total-row">
        <span>Final Bill (Payable at Checkout):</span>
        <span>Rs. ${finalBill}</span>
    </div>

    <form action="${pageContext.request.contextPath}/SaveBookingServlet" method="post">
        <input type="hidden" name="checkIn" value="${checkIn}">
        <input type="hidden" name="checkOut" value="${checkOut}">
        <input type="hidden" name="finalBill" value="${finalBill}">
        <input type="hidden" name="selectedRoomIds" value="${selectedRoomIds}">
        
        <button type="submit" class="btn-confirm">Confirm Reservation</button>
    </form>
    
    <button class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/user/search-guest.jsp'">Cancel and Restart</button>
</div>

</body>
</html>