package com.GAEDataStoreJDO.datastore;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class DeleteServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		res.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = req.getSession();
		String userid = (String) session.getAttribute("Userid");
		PersistenceManager pm = PMF.get().getPersistenceManager();
		
		try {
			
			EmployeeServlet employee = pm.getObjectById(EmployeeServlet.class, userid);
			pm.deletePersistent(employee);
		} finally {
			pm.close();
		}
		//session.invalidate();
		res.sendRedirect("JSPPages/Index.jsp");
	}
}
