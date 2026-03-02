<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Help Center - Ocean View</title>
    <style>
        :root {
            --ocean: #2980b9;
            --ocean-dark: #1a6fa3;
            --ocean-pale: #ebf5fb;
            --dark: #2c3e50;
            --success: #27ae60;
            --danger: #c0392b;
            --gold: #f39c12;
            --gray: #7f8c8d;
            --border: #e2e8f0;
            --bg: #f4f7f6;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            color: var(--dark);
            background:
                linear-gradient(rgba(255,255,255,0.25), rgba(255,255,255,0.35)),
                url('${pageContext.request.contextPath}/images/resort-bg.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        /* ── TOP NAV BAR ── */
        .topbar {
            background: var(--dark);
            padding: 14px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        .topbar-brand {
            font-weight: 700;
            font-size: 1.1em;
            color: white;
            letter-spacing: 1px;
        }
        .topbar-brand span { font-weight: 300; }
        .btn-back {
            text-decoration: none;
            background: white;
            color: #334155;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.85rem;
            border: 1px solid var(--border);
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-back:hover {
            background: #f1f5f9;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }

        /* ── PAGE HEADER ── */
        .page-header {
            background: linear-gradient(135deg, var(--dark) 0%, #34495e 60%, var(--ocean-dark) 100%);
            padding: 40px 32px 36px;
            text-align: center;
        }
        .page-header h1 {
            color: white;
            font-size: 2em;
            margin-bottom: 8px;
        }
        .page-header p { color: rgba(255,255,255,0.6); font-size: 0.95em; }

        /* ── TAB BAR ── */
        .tab-bar {
            background: white;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: center;
            gap: 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }
        .tab-btn {
            padding: 14px 26px;
            font-size: 0.85em;
            font-weight: 600;
            color: var(--gray);
            cursor: pointer;
            border: none;
            background: transparent;
            border-bottom: 3px solid transparent;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 7px;
        }
        .tab-btn:hover { color: var(--ocean); background: var(--ocean-pale); }
        .tab-btn.active {
            color: var(--ocean);
            border-bottom-color: var(--ocean);
            background: #f0f8ff;
        }

        /* ── MAIN CONTENT ── */
        .main { max-width: 960px; margin: 0 auto; padding: 36px 24px 60px; }

        .tab-panel { display: none; }
        .tab-panel.active { display: block; }

        /* ── SECTION TITLE ── */
        .section-title {
            font-size: 1.25em;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--ocean-pale);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* ── TUTORIAL CARDS GRID ── */
        .tutorial-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
            gap: 18px;
            margin-bottom: 36px;
        }
        .tutorial-card {
            background: white;
            border-radius: 14px;
            padding: 24px;
            border: 1.5px solid var(--border);
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: all 0.25s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .tutorial-card:hover {
            transform: translateY(-4px);
            border-color: var(--ocean);
            box-shadow: 0 8px 24px rgba(41,128,185,0.15);
        }
        .tc-icon {
            width: 46px; height: 46px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4em;
        }
        .tc-icon.blue  { background: #e3f2fd; }
        .tc-icon.green { background: #e8f5e9; }
        .tc-icon.gold  { background: #fff8e1; }
        .tc-icon.red   { background: #fdecea; }
        .tc-icon.purple{ background: #f3e5f5; }
        .tc-icon.teal  { background: #e0f2f1; }

        .tc-title { font-weight: 700; font-size: 0.95em; color: var(--dark); }
        .tc-desc  { font-size: 0.82em; color: var(--gray); line-height: 1.5; flex: 1; }
        .tc-tag {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.72em;
            font-weight: 600;
            padding: 3px 10px;
            border-radius: 20px;
            align-self: flex-start;
        }
        .tc-tag.beginner { background: #e8f5e9; color: #2e7d32; }
        .tc-tag.staff    { background: #e3f2fd; color: #1565c0; }
        .tc-tag.advanced { background: #fff3e0; color: #e65100; }
        .tc-arrow {
            font-size: 0.8em;
            color: var(--ocean);
            font-weight: 600;
            margin-top: 4px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* ── HELP CARDS (original style, enhanced) ── */
        .help-card {
            background: white;
            padding: 26px 28px;
            border-radius: 12px;
            margin-bottom: 18px;
            border-left: 5px solid var(--ocean);
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
        .help-card h3 {
            margin-top: 0;
            margin-bottom: 14px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1em;
        }
        .step-list {
            padding-left: 20px;
            line-height: 1.7;
            color: #555;
            font-size: 0.9em;
        }
        .step-list li { margin-bottom: 8px; }
        .badge-info {
            background: #e3f2fd;
            color: #1976d2;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.8em;
            font-weight: bold;
        }

        /* ── TEMPLATE CARDS ── */
        .template-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }
        .template-card {
            background: white;
            border-radius: 12px;
            border: 1.5px solid var(--border);
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: all 0.2s;
        }
        .template-card:hover {
            border-color: var(--ocean);
            box-shadow: 0 6px 20px rgba(41,128,185,0.12);
        }
        .tc-header {
            padding: 16px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid var(--border);
        }
        .tc-header-icon {
            font-size: 1.3em;
            width: 38px; height: 38px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
        }
        .tc-header-title { font-weight: 700; font-size: 0.9em; color: var(--dark); }
        .tc-header-sub   { font-size: 0.75em; color: var(--gray); margin-top: 2px; }
        .tc-body { padding: 16px 20px; }
        .tc-preview {
            background: #f8fafc;
            border-radius: 8px;
            padding: 12px 14px;
            font-size: 0.78em;
            color: #555;
            line-height: 1.7;
            border: 1px solid #eef2f7;
            margin-bottom: 14px;
            font-family: monospace;
            white-space: pre-wrap;
        }
        .tc-actions { display: flex; gap: 8px; }
        .tc-btn {
            flex: 1;
            padding: 8px;
            border-radius: 7px;
            font-size: 0.78em;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        .tc-btn.primary { background: var(--ocean); color: white; }
        .tc-btn.primary:hover { background: var(--ocean-dark); }
        .tc-btn.outline { background: white; color: var(--ocean); border: 1px solid var(--ocean); }
        .tc-btn.outline:hover { background: var(--ocean-pale); }
        .tc-btn.success { background: var(--success); color: white; }
        .tc-btn.success:hover { background: #219a52; }
        .copied-toast {
            display: none;
            background: var(--success);
            color: white;
            font-size: 0.75em;
            padding: 4px 12px;
            border-radius: 20px;
            margin-left: auto;
            font-weight: 600;
        }
        .copied-toast.show { display: inline-block; }

        /* ── QUICK REF TABLE ── */
        .ref-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.88em;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .ref-table th {
            background: var(--dark);
            color: white;
            padding: 12px 16px;
            text-align: left;
            font-size: 0.82em;
            letter-spacing: 0.5px;
        }
        .ref-table td { padding: 12px 16px; border-bottom: 1px solid #f0f4f8; color: #444; }
        .ref-table tr:last-child td { border-bottom: none; }
        .ref-table tr:hover td { background: #f8fbfe; }
        .status-dot {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-weight: 600;
        }
        .dot { width: 9px; height: 9px; border-radius: 50%; display: inline-block; }
        .dot.green  { background: var(--success); }
        .dot.blue   { background: var(--ocean); }
        .dot.red    { background: var(--danger); }
        .dot.gold   { background: var(--gold); }

        /* ── FAQ ACCORDION ── */
        .faq-item {
            background: white;
            border-radius: 10px;
            border: 1px solid var(--border);
            margin-bottom: 10px;
            overflow: hidden;
        }
        .faq-question {
            padding: 16px 20px;
            font-weight: 600;
            font-size: 0.9em;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--dark);
            user-select: none;
            transition: background 0.15s;
        }
        .faq-question:hover { background: var(--ocean-pale); }
        .faq-question.open { color: var(--ocean); background: var(--ocean-pale); }
        .faq-chevron { transition: transform 0.25s; font-size: 0.8em; color: var(--gray); }
        .faq-question.open .faq-chevron { transform: rotate(180deg); color: var(--ocean); }
        .faq-answer {
            display: none;
            padding: 0 20px 16px;
            font-size: 0.87em;
            color: #555;
            line-height: 1.7;
            border-top: 1px solid var(--border);
        }
        .faq-answer.open { display: block; }

        @media (max-width: 640px) {
            .tutorial-grid, .template-grid { grid-template-columns: 1fr; }
            .tab-btn { padding: 12px 14px; font-size: 0.78em; }
            .page-header h1 { font-size: 1.5em; }
        }
    </style>
</head>
<body>

<!-- ══ TOP BAR ══ -->
<div class="topbar">
    <div class="topbar-brand">OCEAN VIEW <span>RESORT</span></div>
    <a href="${pageContext.request.contextPath}/user/user-dashboard.jsp" class="btn-back">
        <span>←</span> Back to Dashboard
    </a>
</div>

<!-- ══ PAGE HEADER ══ -->
<div class="page-header">
    <h1>💡 Staff Help Center</h1>
    <p>Tutorials, guidelines, templates and quick references for all staff members.</p>
</div>

<!-- ══ TAB BAR ══ -->
<div class="tab-bar">
    <button class="tab-btn active" onclick="switchTab('tutorials', this)">📘 Tutorials</button>
    <button class="tab-btn" onclick="switchTab('guidelines', this)">📋 Guidelines</button>

    <button class="tab-btn" onclick="switchTab('reference', this)">🔍 Quick Reference</button>
    <button class="tab-btn" onclick="switchTab('faq', this)">❓ FAQ</button>
</div>

<div class="main">

    <!-- ════════════════════════════════ -->
    <!-- TAB 1: TUTORIALS                 -->
    <!-- ════════════════════════════════ -->
    <div id="tab-tutorials" class="tab-panel active">

        <div class="section-title">📘 Step-by-Step Tutorials</div>

        <div class="tutorial-grid">

            <!-- MAIN TUTORIAL — links to the created tutorial file -->
            <a href="${pageContext.request.contextPath}/user/tutorial-reservation.html" class="tutorial-card" style="border-color: var(--ocean); background: linear-gradient(135deg, #f0f8ff, white);">
                <div class="tc-icon blue">🏨</div>
                <div class="tc-title">Register Guest & Room Reservation</div>
                <div class="tc-desc">Complete walkthrough: register a new guest, search by NIC, select dates, pick rooms, and confirm the booking.</div>
                <div class="tc-tag staff">⭐ Full Tutorial</div>
                <div class="tc-arrow">Open Tutorial →</div>
            </a>

          

            <a href="${pageContext.request.contextPath}/user/tutorial-checkout.html" class="tutorial-card">
                <div class="tc-icon gold">💳</div>
                <div class="tc-title">Check-Out & Payment</div>
                <div class="tc-desc">Process a guest departure, finalize the room bill including any food orders, and mark the room as available.</div>
                <div class="tc-tag staff">Staff</div>
                <div class="tc-arrow">Open Tutorial →</div>
            </a>

            <a href="${pageContext.request.contextPath}/user/tutorial-food.html" class="tutorial-card">
                <div class="tc-icon teal">🍽️</div>
                <div class="tc-title">Food Ordering for Guests</div>
                <div class="tc-desc">How to place meal orders for guests, add items to their room bill, and track order status.</div>
                <div class="tc-tag beginner">Beginner</div>
                <div class="tc-arrow">Open Tutorial →</div>
            </a>

            <a href="${pageContext.request.contextPath}/user/tutorial-roomstatus.html" class="tutorial-card">
                <div class="tc-icon purple">📋</div>
                <div class="tc-title">Room Status & Occupancy</div>
                <div class="tc-desc">Reading the live room status board, understanding occupancy indicators, and identifying available rooms.</div>
                <div class="tc-tag beginner">Beginner</div>
                <div class="tc-arrow">Open Tutorial →</div>
            </a>

            

        </div>
    </div>

    <!-- ════════════════════════════════ -->
    <!-- TAB 2: GUIDELINES                -->
    <!-- ════════════════════════════════ -->
    <div id="tab-guidelines" class="tab-panel">

        <div class="section-title">📋 Staff Guidelines</div>

        <div class="help-card">
            <h3>🔑 1. New Reservations</h3>
            <ol class="step-list">
                <li>Go to <strong>Guest Search</strong> and enter the NIC or Passport number.</li>
                <li>If the guest is new, register them first. If existing, the system will auto-load their profile.</li>
                <li>Select <strong>Check-in</strong> and <strong>Check-out</strong> dates. The system automatically hides rooms that are already occupied for those dates.</li>
                <li>Choose one or more rooms from the available inventory list and click <strong>"Calculate Bill"</strong>.</li>
                <li>Review the final summary — including any automatic discounts — with the guest before clicking <strong>"Confirm Booking"</strong>.</li>
            </ol>
        </div>

        <div class="help-card" style="border-left-color: var(--success);">
            <h3>✅ 2. Discount Policy</h3>
            <ul class="step-list">
                <li><strong>Long Stay Discount:</strong> Automatically applied for stays of 5 or more nights.</li>
                <li><strong>Multi-Room Discount:</strong> Applied when 2 or more rooms are booked in the same reservation.</li>
                <li>Discounts are calculated automatically on the billing summary screen — staff do not need to apply them manually.</li>
            </ul>
        </div>

        <div class="help-card" style="border-left-color: var(--gold);">
            <h3>⚠️ 3. System Booking Statuses</h3>
            <ul class="step-list" style="list-style: none; padding-left: 0;">
                <li style="margin-bottom:10px;"><span class="badge-info" style="background:#e8f5e9; color:#2e7d32;">PAID</span> — Guest has completed check-out and payment is processed. Room is now available.</li>
                <li style="margin-bottom:10px;"><span class="badge-info">BOOKED</span> — Active stay. Room is currently occupied by a guest.</li>
                <li><span class="badge-info" style="background:#ffebee; color:#c62828;">CANCELLED</span> — Guest did not arrive or requested cancellation. Room is released.</li>
            </ul>
        </div>

        <div class="help-card" style="border-left-color: var(--danger);">
            <h3>🚫 4. Important Restrictions</h3>
            <ul class="step-list">
                <li>Do <strong>not</strong> create a reservation without first verifying the guest's NIC in the system.</li>
                <li>Never manually alter the room status — always use the Check-Out module to release rooms.</li>
                <li>Do not use shared login credentials. Each staff member should use their own account.</li>
                <li>If a system error occurs during booking, refresh and retry — do not submit the form twice.</li>
            </ul>
        </div>
    </div>

    
    <!-- ════════════════════════════════ -->
    <!-- TAB 4: QUICK REFERENCE          -->
    <!-- ════════════════════════════════ -->
    <div id="tab-reference" class="tab-panel">

        <div class="section-title">🔍 Quick Reference</div>

        <p style="color:var(--gray);font-size:0.88em;margin-bottom:20px;">Fast lookup for statuses, shortcuts, and common actions.</p>

        <div style="margin-bottom:10px;font-weight:700;color:var(--dark);font-size:0.9em;">Booking Statuses</div>
        <table class="ref-table">
            <thead><tr><th>Status</th><th>Meaning</th><th>Room State</th><th>Action Required</th></tr></thead>
            <tbody>
                <tr>
                    <td><span class="status-dot"><span class="dot blue"></span> BOOKED</span></td>
                    <td>Guest is currently staying</td>
                    <td>Occupied</td>
                    <td>Process check-out when guest leaves</td>
                </tr>
                <tr>
                    <td><span class="status-dot"><span class="dot green"></span> PAID</span></td>
                    <td>Check-out completed & bill paid</td>
                    <td>Available</td>
                    <td>No action — room ready for next booking</td>
                </tr>
                <tr>
                    <td><span class="status-dot"><span class="dot red"></span> CANCELLED</span></td>
                    <td>Booking was cancelled</td>
                    <td>Available</td>
                    <td>Room released — can be rebooked</td>
                </tr>
                <tr>
                    <td><span class="status-dot"><span class="dot gold"></span> PENDING</span></td>
                    <td>Reservation made, not checked in yet</td>
                    <td>Reserved</td>
                    <td>Confirm on check-in day</td>
                </tr>
            </tbody>
        </table>

        <div style="margin-bottom:10px;margin-top:28px;font-weight:700;color:var(--dark);font-size:0.9em;">Room Types & Rates</div>
        <table class="ref-table">
            <thead><tr><th>Room Type</th><th>Capacity</th><th>Base Rate / Night</th><th>Features</th></tr></thead>
            <tbody>
                <tr><td><strong>Standard</strong></td><td>1–2 guests</td><td>Rs. 4,500 – 6,000</td><td>AC, TV, En-suite bathroom</td></tr>
                <tr><td><strong>Deluxe</strong></td><td>2 guests</td><td>Rs. 7,500 – 9,500</td><td>Ocean view, AC, TV, Mini-bar</td></tr>
                <tr><td><strong>Suite</strong></td><td>2–4 guests</td><td>Rs. 12,000 – 16,000</td><td>Living area, Jacuzzi, Butler service</td></tr>
            </tbody>
        </table>

        <div style="margin-bottom:10px;margin-top:28px;font-weight:700;color:var(--dark);font-size:0.9em;">Automatic Discounts</div>
        <table class="ref-table">
            <thead><tr><th>Discount Type</th><th>Trigger</th><th>Rate</th></tr></thead>
            <tbody>
                <tr><td>🌙 Long Stay</td><td>Stay of 5 or more nights</td><td>10% off total</td></tr>
                <tr><td>🏠 Multi-Room</td><td>2 or more rooms booked together</td><td>5% off total</td></tr>
                <tr><td>🎯 Combined</td><td>Both conditions met</td><td>15% off total</td></tr>
            </tbody>
        </table>

        <div style="margin-bottom:10px;margin-top:28px;font-weight:700;color:var(--dark);font-size:0.9em;">Dashboard Menu — At a Glance</div>
        <table class="ref-table">
            <thead><tr><th>Card</th><th>Function</th><th>When to Use</th></tr></thead>
            <tbody>
                <tr><td>👤 Register Guest</td><td>Add a new guest profile</td><td>First-time guests only</td></tr>
                <tr><td>🔑 New Reservation</td><td>Start the booking wizard</td><td>Any time a guest wants to book</td></tr>
                <tr><td>📋 Room Status</td><td>Live occupancy view</td><td>Check room availability before booking</td></tr>
                <tr><td>🚪 Process Check-Out</td><td>Finalize guest departure</td><td>When guest is leaving</td></tr>
                <tr><td>📅 View Bookings</td><td>Full reservations list</td><td>Searching/filtering past & current bookings</td></tr>
                <tr><td>🍽️ Food Ordering</td><td>Order meals for guests</td><td>Guest places a room service order</td></tr>
            </tbody>
        </table>
    </div>

    <!-- ════════════════════════════════ -->
    <!-- TAB 5: FAQ                       -->
    <!-- ════════════════════════════════ -->
    <div id="tab-faq" class="tab-panel">

        <div class="section-title">❓ Frequently Asked Questions</div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                Why can't I see Room 102 in the available list?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                A room is hidden from the list if it has an active booking that overlaps with your selected check-in and check-out dates. Use the <strong>📋 Room Status</strong> card on the dashboard to see who is currently occupying that room and when they are checking out.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                Can I change dates after a booking is confirmed?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                Currently, the system does not support direct date editing after confirmation. You must cancel the existing booking via <strong>📅 View Bookings</strong> and then create a new reservation with the correct dates. This ensures room inventory accuracy is maintained.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                The guest's NIC search shows "Not Found" — what do I do?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                This means the guest has not been registered in the system yet. A popup will offer you the option to <strong>Register New Guest</strong>. Click it, fill in their details, then return to the dashboard and start a new reservation using <strong>🔑 New Reservation</strong>.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                Why wasn't the long-stay discount applied?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                The long-stay discount requires a minimum of <strong>5 nights</strong>. Make sure the check-out date is at least 5 days after the check-in date. If the stay is exactly 4 nights, no discount applies. The discount is shown automatically on the billing summary page when the condition is met.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                I accidentally submitted the booking form twice — what happens?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                If a duplicate booking was created, go to <strong>📅 View Bookings</strong>, locate the duplicate entry, and cancel it. The system will release the room back to available status. If you cannot identify the duplicate, contact your system administrator.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                How do I add food charges to a guest's existing bill?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                Go to <strong>🍽️ Food Ordering</strong> on the dashboard. Search for the guest's active booking, select the items they ordered, and confirm. The charges will automatically be added to their room bill and reflected in the final total at check-out.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                Can I book multiple rooms for the same guest in one reservation?
                <span class="faq-chevron">▼</span>
            </div>
            <div class="faq-answer">
                Yes! On the <strong>Pick Rooms</strong> step (Step 2) of the booking wizard, you can tick multiple checkboxes to select more than one room. All selected rooms will be included in the same reservation, and the multi-room discount will be applied automatically if 2 or more rooms are chosen.
            </div>
        </div>

    </div>

</div><!-- /main -->

<script>
    function switchTab(id, btn) {
        document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        document.getElementById('tab-' + id).classList.add('active');
        btn.classList.add('active');
    }

    function toggleFaq(el) {
        const answer = el.nextElementSibling;
        const isOpen = el.classList.contains('open');
        // close all
        document.querySelectorAll('.faq-question').forEach(q => q.classList.remove('open'));
        document.querySelectorAll('.faq-answer').forEach(a => a.classList.remove('open'));
        if (!isOpen) {
            el.classList.add('open');
            answer.classList.add('open');
        }
    }

    function copyTemplate(id, btn) {
        const text = document.getElementById(id).innerText;
        navigator.clipboard.writeText(text).then(() => {
            const toast = document.getElementById('toast-' + id);
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 2000);
        });
    }

    function printTemplate(id) {
        const content = document.getElementById(id).innerText;
        const win = window.open('', '_blank');
        win.document.write('<pre style="font-family:monospace;font-size:14px;padding:30px;">' + content + '</pre>');
        win.document.close();
        win.print();
    }
</script>
</body>
</html>
