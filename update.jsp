<%@ page contentType="application/json;charset=UTF-8" errorPage="jsonerror.jsp" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.chimerasys.*" %>

<jsp:declaration>
   PasswdUtility pwdUtil;
   SimpleDateFormat ISOFormat;
   Context initContext, envContext;
   javax.sql.DataSource ds;

   public int getIntParam(String name, int dflt, HttpServletRequest request) {
     if (name == null) { return dflt; }
     if (request.getParameter(name) == null) { return dflt; }
     int v = dflt;
     try { v = Integer.parseInt(request.getParameter(name)); } catch (Exception uncaught) {}
     return v;
   }

   public void delRecord(String table, String paramName, boolean doAction, boolean hasAccess, HttpServletRequest request, JspWriter out, Connection conn) throws SQLException, IOException {
      int id = getIntParam(paramName, 0, request);
      int res = -1;
      if (!doAction || !hasAccess) { return; }
      if (id > 0 /* && u.getRole() == u.ACCESS_ADMIN */) {
        PreparedStatement pstmt = conn.prepareStatement("UPDATE " + table + " SET deletiondate=CURRENT_TIMESTAMP WHERE id=?");
        pstmt.setInt(1, id);
        res = pstmt.executeUpdate();
        pstmt.close();
     } else {
          out.println("{\"status\": \"Error\", \"message\": \"parameter missing or invalid.\"}");
      }
      if (res == 1) {
       out.println("{\"status\": \"OK\"}");
        } else {
       out.println("{\"status\": \"Error\", \"message\": \"DB error in delete record\"}");
        }
    conn.close();
   }

    public java.sql.Timestamp getTSParam(String p) {
        java.sql.Timestamp ts = null;
        try {
            java.util.Date utilDate = ISOFormat.parse(p);
            Calendar cal = Calendar.getInstance();
            cal.setTime(utilDate);
            cal.set(Calendar.MILLISECOND, 0);
            ts = new java.sql.Timestamp(utilDate.getTime());
        } catch (Exception ignored) {
        }
        return ts;
    }
</jsp:declaration>

