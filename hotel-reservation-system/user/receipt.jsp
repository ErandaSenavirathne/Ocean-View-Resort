<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DBConnection, java.time.*, java.time.temporal.ChronoUnit" %>
<!DOCTYPE html>
<html>
<head>
    <title>Receipt - Ocean View Resort</title>
    <style>
        
		body { 
   				font-family: 'Courier New', Tahoma, Geneva, Verdana, sans-serif; 
   				
   				padding: 20px; 
   				color: var(--dark-blue);

    		/* 🔥 Background Image */
  				background: 
      				 linear-gradient(rgba(255,255,255,0.25), rgba(255,255,255,0.35)),
      				 url('${pageContext.request.contextPath}/images/resort-bg.jpg');

				background-size: cover;
   				background-position: center;
   				background-attachment: fixed;
   					 
				}


.receipt-card {
    background: white;
    width: 420px;              /* increased width */
    max-width: 100%;           /* prevents overflow on small screens */
    margin: auto;
    padding: 25px;
    border: 1px solid #ddd;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    box-sizing: border-box;    /* keeps padding inside width */
}

.header { text-align: center; border-bottom: 2px dashed #000; padding-bottom: 10px; margin-bottom: 15px; }
.header h2 { margin: 0; font-size: 20px; }

.section-title {
    font-size: 12px;
    font-weight: bold;
    border-bottom: 1px solid #eee;
    margin: 10px 0 5px 0;
    padding-bottom: 2px;
    text-transform: uppercase;
}

/* 🔥 CRITICAL FIX FOR ROW OVERFLOW */
.row, .item-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 10px;
    font-size: 13px;
    margin: 5px 0;
    word-break: break-word;
}

.row span:first-child,
.item-row span:first-child {
    flex: 1;
    min-width: 0;
}

.row span:last-child,
.item-row span:last-child {
    white-space: nowrap;
}

.item-row { font-size: 12px; color: #333; }

.total-row {
    border-top: 2px solid #000;
    margin-top: 15px;
    padding-top: 10px;
    font-weight: bold;
    font-size: 18px;
}

.btn {
    padding: 10px 20px;
    background: #2980b9;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    text-decoration: none;
}

/* Print optimization */
@media print {
    .no-print { display: none; }
    body { background: white; padding: 0; }
    .receipt-card {
        border: none;
        box-shadow: none;
        width: 100%;
    }
}

    </style>
</head>
<body>

<%
    String resId = request.getParameter("resId");
    String totalAmount = request.getParameter("amount");
    
    String guestName = "", guestNIC = "", rooms = "";
    double roomTotal = 0;
    long nights = 0;

    try (Connection con = DBConnection.getConnection()) {
        // 1. Fetch Reservation, Guest, and Room Price Details
        String hSql = "SELECT g.full_name, g.nic, r.check_in, r.actual_check_out, " +
                      "GROUP_CONCAT(rm.room_number SEPARATOR ', ') as rms, " +
                      "SUM(rm.price_per_night) as daily_rate " +
                      "FROM reservations r " +
                      "JOIN guests g ON r.guest_id = g.guest_id " +
                      "JOIN reservation_items ri ON r.res_id = ri.res_id " +
                      "JOIN rooms rm ON ri.room_id = rm.room_id " +
                      "WHERE r.res_id = ? GROUP BY r.res_id";
        
        PreparedStatement ps = con.prepareStatement(hSql);
        ps.setInt(1, Integer.parseInt(resId));
        ResultSet rs = ps.executeQuery();
        
        if(rs.next()){
            guestName = rs.getString("full_name");
            guestNIC = rs.getString("nic");
            rooms = rs.getString("rms");
            
            // Calculate nights stayed
            LocalDate cin = rs.getDate("check_in").toLocalDate();
            // If actual_check_out isn't set yet in DB, use today
            Date coutDate = rs.getDate("actual_check_out");
            LocalDate cout = (coutDate != null) ? coutDate.toLocalDate() : LocalDate.now();
            
            nights = ChronoUnit.DAYS.between(cin, cout);
            if (nights <= 0) nights = 1; // Minimum 1 night charge
            
            roomTotal = rs.getDouble("daily_rate") * nights;
        }
%>

<div class="receipt-card">
    <div class="header">
        <h2>OCEAN VIEW RESORT</h2>
        <p>Galle Road, Galle<br>Tel: +94 11 234 5678</p>
        <p><strong>OFFICIAL RECEIPT</strong></p>
    </div>

    <div class="row"><span>Date:</span><span><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()) %></span></div>
    <div class="row"><span>Booking ID:</span><span>#<%= resId %></span></div>
    <div class="row"><span>Guest:</span><span><%= guestName %></span></div>
    <div class="row"><span>NIC:</span><span><%= guestNIC %></span></div>

    <div class="section-title">Accommodation</div>
    <div class="row">
        <span>Room(s): <%= rooms %></span>
        <span><%= nights %> Night(s)</span>
    </div>
    <div class="row" style="font-weight: bold;">
        <span>Room Subtotal</span>
        <span>Rs. <%= String.format("%.2f", roomTotal) %></span>
    </div>

    <div class="section-title">Service & Food Orders</div>
    <%
        double foodTotal = 0;
        String fSql = "SELECT fi.item_name, fo.quantity, (fi.price * fo.quantity) as sub " +
                      "FROM food_orders fo JOIN food_items fi ON fo.item_id = fi.item_id WHERE fo.res_id = ?";
        PreparedStatement psF = con.prepareStatement(fSql);
        psF.setInt(1, Integer.parseInt(resId));
        ResultSet rsF = psF.executeQuery();
        boolean hasFood = false;
        while(rsF.next()){
            hasFood = true;
            foodTotal += rsF.getDouble("sub");
    %>
        <div class="item-row">
            <span><%= rsF.getString("item_name") %> (x<%= rsF.getInt("quantity") %>)</span>
            <span><%= String.format("%.2f", rsF.getDouble("sub")) %></span>
        </div>
    <% 
        } 
        if(!hasFood) { 
    %>
        <div class="item-row"><span style="color: #999;">No food orders found</span><span>0.00</span></div>
    <% } %>
    
    <div class="row" style="font-weight: bold; margin-top: 5px;">
        <span>Service Subtotal</span>
        <span>Rs. <%= String.format("%.2f", foodTotal) %></span>
    </div>

    <div class="total-row row">
        <span>TOTAL PAID</span>
        <span>Rs. <%= totalAmount %></span>
    </div>

    <div style="text-align: center; margin-top: 25px; font-size: 11px; border-top: 1px dashed #ccc; padding-top: 10px;">
        <p>Thank you for staying with us!<br>Please come again.</p>
        <p><em>Computer Generated Receipt</em></p>
    </div>
</div>

<% } catch(Exception e) { 
    out.println("<p>Error generating receipt: " + e.getMessage() + "</p>");
} %>

<div class="no-print" style="text-align:center; margin-top: 20px;">
    <button onclick="window.print()" class="btn">Print Receipt</button>
    <button onclick="location.href='user-dashboard.jsp'" class="btn" style="background:#7f8c8d;">Close</button>
</div>

</body>
</html>