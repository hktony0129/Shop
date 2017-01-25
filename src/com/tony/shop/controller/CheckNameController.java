package com.tony.shop.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tony.shop.service.UserService;


@WebServlet("/CheckNameController")
public class CheckNameController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CheckNameController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		UserService us = new UserService();
		String str = String.valueOf(us.checkUnique(name));
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(str);
	}

}
