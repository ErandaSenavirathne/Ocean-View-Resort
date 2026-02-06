<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Receipt - Ocean View Resort</title>
    <style>
    body { font-family: 'Courier New', Courier, monospace; background: #f0f0f0; padding: 20px; }
    
    .receipt-card {
        background: white;
        width: 380px; /* Screen width */
        margin: auto;
        padding: 25px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border: 1px solid #ddd;
        box-sizing: border-box; /* Ensures padding doesn't increase width */
    }
    
    .header { text-align: center; border-bottom: 2px dashed #000; padding-bottom: 10px; margin-bottom: 15px; }
    .header h1 { margin: 0; font-size: 20px; letter-spacing: 1px; }
    
    /* Improved Row Layout for Printing */
    .row { 
        display: flex; 
        justify-content: space-between; 
        margin-bottom: 8px; 
        font-size: 13px; 
        width: 100%;
        overflow: hidden; /* Prevents text overflow */
    }
    
    .row span:last-child {
        text-align: right;
        padding-left: 10px;
    }

    .total-row { border-top: 2px solid #000; margin-top: 15px; padding-top: 10px; font-weight: bold; font-size: 18px; display: flex; justify-content: space-between; }
    .footer { text-align: center; margin-top: 25px; font-size: 11px; border-top: 1px dashed #ccc; padding-top: 10px; }
    
    .no-print { text-align: center; margin-top: 20px; }
    .btn { padding: 10px 20px; background: #2980b9; color: white; text-decoration: none; border-radius: 5px; cursor: pointer; border: none; font-weight: bold; }
    
    /* PRINT SPECIFIC FIXES */
    @media print {
        @page {
            margin: 0.5cm; /* Forces a small margin on the physical paper */
        }
        .no-print { display: none !important; }
        body { background: white; padding: 0; margin: 0; }
        .receipt-card { 
            box-shadow: none; 
            border: none; 
            width: 100%; /* Spans full width of paper */
            max-width: 100%;
            padding: 10px; 
        }
        .row { font-size: 14pt; } /* Makes text slightly larger for physical print */
    }
</style>
</head>
<body>

<%
    String resId = request.getParameter("resId");
    String guestName = "";
    String guestNIC = ""; // This acts as your real-world Guest ID
    String roomNums = "";
    
    try (Connection con = DBConnection.getConnection()) {
        // Query modified to fetch 'nic' as the unique Guest ID
        String sql = "SELECT g.full_name, g.nic, GROUP_CONCAT(rm.room_number) as rooms " +
                     "FROM reservations r " +
                     "JOIN guests g ON r.guest_id = g.guest_id " +
                     "JOIN reservation_items ri ON r.res_id = ri.res_id " +
                     "JOIN rooms rm ON ri.room_id = rm.room_id " +
                     "WHERE r.res_id = ? " +
                     "GROUP BY r.res_id";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(resId));
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            guestName = rs.getString("full_name");
            guestNIC = rs.getString("nic");
            roomNums = rs.getString("rooms");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="receipt-card">
    <div class="header">
        <h1>OCEAN VIEW RESORT</h1>
        <p>123 Coastal Road, Galle<br>Tel: +94 11 234 5678</p>
        <p><strong>OFFICIAL RECEIPT</strong></p>
    </div>

    <div class="row">
        <span>Date:</span> 
        <span><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()) %></span>
    </div>
    
    <%-- Displaying NIC as the Guest ID --%>
    <div class="row">
        <span>Guest ID (NIC):</span> 
        <span><strong><%= guestNIC %></strong></span>
    </div>

    <div class="row">
        <span>Booking ID:</span> 
        <span>#<%= resId %></span>
    </div>

    <div class="row">
        <span>Guest Name:</span> 
        <span><%= guestName %></span>
    </div>

    <div class="row">
        <span>Rooms:</span> 
        <span><%= roomNums %></span>
    </div>
    
    <div class="total-row">
        <span>TOTAL PAID</span>
        <span>Rs. <%= request.getParameter("amount") %></span>
    </div>

    <div class="footer">
        <p>Thank you for choosing Ocean View Resort.<br>We hope to see you again!</p>
        <p><em>This is a computer-generated receipt.</em></p>
    </div>
</div>

<div class="no-print">
    <button onclick="window.print()" class="btn">Print Receipt</button>
    <a href="user-dashboard.jsp" class="btn" style="background: #7f8c8d;">Close</a>
</div>

</body>
</html>