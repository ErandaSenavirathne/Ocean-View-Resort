<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Management | Ocean View</title>
    <style>
        :root {
            --ocean-primary: #3f83f8;
            --white: #ffffff;
            --bg-light: #f4f5f7;
            --danger: #f05252;
            --dark: #1a1c23;
        }

        body { font-family: 'Inter', sans-serif; background: var(--bg-light); margin: 0; padding: 20px; }
        
        .container { max-width: 1100px; margin: 0 auto; }

        .top-nav { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        
        /* Back Button Styling */
        .btn-back { 
            text-decoration: none; color: #4b5563; font-weight: 600; 
            display: flex; align-items: center; gap: 8px; transition: 0.2s;
        }
        .btn-back:hover { color: var(--ocean-primary); }

        .header-flex { display: flex; justify-content: space-between; align-items: center; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
        
        .data-card { background: var(--white); border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: #f9fafb; padding: 15px; color: #4b5563; text-transform: uppercase; font-size: 0.75rem; border-bottom: 2px solid #edf2f7; }
        td { padding: 15px; border-top: 1px solid #e5e7eb; color: #374151; }

        .badge { padding: 4px 10px; border-radius: 12px; font-size: 0.75rem; font-weight: 600; }
        .badge-available { background: #def7ec; color: #03543f; }
        .badge-unavailable { background: #fde8e8; color: #9b1c1c; }

        .btn { padding: 10px 18px; border-radius: 8px; border: none; cursor: pointer; font-weight: 600; transition: 0.2s; font-size: 0.85rem; }
        .btn-add { background: var(--ocean-primary); color: white; }
        .btn-edit { background: #e1effe; color: #1e429f; margin-right: 5px; }
        .btn-delete { background: #fde8e8; color: #c81e1e; text-decoration: none; }

        /* Modal styling kept from previous version */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); z-index: 1000; justify-content: center; align-items: center; backdrop-filter: blur(3px); }
        .modal-content { background: white; padding: 30px; border-radius: 15px; width: 400px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #374151; }
        .form-control { width: 100%; padding: 12px; border: 1px solid #d1d5db; border-radius: 8px; }
    </style>
</head>
<body>

    <div class="container">
        <div class="top-nav">
            <a href="AdminDashboardServlet" class="btn-back">
                ← Back to Admin Dashboard
            </a>
            <div style="color: #6b7280; font-size: 0.9rem;">
                Logged in as <strong>Admin</strong>
            </div>
        </div>

        <c:if test="${param.error == 'fk_constraint'}">
            <div style="background: #fde8e8; color: #c81e1e; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #f8b4b4;">
                <strong>Cannot Delete:</strong> This item is linked to existing customer orders. Please mark it as "Sold Out" instead of deleting.
            </div>
        </c:if>

        <div class="header-flex">
            <div>
                <h2 style="margin: 0; color: var(--dark);">Restaurant Menu Management</h2>
                <p style="color: #6b7280; margin: 5px 0 0 0;">Manage food catalog, pricing, and daily availability.</p>
            </div>
            <button class="btn btn-add" onclick="openModal('add')">+ Add New Food Item</button>
        </div>

        <div class="data-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Price (Rs.)</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="food" items="${foodItems}">
                        <tr>
                            <td>#${food.item_id}</td>
                            <td><strong>${food.item_name}</strong></td>
                            <td>${food.category}</td>
                            <td>${food.price}</td>
                            <td>
                                <span class="badge ${food.is_available == '1' || food.is_available == 'true' ? 'badge-available' : 'badge-unavailable'}">
                                    ${food.is_available == '1' || food.is_available == 'true' ? 'Available' : 'Sold Out'}
                                </span>
                            </td>
                            <td>
                                <button class="btn btn-edit" onclick="editFood('${food.item_id}', '${food.item_name}', '${food.price}', '${food.category}', '${food.is_available}')">Edit</button>
                                <a href="AdminManageFoodServlet?action=delete&id=${food.item_id}" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div id="foodModal" class="modal">
        <div class="modal-content">
            <h3 id="modalTitle" style="margin-top:0;">Add Food Item</h3>
            <form action="AdminManageFoodServlet" method="post">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="itemId" id="itemId">
                
                <div class="form-group">
                    <label>Item Name</label>
                    <input type="text" name="itemName" id="itemName" class="form-control" placeholder="e.g. Club Sandwich" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" id="category" class="form-control">
                        <option value="Breakfast">Breakfast</option>
                        <option value="Lunch">Lunch</option>
                        <option value="Dinner">Dinner</option>
                        <option value="Beverages">Beverages</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (Rs.)</label>
                    <input type="number" step="0.01" name="price" id="price" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Menu Status</label>
                    <select name="available" id="available" class="form-control">
                        <option value="true">Available</option>
                        <option value="false">Sold Out (Hide)</option>
                    </select>
                </div>
                
                <div style="display: flex; gap: 10px; margin-top: 25px;">
                    <button type="submit" class="btn btn-add" style="flex: 2;">Save Item</button>
                    <button type="button" class="btn" style="flex: 1; background: #f3f4f6;" onclick="closeModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal(mode) {
            document.getElementById('foodModal').style.display = 'flex';
            document.getElementById('formAction').value = mode;
            if(mode === 'add') {
                document.getElementById('modalTitle').innerText = 'Add New Food';
                document.getElementById('itemName').value = '';
                document.getElementById('price').value = '';
            }
        }
        function closeModal() { document.getElementById('foodModal').style.display = 'none'; }
        
        function editFood(id, name, price, cat, avail) {
            openModal('edit');
            document.getElementById('modalTitle').innerText = 'Edit Food Item';
            document.getElementById('itemId').value = id;
            document.getElementById('itemName').value = name;
            document.getElementById('price').value = price;
            document.getElementById('category').value = cat;
            document.getElementById('available').value = avail;
        }
    </script>
</body>
</html>