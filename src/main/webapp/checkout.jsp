<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.servlets.Cart"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Page</title>
    <link rel="stylesheet" href="checkout.css">
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
        <a href="orderHistory">Order History</a>
        <a href="signout">Sign Out</a>
        <a href="cart.jsp" class="cart-icon">
            <i class="fas fa-shopping-cart"></i>
        </a>
    </div>
  </nav>

  <div class="container">
      <div class="header">
          <h1>Checkout</h1>
          <p>Complete your order</p>
      </div>

      <div class="progress-bar">
          <!-- Add progress bar elements if needed -->
      </div>

      <form action="checkout">
          <div class="main-content">
              <div class="left-column">
                  <!-- Delivery Address Section -->
                  <div class="card">
                      <div class="section-header">
                          <h2>Delivery Address</h2>
                      </div>
                      <div class="form-grid form-grid-2">
                          <div class="form-group">
                              <label class="form-label">First Name</label>
                              <input type="text" class="form-input" name="firstName">
                          </div>
                          <div class="form-group">
                              <label class="form-label">Last Name</label>
                              <input type="text" class="form-input" name="lastName">
                          </div>
                      </div>
                      <div class="form-group">
                          <label class="form-label">Street Address</label>
                          <input type="text" class="form-input" name="streetAddress">
                      </div>
                      <div class="form-grid form-grid-3">
                          <div class="form-group">
                              <label class="form-label">City</label>
                              <input type="text" class="form-input" name="city">
                          </div>
                          <div class="form-group">
                              <label class="form-label">State</label>
                              <input type="text" class="form-input" name="state">
                          </div>
                          <div class="form-group">
                              <label class="form-label">ZIP Code</label>
                              <input type="text" class="form-input" name="zipCode">
                          </div>
                      </div>
                  </div>

                  <!-- Payment Section -->
                  <div class="card">
                      <div class="section-header">
                          <h2>Payment Method</h2>
                      </div>
                      <div class="payment-option">
                          <label>
                              <input type="radio" name="payment" value="card" checked>
                              <span>Card - Pay with card</span>
                          </label>
                      </div>
                      <div class="payment-option">
                          <label>
                              <input type="radio" name="payment" value="UPI">
                              <span>UPI - Pay with your UPI</span>
                          </label>
                      </div>
                      <div class="payment-option">
                          <label>
                              <input type="radio" name="payment" value="COD">
                              <span>Cash On Delivery - Pay by cash</span>
                          </label>
                      </div>
                  </div>
              </div>

              <!-- Order Summary -->
              <% Cart cart = (Cart) session.getAttribute("cart"); %>
              <div class="right-column">
                  <div class="card">
                      <h2 class="section-header">Order Summary</h2>
                      <div class="summary-item">
                          <span>Subtotal</span>
                          <span>Rs. <%= (double) cart.getTotalPrice() %></span>
                      </div>
                      <div class="summary-item">
                          <span>Shipping</span>
                          <span>Rs. 5.00</span>
                      </div>
                      <div class="summary-item summary-total">
                          <span>Total</span>
                          <span>Rs. <%= (double) cart.getTotalPrice()+5.00%></span>
                      </div>
                      <button type="submit" class="place-order-btn">Place Order</button>
                  </div>
              </div>
          </div>
      </form>
  </div>
</body>
</html>
