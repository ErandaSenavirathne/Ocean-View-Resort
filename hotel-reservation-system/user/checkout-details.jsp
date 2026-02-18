<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Finalize Check-Out - Ocean View</title>
    <style>
        :root { --ocean-blue: #2980b9; --dark-blue: #2c3e50; --success-green: #27ae60; --danger-red: #c0392b; }
    
        body { 
   				font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
   				margin: 0;
   				padding: 30px; 
   				background: #f4f7f6; 
   				color: var(--dark-blue);

    		/* 🔥 Background Image */
  				background: 
      				 linear-gradient(rgba(255,255,255,0.25), rgba(255,255,255,0.35)),
      				 url('${pageContext.request.contextPath}/images/resort-bg.jpg');

				background-size: cover;
   				background-position: center;
   				background-attachment: fixed;
   					 
				}
        .container { max-width: 800px; margin: auto; background: white; padding: 35px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .header { border-bottom: 2px solid var(--ocean-blue); padding-bottom: 15px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; }
        .detail-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .detail-item { padding: 15px; background: #f9f9f9; border-radius: 8px; border-left: 4px solid #ddd; }
        .label { font-size: 0.75em; color: #7f8c8d; text-transform: uppercase; font-weight: bold; }
        .value { font-size: 1.1em; color: var(--dark-blue); font-weight: 600; display: block; margin-top: 5px; }
        .bill-card { background: #fff9e6; border: 1px solid #f1c40f; padding: 25px; border-radius: 10px; }
        .bill-row { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .btn-checkout { width: 100%; background: var(--success-green); color: white; padding: 16px; border: none; border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; }
        .btn-back { display: block; text-align: center; padding: 12px; color: var(--dark-blue); text-decoration: none; margin-top: 10px; }
        .early-badge { background: var(--danger-red); color: white; padding: 3px 10px; border-radius: 4px; font-size: 0.7em; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2 style="margin:0; color: var(--dark-blue);">Review Final Bill</h2>
        <span style="background: var(--dark-blue); color:white; padding: 5px 12px; border-radius: 5px;">ID: #${resId}</span>
    </div>

    <div class="detail-grid">
        <div class="detail-item"><span class="label">Guest Name</span><span class="value">${guestName}</span></div>
        <div class="detail-item"><span class="label">NIC</span><span class="value">${guestNIC}</span></div>
        <div class="detail-item"><span class="label">Scheduled Stay</span><span class="value">${checkIn} to ${checkOut}</span></div>
        <div class="detail-item"><span class="label">Nights Stayed</span><span class="value">${actualNights} <c:if test="${isEarly}"><span class="early-badge">EARLY</span></c:if></span></div>
        <div class="detail-item"><span class="label">Rooms</span><span class="value">${roomNumbers}</span></div>
    </div>

    <div class="bill-card">
        <div class="bill-row">
            <span class="label">Room Charges</span>
            <span class="value" style="margin:0;">Rs. ${roomTotal}</span>
        </div>
        <div class="bill-row" style="border-bottom: 1px dashed #f1c40f; padding-bottom: 10px;">
            <span class="label">Food & Service Orders</span>
            <span class="value" style="margin:0;">Rs. ${foodTotal}</span>
        </div>
        <div class="bill-row" style="margin-top: 15px;">
            <span class="label" style="font-size: 1em; color: black;">Total Payable</span>
            <span class="value" style="font-size: 2em; color: var(--dark-blue); margin:0;">Rs. ${adjustedBill}</span>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/ProcessCheckOutServlet" method="post">
        <input type="hidden" name="resId" value="${resId}">
        <input type="hidden" name="roomIds" value="${roomIds}">
        <input type="hidden" name="finalBill" value="${adjustedBill}">
        <button type="submit" class="btn-checkout" style="margin-top: 20px;">Confirm & Print Receipt</button>
        <a href="${pageContext.request.contextPath}/user/manage-occupancy.jsp" class="btn-back">Back</a>
    </form>
</div>

</body>
</html>