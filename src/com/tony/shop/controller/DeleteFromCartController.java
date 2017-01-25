package com.tony.shop.controller;

import java.io.*;
import java.net.URLDecoder;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tony.shop.service.UserService;

@WebServlet("/DeleteFromCartController")
public class DeleteFromCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteFromCartController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService us = new UserService();
		String PetId = request.getParameter("petId");
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username"); 
		name = URLDecoder.decode(name,"UTF-8");
		us.deletePet(name, PetId);
		response.sendRedirect("ShoppingCartController");
	}

}
