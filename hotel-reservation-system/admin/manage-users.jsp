<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Staff | Ocean View</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7f6; padding: 40px; }
        .container { max-width: 900px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .form-box { background: #eef2f3; padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .btn { padding: 8px 15px; border-radius: 4px; border: none; cursor: pointer; text-decoration: none; }
        .btn-add { background: #27ae60; color: white; }
        .btn-del { background: #e74c3c; color: white; font-size: 0.8em; }
        .badge { padding: 4px 8px; border-radius: 12px; font-size: 0.8em; font-weight: bold; }
        .role-ADMIN { background: #d4edda; color: #155724; }
        .role-USER { background: #e1effe; color: #1e429f; }
    </style>
</head>
<body>

<div class="container">
    <a href="${pageContext.request.contextPath}/AdminDashboardServlet" style="text-decoration: none;">← Back to Dashboard</a>
    <h2>Staff & Admin Management</h2>

    <div class="form-box">
        <h4>Add New Account</h4>
        <form action="${pageContext.request.contextPath}/AdminManageUsersServlet" method="post" style="display: flex; gap: 10px; align-items: flex-end;">
            <div>
                <label style="display:block; font-size: 0.8em;">Username</label>
                <input type="text" name="username" required style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
            </div>
            <div>
                <label style="display:block; font-size: 0.8em;">Password</label>
                <input type="password" name="password" required style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
            </div>
            <div>
                <label style="display:block; font-size: 0.8em;">Role</label>
                <select name="role" style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
                    <option value="USER">USER (Staff)</option>
                    <option value="ADMIN">ADMIN (Full Access)</option>
                </select>
            </div>
            <button type="submit" class="btn btn-add">Create User</button>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Account Level</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${userList}">
                <tr>
                    <td>#${u.id}</td>
                    <td><strong>${u.username}</strong></td>
                    <td><span class="badge role-${u.role}">${u.role}</span></td>
                    <td>
                        <c:if test="${u.username != sessionScope.username}">
                            <a href="${pageContext.request.contextPath}/AdminManageUsersServlet?action=delete&id=${u.id}" 
   							class="btn btn-del" onclick="return confirm('Delete this user?')">Delete</a>
                        </c:if>
                        <c:if test="${u.username == sessionScope.username}">
                            <small style="color: #999;">(You)</small>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>