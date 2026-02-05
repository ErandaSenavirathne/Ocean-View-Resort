<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Fetch guest details from session
    String guestName = (String) session.getAttribute("guestName");
    // We now retrieve the NIC instead of the internal database ID for display
    String guestNIC = (String) session.getAttribute("guestNIC");
    
    // Redirect if no guest is selected
    if (guestName == null || guestNIC == null) {
        response.sendRedirect("search-guest.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Dates - Ocean View</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --soft-gray: #f4f7f6;
            --dark-blue: #2c3e50;
            --danger-red: #c0392b;
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--soft-gray); margin: 0; padding: 20px; }
        .container { max-width: 600px; margin: 40px auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        
        /* Guest Details Header */
        .guest-info { background: #ebf5fb; padding: 15px; border-radius: 10px; border-left: 5px solid var(--ocean-blue); margin-bottom: 25px; }
        .guest-info h4 { margin: 0; color: var(--dark-blue); font-size: 1.1em; }
        .guest-info p { margin: 5px 0 0; font-size: 0.95em; color: #555; font-weight: 500; }
        .nic-label { color: var(--ocean-blue); font-weight: bold; }

        /* Progress Bar */
        .progress-container { display: flex; justify-content: space-between; margin-bottom: 30px; }
        .step { font-size: 0.8em; color: #bdc3c7; font-weight: bold; flex: 1; text-align: center; border-bottom: 2px solid #eee; padding-bottom: 5px; }
        .active-step { color: var(--ocean-blue); border-bottom: 2px solid var(--ocean-blue); }

        h2 { color: var(--dark-blue); text-align: center; margin-bottom: 30px; }
        
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        input[type="date"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-size: 16px; }
        
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        button { flex: 2; background: var(--ocean-blue); color: white; border: none; padding: 15px; border-radius: 6px; font-size: 16px; cursor: pointer; transition: 0.3s; }
        button:hover { background: #1f6391; }
        
        .back-btn { flex: 1; background: #95a5a6; text-decoration: none; color: white; text-align: center; padding: 15px; border-radius: 6px; font-size: 16px; display: flex; align-items: center; justify-content: center; }
        .cancel-btn { flex: 1; background: var(--danger-red); color: white; border-radius: 6px; font-size: 16px; cursor: pointer; text-align: center; display: flex; align-items: center; justify-content: center; text-decoration: none; border: none; }
        .back-btn:hover, .cancel-btn:hover { opacity: 0.9; }

        /* Modal Styling */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 1000; justify-content: center; align-items: center; }
        .modal-box { background: white; padding: 30px; border-radius: 15px; width: 400px; text-align: center; box-shadow: 0 10px 40px rgba(0,0,0,0.2); animation: popIn 0.3s ease; }
        @keyframes popIn { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .modal-buttons { display: flex; gap: 10px; margin-top: 25px; }
        .m-btn { flex: 1; padding: 12px; border-radius: 6px; border: none; cursor: pointer; font-weight: bold; }
        .m-confirm { background: var(--ocean-blue); color: white; }
        .m-cancel { background: #eee; color: #666; }
    </style>
</head>
<body>

<div class="container">
    <div class="progress-container">
        <span class="step active-step">1. SELECT DATES</span>
        <span class="step">2. PICK ROOMS</span>
        <span class="step">3. CONFIRM</span>
    </div>

    <div class="guest-info">
        <h4>Guest: <%= guestName %></h4>
        <p>NIC / Passport: <span class="nic-label"><%= guestNIC %></span></p>
    </div>

    <h2>Stay Duration</h2>

    <form action="${pageContext.request.contextPath}/CheckAvailabilityServlet" method="post">
        <div class="form-group">
            <label>Check-in Date</label>
            <input type="date" name="checkIn" id="checkIn" required>
        </div>

        <div class="form-group">
            <label>Check-out Date</label>
            <input type="date" name="checkOut" id="checkOut" required>
        </div>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/user/search-guest.jsp" class="back-btn">Back</a>
            <button type="button" class="cancel-btn" onclick="handleCancel()">Cancel</button>
            <button type="submit">Check Availability →</button>
        </div>
    </form>
</div>

<div id="modalOverlay" class="modal-overlay">
    <div class="modal-box">
        <div style="font-size: 40px; color: var(--ocean-blue); margin-bottom: 10px;">ⓘ</div>
        <h3 style="margin:0; color: var(--dark-blue);">Cancel Booking?</h3>
        <p style="color: #666; margin-top:10px;">Are you sure you want to stop? All selection progress for this guest will be lost.</p>
        <div class="modal-buttons">
            <button class="m-btn m-cancel" onclick="closeModal()">Go Back</button>
            <button class="m-btn m-confirm" id="confirmRedirect">Yes, Cancel</button>
        </div>
    </div>
</div>

<script>
    const overlay = document.getElementById('modalOverlay');
    
    function handleCancel() {
        overlay.style.display = 'flex';
        document.getElementById('confirmRedirect').onclick = function() {
            window.location.href = "${pageContext.request.contextPath}/user/user-dashboard.jsp";
        };
    }

    function closeModal() {
        overlay.style.display = 'none';
    }

    const today = new Date().toISOString().split('T')[0];
    const checkInInput = document.getElementById('checkIn');
    const checkOutInput = document.getElementById('checkOut');

    checkInInput.setAttribute('min', today);
    checkInInput.addEventListener('change', function() {
        checkOutInput.setAttribute('min', this.value);
    });
</script>

</body>
</html>