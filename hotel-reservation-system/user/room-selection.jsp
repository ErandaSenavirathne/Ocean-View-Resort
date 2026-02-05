<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Security & Data Check
    String guestName = (String) session.getAttribute("guestName");
    // Retrieve NIC from session for professional display
    String guestNIC = (String) session.getAttribute("guestNIC");
    
    if (guestName == null || guestNIC == null) {
        response.sendRedirect("search-guest.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Rooms - Ocean View</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --soft-gray: #f4f7f6;
            --dark-blue: #2c3e50;
            --danger-red: #c0392b;
            --success-green: #27ae60;
        }

        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--soft-gray); margin: 0; padding: 20px; }
        .container { max-width: 850px; margin: 20px auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        
        /* Progress Bar */
        .progress-container { display: flex; justify-content: space-between; margin-bottom: 30px; }
        .step { font-size: 0.85em; color: #bdc3c7; font-weight: bold; flex: 1; text-align: center; border-bottom: 3px solid #eee; padding-bottom: 10px; }
        .active-step { color: var(--ocean-blue); border-bottom: 3px solid var(--ocean-blue); }

        /* Guest & Date Header */
        .info-header { background: #ebf5fb; padding: 20px; border-radius: 10px; border-left: 5px solid var(--ocean-blue); margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; }
        .info-header h4 { margin: 0; color: var(--dark-blue); font-size: 1.2em; }
        .stay-details { text-align: right; color: var(--ocean-blue); font-weight: bold; }
        .nic-badge { color: #555; font-size: 0.85em; font-weight: 500; }

        /* Table Styling */
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: var(--ocean-blue); color: white; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #eee; transition: 0.2s; }
        tr:hover td { background-color: #fcfcfc; }
        
        .price-tag { font-weight: bold; color: var(--success-green); font-size: 1.1em; }
        .type-badge { padding: 5px 10px; border-radius: 20px; font-size: 0.8em; background: white; border: 1px solid var(--ocean-blue); color: var(--ocean-blue); text-transform: uppercase; }

        /* Form Buttons */
        .btn-group { display: flex; gap: 12px; margin-top: 30px; }
        .btn { padding: 15px 25px; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; border: none; transition: 0.3s; text-decoration: none; text-align: center; }
        .btn-next { flex: 2; background: var(--ocean-blue); color: white; }
        .btn-back { flex: 1; background: #95a5a6; color: white; }
        .btn-cancel { flex: 1; background: var(--danger-red); color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-2px); }

        /* Modal Styling */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 1000; justify-content: center; align-items: center; }
        .modal-box { background: white; padding: 30px; border-radius: 15px; width: 400px; text-align: center; box-shadow: 0 10px 40px rgba(0,0,0,0.2); animation: popIn 0.3s ease; }
        @keyframes popIn { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .modal-icon { font-size: 40px; margin-bottom: 15px; color: var(--ocean-blue); }
        .modal-buttons { display: flex; gap: 10px; margin-top: 25px; }
        .m-btn { flex: 1; padding: 12px; border-radius: 6px; border: none; cursor: pointer; font-weight: bold; }
        .m-confirm { background: var(--ocean-blue); color: white; }
        .m-cancel { background: #eee; color: #666; }

        input[type="checkbox"] { width: 20px; height: 20px; cursor: pointer; }
    </style>
</head>
<body>

<div class="container">
    <div class="progress-container">
        <div class="step">1. SELECT DATES</div>
        <div class="step active-step">2. PICK ROOMS</div>
        <div class="step">3. CONFIRMATION</div>
    </div>

    <div class="info-header">
        <div>
            <h4>Booking for: <%= guestName %></h4>
            <span class="nic-badge">NIC / Passport: <strong><%= guestNIC %></strong></span>
        </div>
        <div class="stay-details">
            Stay: ${checkIn} — ${checkOut}
        </div>
    </div>

    <h2 style="color: var(--dark-blue); margin-bottom: 5px;">Available Inventory</h2>
    <p style="color: #7f8c8d; margin-bottom: 25px;">Select the rooms the guest wishes to reserve.</p>

    <form action="${pageContext.request.contextPath}/CalculateBillServlet" method="post" id="selectionForm">
        <input type="hidden" name="checkIn" value="${checkIn}">
        <input type="hidden" name="checkOut" value="${checkOut}">
        
        <table>
            <thead>
                <tr>
                    <th width="80">Select</th>
                    <th>Room No.</th>
                    <th>Type</th>
                    <th>Price / Night</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${rooms}">
                    <tr>
                        <td align="center">
                            <input type="checkbox" name="selectedRoomIds" value="${room.id}">
                        </td>
                        <td><strong>${room.number}</strong></td>
                        <td><span class="type-badge">${room.type}</span></td>
                        <td class="price-tag">Rs. ${room.price}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty rooms}">
            <div style="padding: 40px; text-align: center; color: #e67e22; font-weight: bold;">
                No rooms are available for these dates. Please try different dates.
            </div>
        </c:if>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/user/select-dates.jsp" class="btn btn-back">Back</a>
            <a href="javascript:void(0)" class="btn btn-cancel" onclick="handleCancel()">Cancel</a>
            <button type="submit" class="btn btn-next" onclick="return handleValidation(event)">Calculate Bill →</button>
        </div>
    </form>
</div>

<div id="modalOverlay" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-icon" id="modalIcon">ⓘ</div>
        <h3 id="modalTitle" style="margin:0; color: var(--dark-blue);">Notice</h3>
        <p id="modalMsg" style="color: #666; margin-top:10px;"></p>
        <div class="modal-buttons">
            <button class="m-btn m-cancel" id="mCancelBtn" onclick="closeModal()">Go Back</button>
            <button class="m-btn m-confirm" id="mConfirmBtn">Confirm</button>
        </div>
    </div>
</div>

<script>
    const overlay = document.getElementById('modalOverlay');
    const mTitle = document.getElementById('modalTitle');
    const mMsg = document.getElementById('modalMsg');
    const mConfirm = document.getElementById('mConfirmBtn');
    const mCancel = document.getElementById('mCancelBtn');

    function openModal(title, message, showCancel, onConfirm) {
        mTitle.innerText = title;
        mMsg.innerText = message;
        mCancel.style.display = showCancel ? "block" : "none";
        
        mConfirm.onclick = () => {
            closeModal();
            if(onConfirm) onConfirm();
        };
        
        overlay.style.display = 'flex';
    }

    function closeModal() {
        overlay.style.display = 'none';
    }

    function handleValidation(event) {
        const checked = document.querySelectorAll('input[name="selectedRoomIds"]:checked');
        if (checked.length === 0) {
            event.preventDefault();
            openModal("Selection Required", "Please select at least one room to proceed to billing.", false);
            return false;
        }
        return true;
    }

    function handleCancel() {
        openModal(
            "Cancel Booking?", 
            "Are you sure? You will lose all dates and room selections for this guest.", 
            true, 
            () => {
                window.location.href = "${pageContext.request.contextPath}/user/user-dashboard.jsp";
            }
        );
    }
</script>

</body>
</html>