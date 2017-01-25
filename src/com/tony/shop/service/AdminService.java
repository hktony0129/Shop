package com.tony.shop.service;
import com.tony.shop.dao.*;

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
