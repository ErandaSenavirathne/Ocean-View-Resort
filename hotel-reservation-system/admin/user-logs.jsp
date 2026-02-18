<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Activity Logs | Ocean View</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f8fafc; padding: 40px; }
        .container { max-width: 1000px; margin: auto; }
        .header-box { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        
        .card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e2e8f0; }
        
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; background: #f1f5f9; padding: 15px; color: #475569; font-size: 0.85rem; text-transform: uppercase; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; color: #1e293b; }
        
        .badge { padding: 5px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700; }
        .badge-login { background: #dcfce7; color: #166534; }
        .badge-logout { background: #fee2e2; color: #991b1b; }
        
        .btn-back {
        text-decoration: none;
        background: white;
        color: #334155;
        padding: 10px 18px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        border: 1px solid #e2e8f0;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-back:hover {
        background: #f1f5f9;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
    }
        
        .ip-text { font-family: monospace; color: #64748b; background: #f1f5f9; padding: 2px 5px; border-radius: 4px; }
    </style>
</head>
<body>

<div class="container">
    <div class="header-box">
        <div>
            <h2 style="margin:0;">User Activity Audit</h2>
            <p style="color: #64748b; margin-top:5px;">Real-time tracking of staff logins and logouts.</p>
        </div>
        <a href="AdminDashboardServlet" class="btn-back"><span>←</span> Back to Dashboard</a>
    </div>

    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>Staff User</th>
                    <th>Activity</th>
                    <th>Timestamp</th>
                    <th>IP Address</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="log" items="${logs}">
                    <tr>
                        <td><strong>${log.username}</strong></td>
                        <td>
                            <span class="badge ${log.action == 'LOGIN' ? 'badge-login' : 'badge-logout'}">
                                ${log.action}
                            </span>
                        </td>
                        <td>${log.time}</td>
                        <td><span class="ip-text">${log.ip}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>