<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.tap.daoimplementation.RestaurantDAOImpl"%>
<%@page import="com.tap.daoimplementation.OrderItemDAOImpl"%>
<%@page import="com.tap.model.Restaurant"%>
<%@page import="com.tap.model.Order"%>
<%@page import="com.tap.model.OrderItem"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>My Orders</title>
		<link rel="stylesheet" href="main.css">
		<link rel="stylesheet" href="orderHistory.css">
	</head>
<body>
<body>
<nav class="navbar">
        <div class="logo">FoodExpress</div>
        <input type="checkbox" id="nav-toggle" class="nav-toggle">
        <label for="nav-toggle" class="nav-toggle-label">
            <span></span>
        </label>
        <div class="nav-links">
            <a href="home">Home</a>
            <a href="signin.jsp">Sign In</a>
            <a href="signout">Sign out</a>
              <a href="orderHistory">Order History</a>
        </div>
    </nav>
  <div class="container">
    <h1>Order History</h1>
    <div class="orders-grid">
    <% 
          List<Order> orders = (List<Order>) request.getAttribute("orders");
          if (orders != null && !orders.isEmpty()) {
              for (Order order : orders) {
                  int rid = order.getRestaurantId();
                  RestaurantDAOImpl rdo = new RestaurantDAOImpl();
                  Restaurant restaurant = rdo.getRestaurant(rid);

                  // Fetch order items
                  OrderItemDAOImpl oido = new OrderItemDAOImpl();
                  List<OrderItem> orderItems = oido.getOrderItemsByOrder(order.getOrderId());

                  double totalAmount = 0;
         %>
      <div class="order-card">
        <div class="order-header">
          <div class="order-info">
            <span class="info-label">Order ID</span>
            <span class="info-value">#ORD-100<%=order.getOrderId() %></span>
          </div>
          <div class="order-info">
            <span class="info-label">Restaurant</span>
            <span class="info-value"><%=restaurant.getName() %></span>
          </div>
          <div class="order-info">
            <span class="info-label">Status</span>
            <span class="status-badge status-delivered"><%=order.getStatus() %></span>
          </div>
          <div class="order-info">
            <span class="info-label">Delivery Date</span>
            <span class="info-value"><%=order.getOrderDate() %></span>
          </div>
        </div>
        <div class="order-footer">
        <form action="orderDetails.jsp">
          <button class="btn">
          <input type="hidden" name="orderId" value=<%=order.getOrderId() %>>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6"/><path d="M16 13H8"/><path d="M16 17H8"/><path d="M10 9H8"/></svg>
            Order Details
          </button>
          </form>
        </div>
      </div>
      <%  
              }
          } else {
          %>
             <h3 class="no-orders" text-align:center>No orders found.</h3>
          <% 
          }
          %>
    </div>
  </div>
</body>
</body>
</html>