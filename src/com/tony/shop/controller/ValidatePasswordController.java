package com.tony.shop.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tony.shop.model.User;
import com.tony.shop.service.UserService;

@WebServlet("/ValidatePasswordController")
public class ValidatePasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ValidatePasswordController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		User user = new User();
		user.setUsername(username);
		user.setPassword(request.getParameter("password"));
		UserService us = new UserService(user);
		String result = String.valueOf(us.login());
		String newpets = "";	
		if (username.equalsIgnoreCase("Guest")){
			result = "false";
		}
		if (result.equals("true")){
			String[] guestpets = us.getPets("Guest").split(",");
			String[] userpets = us.getPets(username).split(",");	
			ArrayList<String> guestList = new ArrayList<String>(Arrays.asList(guestpets));
			ArrayList<String> userList = new ArrayList<String>(Arrays.asList(userpets));
			if (!guestList.get(0).equals("")){
				userList.removeAll(guestList);
				userList.addAll(guestList);
			}
			
			for (String s : userList)
			{
			    newpets += s + ",";
			}
			if (newpets != null && newpets.length() > 0 && newpets.charAt(newpets.length()-1)==',') {
			      newpets = newpets.substring(0, newpets.length()-1);
			}
			us.changeValue("Guest", "Pets", "");
			us.changeValue(username, "Pets", newpets);
			HttpSession session = request.getSession();
			session.setAttribute("username", URLEncoder.encode(username, "UTF-8"));
		}
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(result);
	}

}
