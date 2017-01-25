package com.tony.shop.controller;

import java.io.*;
import java.net.URLDecoder;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tony.shop.service.UserService;

@WebServlet("/AddToCartController")
public class AddToCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddToCartController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService us = new UserService();
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username"); 
		name = URLDecoder.decode(name,"UTF-8");
		int PetId = Integer.parseInt(request.getParameter("petId"));
		boolean redirect = us.addPet(name, PetId);
		response.sendRedirect("added.jsp?result=" + redirect);
	}

}
