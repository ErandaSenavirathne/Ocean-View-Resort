<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Financial Reports | Admin</title>
    <style>
        body { font-family: 'Inter', sans-serif; background: #f4f5f7; padding: 40px; }
        .container { max-width: 1100px; margin: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .grid { display: grid; grid-template-columns: 1fr 2fr; gap: 20px; }
        .card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .total-box { background: #3f83f8; color: white; padding: 30px; border-radius: 12px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { text-align: left; padding: 12px; border-bottom: 1px solid #eee; }
        .money { font-weight: bold; color: #057a55; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Financial Analytics</h2>
        <a href="${pageContext.request.contextPath}/AdminDashboardServlet" style="text-decoration:none; color:#3f83f8;">← Dashboard</a>
    </div>

    <div class="total-box">
        <h4 style="margin:0; opacity:0.8;">Total Collected Revenue</h4>
        <h1 style="margin:10px 0;">Rs. ${totalRev}</h1>
        <small>Based on completed (Checked Out) stays</small>
    </div>

    <div class="grid">
        <div class="card">
            <h3>Revenue by Category</h3>
            <table>
                <c:forEach var="item" items="${typeBreakdown}">
                    <tr>
                        <td>${item.type}</td>
                        <td class="money">Rs. ${item.revenue}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="card">
            <h3>Recent Completed Stays</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Guest</th>
                        <th>Date</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tx" items="${recentTx}">
                        <tr>
                            <td>#${tx.id}</td>
                            <td>${tx.guest}</td>
                            <td>${tx.date}</td>
                            <td class="money">Rs. ${tx.amount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>