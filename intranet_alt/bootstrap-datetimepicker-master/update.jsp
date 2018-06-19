<%@ page contentType="application/json;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="javax.activation.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.chimerasys.*" %>
<%@ page errorPage="error.jsp" %>

<jsp:declaration>
   Statement stmt;
   PreparedStatement pstmt;
   Connection conn;
   Context initContext, envContext;
   javax.sql.DataSource ds;
   SimpleDateFormat dateFormat, dateTimeFormat, ISOFormat;
</jsp:declaration>

<%
    dateFormat = new SimpleDateFormat("dd MMM yyyy", Locale.GERMAN);
    dateTimeFormat = new SimpleDateFormat("dd MMM yyyy 'um' HH:mm", Locale.GERMAN);
    ISOFormat = new SimpleDateFormat("yyyy-MM-dd");
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // response.sendRedirect("login.jsp");
    }

try {
      initContext = new InitialContext();
      envContext  = (Context)initContext.lookup("java:/comp/env");
      ds = (javax.sql.DataSource)envContext.lookup("jdbc/intranet");
      conn = ds.getConnection();

  } catch (Exception ex) {
          System.err.println(ex.getClass().getName() + ": " + ex.getMessage());
          //Logger.getLogger(this.class.getName()).log(Level.SEVERE, null, ex);
  }


  String action = request.getParameter("action");
  if (action == null || action.length() == 0) {
      out.println("{\"status\": \"Error\", \"message\": \"action parameter missing\"}");
      // for (String p: Collections.list(request.getParameterNames())) {
      // 	  out.println(p + " = " + request.getParameter(p) + "<BR>");
      // }
      conn.close();
      return;
  }

/*
mysql> desc tags;
+--------------+-------------+------+-----+-------------------+----------------+
| Field        | Type        | Null | Key | Default           | Extra          |
+--------------+-------------+------+-----+-------------------+----------------+
| id           | int(11)     | NO   | PRI | NULL              | auto_increment |
| category     | varchar(32) | NO   |     | NULL              |                |
| label        | varchar(32) | NO   |     | NULL              |                |
| creationdate | timestamp   | NO   |     | CURRENT_TIMESTAMP |                |
| deletiondate | timestamp   | YES  |     | NULL              |                |
+--------------+-------------+------+-----+-------------------+----------------+
*/

  if (action.equals("newtag")) {
      String tagname = request.getParameter("tagname");
      String category = request.getParameter("category");
      java.util.Date d;
      if (tagname == null || tagname.length() == 0 || category == null || category.length() == 0) {
	  out.println("{\"status\": \"Error\", \"message\": \"parameter (tagname or category) missing or empty\"}");
          conn.close();
	  return;
      }
      // if (user.getRole() != 2) {
      // 	  out.println("{\"status\": \"Error\", \"message\": \"Not allowed: User has no admin role (role=2)\"}");
      //     conn.close();
      // 	  return;
      // }
     pstmt = conn.prepareStatement("INSERT INTO tags (category, label) VALUES (?, ?)");
     pstmt.setString(1, category);
     pstmt.setString(2, tagname);
     int res = pstmt.executeUpdate();
     if (res == 1) {
	  out.println("{\"status\": \"OK\"}");
     } else {
	  out.println("{\"status\": \"Error\", \"message\": \"DB error in INSERT INTO tags\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  if (action.equals("deltag")) {
      int tid = 0;
      try {
	  tid = Integer.parseInt( request.getParameter("tagid") );
      } catch (Exception ignored) {
      }
      if (tid <= 0) {
	  out.println("{\"status\": \"Error\", \"message\": \"parameter tagid missing or not a positive integer\"}");
          conn.close();
	  return;
      }
     pstmt = conn.prepareStatement("UPDATE tags SET deletiondate=CURRENT_TIMESTAMP WHERE id=?");
     pstmt.setInt(1, tid);
     int res = pstmt.executeUpdate();
     if (res == 1) {
	  out.println("{\"status\": \"OK\"}");
     } else {
	  out.println("{\"status\": \"Error\", \"message\": \"DB error in UPDATE tags\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  if (action.equals("modtag")) {
      int tid = 0;
      String tagname = request.getParameter("tagname");
      try {
	  tid = Integer.parseInt( request.getParameter("tagid") );
      } catch (Exception ignored) {
      }
      if (tid <= 0 || tagname == null || tagname.length() == 0) {
	  out.println("{\"status\": \"Error\", \"message\": \"parameter tagid missing or not a positive integer or tagname missing or empty\"}");
          conn.close();
	  return;
      }

     pstmt = conn.prepareStatement("UPDATE tags SET label=? WHERE id=?");
     pstmt.setString(1, tagname);
     pstmt.setInt(2, tid);
     int res = pstmt.executeUpdate();
     if (res == 1) {
	  out.println("{\"status\": \"OK\"}");
     } else {
	  out.println("{\"status\": \"Error\", \"message\": \"DB error in UPDATE tags\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  if (action.equals("newdoc")) {
      out.println("{\"status\": \"Error\", \"message\": \"Action 'newdoc' is not yet implemented.\"}");
      conn.close();
  }

  if (action.equals("deldoc")) {
      out.println("{\"status\": \"Error\", \"message\": \"Action 'deldoc' is not yet implemented.\"}");
      conn.close();
     return;
  }

  if (action.equals("moddoc")) {
      out.println("{\"status\": \"Error\", \"message\": \"Action 'moddoc' is not yet implemented.\"}");
      conn.close();
     return;
  }

//      java.util.Date d;
//      try {
//       d = ISOFormat.parse(startDate);
//     } catch (java.text.ParseException ex) {
//          out.println("EERRORPARAMDATE");
//          conn.close();
//	  return;
//     }
  out.println("{\"status\": \"Error\", \"message\": \"action parameter unknown '" + action + "'\"}");

%>
