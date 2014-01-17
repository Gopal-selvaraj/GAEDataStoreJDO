package com.GAEDataStoreJDO.datastore;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.images.ImagesServiceFactory;

@SuppressWarnings("serial")
public class UploadImageServlet extends HttpServlet {
	private com.google.appengine.api.blobstore.BlobstoreService blobstoreService = BlobstoreServiceFactory
			.getBlobstoreService();
	@SuppressWarnings({ "deprecation", "unchecked", "unused" })
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
//		res.setContentType("text/plain");
//		PrintWriter op=res.getWriter();

		HttpSession session = req.getSession();
		String userid = (String) session.getAttribute("Userid");
		//System.out.println(userid);
		
		PersistenceManager pm = PMF.get().getPersistenceManager();
		

		

		// UpdateImage
				if (req.getParameter("Upload") != null) {
					try {

						Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
						BlobKey blobKey = blobs.get("Image");
						String imgUrl = ImagesServiceFactory.getImagesService().getServingUrl(blobKey);
						
						EmployeeServlet employee = pm.getObjectById(EmployeeServlet.class, userid);
						// Query filter is used to filter the particular field with
						// value
						Query query = pm.newQuery(EmployeeServlet.class);
						query.setFilter("userId =='" + userid + "'");
						// query.declareParameters("String username");

						List<EmployeeServlet> employees = (List<EmployeeServlet>) query.execute();

						// Here the input values are updated into the datastore

						if (imgUrl != null && imgUrl != "") {
							employee.setImage(imgUrl);
						}

						session.setAttribute("Image", employee.getImage());

					} finally {
						pm.close();
					}
				}
				res.sendRedirect("/JSPPages/Retrieve.jsp");
			}
		
	}
//}
