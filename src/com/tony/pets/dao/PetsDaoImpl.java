package com.tony.pets.dao;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.sql.DataSource;
import com.tony.pets.model.Pet;
import java.sql.*;

public class PetsDaoImpl implements PetsDao {

	private static final String SEARCH = "SELECT * FROM pets WHERE Type LIKE ? AND breed LIKE ? AND age >= ? AND age <= ? limit ?, 8";
	private static final String GET_BY_ID = "SELECT * FROM pets WHERE Id IN ";
	private static final String GET_PAGE = "SELECT COUNT(Id) FROM pets WHERE Type LIKE ? AND breed LIKE ? AND age >= ? AND age <= ?";
	private static final String GET_TYPE = "SELECT distinct type from pets"; 
	
	DataSource ds;
	final Logger log = LogManager.getLogger(PetsDaoImpl.class.getName());
	
	public PetsDaoImpl(){
		Context initCtx;
		try {
			initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			ds = (DataSource) envCtx.lookup("jdbc/shop");
		} catch (Exception e) {
			log.error("error occured: " + e );
		}
		
	}
	
	@Override
	public List<Pet> search(String type, String breed, int ageLow, int ageHigh,int page ) {
		if (type == null){
			type = "";
		} 
		if (breed == null){
			breed = "";
		}
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Pet> list = new ArrayList<Pet>();
		try {
			conn = connect();
			
			stmt = conn.prepareStatement(SEARCH);
			stmt.setString(1, "%" + type + "%");
			stmt.setString(2, "%" + breed + "%");
			stmt.setInt(3, ageLow);
			stmt.setInt(4, ageHigh);
			stmt.setInt(5, (page-1)*8);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Pet pet = new Pet();
				pet.setId(rs.getInt("id"));
				pet.setBreed(rs.getString("breed"));
				pet.setType(rs.getString("Type"));
				pet.setAge(rs.getInt("Age"));
				pet.setPrice(rs.getInt("price"));
				list.add(pet);
			}
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
			System.out.print("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(rs);
			disconnect(stmt);
			disconnect(conn);
		}
		return list;
	}

	@Override
	public List<Pet> getById(String Ids) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Pet> list = new ArrayList<Pet>();
		try {
			conn = connect();
			stmt = conn.prepareStatement(GET_BY_ID + Ids);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Pet pet = new Pet();
				pet.setId(rs.getInt("id"));
				pet.setBreed(rs.getString("breed"));
				pet.setType(rs.getString("Type"));
				pet.setAge(rs.getInt("Age"));
				pet.setPrice(rs.getInt("price"));
				list.add(pet);
			}
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(stmt);
			disconnect(conn);
		}
		return list;
	}
	
	@Override
	public int getSize(String type, String breed, int ageLow, int ageHigh) {
		if (type == null){
			type = "";
		} 
		if (breed == null){
			breed = "";
		}
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int pages = 0;
		try {
			conn = connect();
			stmt = conn.prepareStatement(GET_PAGE);
			stmt.setString(1, "%" + type + "%");
			stmt.setString(2, "%" + breed + "%");
			stmt.setInt(3, ageLow);
			stmt.setInt(4, ageHigh);
			rs = stmt.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			pages = (count - 1) / 8 + 1 ;
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(rs);
			disconnect(stmt);
			disconnect(conn);
		}
		return pages;
	}
	
	@Override
	public List<String> getType(){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> list = new ArrayList<String>();
		try {
			conn = connect();
			stmt = conn.prepareStatement(GET_TYPE);
			rs = stmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (SQLException e) {
			log.error("error occured: " + e + " statement: " + stmt);
		} finally {
			disconnect(stmt);
			disconnect(conn);
		}
		return list;
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
