package com.GAEDataStoreJDO.datastore;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.jdo.Query;
import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

@SuppressWarnings("unused")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BlobstoreService blobstoreService = BlobstoreServiceFactory
			.getBlobstoreService();
	@Override
	@SuppressWarnings({ "unchecked" })
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {

		res.setContentType("text/html;charset=UTF-8");
		HttpSession session = req.getSession();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		
		// Login
		if (req.getParameter("Login") != null) {

			String loginusername = req.getParameter("UserName");
			String loginpassword = req.getParameter("Password");
			// Employee employee=new Employee();
			try {
				int increment = 0;

				// Query filter is used to filter the particular field with
				// value
				Query query = pm.newQuery(EmployeeServlet.class);
				query.setFilter("userName =='" + loginusername + "' ");

				// using the List to get the entries from the data store
				List<EmployeeServlet> employees = (List<EmployeeServlet>) query.execute();
				// System.out.println(employees.size());
				// System.out.println(loginusername );
				for (EmployeeServlet employee : employees) {
					if (employee.getUserName().equals(loginusername)
							&& employee.getPassword().equals(loginpassword)) {
						{
//							`							
							int count = employee.getCount() + 1;
							employee.setCount(count);
							pm.makePersistent(employee);
							// Here i create a session for the login user
							
							// Here i am fetching the value from the datastore
							// because userId is primary key that we can't
							// change.
							session.setAttribute("Username",
									employee.getUserName());
							session.setAttribute("DateofBirth",
									employee.getDateOfBirth());
							session.setAttribute("DateofRegistration",
									employee.getDateOfRegistration());
							session.setAttribute("Userid", employee.getUserId());
							session.setAttribute("Company",
									employee.getCompany());
							session.setAttribute("Emailid",
									employee.getEmailId());
							session.setAttribute("Mobileno",
									employee.getMobileNo());
							session.setAttribute("Password",
									employee.getPassword());
							session.setAttribute("Image", employee.getImage());
							session.setAttribute("Count", count);
							increment++;
							res.sendRedirect("JSPPages/UserProfile.jsp");
						}
					}
				}
				// Here i check whether the entries are present or not as per
				// the user input.
				// ...
				if (increment == 0) {
					// LoginFailed
					// PrintWriter op=res.getWriter();
					// op.write("Username and Password Mismatch");
					res.sendRedirect("JSPPages/LoginFailed.jsp");
				}

			} catch (Exception e) {
				res.sendRedirect("JSPPages/LoginFailed.jsp");
			} finally {
				pm.close();
			}
		}
	}
}
