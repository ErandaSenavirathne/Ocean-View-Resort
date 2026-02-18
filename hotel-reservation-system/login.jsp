<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Login | Ocean View Resort Galle</title>
    <style>
        :root {
            --primary-teal: #008080; 
            --accent-gold: #c5a059;  
            --dark-navy: #1a2a3a;
            --soft-sand: #fdfaf5;
            --glass: rgba(255, 255, 255, 0.95);
        }

        body {
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), 
                        url('images/resort-bg.jpg');
            background-size: cover;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            display: flex;
            background: var(--glass);
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.3);
            overflow: hidden;
            width: 850px;
            min-height: 520px;
            backdrop-filter: blur(10px);
        }

        /* Branding Side Panel */
        .brand-side {
            background: var(--dark-navy);
            color: white;
            width: 40%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center; /* Centers the logo and text */
            text-align: center;
            position: relative;
        }

        /* LOGO STYLING */
        .resort-logo {
            width: 120px;         /* Adjust size as needed */
            height: 120px;
            object-fit: contain;  /* Keeps logo proportions */
            margin-bottom: 20px;
            filter: drop-shadow(0 5px 15px rgba(0,0,0,0.3));
        }

        .brand-side h2 {
            letter-spacing: 4px;
            margin: 10px 0;
            font-weight: 300;
        }

        /* Form Side */
        .form-side {
            width: 60%;
            padding: 50px;
            background: var(--soft-sand);
        }

        h1 {
            font-size: 2rem;
            color: var(--dark-navy);
            margin: 0;
        }

        .subtitle {
            color: var(--primary-teal);
            font-size: 0.85rem;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-bottom: 35px;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 0.8rem;
            color: #555;
            margin-bottom: 8px;
            font-weight: 600;
            text-transform: uppercase;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ccd1d1;
            border-radius: 6px;
            background: white;
            font-size: 1rem;
            box-sizing: border-box;
            transition: 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--primary-teal);
            box-shadow: 0 0 8px rgba(0, 128, 128, 0.15);
        }

        .btn-login {
            width: 100%;
            padding: 16px;
            background: var(--dark-navy);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        .btn-login:hover {
            background: var(--primary-teal);
            transform: translateY(-1px);
        }

        .error-msg {
            background: #ffebeb;
            color: #b33939;
            padding: 12px;
            border-radius: 6px;
            border-left: 4px solid #b33939;
            margin-bottom: 20px;
            font-size: 0.85rem;
        }

        .footer {
            margin-top: 40px;
            font-size: 0.75rem;
            color: #888;
            border-top: 1px solid #e0e0e0;
            padding-top: 15px;
            line-height: 1.5;
        }

        @media (max-width: 768px) {
            .login-container { width: 90%; flex-direction: column; }
            .brand-side { width: 100%; padding: 30px; }
            .form-side { width: 100%; padding: 30px; }
            .resort-logo { width: 80px; height: 80px; }
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="brand-side">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Ocean View Resort Logo" class="resort-logo">
        
        <h2>GALLE</h2>
        <p style="font-style: italic; opacity: 0.7; font-size: 0.9rem;">
            Excellence in Hospitality
        </p>
    </div>

    <div class="form-side">
        <div class="header-area">
            <h1>Ocean View Resort</h1>
            <div class="subtitle">Staff Management Portal</div>
        </div>

        <%-- Error Message JSP Logic --%>
        <% String error = (String) request.getAttribute("error"); if (error != null) { %>
            <div class="error-msg">
                <strong>Error:</strong> <%= error %>
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Employee ID" required autofocus>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="********" required>
            </div>

            <button type="submit" class="btn-login">SECURE LOGIN</button>
        </form>

        <div class="footer">
            &copy; 2026 Ocean View Resort & Spa | Galle Branch<br>
            <em>Authorized Access Only. All activities are monitored.</em>
        </div>
    </div>
</div>

</body>
</html>