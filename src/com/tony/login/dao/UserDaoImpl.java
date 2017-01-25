package com.tony.login.dao;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.sql.DataSource;

import com.tony.login.model.User;

import java.sql.*;

public class UserDaoImpl implements UserDao {
	private static final String DELETE = "DELETE FROM accounts WHERE Id=?";
	private static final String FIND_ALL = "SELECT * FROM accounts ORDER BY Id";
	private static final String INSERT = "INSERT INTO accounts(Username, Password, Email) VALUES(?, ?, ?)";
	private static final String LOGIN = "SELECT * FROM accounts WHERE Username=? and Password = ?";
	private static final String FIND = "SELECT * FROM accounts WHERE Username=?";
	private static final String UPDATE = "UPDATE accounts SET ";
	private static final String UPDATE2 = "= ? WHERE Username = ?";
	private static final String GET_ADDRESS = "SELECT Address FROM accounts WHERE Username = ?";
	DataSource ds;
	final Logger log = LogManager.getLogger(UserDaoImpl.class.getName());
	public UserDaoImpl(){
		Context initCtx;
		try {
			initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			ds = (DataSource) envCtx.lookup("jdbc/shop");
		} catch (Exception e) {
			log.error("error occured: " + e);
		}
		
	}
	 
	@Override
	public void delete(int x) {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = connect();
			stmt = conn.prepareStatement(DELETE);
			stmt.setInt(1, x);
			stmt.executeUpdate();
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt + " statement: " + stmt);
		} finally {
			disconnect(stmt);
			disconnect(conn);
		}
	}



	@Override
	public boolean insert(User user) {
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null;
		boolean bool = true;
		try {
			conn = connect();	
			stmt = conn.prepareStatement(FIND);
			stmt.setString(1, user.getUsername());
			rs = stmt.executeQuery();
			if (rs.next()){
				bool = false;
			} else {
				stmt2 = conn.prepareStatement(INSERT);
				stmt2.setString(1, user.getUsername());
				stmt2.setString(2, user.getPassword());
				stmt2.setString(3, user.getEmail());
				stmt2.executeUpdate();
			}
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(rs);
			disconnect(stmt);
			if (stmt2 != null){
				disconnect(stmt2);
			}
			disconnect(conn);
		}
		return bool;
	}

	@Override
	public boolean login(User user) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = connect();
			stmt = conn.prepareStatement(LOGIN);
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getPassword());
			
			rs = stmt.executeQuery();
			if (rs.next()){
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(rs);
			disconnect(stmt);
			disconnect(conn);
		}
		return false;
	}



	@Override
	public List<User> findAll() {
		Connection conn = null;;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<User> list = new ArrayList<User>();
		try {
			conn = connect();
			stmt = conn.prepareStatement(FIND_ALL);
			rs = stmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("Username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("Address"));
				list.add(user);
			}
			
		} catch (Exception e) {
			log.error("error occured: " + e + " statement: " + stmt);
		}
		return list;
	}
	


	@Override
	public User search(String name) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		User user = new User();
		try {
			conn = connect();
			stmt = conn.prepareStatement(FIND);
			stmt.setString(1, name);
			rs = stmt.executeQuery();
			while (rs.next()) {
				user.setUsername(rs.getString("Username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("Email"));
				user.setPets(rs.getString("Pets"));
				user.setAddress(rs.getString("Address"));

			}
			
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally{
			disconnect(rs);
			disconnect(stmt);;
			disconnect(conn);
		}
		return user;
	}

	@Override
	public void changeValue(String username, String valuename, String value) {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = connect();
			stmt = conn.prepareStatement(UPDATE + valuename + UPDATE2);
			stmt.setString(1, value);
			stmt.setString(2, username);
			stmt.executeUpdate();
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(stmt);
			disconnect(conn);
		}
	}
	
	public boolean checkUnique(String name){
		boolean bool = true;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = connect();
			stmt = conn.prepareStatement(FIND);
			stmt.setString(1, name);
			rs = stmt.executeQuery();
			if (rs.next()) {
				bool = false;
			} 
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(rs);
			disconnect(stmt);;
			disconnect(conn);
		}
		return bool;
	}
	
	@Override
	public String getAdd(String username) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String address = "";
		try {
			conn = connect();
			stmt = conn.prepareStatement(GET_ADDRESS);
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			rs.next();
			address = rs.getString(1);
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(rs);
			disconnect(stmt);;
			disconnect(conn);
		}
		return address;
	}
	

	private Connection connect() {
		try {
			return ds.getConnection();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}
	private void disconnect(PreparedStatement x) {
		try {
			x.close();
		} catch (SQLException e) {
			
		}
		
	}

	private void disconnect(Connection x) {
		try {
			x.close();
		} catch (SQLException e) {
			
		}
				
	}	
	private void disconnect (ResultSet x) {
		try {
			x.close();
		} catch (SQLException e ){
			
		}
	}

}
