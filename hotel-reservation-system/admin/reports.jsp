<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Hotel Reports | Ocean View</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    :root {
        --primary: #1e40af;
        --secondary: #64748b;
        --success: #059669;
        --bg-color: #f8fafc;
        --card-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    }

    body { 
        font-family: 'Inter', sans-serif; 
        background: var(--bg-color); 
        padding: 20px; 
        margin: 0;
        color: #1e293b;
    }

    .container { max-width: 1200px; margin: auto; }

    /* Top Navigation Header */
    .dashboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 10px 0;
    }

    .btn-back {
        text-decoration: none;
        background: white;
        color: #334155;
        padding: 10px 18px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        border: 1px solid #e2e8f0;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-back:hover {
        background: #f1f5f9;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
    }

    /* KPI Grid */
    .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px;}
    
    .card { 
        background: white; 
        padding: 24px; 
        border-radius: 12px;
        box-shadow: var(--card-shadow); 
        border: 1px solid #f1f5f9;
    }

    .kpi-title { font-size: 0.85rem; color: var(--secondary); text-transform: uppercase; letter-spacing: 0.025em; margin: 0; }
    .kpi-value { font-size: 1.75rem; font-weight: 700; margin: 10px 0 0 0; color: #0f172a; }
    
    .money { color: var(--success); font-weight: 600; }
    
    /* Charts & Layout */
    .charts-row { display: grid; grid-template-columns: 3fr 2fr; gap: 20px; margin-bottom: 30px;}
    
    h2, h3 { color: #0f172a; margin-top: 0; }

    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th { text-align: left; background: #f8fafc; padding: 12px; color: #64748b; font-size: 0.8rem; text-transform: uppercase; }
    td { padding: 14px 12px; border-bottom: 1px solid #f1f5f9; font-size: 0.95rem; }
    tr:hover { background-color: #fdfdfd; }

    .badge {
        padding: 4px 10px;
        background: #dcfce7;
        color: #166534;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
    }
</style>
</head>

<body>

<div class="container">
    
    <div class="dashboard-header">
        <div>
            <h2 style="margin:0;">Hotel Analytics Dashboard</h2>
            <p style="color: var(--secondary); margin: 5px 0 0 0;">Visualizing performance and revenue trends</p>
        </div>
        <a href="AdminDashboardServlet" class="btn-back">
            <span>←</span> Back to Dashboard
        </a>
    </div>

    <div class="grid">
        <div class="card">
            <p class="kpi-title">Total Revenue</p>
            <h2 class="kpi-value">Rs. ${totalRev}</h2>
        </div>
        <div class="card">
            <p class="kpi-title">Today's Sales</p>
            <h2 class="kpi-value">Rs. ${todayRev}</h2>
        </div>
        <div class="card">
            <p class="kpi-title">Monthly Total</p>
            <h2 class="kpi-value">Rs. ${monthRev}</h2>
        </div>
        <div class="card">
            <p class="kpi-title">Occupancy Rate</p>
            <h2 class="kpi-value">${occupancyRate}%</h2>
        </div>
    </div>

    <div class="card" style="margin-bottom:30px; border-left: 5px solid var(--primary); display: flex; align-items: center; justify-content: space-between;">
        <h3 style="margin:0; font-size: 1.1rem;">🔥 Most Popular Room Type: <span style="color: var(--primary)">${popularType}</span></h3>
    </div>

    <div class="charts-row">
        <div class="card">
            <h3 style="font-size: 1rem;">Revenue Performance by Room Type</h3>
            <div style="height: 300px;"><canvas id="barChart"></canvas></div>
        </div>

        <div class="card">
            <h3 style="font-size: 1rem;">Revenue Distribution</h3>
            <div style="height: 300px;"><canvas id="pieChart"></canvas></div>
        </div>
    </div>

    <div class="card">
        <h3>Recent Completed Stays</h3>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Guest Name</th>
                    <th>Check-out Date</th>
                    <th>Final Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tx" items="${recentTx}">
                    <tr>
                        <td style="font-weight: 600; color: var(--primary);">#${tx.id}</td>
                        <td>${tx.guest}</td>
                        <td>${tx.date}</td>
                        <td class="money">Rs. ${tx.amount}</td>
                        <td><span class="badge">Paid</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>

<script>
// Data from JSTL
const labels = [<c:forEach var="item" items="${typeBreakdown}">"${item.type}",</c:forEach>];
const values = [<c:forEach var="item" items="${typeBreakdown}">${item.revenue},</c:forEach>];

const chartColors = ['#1e40af', '#3b82f6', '#60a5fa', '#93c5fd', '#bfdbfe'];

// Professional BAR CHART
new Chart(document.getElementById('barChart'), {
    type: 'bar',
    data: { 
        labels: labels,
        datasets: [{ 
            label: 'Revenue (Rs)', 
            data: values,
            backgroundColor: chartColors[0],
            borderRadius: 6
        }]
    },
    options: { 
        responsive: true, 
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
            y: { beginAtZero: true, grid: { color: '#f1f5f9' } },
            x: { grid: { display: false } }
        }
    }
});

// Professional PIE CHART
new Chart(document.getElementById('pieChart'), {
    type: 'pie',
    data: { 
        labels: labels,
        datasets: [{ 
            data: values,
            backgroundColor: chartColors,
            borderWidth: 2,
            borderColor: '#ffffff'
        }]
    },
    options: { 
        responsive: true, 
        maintainAspectRatio: false,
        plugins: { 
            legend: { 
                position: 'bottom',
                labels: { usePointStyle: true, padding: 20 }
            } 
        } 
    }
});
</script>

</body>
</html>