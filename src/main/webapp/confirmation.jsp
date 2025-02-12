<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.tap.daoimplementation.OrderItemDAOImpl"%>
<%@page import="com.tap.daoimplementation.RestaurantDAOImpl"%>
<%@page import="com.tap.dao.RestaurantDAO"%>
 <%@page import="com.tap.model.Order"%>
 <%@page import="com.tap.model.Restaurant"%>
 <%@ page import="java.util.List" %>
 <%@page import="com.tap.model.OrderItem"%>
 <%@page import="com.tap.daoimplementation.MenuDAOImpl"%>
 <%@ page import="com.tap.model.Menu"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - Food Delivery</title>
    <link rel="stylesheet" href="confirmation.css">
    <link rel="stylesheet" href="main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <nav class="navbar">
    <div class="logo">FoodExpress</div>
    <input type="checkbox" id="nav-toggle" class="nav-toggle">
    <label for="nav-toggle" class="nav-toggle-label">
        <span></span>
    </label>
    <div class="nav-links">
        <a href="home">Home</a>
        <a href="orderHistory">My Orders</a>
        <a href="cart.jsp" class="cart-icon">
            <i class="fas fa-shopping-cart"></i>
        </a>
    </div>
  </nav>
    <%Order order=(Order)session.getAttribute("order");
      int restaurantId=(Integer)session.getAttribute("restaurantId"); 
      RestaurantDAOImpl rdao=new RestaurantDAOImpl();
      Restaurant restaurant=rdao.getRestaurant(restaurantId);
    %>
    
    <div class="container">
        <div class="confirmation-card">
            <!-- Success Icon -->
            <div class="success-icon">✓</div>
            
            <!-- Order Status -->
            <h1>Order Confirmed!</h1>
            <p class="order-id">Order ID:#ORD-100<%=order.getOrderId() %></p>
            
            <!-- Estimated Time -->
            <div class="delivery-time">
                <h2>Estimated Delivery Time</h2>
                <p><%=restaurant.getEta() %> mins</p>
            </div>

            <!-- Order Details -->
            <div class="order-details">
                <h2>Order Details</h2>
                <div class="detail-row">
                    <span>Delivery Address:</span>
                    <p><%=order.getAddress() %></p>
                </div>
                <div class="detail-row">
                    <span>Payment Method:</span>
                    <p><%=order.getPaymentMode() %></p>
                </div>
                <div class="detail-row">
                    <span>Order Amount:</span>
                    <p><%= String.format("%.2f", order.getTotalAmount() + 5.0) %></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>