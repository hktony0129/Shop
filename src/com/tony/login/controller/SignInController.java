package com.tony.login.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.tony.login.model.User;
import com.tony.login.service.UserService;

@WebServlet(urlPatterns = {"/SignInController"})
public class SignInController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	final Logger log = LogManager.getLogger(SignInController.class.getName());
	
    public SignInController() {
        super();
        // TODO Auto-generated constructor stub
    }

    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		UserService us = new UserService(user);		
        
		if (us.login() == true ){
			HttpSession session = request.getSession(); 
			session.setAttribute("username",request.getParameter("username"));
			us.changeValue("Guest", "Pets", "");
	        log.info(user.getId()+ " " + user.getUsername() + " IN");
			response.sendRedirect("success.jsp");
		} else {
			response.sendRedirect("failed.jsp");
		}
	}

}
