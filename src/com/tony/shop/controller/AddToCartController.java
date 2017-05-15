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
		
		HttpSession session = request.getSession(false); 
		String name = (String)session.getAttribute("username");
		int PetId = Integer.parseInt(request.getParameter("petId"));
		name = URLDecoder.decode(name,"UTF-8");
		boolean redirect = true;
		if (name.equals("Guest")){
			
			String oldpets = (String) session.getAttribute("pets");
			
			if (!oldpets.equals("")){
				String[] animalsArray = oldpets.split(",");
				for (String element : animalsArray){
					if(element.equals(PetId)){
						redirect = false;
					}
				}
				if (redirect){
					session.setAttribute("pets", oldpets + "," + PetId);
				}
			} else {
				session.setAttribute("pets", PetId);
			}

		} else {
			UserService us = new UserService();
			redirect = us.addPet(name, PetId);
		}
		
		response.sendRedirect("added.jsp?result=" + redirect);
	}

}
