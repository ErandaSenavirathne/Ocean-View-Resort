<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Guest - Ocean View</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7f6; display: flex; justify-content: center; padding-top: 50px; }
        .search-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 400px; text-align: center; }
        input[type="text"] { width: 90%; padding: 10px; margin: 20px 0; border: 1px solid #ddd; border-radius: 4px; }
        .btn-search { background: #3498db; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 4px; width: 100%; }
        
        /* Modal Popup Styling */
        .modal { display: <%= request.getAttribute("showRegister") != null ? "flex" : "none" %>; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); justify-content: center; align-items: center; }
        .modal-content { background: white; padding: 20px; border-radius: 8px; width: 350px; text-align: center; }
        .btn-reg { background: #27ae60; color: white; padding: 10px; text-decoration: none; display: block; margin-top: 15px; border-radius: 4px; }
    </style>
</head>
<body>

<div class="search-box">
    <h2>Make Reservation</h2>
    <p>Enter Guest NIC or Passport Number</p>
    <form action="../SearchGuestServlet" method="get">
        <input type="text" name="nicSearch" placeholder="Ex: 199512345678" required>
        <button type="submit" class="btn-search">Search Guest</button>
    </form>
</div>

<div class="modal">
    <div class="modal-content">
        <h3>Guest Not Found</h3>
        <p>No record exists for NIC: <strong><%= request.getAttribute("searchedNic") %></strong></p>
        <p>Would you like to register them as a new guest?</p>
        <a href="user/add-guest.jsp" class="btn-reg">Register New Guest</a>
        <a href="user/search-guest.jsp" style="display:block; margin-top:10px; color: #7f8c8d;">Cancel</a>
    </div>
</div>

</body>
</html>