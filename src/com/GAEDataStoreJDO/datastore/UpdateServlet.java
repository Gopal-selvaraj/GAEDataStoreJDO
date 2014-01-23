package com.GAEDataStoreJDO.datastore;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.jdo.Query;
import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

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

		HttpSession session = req.getSession();

		PersistenceManager pm = PMF.get().getPersistenceManager();

// Update

		try {

			String username = req.getParameter("userName");
			String userid = req.getParameter("userId");
			String dateofbirth = req.getParameter("dateOfBirth");
			String dateofregistration = req.getParameter("dateOfRegistration");
			String company = req.getParameter("companyName");
			String emailid = req.getParameter("emailId");
			String mobileno = req.getParameter("mobileNo");
			String password = req.getParameter("password");

			EmployeeServlet employee = pm.getObjectById(EmployeeServlet.class,
					userid);

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
//JSON
			// I create the JSONObject to send the values to the jsp ...

			res.setContentType("Application/json");
			JSONObject json = new JSONObject();

			json.put("userName", employee.getUserName());
			json.put("dateOfBirth", employee.getDateOfBirth());
			json.put("dateOfRegistration", employee.getDateOfRegistration());
			json.put("userId", employee.getUserId());
			json.put("companyName", employee.getCompany());
			json.put("emailId", employee.getEmailId());
			json.put("mobileNo", employee.getMobileNo());
			json.put("password", employee.getPassword());

			// System.out.println(json.toString());

			PrintWriter out = res.getWriter();
			out.write(json.toString());
//SESSION
			session.setAttribute("Username", employee.getUserName());
			session.setAttribute("DateofBirth", employee.getDateOfBirth());
			session.setAttribute("DateofRegistration",
					employee.getDateOfRegistration());
			session.setAttribute("Emailid", employee.getEmailId());
			session.setAttribute("Userid", employee.getUserId());
			session.setAttribute("Company", employee.getCompany());
			session.setAttribute("Mobileno", employee.getMobileNo());
			session.setAttribute("Image", employee.getImage());

		} finally {
			pm.close();
		}
		res.sendRedirect("/JSPPages/Retrieve.jsp");
	}
}
