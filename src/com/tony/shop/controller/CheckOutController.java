package com.tony.shop.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tony.pets.model.Pet;
import com.tony.pets.service.PetsService;
import com.tony.shop.service.UserService;

@WebServlet("/CheckOutController")
public class CheckOutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CheckOutController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username"); 
		name = URLDecoder.decode(name,"UTF-8");
		String[] amountsArray = request.getParameter("amounts").split(",");
		ArrayList<String> amountsList = new ArrayList<String>(Arrays.asList(amountsArray));
		UserService us = new UserService();
		PetsService ps = new PetsService();
		String pets = "(" + us.getPets(name) + ")";
		List<Pet> petsList = ps.getById(pets);
		String add = us.getAddress(name);
		RequestDispatcher view = request.getRequestDispatcher("Checkout.jsp");
		request.setAttribute("address", add);
		request.setAttribute("pets", petsList);
		request.setAttribute("amounts", amountsList);
        view.forward(request, response);
	}

}
