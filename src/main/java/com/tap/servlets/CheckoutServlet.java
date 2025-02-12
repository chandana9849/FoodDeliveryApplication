package com.tap.servlets;

import java.io.IOException;

import com.tap.daoimplementation.OrderDAOImpl;
import com.tap.daoimplementation.OrderItemDAOImpl;
import com.tap.model.Order;
import com.tap.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet{
	public OrderDAOImpl orderDAOImpl;
	public OrderItemDAOImpl orderItemDAOImpl;
	@Override
	public void init() throws ServletException {
		orderDAOImpl = new OrderDAOImpl();
	    orderItemDAOImpl = new OrderItemDAOImpl();
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		Integer userId = (Integer)session.getAttribute("userId");
		System.out.println(userId);
		if(cart!=null&& userId!=null && !cart.getItems().isEmpty()) {
			int restaurantId=(Integer)session.getAttribute("restaurantId");
			String payment = req.getParameter("payment");
			String address=req.getParameter("streetAddress")+","+req.getParameter("city")+","+
			               req.getParameter("state")+","+req.getParameter("zipCode");
			Order order = new Order();
			order.setUserId(userId);
			order.setRestaurantId(restaurantId);
			order.setTotalAmount(cart.getTotalPrice());
			order.setPaymentMode(payment);
			order.setAddress(address);
			int orderId = orderDAOImpl.addOrder(order);
			order= orderDAOImpl.getOrder(orderId);
			if(orderId!=-1) {
				for(CartItem cartItem:cart.getItems().values()) {
					OrderItem orderItem = new OrderItem();
					orderItem.setOrderId(orderId);
					orderItem.setMenuId(cartItem.getId());
					orderItem.setQuantity(cartItem.getQuantity());
					orderItem.setTotalPrice(cartItem.getQuantity()*cartItem.getPrice());
					orderItemDAOImpl.addOrderItem(orderItem);
				}
				session.removeAttribute("cart");
				session.setAttribute("order", order);
				resp.sendRedirect("confirmation.jsp");
			}
		}
		else {
			System.out.println("cart is null");
		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

}