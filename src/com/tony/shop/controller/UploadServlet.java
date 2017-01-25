package com.tony.shop.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UploadServlet() {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		String savePath = request.getServletContext().getRealPath("/IMG/users");
		Part part = request.getPart("file");	
		String fileName =(String) session.getAttribute("username") + ".jpg";
		System.out.println(savePath);
		System.out.println(fileName);
		part.write(savePath+File.separator+fileName);
		response.sendRedirect("UserManageController");
	}
}
