package com.tony.shop.model;

public class User {
	private String Username ;
	private String Password ;
	private String Email;
	private String Pets;
	private String Address;
	private Integer Id;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public Integer getId() {
		return Id;
	}
	public void setId(Integer id) {
		Id = id;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPets() {
		return Pets;
	}
	public void setPets(String pets) {
		Pets = pets;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}

	
	
	

}
