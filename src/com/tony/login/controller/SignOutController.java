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

@WebServlet("/SignOutController")
public class SignOutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	final Logger log = LogManager.getLogger(SignOutController.class.getName());
	
    public SignOutController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false); 
		log.info(session.getAttribute("username") + " OUT");
		session.setAttribute("username", "Guest");
		response.sendRedirect("main.jsp");
	}

}
