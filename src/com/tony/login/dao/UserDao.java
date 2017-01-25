package com.tony.login.dao;

import com.tony.login.model.User;
import java.util.List;

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
