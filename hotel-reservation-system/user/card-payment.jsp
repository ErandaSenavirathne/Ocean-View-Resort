<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Secure Card Payment | Ocean View</title>
    <style>
        :root { --ocean-blue: #2980b9; --dark-blue: #2c3e50; --success-green: #27ae60; }
        body { 
            font-family: 'Segoe UI', sans-serif; margin: 0; padding: 30px; 
            background: linear-gradient(rgba(255,255,255,0.3), rgba(255,255,255,0.4)), url('${pageContext.request.contextPath}/images/resort-bg.jpg') center/cover fixed;
            display: flex; justify-content: center; align-items: center; min-height: 90vh;
        }
        .pay-card { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); width: 100%; max-width: 450px; text-align: center; }
        .input-group { text-align: left; margin-bottom: 15px; }
        label { font-size: 0.75rem; font-weight: bold; color: #7f8c8d; text-transform: uppercase; }
        input { width: 100%; padding: 12px; margin-top: 5px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .btn-pay { width: 100%; background: var(--ocean-blue); color: white; padding: 15px; border: none; border-radius: 8px; font-size: 1.1em; font-weight: bold; cursor: pointer; margin-top: 20px; transition: 0.3s; }
        
        #successUI { display: none; animation: popIn 0.5s ease forwards; }
        @keyframes popIn { from { transform: scale(0.9); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .checkmark { font-size: 60px; color: var(--success-green); }
    </style>
</head>
<body>

<div class="pay-card">
    <div id="paymentForm">
        <h2 style="color: var(--dark-blue); margin-bottom: 5px;">Authorize Card</h2>
        <p style="color: #666; margin-bottom: 30px;">Amount: <strong>Rs. ${param.finalBill}</strong></p>
        
        <div class="input-group"><label>Cardholder Name</label><input type="text" id="cName" placeholder="Name on Card"></div>
        <div class="input-group"><label>Card Number</label><input type="text" placeholder="XXXX XXXX XXXX XXXX" maxlength="19"></div>
        <div class="row">
            <div class="input-group"><label>Expiry</label><input type="text" placeholder="MM/YY" maxlength="5"></div>
            <div class="input-group"><label>CVV</label><input type="password" placeholder="***" maxlength="3"></div>
        </div>
        <button class="btn-pay" onclick="processPayment()">Pay Rs. ${param.finalBill}</button>
    </div>

    <div id="successUI">
        <div class="checkmark">✔</div>
        <h2 style="color: var(--dark-blue);">Payment Complete</h2>
        <p style="color: #666; font-size: 0.9em;">Transaction ID: #TXN-<%= System.currentTimeMillis() %></p>
        
        <div id="receiptData" style="display:none;">
            <div style="text-align:center;">
                <h3>OCEAN VIEW RESORT</h3>
                <p>Payment Receipt</p>
                <hr>
                <div style="text-align:left;">
                    <p>Res ID: ${param.resId}</p>
                    <p>Guest: ${param.guestName}</p>
                    <p>Total Paid: Rs. ${param.finalBill}</p>
                    <p>Method: Credit Card</p>
                </div>
            </div>
        </div>

        <div style="display: flex; gap: 10px; margin-top: 20px;">
            <button class="btn-pay" onclick="printReceipt()" style="background: var(--dark-blue); flex:1;">Print Receipt</button>
            <form action="${pageContext.request.contextPath}/ProcessCheckOutServlet" method="post" style="flex:1;">
                <input type="hidden" name="resId" value="${param.resId}">
                <input type="hidden" name="roomIds" value="${param.roomIds}">
                <input type="hidden" name="finalBill" value="${param.finalBill}">
                <input type="hidden" name="paymentMethod" value="CARD">
                <button type="submit" class="btn-pay" style="background: var(--success-green); width:100%;">Finish</button>
            </form>
        </div>
    </div>
</div>

<script>
    function processPayment() {
        const btn = document.querySelector('.btn-pay');
        btn.innerText = "Processing Authorization...";
        btn.disabled = true;
        setTimeout(() => {
            document.getElementById('paymentForm').style.display = 'none';
            document.getElementById('successUI').style.display = 'block';
        }, 2000);
    }

    function printReceipt() {
        const content = document.getElementById('receiptData').innerHTML;
        const win = window.open('', '', 'height=500,width=400');
        win.document.write('<html><body>' + content + '</body></html>');
        win.document.close();
        win.print();
    }
</script>
</body>
</html>