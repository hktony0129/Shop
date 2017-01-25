package com.tony.login.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.tony.login.model.User;
import com.tony.login.service.UserService;

@WebServlet("/UserManageController")
public class UserManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserManageController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = null;
		UserService us = new UserService(user);	
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username"); 
		name = URLDecoder.decode(name,"UTF-8");
		user = us.getInfo(name);
		RequestDispatcher view = request.getRequestDispatcher("manageAccount.jsp");
		request.setAttribute("user", user);
	    view.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		Enumeration<String> e = request.getParameterNames();
		String paramName = null;
		while (e.hasMoreElements()){
			paramName = e.nextElement();
		}
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username"); 
		name = URLDecoder.decode(name,"UTF-8");
		UserService us = new UserService();
		us.changeValue(name, paramName, request.getParameter(paramName));
		doGet(request, response);
        
	}


}
