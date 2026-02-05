<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String guestName = (String) session.getAttribute("guestName");
    String guestNIC = (String) session.getAttribute("guestNIC");
    if (guestName == null || guestNIC == null) {
        response.sendRedirect("search-guest.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Summary - Ocean View</title>
    <style>
        :root {
            --ocean-blue: #2980b9; --soft-gray: #f4f7f6; --dark-blue: #2c3e50;
            --danger-red: #c0392b; --success-green: #27ae60; --gold: #f1c40f;
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--soft-gray); padding: 20px; }
        .container { max-width: 700px; margin: 20px auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        
        .progress-container { display: flex; justify-content: space-between; margin-bottom: 30px; }
        .step { font-size: 0.85em; color: #bdc3c7; font-weight: bold; flex: 1; text-align: center; border-bottom: 3px solid #eee; padding-bottom: 10px; }
        .active-step { color: var(--ocean-blue); border-bottom: 3px solid var(--ocean-blue); }

        .summary-card { border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden; margin-bottom: 25px; }
        .summary-header { background: var(--dark-blue); color: white; padding: 15px; font-weight: bold; display: flex; justify-content: space-between; }
        .summary-body { padding: 20px; }
        
        .summary-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px dashed #eee; }
        .label { color: #7f8c8d; font-weight: 500; }
        .value { color: var(--dark-blue); font-weight: 600; }

        .bill-section { background: #fff9e6; padding: 20px; border-radius: 10px; border: 1px solid var(--gold); }
        .total-row { display: flex; justify-content: space-between; font-size: 1.3em; margin-top: 10px; padding-top: 10px; border-top: 2px solid var(--gold); }
        .final-price { color: var(--success-green); font-weight: 800; }

        .btn-group { display: flex; gap: 12px; margin-top: 30px; }
        .btn { padding: 15px 25px; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; border: none; transition: 0.3s; text-decoration: none; text-align: center; flex: 1; }
        .btn-confirm { flex: 2; background: var(--success-green); color: white; }
        .btn-back { background: #95a5a6; color: white; }
        .btn-cancel { background: var(--danger-red); color: white; }

        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 1000; justify-content: center; align-items: center; }
        .modal-box { background: white; padding: 30px; border-radius: 15px; width: 400px; text-align: center; }
        .modal-buttons { display: flex; gap: 10px; margin-top: 25px; }
    </style>
</head>
<body>

<div class="container">
    <div class="progress-container">
        <div class="step">1. DATES</div><div class="step">2. ROOMS</div><div class="step active-step">3. CONFIRM</div>
    </div>

    <h2 style="text-align: center; color: var(--dark-blue);">Final Review</h2>

    <div class="summary-card">
        <div class="summary-header">
            <span>Guest Information</span>
            <span>NIC: <%= guestNIC %></span>
        </div>
        <div class="summary-body">
            <div class="summary-row"><span class="label">Guest Name</span><span class="value"><%= guestName %></span></div>
            <div class="summary-row"><span class="label">Check-in</span><span class="value">${checkIn}</span></div>
            <div class="summary-row"><span class="label">Check-out</span><span class="value">${checkOut}</span></div>
            <div class="summary-row"><span class="label">Total Stay</span><span class="value">${nights} Night(s)</span></div>
        </div>
    </div>

    <div class="bill-section">
        <div class="summary-row"><span class="label">Base Total</span><span class="value">Rs. ${baseTotal}</span></div>
        <div class="summary-row"><span class="label">Discount</span><span class="value" style="color: var(--danger-red);">- Rs. ${discount}</span></div>
        <div class="total-row"><span>Final Payable</span><span class="final-price">Rs. ${finalBill}</span></div>
    </div>

    <form action="${pageContext.request.contextPath}/SaveBookingServlet" method="post">
        <input type="hidden" name="checkIn" value="${checkIn}">
        <input type="hidden" name="checkOut" value="${checkOut}">
        <input type="hidden" name="finalBill" value="${finalBill}">
        <input type="hidden" name="selectedRoomIds" value="${selectedRoomIds}">

        <div class="btn-group">
            <a href="javascript:history.back()" class="btn btn-back">Back</a>
            <button type="button" class="btn btn-cancel" onclick="handleCancel()">Cancel</button>
            <button type="submit" class="btn btn-confirm">Confirm & Save Booking ✓</button>
        </div>
    </form>
</div>

<div id="modalOverlay" class="modal-overlay">
    <div class="modal-box">
        <div style="font-size: 40px; color: var(--ocean-blue); margin-bottom: 10px;">ⓘ</div>
        <h3>Discard Reservation?</h3>
        <p>This will cancel the current booking process and return to the dashboard.</p>
        <div class="modal-buttons">
            <button class="btn" style="background:#eee; color:#666" onclick="closeModal()">Go Back</button>
            <button class="btn" style="background:var(--ocean-blue); color:white" onclick="confirmDiscard()">Yes, Discard</button>
        </div>
    </div>
</div>

<script>
    function handleCancel() { document.getElementById('modalOverlay').style.display = 'flex'; }
    function closeModal() { document.getElementById('modalOverlay').style.display = 'none'; }
    function confirmDiscard() { window.location.href = "${pageContext.request.contextPath}/user/user-dashboard.jsp"; }
</script>

</body>
</html>