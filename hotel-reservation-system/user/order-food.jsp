<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Food POS | Ocean View</title>
    <style>
        :root { --orange: #e67e22; --dark: #2c3e50; --gray: #f4f7f6; --success: #27ae60; --danger: #c0392b; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--gray); display: flex; height: 100vh; margin: 0; }
        
        .selection-panel { flex: 2; padding: 25px; overflow-y: auto; border-right: 2px solid #ddd; }
        .search-container { background: white; padding: 20px; border-radius: 12px; margin-bottom: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .search-flex { display: flex; gap: 10px; }
        .search-box { flex: 1; padding: 12px; border-radius: 8px; border: 1px solid #ccc; font-size: 1rem; }
        .btn-search { background: var(--dark); color: white; border: none; padding: 0 25px; border-radius: 8px; cursor: pointer; font-weight: bold; }
        
        #searchResults { margin-top: 15px; display: none; border-top: 1px solid #eee; padding-top: 15px; }
        .result-item { padding: 10px; border: 1px solid #eee; margin-bottom: 5px; border-radius: 6px; cursor: pointer; transition: 0.2s; display: flex; justify-content: space-between; }
        .result-item:hover { background: #fff4e5; border-color: var(--orange); }

        .selection-status { background: #eafaf1; border: 1px solid var(--success); padding: 15px; border-radius: 8px; margin-bottom: 20px; display: none; align-items: center; justify-content: space-between; }
        
        .category-tabs { display: flex; gap: 10px; margin-bottom: 20px; }
        .tab { padding: 10px 20px; background: white; border-radius: 20px; cursor: pointer; border: 1px solid var(--orange); color: var(--orange); font-weight: bold; }
        .tab.active { background: var(--orange); color: white; }
        .food-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 15px; }
        .food-item { background: white; padding: 15px; border-radius: 10px; text-align: center; cursor: pointer; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }

        .cart-panel { flex: 1; background: white; padding: 25px; display: flex; flex-direction: column; }
        .cart-items { flex-grow: 1; overflow-y: auto; }
        .cart-row { display: flex; align-items: center; padding: 10px 0; border-bottom: 1px solid #f9f9f9; gap: 10px; }
        .cart-info { flex-grow: 1; display: flex; justify-content: space-between; align-items: center; }
        .btn-remove-item { color: var(--danger); background: none; border: none; cursor: pointer; font-size: 1.1rem; padding: 5px; border-radius: 4px; transition: 0.2s; }
        .btn-remove-item:hover { background: #fee2e2; }

        .total-section { padding: 20px 0; font-size: 1.5em; font-weight: bold; color: var(--dark); border-top: 2px solid #eee; }
        .btn-confirm { background: var(--success); color: white; padding: 18px; border: none; border-radius: 8px; cursor: pointer; font-size: 1.1em; font-weight: bold; width: 100%; }
        .btn-clear-cart { background: #fdfdfd; color: var(--danger); border: 1px solid var(--danger); padding: 10px; border-radius: 8px; cursor: pointer; font-weight: bold; width: 100%; margin-bottom: 10px; transition: 0.2s; }
        .btn-clear-cart:hover { background: var(--danger); color: white; }

        /* MODAL STYLING */
        .modal-overlay { 
            display: ${param.status != null ? 'flex' : 'none'}; 
            position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
            background: rgba(0,0,0,0.7); backdrop-filter: blur(5px); 
            z-index: 2000; justify-content: center; align-items: center; 
        }
        .modal-box { 
            background: white; padding: 40px; border-radius: 15px; 
            text-align: center; width: 350px; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            animation: popIn 0.3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
        }
        @keyframes popIn { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .modal-icon { font-size: 50px; margin-bottom: 15px; }
        .btn-dash { display: inline-block; margin-top: 20px; padding: 12px 25px; background: var(--dark); color: white; text-decoration: none; border-radius: 6px; font-weight: bold; }
        .modal-buttons { display: flex; gap: 10px; justify-content: center; margin-top: 20px; }
        .btn-modal-primary { background: var(--dark); color: white; border: none; padding: 12px 20px; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .btn-modal-danger { background: var(--danger); color: white; border: none; padding: 12px 20px; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .btn-modal-secondary { background: #eee; color: #333; border: none; padding: 12px 20px; border-radius: 6px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>

<div id="validationModal" class="modal-overlay">
    <div class="modal-box">
        <div id="vIcon" class="modal-icon">⚠️</div>
        <h3 id="vTitle" style="margin:0; color: var(--dark);">Attention</h3>
        <p id="vMsg" style="color: #666; margin-top:10px;"></p>
        <div class="modal-buttons" id="modalActions"></div>
    </div>
</div>

<c:if test="${not empty param.status}">
    <div class="modal-overlay" style="display: flex;">
        <div class="modal-box">
            <c:choose>
                <c:when test="${param.status == 'success'}">
                    <div class="modal-icon" style="color: var(--success);">✔</div>
                    <h3 style="margin:0; color: var(--dark);">Order Placed!</h3>
                    <p style="color: #666; margin-top:10px;">The food items have been successfully added to the room bill.</p>
                </c:when>
                <c:otherwise>
                    <div class="modal-icon" style="color: var(--danger);">✖</div>
                    <h3 style="margin:0; color: var(--dark);">System Error</h3>
                    <p style="color: #666; margin-top:10px;">Could not process the order. Please try again.</p>
                </c:otherwise>
            </c:choose>
            <div class="modal-buttons">
                <a href="FoodOrderingServlet" class="btn-dash" style="background: #eee; color: #333;">New Order</a>
                <a href="${pageContext.request.contextPath}/user/user-dashboard.jsp" class="btn-dash">Dashboard</a>
            </div>
        </div>
    </div>
</c:if>

<div class="selection-panel">
    <h2>🍽️ Food Ordering System</h2>
    <div class="search-container">
        <label style="display:block; margin-bottom:8px; font-weight:bold;">1. Find Guest</label>
        <div class="search-flex">
            <input type="text" id="guestInput" class="search-box" placeholder="Enter Name or Room Number...">
            <button type="button" class="btn-search" onclick="searchGuest()">Search</button>
        </div>
        <div id="searchResults">
            <div id="resultsList" style="margin-top:10px;"></div>
        </div>
    </div>

    <div id="selectionStatus" class="selection-status">
        <div>
            <span style="color:var(--success); font-weight:bold;">Guest:</span>
            <span id="displayGuestName" style="margin-left:10px; font-weight:600;">-</span>
            <span id="displayRoom" style="margin-left:10px; color:#666;">(Room: -)</span>
        </div>
        <button onclick="resetSelection()" style="background:none; border:1px solid #ccc; border-radius:4px; cursor:pointer;">Change</button>
    </div>

    <div class="category-tabs">
        <div class="tab active" onclick="filterCategory('All', this)">All Items</div>
        <div class="tab" onclick="filterCategory('Breakfast', this)">Breakfast</div>
        <div class="tab" onclick="filterCategory('Lunch', this)">Lunch</div>
        <div class="tab" onclick="filterCategory('Dinner', this)">Dinner</div>
    </div>

    <div class="food-grid">
        <c:forEach var="item" items="${menuItems}">
            <div class="food-item" data-category="${item.category}" onclick="addToCart('${item.itemId}', '${item.name}', ${item.price})">
                <strong>${item.name}</strong><br>
                <span style="color:var(--orange); font-weight:bold;">Rs. ${item.price}</span>
            </div>
        </c:forEach>
    </div>
</div>

<div class="cart-panel">
    <h3 style="margin-top:0; border-bottom:2px solid var(--gray); padding-bottom:10px;">Order Summary</h3>
    <div class="cart-items" id="cartList">
        <p style="color:#999; text-align:center; margin-top:50px;">No items added yet.</p>
    </div>
    <div class="total-section">
        Total: <span style="float:right;">Rs. <span id="grandTotal">0.00</span></span>
    </div>
    <button type="button" class="btn-clear-cart" onclick="confirmClearCart()">Clear Selection</button>
    <form action="FoodOrderingServlet" method="post" onsubmit="return validateOrder()">
        <div id="hiddenItems"></div>
        <input type="hidden" name="resId" id="selectedResId">
        <button type="submit" class="btn-confirm">Add to Room Bill ✓</button>
        <a href="${pageContext.request.contextPath}/user/user-dashboard.jsp" style="text-align:center; margin-top:15px; color:#666; text-decoration:none; font-size:0.9rem; display: block;">Back to Dashboard</a>
    </form>
</div>

<script>
    const allGuests = [
        <c:forEach var="res" items="${activeReservations}" varStatus="loop">
            { id: "${res.resId}", name: "${res.guestName}", rooms: "${res.rooms}" }${!loop.last ? ',' : ''}
        </c:forEach>
    ];

    let cart = [];

    function showModal(title, message, icon, buttonsHTML) {
        document.getElementById('vTitle').innerText = title;
        document.getElementById('vMsg').innerText = message;
        document.getElementById('vIcon').innerText = icon;
        document.getElementById('modalActions').innerHTML = buttonsHTML;
        document.getElementById('validationModal').style.display = 'flex';
    }

    function closeModal() { document.getElementById('validationModal').style.display = 'none'; }

    function confirmClearCart() {
        if(cart.length === 0) return;
        showModal("Clear Selection?", "Remove all items from the current order?", "🗑️", 
            `<button class="btn-modal-danger" onclick="executeClear()">Yes, Clear All</button>
             <button class="btn-modal-secondary" onclick="closeModal()">Cancel</button>`);
    }

    function executeClear() { cart = []; renderCart(); closeModal(); }

    function removeFromCart(id) {
        cart = cart.filter(item => item.id !== id);
        renderCart();
    }

    function searchGuest() {
        const query = document.getElementById('guestInput').value.toLowerCase();
        if(!query) { showModal("Input Required", "Enter a name or room number.", "⚠️", `<button class="btn-modal-primary" onclick="closeModal()">OK</button>`); return; }
        const filtered = allGuests.filter(g => g.name.toLowerCase().includes(query) || g.rooms.includes(query));
        const resultsList = document.getElementById('resultsList');
        resultsList.innerHTML = '';
        if(filtered.length > 0) {
            filtered.forEach(g => {
                resultsList.innerHTML += `<div class="result-item" onclick="selectGuest('\${g.id}', '\${g.name}', '\${g.rooms}')">
                    <span><strong>\${g.name}</strong></span><span style="color:#e67e22;">Room: \${g.rooms}</span></div>`;
            });
            document.getElementById('searchResults').style.display = 'block';
        } else { showModal("No Results", "No matching guests found.", "🔍", `<button class="btn-modal-primary" onclick="closeModal()">OK</button>`); }
    }

    function selectGuest(id, name, room) {
        document.getElementById('selectedResId').value = id;
        document.getElementById('displayGuestName').innerText = name;
        document.getElementById('displayRoom').innerText = `(Room: \${room})`;
        document.getElementById('searchResults').style.display = 'none';
        document.getElementById('selectionStatus').style.display = 'flex';
        document.querySelector('.search-container').style.display = 'none';
    }

    function resetSelection() {
        document.getElementById('selectedResId').value = '';
        document.getElementById('selectionStatus').style.display = 'none';
        document.querySelector('.search-container').style.display = 'block';
    }

    function addToCart(id, name, price) {
        let existing = cart.find(i => i.id === id);
        if(existing) { existing.qty++; } else { cart.push({id, name, price, qty: 1}); }
        renderCart();
    }

    function renderCart() {
        const list = document.getElementById('cartList');
        const hidden = document.getElementById('hiddenItems');
        let total = 0;
        list.innerHTML = ''; hidden.innerHTML = '';
        if(cart.length === 0) { list.innerHTML = '<p style="color:#999; text-align:center; margin-top:50px;">No items added yet.</p>'; }
        cart.forEach(item => {
            total += (item.price * item.qty);
            list.innerHTML += `
                <div class="cart-row">
                    <button type="button" class="btn-remove-item" onclick="removeFromCart('\${item.id}')" title="Remove Item">🗑️</button>
                    <div class="cart-info">
                        <span>\${item.name} <strong>x\${item.qty}</strong></span>
                        <span>Rs. \${(item.price * item.qty).toFixed(2)}</span>
                    </div>
                </div>`;
            hidden.innerHTML += `<input type="hidden" name="itemId" value="\${item.id}"><input type="hidden" name="quantity" value="\${item.qty}">`;
        });
        document.getElementById('grandTotal').innerText = total.toFixed(2);
    }

    function filterCategory(cat, el) {
        document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
        el.classList.add('active');
        document.querySelectorAll('.food-item').forEach(item => {
            item.style.display = (cat === 'All' || item.dataset.category === cat) ? 'block' : 'none';
        });
    }

    function validateOrder() {
        if(!document.getElementById('selectedResId').value) {
            showModal("Guest Required", "Select a guest before confirming.", "👤", `<button class="btn-modal-primary" onclick="closeModal()">OK</button>`);
            return false;
        }
        if(cart.length === 0) {
            showModal("Cart Empty", "Add items before confirming.", "🛒", `<button class="btn-modal-primary" onclick="closeModal()">OK</button>`);
            return false;
        }
        return true;
    }
</script>
</body>
</html>