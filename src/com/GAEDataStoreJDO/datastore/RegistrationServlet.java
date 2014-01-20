package com.GAEDataStoreJDO.datastore;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ServingUrlOptions;

@SuppressWarnings({ "serial", "deprecation" })
public class RegistrationServlet extends HttpServlet {

	private BlobstoreService blobstoreService = BlobstoreServiceFactory
			.getBlobstoreService();

	@SuppressWarnings({})
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {

		res.setContentType("text/html;charset=UTF-8");
		PersistenceManager pm = PMF.get().getPersistenceManager();
		EmployeeServlet employee = new EmployeeServlet();

		Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
		BlobKey blobKey = blobs.get("Image");
		ImagesService services = ImagesServiceFactory.getImagesService();
		ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKey);    // Blobkey of the image uploaded to BlobStore.
		String imgUrl = services.getServingUrl(serve);
//		String imgUrl=blobKey.getKeyString();
		
//		BlobInfoFactory blobInfoFactory = new BlobInfoFactory();		 
//		BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(blobKey);
		
		// Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		// BlobKey blobKey = blobs.get("Image").get(0);
		// String imgUrl=blobKey.getKeyString();
		// System.out.println(imgUrl);

		// Registration
		if (req.getParameter("Registration") != null) {

			try {
				int count = 0;
				String username = req.getParameter("UserName");
				String userid = req.getParameter("UserId");
				String company = req.getParameter("Company");
				String emailid = req.getParameter("EmailId");
//				String blobName = blobInfo.getFilename();
//				System.out.println("BlobName :"+blobName);
//				String blobkey = blobKey.getKeyString();
//				System.out.println("BlobKey :"+blobkey);
				String mobileno = req.getParameter("MobileNo");
				//System.out.println("Your Mobile No is : " + mobileno);

				String password = req.getParameter("Password");
				String dateofbirth = req.getParameter("DateOfBirth");
				String dateofregistration = req
						.getParameter("DateOfRegistration");
				// System.out.println(blobKey);
				// UUID is the universal that is assigned to the primary key
				// field.
				UUID id = UUID.randomUUID();
				employee.setUserId(id.toString());

				// Here the input values are inserted into the datastore
				if (username != null && username != "") {
					employee.setUserName(username);
				}
				if (userid != null && userid != "") {
				employee.setUserId(userid);}
				if (dateofbirth != null && dateofbirth != "") {
				employee.setDateOfBirth(dateofbirth);}
				if (dateofregistration != null && dateofregistration != "") {
				employee.setDateOfRegistration(dateofregistration);}
				if (emailid != null && emailid != "") {
				employee.setEmailId(emailid);}
				employee.setMobileNo(mobileno);
				if (company != null && company != "") {
				employee.setCompany(company);}
				if (password != null && password != "") {
				employee.setPassword(password);}
				if (imgUrl != null && imgUrl != "") {
				employee.setImage(imgUrl);}
//				if (blobName != null && blobName != "") {
//					employee.setBlobName(blobName);}
//				if (blobkey != null && blobName != "" ) {
//					employee.setBlobKey(blobkey);}
				employee.setCount(count);

				// System.out.println(imgUrl);
				pm.makePersistent(employee);

			} finally {
				pm.close();
			}
		}
		res.sendRedirect("/JSPPages/RegisteredSuccessfully.jsp");
	}
}
