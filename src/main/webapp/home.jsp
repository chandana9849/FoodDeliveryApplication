<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
    <%@ page import="com.tap.model.Restaurant"%>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodExpress - Restaurants</title>
    <link rel="stylesheet" href="main.css">
    <link rel="stylesheet" href="restaurant.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            <a href="signin.jsp">Sign In</a>
             <a href="signout">Sign out</a>
              <a href="orderHistory">Order History</a>
            <a href="cart.jsp" class="cart-icon">
                <i class="fas fa-shopping-cart"></i>
            </a>
        </div>
    </nav>
    <main class="restaurants-container">
    <h1>Featured Restaurants</h1>
        <div class="restaurant-grid">
        
        <%
        List<Restaurant> restaurants=(List<Restaurant>)request.getAttribute("allRestaurants");
            for(Restaurant r:restaurants)
            {
            	
        %>
            <div class="restaurant-card">
                <div class="restaurant-image">
                    <img src=<%=r.getImagePath() %>alt="Pizza Paradise">
                </div>
                <div class="restaurant-info">
                    <h2><%=r.getName() %></h2>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <span><%=r.getRating() %></span><br>
                        <span><%=r.getEta() %> mins</span>
                    </div>
                    <p><%=r.getCusinType() %></p>
                    <a href="menu?restaurantId=<%=r.getRestaurantId()%>" class="view-menu-btn">View Menu</a>
                </div>
            </div>
            <%
            }
            %>
            
            </div>
    </main>



    <footer>
        <p>&copy; 2024 FoodExpress. All rights reserved.</p>
    </footer>
</body>
</html>