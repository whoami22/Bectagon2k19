
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.faces.model.SelectItem"%>
<%@page import="java.lang.NumberFormatException"%>
<%@page import="java.lang.String"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="refresh" content="10;URL='index.html'"/>
        <title>Registration</title>
		
		
       </head>
    <body>
          <%! 
            //String username,password; 
            Connection con;
            //int count=0;
        %>
        <% 
			String remoteAddr = request.getRemoteAddr();
        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
        reCaptcha.setPrivateKey("your_private_key");

        String challenge = request.getParameter("recaptcha_challenge_field");
        String uresponse = request.getParameter("recaptcha_response_field");
        ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);

        if (reCaptchaResponse.isValid()) {
          out.print("Answer was entered correctly!");
        } else {
          out.print("Answer is wrong");
        }

            String name=request.getParameter("full_name");
            String col_name = request.getParameter("college_name");
            String regdno = request.getParameter("college_regdno");
            String col_town = request.getParameter("college_town");
            String gender = request.getParameter("gender");
            String accomm = request.getParameter("accomm");
            String email = request.getParameter("email");
            String mobno = request.getParameter("phone");
            String dept = request.getParameter("dept");
            String[] events = request.getParameterValues("selected");
            String event="";
            for(int j=0;j<events.length;j++){
                event=event+events[j]+",";
            }
            
            //Connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/new?user=root&password=GATE2016@BEC.ac.in");
            String i="insert into BEC values(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(i);                    
            pst.setString(1,name);   
            pst.setString(2, col_name);
            pst.setString(3, regdno);
            pst.setString(4, col_town);
            pst.setString(5, gender);
            pst.setString(6, accomm);
            pst.setString(7, email);
            pst.setString(8, mobno);
            pst.setString(9, dept);
            pst.setString(10, event);
            /*PrintWriter out1=response.getWriter();
            out1.println(name);
            out1.println(col_name);
            out1.println(regdno);
            out1.println(col_town);
            out1.println(gender);
            out1.println(accomm);
            out1.println(email);
            out1.println(mobno);
            out1.println(dept);*/
            
            //out.println(event);
            int up = pst.executeUpdate();          
            if(up==1){
				out.println("<div style='text-align:center;'>");
                out.println("<img style='display:block;margin-left:auto;margin-right:auto;' src='assets/img/registrationsuccess.gif' //>");
                out.println("<h3>Registration Successful.</h3>");
				out.println("<p>For Other Events <a href='https://goo.gl/forms/c21sQGT6lUHAbyC22' target='_blank'>Click Here</a></p>");
				out.println("</div>");
            }
   %>
   
    
    </body>
</html>