<%
    Statement stmt;
    PreparedStatement pstmt;
    Connection conn;

    response.setHeader("Access-Control-Allow-Origin", "*");
    User user = (User) session.getAttribute("user");
    if (user == null) {
       out.println("{\"status\":\"Error\", \"message\": \"Nicht eingeloggt.\"}");
       return;
    }
    if (pwdUtil == null) {
        pwdUtil = new PasswdUtility();
    }
    if (ISOFormat == null) {
        ISOFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    }
    try {
      if (initContext == null || envContext == null || ds == null) {
          initContext = new InitialContext();
          envContext  = (Context)initContext.lookup("java:/comp/env");
          ds = (javax.sql.DataSource)envContext.lookup("jdbc/intranet");
      }
      conn = ds.getConnection();
    } catch (Exception ex) {
          System.err.println(ex.getClass().getName() + ": " + ex.getMessage());
          //Logger.getLogger(this.class.getName()).log(Level.SEVERE, null, ex);
          out.println("{\"status\": \"Error\", \"message\": \"DB Connection error: "
          + ex.getClass().getName() + ": " + ex.getMessage()
          + "\"}");
          return;
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

  if (action.equals("newuser") || action.equals("adduser")) {
      String email = request.getParameter("email");
      String firstname = request.getParameter("firstname");
      String lastname = request.getParameter("lastname");
      String password = request.getParameter("password"); // or random
      int role = 0;
      try { role = Integer.parseInt(request.getParameter("role")); }
      catch (Exception uncaught) {}
      if (email == null || email.length() == 0
          || firstname == null || firstname.length() == 0
          || lastname == null || lastname.length() == 0
          ) {
	        out.println("{\"status\": \"Error\", \"message\": \"parameters missing or empty\"}");
          conn.close();
	        return;
      }
      // if (user.getRole() != 2) {
      // 	  out.println("{\"status\": \"Error\", \"message\": \"Access denied: User has no admin role (role=2)\"}");
      //     conn.close();
      // 	  return;
      // }
     pstmt = conn.prepareStatement("INSERT INTO users (email, firstname, lastname, salthash, accesslevel) VALUES (?, ?, ?, ?, ?)");
     pstmt.setString(1, email);
     pstmt.setString(2, firstname);
     pstmt.setString(3, lastname);
     pstmt.setString(4, pwdUtil.addUserPasswdHash(password));
     pstmt.setInt(5, role);
     int res = pstmt.executeUpdate();
     if (res == 1) {
	      out.println("{\"status\": \"OK\"}");
     } else {
	      out.println("{\"status\": \"Error\", \"message\": \"DB error in INSERT INTO users\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  if (action.equals("deluser")) {
      int uid = 0;
      try {
        uid = Integer.parseInt( request.getParameter("userid") );
      } catch (Exception ignored) {
      }
      if (uid <= 0) {
        out.println("{\"status\": \"Error\", \"message\": \"parameter userid missing or not a positive integer\"}");
        conn.close();
        return;
      }
      // TODO: check if user.getRole() == 2

     pstmt = conn.prepareStatement("UPDATE users SET deletiondate=CURRENT_TIMESTAMP WHERE id=?");
     pstmt.setInt(1, uid);
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

  if (action.equals("actuser")) {
      int uid = 0;
      try {
        uid = Integer.parseInt( request.getParameter("userid") );
      } catch (Exception ignored) {
      }
      if (uid <= 0) {
        out.println("{\"status\": \"Error\", \"message\": \"parameter userid missing or not a positive integer\"}");
        conn.close();
        return;
      }
      // TODO: check if user.getRole() == 2

     pstmt = conn.prepareStatement("UPDATE users SET deletiondate=null WHERE id=?");
     pstmt.setInt(1, uid);
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

  if (action.equals("newpass")) {
      int uid = 0;
      try {
        uid = Integer.parseInt( request.getParameter("userid") );
      } catch (Exception ignored) {
      }
      if (uid <= 0) {
        out.println("{\"status\": \"Error\", \"message\": \"parameter userid missing or not a positive integer\"}");
        conn.close();
        return;
      }
      // TODO: create new password and email to users
      out.println("{\"status\": \"OK\"}");
    }

    if (action.equals("login")) {
      String email = request.getParameter("email");
      String pass = request.getParameter("password");
      String salthash = null;
      User u = null;
      if (email == null || pass == null || email.length() == 0 || pass.length() == 0) {
          out.println("{\"status\": \"Error\", \"message\": \"parameter email/passwd missing or empty\"}");
          conn.close();
          return;
        }
        pstmt = conn.prepareStatement("SELECT id, email, firstname, lastname, accesslevel, salthash"
           + " FROM users"
           + " WHERE lower(email)=?");
        pstmt.setString(1, email.toLowerCase());
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
          u = new User(rs.getInt(1));
          u.setEmail(rs.getString("email"));
          u.setFirstname(rs.getString("firstname"));
          u.setLastname(rs.getString("lastname"));
          u.setRole(rs.getInt("accesslevel"));
          salthash = rs.getString("salthash");
        }
        rs.close();
        pstmt.close();
        conn.close();

        // check passwd
        if (u != null && salthash != null
            && pwdUtil.authenticate(email, salthash.substring(13), salthash.substring(0, 12), pass)) {
          session.setAttribute("user", u);
          out.println("{ \"status\": \"ok\" }");
        } else {
          out.println("{ \"status\": \"Error\", \"message\": \"invalid credentials\" }");
        }
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
      // TODO: check if user.getRole() == 2 OR tag.ownerid == user.id

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

  if (action.equals("newevent")) {
      String name = request.getParameter("name");
      java.sql.Timestamp dtStart = getTSParam(request.getParameter("dtStart"));
      java.sql.Timestamp dtEnd = getTSParam(request.getParameter("dtEnd"));;
      int alarmMin = getIntParam("alarmmin", -1, request); // -1 = no alarm
      String status = "NEW";
      String location = request.getParameter("location");
      String comment = request.getParameter("comment");
      String url = request.getParameter("url");
      char repeatType = request.getParameter("repeattype") == null ? '-' : request.getParameter("repeattype").charAt(0);
      java.sql.Date repeatUntil = null; // TODO request.getParameter("repeatuntil");
      if (name == null || name.length() == 0
          || dtStart == null || dtEnd == null) {
	           out.println("{\"status\": \"Error\", \"message\": \"parameter missing or empty\"}");
             conn.close();
	           return;
      }
      // if (user.getRole() != user.ACCESS_ADMIN) {
      // 	  out.println("{\"status\": \"Error\", \"message\": \"Not allowed: User has no admin role (role=2)\"}");
      //     conn.close();
      // 	  return;
      // }
     pstmt = conn.prepareStatement("INSERT INTO events (name, dtstart, dtend, ownerid, alarmmin, status, location, repeattype, repeatuntil, comment, url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
     pstmt.setString(1, name);
     pstmt.setTimestamp(2, dtStart);
     pstmt.setTimestamp(3, dtEnd);
     pstmt.setInt(4, user.getId());
     pstmt.setInt(5, alarmMin);
     pstmt.setString(6, status);
     pstmt.setString(7, location);
     pstmt.setString(8, "" + repeatType);
     pstmt.setDate(9, repeatUntil); // TODO: repeatuntil
     pstmt.setString(10, comment);
     pstmt.setString(11, url);

     int res = pstmt.executeUpdate();
     if (res == 1) {
	      out.println("{\"status\": \"OK\"}");
     } else {
	      out.println("{\"status\": \"Error\", \"message\": \"DB error in INSERT INTO events\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  if (action.equals("newcustomer")) {
      String name = request.getParameter("name");
      int type = getIntParam("type", -1, request);
      String status = "NEW";
      String address = request.getParameter("address");
      String city = request.getParameter("city");
      String zip = request.getParameter("zip");
      String url = request.getParameter("url");
      String email = request.getParameter("email");

      if (name == null || name.length() == 0
          || type < 0) {
	           out.println("{\"status\": \"Error\", \"message\": \"parameter missing or empty\"}");
             conn.close();
	           return;
      }
      // if (user.getRole() != 2) {
      // 	  out.println("{\"status\": \"Error\", \"message\": \"Not allowed: User has no admin role (role=2)\"}");
      //     conn.close();
      // 	  return;
      // }
     pstmt = conn.prepareStatement("INSERT INTO customer (name, type, address, city, zip, email, url, userid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
     pstmt.setString(1, name);
     pstmt.setInt(2, type);
     pstmt.setString(3, address);
     pstmt.setString(4, city);
     pstmt.setString(5, zip);
     pstmt.setString(6, email);
     pstmt.setString(7, url);
     pstmt.setInt(8, user.getId());

     int res = pstmt.executeUpdate();
     if (res == 1) {
	      out.println("{\"status\": \"OK\"}");
     } else {
	      out.println("{\"status\": \"Error\", \"message\": \"DB error in INSERT INTO events\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  if (action.equals("newcustcomm")) {
      String details = request.getParameter("details");
      int type = getIntParam("type", -1, request);
      int customerid = getIntParam("customerid", -1, request);
      String address = request.getParameter("address");
      String city = request.getParameter("city");
      String zip = request.getParameter("zip");
      String url = request.getParameter("url");
      String email = request.getParameter("email");

      if (details == null || details.length() == 0
          || type < 0 || customerid < 0) {
	           out.println("{\"status\": \"Error\", \"message\": \"parameter missing or empty\"}");
             conn.close();
	           return;
      }
      // if (user.getRole() != User.ACCESS_ADMIN) {
      // 	  out.println("{\"status\": \"Error\", \"message\": \"Not allowed: User has no admin role (role=2)\"}");
      //     conn.close();
      // 	  return;
      // }
     pstmt = conn.prepareStatement("INSERT INTO custcomm (customerid, commtype, commdetails, userid) VALUES (?, ?, ?, ?)");
     pstmt.setInt(1, customerid);
     pstmt.setInt(2, type);
     pstmt.setString(3, details);
     pstmt.setInt(4, user.getId());

     int res = pstmt.executeUpdate();
     if (res == 1) {
	      out.println("{\"status\": \"OK\"}");
     } else {
	      out.println("{\"status\": \"Error\", \"message\": \"DB error in INSERT INTO custcomm\"}");
     }
     pstmt.close();
     conn.close();
     return;
  }

  delRecord("customer", "customerid", action.equals("delcustomer"), true /* user.getRole() != User.ACCESS_ADMIN*/, request, out, conn);
  delRecord("documents", "docid", action.equals("deldoc"),  true /* user.getRole() != User.ACCESS_ADMIN*/, request, out, conn);
  delRecord("events", "eventid", action.equals("delevent"),  true /* user.getRole() != User.ACCESS_ADMIN*/, request, out, conn);
  delRecord("users", "userid", action.equals("deluser"),  true /* user.getRole() != User.ACCESS_ADMIN*/, request, out, conn);
  delRecord("tags", "tagid", action.equals("deltag"),  true /* user.getRole() != User.ACCESS_ADMIN*/, request, out, conn);

  out.println("{\"status\": \"Error\", \"message\": \"action parameter unknown '" + action + "'\"}");

%>
