<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Finalize Check-Out - Ocean View</title>
    <style>
        :root { 
            --ocean-blue: #2980b9; 
            --dark-blue: #2c3e50; 
            --success-green: #27ae60; 
            --danger-red: #c0392b; 
            --soft-gray: #bdc3c7;
        }
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7f6; padding: 30px; }
        .container { max-width: 800px; margin: auto; background: white; padding: 35px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .header { border-bottom: 2px solid var(--ocean-blue); padding-bottom: 15px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; }
        .detail-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .detail-item { padding: 15px; background: #f9f9f9; border-radius: 8px; border-left: 4px solid #ddd; }
        .label { font-size: 0.75em; color: #7f8c8d; text-transform: uppercase; font-weight: bold; letter-spacing: 1px; }
        .value { font-size: 1.1em; color: var(--dark-blue); font-weight: 600; display: block; margin-top: 5px; }
        .bill-card { background: #fff9e6; border: 1px solid #f1c40f; padding: 25px; border-radius: 10px; text-align: center; }
        
        .btn-container { margin-top: 25px; display: flex; flex-direction: column; gap: 12px; }
        
        .btn-checkout { 
            width: 100%; 
            background: var(--success-green); 
            color: white; 
            padding: 16px; 
            border: none; 
            border-radius: 8px; 
            font-size: 18px; 
            font-weight: bold; 
            cursor: pointer; 
            transition: 0.3s; 
        }
        .btn-checkout:hover { background: #219150; transform: translateY(-2px); }

        .btn-back {
            display: block;
            text-align: center;
            padding: 12px;
            background: #ecf0f1;
            color: var(--dark-blue);
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95em;
            transition: 0.3s;
            border: 1px solid #dcdde1;
        }
        .btn-back:hover {
            background: #dcdde1;
            color: black;
        }

        .early-badge { background: var(--danger-red); color: white; padding: 3px 10px; border-radius: 4px; font-size: 0.7em; margin-left: 10px; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2 style="margin:0; color: var(--dark-blue);">Review Final Bill</h2>
        <span style="background: var(--dark-blue); color:white; padding: 5px 12px; border-radius: 5px; font-size: 0.9em;">Booking ID: #${resId}</span>
    </div>

    <div class="detail-grid">
        <div class="detail-item"><span class="label">Guest Full Name</span><span class="value">${guestName}</span></div>
        <div class="detail-item"><span class="label">NIC / Passport</span><span class="value">${guestNIC}</span></div>
        <div class="detail-item"><span class="label">Scheduled Stay</span><span class="value">${checkIn} to ${checkOut}</span></div>
        <div class="detail-item">
            <span class="label">Actual Stay Period</span>
            <span class="value">${actualNights} Night(s) 
                <c:if test="${isEarly}"><span class="early-badge">EARLY DEPARTURE</span></c:if>
            </span>
        </div>
        <div class="detail-item" style="grid-column: span 2;">
            <span class="label">Rooms Assigned</span>
            <span class="value">${roomNumbers}</span>
        </div>
    </div>

    <div class="bill-card">
        <p class="label">Amount Payable (Adjusted)</p>
        <h1 style="margin:10px 0; color: var(--dark-blue); font-size: 2.5em;">Rs. ${adjustedBill}</h1>
        <p style="font-size: 0.9em; color: #7f8c8d;">Bill recalculated for ${actualNights} night(s) stay.</p>
    </div>

    <form action="${pageContext.request.contextPath}/ProcessCheckOutServlet" method="post">
        <input type="hidden" name="resId" value="${resId}">
        <input type="hidden" name="roomIds" value="${roomIds}">
        <input type="hidden" name="finalBill" value="${adjustedBill}">
        
        <div class="btn-container">
            <button type="submit" class="btn-checkout">Confirm Payment & Check-Out</button>
            
            <a href="${pageContext.request.contextPath}/user/manage-occupancy.jsp" class="btn-back">
                &larr; Back
            </a>
        </div>
    </form>
</div>

</body>
</html>