package com.tony.login.service;
import com.tony.login.dao.*;

public class AdminService {
	int userid = 0;
	UserDao dao = new UserDaoImpl();
	
	public AdminService(int x) {
		userid = x;
	}
	
	public void deleteuser(int x) {
		dao.delete(userid);
	}
}
