<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Guest - Ocean View</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --soft-gray: #f4f7f6;
            --dark-blue: #2c3e50;
            --success-green: #27ae60;
            --danger-red: #c0392b;
        }

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--soft-gray); 
            display: flex; 
            justify-content: center; 
            padding-top: 60px; 
            margin: 0;
        }

        .search-box { 
            background: white; 
            padding: 40px; 
            border-radius: 15px; 
            box-shadow: 0 8px 25px rgba(0,0,0,0.1); 
            width: 420px; 
            text-align: center; 
        }

        h2 { color: var(--dark-blue); margin-bottom: 10px; }
        p.subtitle { color: #7f8c8d; margin-bottom: 25px; font-size: 0.95em; }

        input[type="text"] { 
            width: 100%; 
            padding: 12px; 
            margin: 10px 0 20px 0; 
            border: 1px solid #ddd; 
            border-radius: 8px; 
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Standardized Button Group */
        .btn-group { display: flex; gap: 12px; }
        
        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
            flex: 1;
        }

        .btn-search { background: var(--ocean-blue); color: white; flex: 2; }
        .btn-back { background: #95a5a6; color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }

        /* Modal Popup Styling */
        .modal-overlay { 
            display: <%= request.getAttribute("showRegister") != null ? "flex" : "none" %>; 
            position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
            background: rgba(0,0,0,0.6); backdrop-filter: blur(5px);
            justify-content: center; align-items: center; z-index: 1000;
        }
        
        .modal-content { 
            background: white; 
            padding: 30px; 
            border-radius: 15px; 
            width: 380px; 
            text-align: center; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .btn-reg { background: var(--success-green); color: white; margin-bottom: 10px; }
        .btn-close { background: #eee; color: #666; }
    </style>
</head>
<body>

<div class="search-box">
    <div style="font-size: 40px; color: var(--ocean-blue); margin-bottom: 10px;">🔍</div>
    <h2>Make Reservation</h2>
    <p class="subtitle">Enter Guest NIC or Passport Number to begin</p>
    
    <form action="../SearchGuestServlet" method="get">
        <input type="text" name="nicSearch" placeholder="Ex: 199512345678" required autofocus>
        
        <div class="btn-group">
            <a href="user-dashboard.jsp" class="btn btn-back">Back</a>
            <button type="submit" class="btn btn-search">Search Guest</button>
        </div>
    </form>
</div>

<div class="modal-overlay">
    <div class="modal-content">
        <div style="font-size: 40px; color: #e67e22; margin-bottom: 10px;">⚠️</div>
        <h3>Guest Not Found</h3>
        <p style="color: #666;">No record exists for NIC:<br><strong><%= request.getAttribute("searchedNic") %></strong></p>
        <p style="font-size: 0.9em; color: #7f8c8d;">Would you like to register them as a new guest in the system?</p>
        
        <div style="display: flex; flex-direction: column; gap: 10px; margin-top: 20px;">
            <a href="user/add-guest.jsp" class="btn btn-reg">Register New Guest</a>
            <a href="user/search-guest.jsp" class="btn btn-close">Try Again</a>
        </div>
    </div>
</div>

</body>
</html>