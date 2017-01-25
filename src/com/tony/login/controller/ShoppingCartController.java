package com.tony.login.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.tony.login.service.UserService;
import com.tony.pets.model.Pet;
import com.tony.pets.service.PetsService;

@WebServlet("/ShoppingCartController")
public class ShoppingCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ShoppingCartController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PetsService ps = new PetsService();
		
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username"); 
		name = URLDecoder.decode(name,"UTF-8");
		
		UserService us = new UserService();	
		String pets = "(" + us.getPets(name) + ")";
		List<Pet> petsList = ps.getById(pets);
		
		RequestDispatcher view = request.getRequestDispatcher("shoppingCart.jsp");
		request.setAttribute("pets", petsList);
        view.forward(request, response);
	}

}
