<!DOCTYPE html>
<html>
<head>
    <title>Login - Ocean View Resort</title>
    <style>
        :root {
            --ocean-blue: #2980b9;
            --dark-blue: #2c3e50;
            --soft-gray: #f4f7f6;
            --danger-red: #c0392b;
            --glass-white: rgba(255, 255, 255, 0.95);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            background: var(--glass-white);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 380px;
            text-align: center;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo-area { margin-bottom: 30px; }
        .logo-area h1 { color: var(--dark-blue); margin: 0; font-size: 24px; letter-spacing: 2px; }
        .logo-area p { color: var(--ocean-blue); font-weight: 600; margin-top: 5px; font-size: 0.9em; text-transform: uppercase; }

        /* Error Message Styling */
        .error-box {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.85em;
            border: 1px solid #f5c6cb;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .form-group { text-align: left; margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: 600; font-size: 0.9em; }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: 0.3s;
        }

        input:focus {
            border-color: var(--ocean-blue);
            outline: none;
            box-shadow: 0 0 8px rgba(41, 128, 185, 0.2);
        }

        button {
            width: 100%;
            padding: 14px;
            background: var(--ocean-blue);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        button:hover {
            background: #1f6391;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .footer-text { margin-top: 25px; font-size: 0.8em; color: #999; }
    </style>
</head>
<body>

<div class="login-card">
    <div class="logo-area">
        <div style="font-size: 45px; margin-bottom: 10px;">🌊</div>
        <h1>OCEAN VIEW</h1>
        <p>Staff Management Portal</p>
    </div>

    <%-- Error message display logic --%>
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error-box">
            <span>⚠️</span> <%= error %>
        </div>
    <%
        }
    %>

    <form action="login" method="post">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter your username" required autofocus>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter your password" required>
        </div>

        <button type="submit">Secure Login</button>
    </form>

    <div class="footer-text">
        &copy; 2026 Ocean View Resort & Spa <br>
        Authorized Personnel Only
    </div>
</div>

</body>
</html>