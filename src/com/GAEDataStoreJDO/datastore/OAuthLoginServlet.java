package com.GAEDataStoreJDO.datastore;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.*;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@SuppressWarnings("serial")
public class OAuthLoginServlet extends HttpServlet {
	@SuppressWarnings("unused")
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		res.setContentType("text/html");
		PrintWriter op = res.getWriter();
		// op.println("Hello, world");
		URL url = null;
		HttpURLConnection con = null;
		HttpSession session = req.getSession();
		String access_token;
		String auth_code;
		String token_type;
		long expires_in;
		String id_token;
		try {
			// op.println("Authentication code="+req.getParameter("code"));
		//	System.out.println("Authentication code="
		//			+ req.getParameter("code"));
			auth_code = req.getParameter("code");
			String auth_code1 = req.getParameter("error");
			if ("access_denied".equals(auth_code1)) {
				res.sendRedirect("/JSPPages/LoginFailed.jsp");
				//System.out.println("Error");
			}
			String urlvalue = "https://accounts.google.com/o/oauth2/token?";
			String param = "code="
					+ auth_code
					+ "&redirect_uri=http://localhost:8888/oAuthLoginServlet&client_id=531458892127-mspjpjjj1ckjq7hlhbndqvqvjulfd4lp.apps.googleusercontent.com&scope=&client_secret=ShCDZ6nBy0AUGKnmXok6ZTyO&grant_type=authorization_code";

			url = new URL(urlvalue);
			// System.out.println(urlvalue);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoInput(true);
			con.setDoOutput(true);
			// System.out.println(urlvalue+param);
			DataOutputStream dout = new DataOutputStream(con.getOutputStream());
			dout.writeBytes(param);
			dout.flush();
			dout.close();
			BufferedReader rd = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String line;
			StringBuffer response = new StringBuffer();
			while ((line = rd.readLine()) != null) {
				response.append(line);
			//	System.out.println(line);

			}


			JSONObject json = new JSONObject();
			JSONParser parse = new JSONParser();

			json = (JSONObject) parse.parse(response.toString());

			access_token = (String) json.get("access_token");
		//	System.out.println(access_token);
			token_type = (String) json.get("token_type");
		//	System.out.println(token_type);
			id_token = (String) json.get("id_token");

			if (!access_token.equals("")) {
				String newurlvalue = "https://www.googleapis.com/oauth2/v2/userinfo?token_type="+ token_type + "&access_token=" + access_token;
				url = new URL(newurlvalue);
				con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				BufferedReader rd1 = new BufferedReader(new InputStreamReader(
						con.getInputStream()));
				String lline;
				StringBuffer rresponse = new StringBuffer();
				while ((lline = rd1.readLine()) != null) {
					rresponse.append(lline);
			//		System.out.println(lline);
				}
				rd.close();
				if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
					JSONObject json1 = new JSONObject();
					JSONParser parse1 = new JSONParser();

					json1 = (JSONObject) parse1.parse(rresponse.toString());

					
					String emailId = (String) json1.get("email");
					String name = (String) json1.get("name");
					String picture = (String) json1.get("picture");
					String id = (String) json1.get("id");
					
					session.setAttribute("Emailid", emailId);					
					session.setAttribute("Username", name);					
					session.setAttribute("Image", picture);					
					session.setAttribute("Userid", id);

					res.sendRedirect("JSPPages/UserProfile.jsp");

				} else {
					con.disconnect();
					res.sendRedirect("JSPPages/Index.jsp");
				}

			} else {
				con.disconnect();
				res.sendRedirect("JSPPages/Index.jsp");
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}