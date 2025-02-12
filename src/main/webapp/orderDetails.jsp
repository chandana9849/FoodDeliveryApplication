<%@page import="com.tap.daoimplementation.RestaurantDAOImpl"%>
<%@page import="com.tap.daoimplementation.MenuDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.tap.daoimplementation.OrderItemDAOImpl"%>
<%@page import="com.tap.daoimplementation.OrderDAOImpl"%>
<%@page import="com.tap.model.Order"%>
<%@page import="com.tap.model.OrderItem"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link rel="stylesheet" href="orderDetails.css">
</head>
<body>
    <div class="container">
        <form action="orderHistory">
        <button class="back-button">← Go to Orders</button>
        </form>
        <% 
        int orderId = Integer.parseInt(request.getParameter("orderId"));
	
	    OrderDAOImpl orderDAO = new OrderDAOImpl();
	    Order order = orderDAO.getOrder(orderId);
	    RestaurantDAOImpl rdi=new RestaurantDAOImpl();
	    OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
	    List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrder(orderId);
	    %>
        <div class="order-card">
            <div class="order-header">
                <h1>Order Details</h1>
                <span class="order-id">Order ID: #ORD-2024-3856</span>
            </div>
            <% 
                if (orderItems != null && !orderItems.isEmpty()) {
                    for (OrderItem item : orderItems) {
                    	MenuDAOImpl mdi=new MenuDAOImpl();
                    	Menu menu=mdi.getMenu(item.getMenuId());
            %>
            <div class="menu-info">
                <h2>Menu Items</h2>
                <div class="menu-item">
                    <img src=<%=menu.getImagePath() %>
                         alt="Spicy Chicken Burger" 
                         class="menu-image">
                    <div class="menu-details">
                        <p class="menu-name"><%=menu.getItemName() %></p>
                        <%Restaurant restaurant=rdi.getRestaurant(menu.getRestaurantId()); %>
                        <p class="restaurant-name"><%= restaurant.getName()%></p>
                        <p class="restaurant-name"><%= menu.getPrice()%></p>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
            <div class="order-summary">
                <h2>Order Summary</h2>  
                <div class="divider"></div>
                <div class="summary-item">
                    <span>Subtotal</span>
                    <span>Rs.<%=order.getTotalAmount() %></span>
                </div>     
                <div class="summary-item">
                    <span>Delivery Fee</span>
                    <span>Rs.5.00</span>
                </div>
                <div class="divider"></div>
                <div class="summary-item total">
                    <span>Total</span>
                    <span><%=order.getTotalAmount()+5.00 %></span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>