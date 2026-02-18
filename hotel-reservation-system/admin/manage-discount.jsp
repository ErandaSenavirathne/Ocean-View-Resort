<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Discounts | Ocean View Resort</title>
    <style>
        :root { --primary: #3f83f8; --dark: #1a1c23; --bg: #f4f5f7; --success: #057a55; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); margin: 0; padding: 40px; }
        .container { max-width: 550px; margin: auto; background: white; padding: 35px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .back-link { color: var(--primary); text-decoration: none; font-weight: 600; display: block; margin-bottom: 20px; font-size: 0.9rem; }
        .header-section { border-bottom: 2px solid #f1f5f9; margin-bottom: 30px; padding-bottom: 15px; }
        h2 { margin: 0; color: var(--dark); }
        .form-group { margin-bottom: 25px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #4b5563; }
        .input-box { position: relative; display: flex; align-items: center; }
        input[type="number"] { width: 100%; padding: 12px; border: 1px solid #d1d5db; border-radius: 8px; font-size: 1.1rem; outline: none; transition: border 0.2s; }
        input[type="number"]:focus { border-color: var(--primary); }
        .percentage-symbol { position: absolute; right: 15px; color: #9ca3af; font-weight: bold; }
        .hint { font-size: 0.8rem; color: #9ca3af; margin-top: 6px; }
        .btn-update { background: var(--primary); color: white; border: none; padding: 14px; border-radius: 8px; cursor: pointer; width: 100%; font-weight: bold; font-size: 1rem; transition: background 0.2s; }
        .btn-update:hover { background: #1c64f2; }
        .btn-back {
            text-decoration: none;
            background: white;
            color: #334155;
            padding: 8px 15px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.85rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s;
            display: inline-flex; /* Changed from flex to inline-flex to stop full width */
            align-items: center;
            gap: 8px;
            float: right; /* Moves it to the right corner */
        }

        .btn-back:hover {
            background: #f1f5f9;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }
        .status-msg { padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-size: 0.9rem; font-weight: 500; }
        .msg-success { background: #def7ec; color: var(--success); border: 1px solid #bcf0da; }
    </style>
</head>
<body>

<div class="container">
    <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="btn-back">
            <span>←</span> Back to Dashboard
        </a>
    
    <div class="header-section">
        <h2>Manage Discounts</h2>
        <p style="color: #6b7280; font-size: 0.9rem; margin-top: 5px;">Adjust percentages for automated billing</p>
    </div>

    <c:if test="${param.success == 'true'}">
        <div class="status-msg msg-success">Settings updated and applied successfully!</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/AdminSystemSettingsServlet" method="post">
        <div class="form-group">
            <label>Long Stay Discount</label>
            <div class="input-box">
                <input type="number" name="long_stay_discount" value="${settings['long_stay_discount']}" step="0.1" min="0" max="100" required>
                <span class="percentage-symbol">%</span>
            </div>
            <p class="hint">Automatically applied to stays of 5 nights or more.</p>
        </div>

        <div class="form-group">
            <label>Multi-Room Discount</label>
            <div class="input-box">
                <input type="number" name="multi_room_discount" value="${settings['multi_room_discount']}" step="0.1" min="0" max="100" required>
                <span class="percentage-symbol">%</span>
            </div>
            <p class="hint">Applied when the guest books 2 or more rooms.</p>
        </div>

        <button type="submit" class="btn-update">Save New Rates</button>
    </form>
</div>

</body>
</html>