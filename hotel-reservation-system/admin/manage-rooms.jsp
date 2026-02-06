<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Rooms | Admin Console</title>
    <style>
        :root { --primary: #3f83f8; --dark: #1a1c23; --bg: #f4f5f7; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); margin: 0; padding: 40px; }
        .container { max-width: 1000px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .back-btn { color: var(--primary); text-decoration: none; font-weight: bold; margin-bottom: 20px; display: inline-block; }
        
        .add-form { background: #f9fafb; padding: 20px; border-radius: 10px; border: 1px solid #e5e7eb; margin-bottom: 30px; }
        .add-form h3 { margin-top: 0; color: var(--dark); }
        .input-group { display: flex; gap: 10px; flex-wrap: wrap; }
        input, select { padding: 10px; border: 1px solid #d1d5db; border-radius: 6px; flex: 1; }
        .btn-submit { background: var(--primary); color: white; border: none; padding: 10px 25px; border-radius: 6px; cursor: pointer; font-weight: bold; }

        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { text-align: left; padding: 15px; background: #f8fafc; color: #64748b; font-size: 0.8rem; text-transform: uppercase; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; }
        
        .badge { padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: bold; text-transform: uppercase; }
        .status-AVAILABLE { background: #dcfce7; color: #166534; }
        .status-OCCUPIED { background: #fee2e2; color: #991b1b; }
        .status-MAINTENANCE { background: #fef9c3; color: #854d0e; }
        
        .delete-link { color: #ef4444; text-decoration: none; font-weight: bold; margin-left: 10px; }
    </style>
</head>
<body>

<div class="container">
    <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="back-btn">← Back to Dashboard</a>
    
    <div class="add-form">
        <h3>Add New Room</h3>
        <form action="${pageContext.request.contextPath}/AdminManageRoomsServlet" method="post" class="input-group">
            <input type="text" name="roomNumber" placeholder="Room Number (e.g. 101)" required>
            <select name="roomType">
                <option value="Single">Single Room</option>
                <option value="Double">Double Room</option>
                <option value="Luxury Suite">Luxury Suite</option>
                <option value="Penthouse">Penthouse</option>
            </select>
            <input type="number" name="price" placeholder="Price per night (Rs.)" step="0.01" required>
            <button type="submit" class="btn-submit">Add Room</button>
        </form>
    </div>

    <h2>Current Inventory</h2>
    <table>
        <thead>
            <tr>
                <th>Room No.</th>
                <th>Type</th>
                <th>Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${roomList}">
                <tr>
                    <td><strong>${room.number}</strong></td>
                    <td>${room.type}</td>
                    <td>Rs. ${room.price}</td>
                    <td><span class="badge status-${room.status}">${room.status}</span></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/AdminManageRoomsServlet" method="get" style="display:inline;">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="id" value="${room.id}">
                            <select name="status" onchange="this.form.submit()" style="font-size: 0.8rem; padding: 2px;">
                                <option value="AVAILABLE" ${room.status == 'AVAILABLE' ? 'selected' : ''}>Available</option>
                                <option value="MAINTENANCE" ${room.status == 'MAINTENANCE' ? 'selected' : ''}>Maintenance</option>
                                <option value="OCCUPIED" ${room.status == 'OCCUPIED' ? 'selected' : ''} disabled>Occupied</option>
                            </select>
                        </form>
                        <a href="${pageContext.request.contextPath}/AdminManageRoomsServlet?action=delete&id=${room.id}" 
                           class="delete-link" onclick="return confirm('Are you sure you want to delete this room?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>