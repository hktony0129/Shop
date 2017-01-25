package com.tony.login.controller;

import java.io.*;
import javax.servlet.*;
import java.util.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.tony.login.model.User;
import com.tony.login.dao.UserDao;
import com.tony.login.dao.UserDaoImpl;

@WebServlet("/AdminManageController")
public class AdminManageController extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;

    public AdminManageController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDao dao = new UserDaoImpl();
		if ("delete".equals(request.getParameter("action"))){
			dao.delete(Integer.parseInt(request.getParameter("userId")));
			response.sendRedirect("?view");
		}
		List<User> list = dao.findAll();
		RequestDispatcher view = request.getRequestDispatcher("manager.jsp");
		request.setAttribute("users", list);
        view.forward(request, response);
        
	}


}
