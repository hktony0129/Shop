package com.tony.shop.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tony.shop.model.User;
import com.tony.shop.service.UserService;


@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		user.setEmail(request.getParameter("email"));
		UserService us = new UserService(user);
		if(us.register() == true){
			HttpSession session = request.getSession(); 
			session.setAttribute("username",user.getUsername());
			response.sendRedirect("success.jsp");
		} else {
			response.sendRedirect("failed.jsp");
		}
	}


}
