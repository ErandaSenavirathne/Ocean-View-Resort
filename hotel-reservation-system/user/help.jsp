<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Help Center - Ocean View</title>
    <style>
        :root { --ocean: #2980b9; --dark: #2c3e50; --bg: #f4f7f6; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); margin: 0; padding: 30px; }
        .help-container { max-width: 900px; margin: auto; }
        .help-card { background: white; padding: 25px; border-radius: 12px; margin-bottom: 20px; border-left: 5px solid var(--ocean); box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .help-card h3 { margin-top: 0; color: var(--dark); display: flex; align-items: center; gap: 10px; }
        .step-list { padding-left: 20px; line-height: 1.6; color: #555; }
        .step-list li { margin-bottom: 10px; }
        .badge-info { background: #e3f2fd; color: #1976d2; padding: 2px 8px; border-radius: 4px; font-size: 0.8em; font-weight: bold; }
        .btn-back { background: var(--dark); color: white; padding: 10px 20px; text-decoration: none; border-radius: 6px; display: inline-block; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="help-container">
    <a href="user-dashboard.jsp" class="btn-back">← Back to Dashboard</a>
    <h1>Staff Training Manual</h1>
    <p style="color: #7f8c8d;">Follow these guidelines to maintain a smooth reservation flow.</p>

    <div class="help-card">
        <h3>1. New Reservations</h3>
        <ol class="step-list">
            <li>Go to <strong>Guest Search</strong> and enter the NIC or Passport number.</li>
            <li>If the guest is new, register them first. If existing, click <strong>"Select"</strong>.</li>
            <li>Select <strong>Check-in</strong> and <strong>Check-out</strong> dates. Note: The system automatically hides rooms that are already occupied.</li>
            <li>Choose one or more rooms from the inventory list and click <strong>"Calculate Bill"</strong>.</li>
            <li>Review the final summary with the guest before clicking <strong>"Confirm Booking"</strong>.</li>
        </ol>
    </div>

    <div class="help-card">
        <h3>2. System Statuses</h3>
        <ul class="step-list" style="list-style: none;">
            <li><span class="badge-info" style="background:#e8f5e9; color:#2e7d32;">PAID</span> : Guest has completed check-out and payment is processed.</li>
            <li><span class="badge-info">BOOKED</span> : Active stay. Room is occupied.</li>
            <li><span class="badge-info" style="background:#ffebee; color:#c62828;">CANCELLED</span> : Guest did not arrive or requested cancellation.</li>
        </ul>
    </div>

    <div class="help-card">
        <h3>3. FAQs & Troubleshooting</h3>
        <p><strong>Q: Why can't I see Room 102 in the list?</strong><br>
        A: A room is hidden if it has an active booking that overlaps with your selected dates. Check the <em>Registry</em> to see who is currently in that room.</p>
        
        <p><strong>Q: Can I change dates after booking?</strong><br>
        A: Currently, you must cancel the existing booking and create a new one to ensure inventory accuracy.</p>
    </div>
</div>

</body>
</html>