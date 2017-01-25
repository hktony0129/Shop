package com.tony.shop.dao;

import java.util.List;

import com.tony.shop.model.User;

public interface UserDao {
	public void delete(int x);
	public boolean insert(User user);
	public boolean login(User user); 
	public boolean checkUnique(String name);
	public User search(String name);
	public List<User> findAll();
	public void changeValue(String username, String valuename, String value);
	public String getAdd(String username);
}
