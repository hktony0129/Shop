package com.tony.shop.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tony.pets.model.Pet;
import com.tony.pets.service.PetsService;
import com.tony.shop.service.UserService;

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
		String pets;
		
		if (name.equals("Guest")){
			pets = "(" + session.getAttribute("pets") + ")";
		} else {
			UserService us = new UserService();	
			pets = "(" + us.getPets(name) + ")";
		}
		
		List<Pet> petsList = ps.getById(pets);
		
		RequestDispatcher view = request.getRequestDispatcher("shoppingCart.jsp");
		request.setAttribute("pets", petsList);
        view.forward(request, response);
	}

}
