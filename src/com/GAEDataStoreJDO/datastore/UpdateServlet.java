package com.GAEDataStoreJDO.datastore;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.jdo.Query;
import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.images.Image;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ServingUrlOptions;

@SuppressWarnings({ "serial", "unused" })
public class UpdateServlet extends HttpServlet {

	@Override
	@SuppressWarnings({ "unchecked" })
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		res.setContentType("text/html;charset=UTF-8");
		// PrintWriter p=res.getWriter();

		HttpSession session = req.getSession();

		PersistenceManager pm = PMF.get().getPersistenceManager();

		// EmployeeServlet employee = new EmployeeServlet();
		
		// Update
		if (req.getParameter("Update") != null) {
			try {
				String username = req.getParameter("UserName");
				String company = req.getParameter("Company");
				String emailid = req.getParameter("EmailId");
				String mobileno = req.getParameter("MobileNo");
				String password = req.getParameter("Password");
				String userid = req.getParameter("UserId");
				//System.out.println(userid);

				EmployeeServlet employee = pm.getObjectById(
						EmployeeServlet.class, userid);
				// Query filter is used to filter the particular field with
				// value
				Query query = pm.newQuery(EmployeeServlet.class);
				query.setFilter("userId =='" + userid + "'");
				// query.declareParameters("String username");

				// using the List to get the entries from the data store
				List<EmployeeServlet> employees = (List<EmployeeServlet>) query
						.execute();

				// Here the input values are updated into the datastore

				employee.setUserName(username);

				employee.setCompany(company);

				employee.setEmailId(emailid);

				employee.setMobileNo(mobileno);

				employee.setPassword(password);
				
//				if("userId"==null){
//					res.sendRedirect("/registrationServlet");
//				}

				session.setAttribute("Username", employee.getUserName());
				session.setAttribute("DateofBirth", employee.getDateOfBirth());
				session.setAttribute("DateofRegistration",
						employee.getDateOfRegistration());
				session.setAttribute("Userid", employee.getUserId());
				session.setAttribute("Company", employee.getCompany());
				session.setAttribute("Emailid", employee.getEmailId());
				session.setAttribute("Mobileno", employee.getMobileNo());
				session.setAttribute("Password", employee.getPassword());
				session.setAttribute("Image", employee.getImage());

			} finally {
				pm.close();
			}
		}
		res.sendRedirect("/JSPPages/Retrieve.jsp");
	}
}
