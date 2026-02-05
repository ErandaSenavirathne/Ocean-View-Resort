<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Guest - Ocean View</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --soft-gray: #f4f7f6;
            --dark-blue: #2c3e50;
            --danger-red: #c0392b;
            --success-green: #27ae60;
        }

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--soft-gray); 
            margin: 0; 
            padding: 20px; 
        }

        .container {
            max-width: 450px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        h2 { 
            text-align: center; 
            color: var(--dark-blue);
            margin-bottom: 25px;
            border-bottom: 2px solid var(--ocean-blue);
            padding-bottom: 10px;
        }

        .form-group { margin-bottom: 15px; }
        
        label { 
            display: block; 
            margin-bottom: 5px; 
            font-weight: 600; 
            color: #555; 
            font-size: 0.9em;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 5px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 15px;
        }

        input:focus {
            border-color: var(--ocean-blue);
            outline: none;
            box-shadow: 0 0 5px rgba(41, 128, 185, 0.2);
        }

        /* Buttons matching your wizard style */
        .btn-group { display: flex; gap: 10px; margin-top: 25px; }
        
        .btn {
            padding: 14px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: 0.3s;
            text-align: center;
            flex: 1;
        }

        .btn-submit { background: var(--ocean-blue); color: white; flex: 2; }
        .btn-cancel { background: var(--danger-red); color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }

        /* Modal / Popup Styling */
        .modal-overlay { 
            display: none; 
            position: fixed; 
            top: 0; left: 0; width: 100%; height: 100%; 
            background: rgba(0,0,0,0.6); 
            backdrop-filter: blur(5px); 
            z-index: 1000; 
            justify-content: center; 
            align-items: center; 
        }

        .modal-box { 
            background: white; 
            padding: 30px; 
            border-radius: 15px; 
            width: 350px; 
            text-align: center; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.2); 
        }

        /* Success/Error Popup specific */
        .status-popup {
            position: fixed;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            padding: 30px;
            border-radius: 10px;
            color: white;
            text-align: center;
            z-index: 2000;
            width: 300px;
        }
        .success { background-color: var(--success-green); }
        .error { background-color: var(--danger-red); }
        .status-popup button {
            margin-top: 15px;
            padding: 8px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Register New Guest</h2>
    
    <form action="${pageContext.request.contextPath}/registerGuest" method="post">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="name" placeholder="Enter guest's full name" required>
        </div>

        <div class="form-group">
            <label>NIC / Passport Number</label>
            <input type="text" name="nic" placeholder="National ID or Passport" required>
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <input type="text" name="phone" placeholder="e.g. +94 77 123 4567">
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="guest@example.com">
        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-cancel" onclick="showCancelModal()">Cancel</button>
            <button type="submit" class="btn btn-submit">Register Guest</button>
        </div>
    </form>
</div>

<div id="cancelModal" class="modal-overlay">
    <div class="modal-box">
        <div style="font-size: 40px; color: var(--ocean-blue); margin-bottom: 10px;">ⓘ</div>
        <h3 style="margin:0; color: var(--dark-blue);">Cancel Registration?</h3>
        <p style="color: #666; margin-top:10px;">Are you sure you want to stop? Data entered will not be saved.</p>
        <div class="btn-group">
            <button class="btn" style="background:#eee; color:#666" onclick="closeCancelModal()">Go Back</button>
            <button class="btn" style="background:var(--ocean-blue); color:white" onclick="confirmCancel()">Yes, Exit</button>
        </div>
    </div>
</div>

<%
    String message = (String) request.getAttribute("message");
    String status = (String) request.getAttribute("status");
    if (message != null) {
%>
    <div class="status-popup <%= status %>">
        <p style="font-size: 1.1em; margin-bottom: 10px;"><%= message %></p>
        <button onclick="goDashboard()">Back to Dashboard</button>
    </div>
<%
    }
%>

<script>
    const cancelModal = document.getElementById('cancelModal');

    function showCancelModal() {
        cancelModal.style.display = 'flex';
    }

    function closeCancelModal() {
        cancelModal.style.display = 'none';
    }

    function confirmCancel() {
        window.location.href = "<%=request.getContextPath()%>/user/user-dashboard.jsp";
    }

    function goDashboard() {
        window.location.href = "<%=request.getContextPath()%>/user/user-dashboard.jsp";
    }
</script>

</body>
</html>