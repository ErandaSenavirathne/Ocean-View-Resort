<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Check-Out Search - Ocean View</title>
    <style>
        :root { --ocean-blue: #2980b9; --soft-gray: #f4f7f6; --dark-blue: #2c3e50; }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--soft-gray); display: flex; justify-content: center; padding-top: 80px; margin: 0; }
        .search-box { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); width: 420px; text-align: center; }
        h2 { color: var(--dark-blue); margin-bottom: 5px; }
        .subtitle { color: #7f8c8d; margin-bottom: 25px; font-size: 0.9em; }
        input[type="text"] { width: 100%; padding: 12px; margin: 20px 0; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 16px; transition: 0.3s; }
        input:focus { border-color: var(--ocean-blue); outline: none; box-shadow: 0 0 8px rgba(41, 128, 185, 0.2); }
        .btn-group { display: flex; gap: 10px; }
        .btn { flex: 1; padding: 13px; border-radius: 8px; font-weight: bold; cursor: pointer; border: none; text-decoration: none; transition: 0.3s; font-size: 15px; text-align: center; }
        .btn-search { background: #f39c12; color: white; flex: 2; }
        .btn-back { background: #95a5a6; color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }
        .error-msg { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-top: 15px; font-size: 0.85em; }
    </style>
</head>
<body>

<div class="search-box">
    <div style="font-size: 50px; margin-bottom: 10px;">🚪</div>
    <h2>Process Check-Out</h2>
    <p class="subtitle">Search for an active reservation by Guest NIC</p>
    
    <%-- FIXED PATH: Points to the root context --%>
    <form action="${pageContext.request.contextPath}/FetchCheckOutDetails" method="get">
        <input type="text" name="nicSearch" placeholder="Ex: 199512345678" required autofocus>
        <div class="btn-group">
        	<a href="${pageContext.request.contextPath}/user/user-dashboard.jsp" class="btn btn-back">Back</a>
            
            <button type="submit" class="btn btn-search">Find Reservation</button>
        </div>
    </form>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg">⚠️ <%= request.getAttribute("error") %></div>
    <% } %>
</div>

</body>
</html>