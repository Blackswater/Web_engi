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
<%@ page import="com.google.gson.*" %>
<%@ page import="com.chimerasys.*" %>

<%@ page errorPage="error.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:declaration>
Statement stmt;
PreparedStatement pstmt;
Connection conn;
Context initContext, envContext;
javax.sql.DataSource ds;
SimpleDateFormat dateFormat, dateTimeFormat, ISOFormat;
String userid, useremail;
PasswdUtility pwdUtil;
</jsp:declaration>

    <%
    response.setHeader("Access-Control-Allow-Origin","*");
    dateFormat = new SimpleDateFormat("dd MMM yyyy", Locale.GERMAN);
    dateTimeFormat = new SimpleDateFormat("dd MMM yyyy 'um' HH:mm", Locale.GERMAN);
    ISOFormat = new SimpleDateFormat("yyyy-MM-dd");
    userid = (String) session.getAttribute("userid");
    useremail = (String) session.getAttribute("useremail");
    if (userid == null || userid.length() == 0) {
        // response.sendRedirect("login.jsp");
    }
    if (pwdUtil == null) {
        pwdUtil = new PasswdUtility();
    }
    Gson gson = new Gson();

try {
      initContext = new InitialContext();
      envContext  = (Context)initContext.lookup("java:/comp/env");
      ds = (javax.sql.DataSource)envContext.lookup("jdbc/intranet");
      conn = ds.getConnection(); 

  } catch (Exception ex) {
          System.err.println(ex.getClass().getName() + ": " + ex.getMessage());
	  out.println("Fehler in der Datenbank: " + ex.getClass().getName() + ": " + ex.getMessage());
//Logger.getLogger(this.class.getName()).log(Level.SEVERE, null, ex);
  }

    boolean isFirst = true;
    java.util.Date d;
    if (conn == null) { out.println("{\"users\":[],\"status\":\"error\", \"message\": \"Kann keine Verbindung mit der Datenbank aufnehmen\"}"); return; }
    stmt = conn.createStatement();
    int oldID = -1;
    Collection<User> users = new ArrayList<User>();
    ResultSet rs = stmt.executeQuery("SELECT id, email, firstname, lastname, accesslevel, creationdate, deletiondate FROM users WHERE deletiondate is null ORDER BY lastname, firstname");
    while (rs.next()) {
	User u = new User(rs.getInt("id"));
	u.setFirstname(rs.getString("firstname"));
	u.setLastname(rs.getString("lastname"));
	u.setEmail(rs.getString("email"));
	u.setRole(rs.getInt("accesslevel"));
	//u.setCreationdate(rs.getTimestamp("creationdate"));
	users.add(u);
    }
    out.print("{ \"status\": \"ok\", \"users\":");
    out.println(gson.toJson(users));
    out.println("}");
    rs.close();
    stmt.close();
    conn.close();
%>
