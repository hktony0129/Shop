package com.tony.pets.controller;

import java.io.*;
import javax.servlet.*;
import java.util.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.tony.pets.model.Pet;
import com.tony.pets.dao.PetsDao;
import com.tony.pets.dao.PetsDaoImpl;

@WebServlet("/PetsController")
public class PetsController extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;

    public PetsController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PetsDao dao = new PetsDaoImpl();
		List<Pet> listPets;
		List<String> listTypes;
		int ageLow, ageHigh, page;
		if(request.getParameter("ageLow") == null || request.getParameter("ageLow").equals("")){
			ageLow = 0;
		} else {
			ageLow = Integer.parseInt(request.getParameter("ageLow"));
		}
		if(request.getParameter("ageHigh") == null || request.getParameter("ageHigh").equals("")){
			ageHigh = 999999;
		} else {
			ageHigh = Integer.parseInt(request.getParameter("ageHigh"));
		}		
		if(request.getParameter("page") == null){
			page = 1;
		} else {
			if (request.getParameter("page").equals("")){
				page = 1;
			} else {
				page = Integer.parseInt(request.getParameter("page"));
			}
		}	
		
		
		listPets = dao.search(request.getParameter("type"), request.getParameter("breed"), ageLow, ageHigh,page);
		int pageNum = dao.getSize(request.getParameter("type"), request.getParameter("breed"), ageLow, ageHigh);
		listTypes = dao.getType();
		
		RequestDispatcher view = request.getRequestDispatcher("pets.jsp");
		request.setAttribute("pets", listPets);
		request.setAttribute("type", request.getParameter("type"));
		request.setAttribute("breed", request.getParameter("breed"));
		request.setAttribute("ageLow", ageLow);
		request.setAttribute("ageHigh", ageHigh);
		request.setAttribute("page", page);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("typeList", listTypes);
        view.forward(request, response);
	}
	



}
