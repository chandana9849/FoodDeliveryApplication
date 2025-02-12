package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.sql.Statement;
import com.tap.dao.OrderDAO;
import com.tap.model.Order;
import com.tap.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO{
	private static final String INSERT_ORDER_QUERY="INSERT INTO orders(userId,restaurantId,totalAmount,paymentMode,Address)VALUES(?,?,?,?,?)";
	private static final String GET_ORDER_QUERY="SELECT * FROM orders WHERE orderId=?";
	//private static final String GET_ORDER_BY_USER_ID="SELECT * FROM orders WHERE userId=?";
	private static final String UPDATE_ORDER_QUERY="UPDATE orders SET userId=?,restaurantId=? ,totalAmount=?, status=?, paymentMode=?, Where orderId=?";
	private static final String DELETE_ORDER_QUERY="DELETE FROM orders WHERE orderId=?";
	private static final String GET_ALL_ORDERS="SELECT * FROM orders WHERE userId=?";
   public static Order order;
	@Override
	public int addOrder(Order order) {
		int orderId=-1;
		try(Connection connection=DBConnection.getConnection();
			PreparedStatement preparestatement=connection.prepareStatement(INSERT_ORDER_QUERY,Statement.RETURN_GENERATED_KEYS)) {
			preparestatement.setInt(1, order.getUserId());
			preparestatement.setInt(2, order.getRestaurantId());
			preparestatement.setDouble(3, order.getTotalAmount());
			preparestatement.setString(4, order.getPaymentMode());
			preparestatement.setString(5, order.getAddress());
			preparestatement.executeUpdate();
			ResultSet generatedKeys = preparestatement.getGeneratedKeys();
			if(generatedKeys.next()) {
				orderId = generatedKeys.getInt(1);
			}
			System.out.println("Generated orderId: " + orderId);
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return orderId;
		
	}

	@Override
	public Order getOrder(int orderId) {
		try(Connection connection=DBConnection.getConnection();
			PreparedStatement preparestatement=connection.prepareStatement(GET_ORDER_QUERY)) {
			preparestatement.setInt(1, orderId);
			ResultSet res=preparestatement.executeQuery();
			res.next();
		    order=extractOrder(res);
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return order;
	}
	@Override
	public void updateOrder(Order order) {
		try(Connection connection=DBConnection.getConnection();
			PreparedStatement preparestatement=connection.prepareStatement(UPDATE_ORDER_QUERY)) {
			preparestatement.setInt(1, order.getUserId());
			preparestatement.setInt(2, order.getRestaurantId());
			preparestatement.setDouble(3, order.getTotalAmount());
			preparestatement.setString(4, order.getStatus());
			preparestatement.setString(5, order.getPaymentMode());
			preparestatement.setInt(6, order.getOrderId());
			preparestatement.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrder(int orderId) {
		try(Connection connection=DBConnection.getConnection();
			PreparedStatement preparestatement=connection.prepareStatement(DELETE_ORDER_QUERY)) {
			preparestatement.setInt(1, orderId);
			preparestatement.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Order> getAllOrdersByUser(int userId) {
		ArrayList<Order> orderList=new ArrayList<Order>();
		try(Connection connection=DBConnection.getConnection();
			PreparedStatement preparestatement=connection.prepareStatement(GET_ALL_ORDERS)) {
			preparestatement.setInt(1, userId);
			ResultSet res=preparestatement.executeQuery();
			while(res.next()) {
				order=extractOrder(res);
				orderList.add(order);
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return orderList;
	}
	   Order extractOrder(ResultSet res) throws SQLException{
		int orderId=res.getInt("OrderId");
		int userId=res.getInt("userId");
		int restaurantId=res.getInt("restaurantId");
		Date orderDate = res.getDate("orderDate");
		double totalAmount=res.getDouble("totalAmount");
		String status=res.getString("status");
		String paymentMode=res.getString("PaymentMode");
		String address=res.getString("address");
		Order order=new Order(userId, restaurantId, orderDate, totalAmount, status, paymentMode, address);
		order.setOrderId(orderId);
		return order;

	}

}