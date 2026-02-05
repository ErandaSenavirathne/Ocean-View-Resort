<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Room Availability - Ocean View</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --soft-gray: #f4f7f6;
            --dark-blue: #2c3e50;
            --success-green: #27ae60;
            --warning-orange: #e67e22;
        }

        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--soft-gray); margin: 0; padding: 20px; }
        .container { max-width: 950px; margin: 20px auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        
        h2 { color: var(--dark-blue); text-align: center; margin-bottom: 25px; }

        /* Professional Filter Box */
        .filter-box { background: #ebf5fb; padding: 20px; border-radius: 10px; border-left: 5px solid var(--ocean-blue); margin-bottom: 30px; }
        .filter-form { display: flex; justify-content: center; align-items: center; gap: 15px; flex-wrap: wrap; }
        .filter-form label { font-weight: 600; color: var(--dark-blue); }
        .filter-form input[type="date"] { padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-family: inherit; }
        
        /* Table Styling */
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: var(--ocean-blue); color: white; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #eee; transition: 0.2s; }
        tr:hover td { background-color: #fcfcfc; }
        
        .price-tag { font-weight: bold; color: var(--success-green); font-size: 1.1em; }
        .type-badge { padding: 5px 10px; border-radius: 20px; font-size: 0.8em; background: white; border: 1px solid var(--ocean-blue); color: var(--ocean-blue); text-transform: uppercase; }
        .status-pill { padding: 4px 12px; border-radius: 12px; font-size: 0.85em; font-weight: bold; }

        /* Consistent Button Group */
        .btn-group { display: flex; gap: 12px; margin-top: 30px; }
        .btn { padding: 12px 25px; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; border: none; transition: 0.3s; text-decoration: none; text-align: center; display: inline-block; }
        
        .btn-filter { background: var(--ocean-blue); color: white; }
        .btn-back { background: #95a5a6; color: white; }
        .btn-clear { background: #eee; color: #666; font-size: 0.9em; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }

        .back-link { display: inline-block; margin-bottom: 15px; text-decoration: none; color: var(--ocean-blue); font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/user/user-dashboard.jsp" class="btn btn-back">Back</a>
    </div>
    
    <h2>Room Inventory & Availability</h2>
    
    <div class="filter-box">
        <form action="${pageContext.request.contextPath}/ViewAvailableRooms" method="get" class="filter-form">
            <label>From:</label>
            <input type="date" name="filterIn" value="${param.filterIn}" required id="fIn">
            
            <label>To:</label>
            <input type="date" name="filterOut" value="${param.filterOut}" required id="fOut">
            
            <button type="submit" class="btn btn-filter">Check Availability</button>
            <a href="${pageContext.request.contextPath}/ViewAvailableRooms" class="btn btn-clear">Reset</a>
        </form>
    </div>

    <c:if test="${not empty param.filterIn}">
        <div style="text-align: center; margin-bottom: 20px; padding: 10px; background: #fff9e6; border-radius: 8px; border: 1px solid #f1c40f;">
            Showing room status for the period: <strong>${param.filterIn}</strong> — <strong>${param.filterOut}</strong>
        </div>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Room No.</th>
                <th>Category</th>
                <th>Price / Night</th>
                <th>Live Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${allRooms}">
                <tr>
                    <td><strong>${room.number}</strong></td>
                    <td><span class="type-badge">${room.type}</span></td>
                    <td class="price-tag">Rs. ${room.price}</td>
                    <td>
                        <span class="status-pill" style="background: ${room.status == 'AVAILABLE' ? '#eafaf1' : '#fef5e7'}; color: ${room.status == 'AVAILABLE' ? '#27ae60' : '#e67e22'}">
                            ● ${room.status}
                        </span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty allRooms}">
        <div style="padding: 40px; text-align: center; color: #7f8c8d;">
            <p>No rooms match your search criteria.</p>
        </div>
    </c:if>

    
</div>

<script>
    // Simple date logic to prevent past dates in filters
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('fIn').setAttribute('min', today);
    
    document.getElementById('fIn').addEventListener('change', function() {
        document.getElementById('fOut').setAttribute('min', this.value);
    });
</script>

</body>
</html>