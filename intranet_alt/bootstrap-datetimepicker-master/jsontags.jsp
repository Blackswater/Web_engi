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

<jsp:declaration>
  Statement stmt;
  PreparedStatement pstmt;
  Connection conn;
  Context initContext, envContext;
  javax.sql.DataSource ds;
  SimpleDateFormat dateFormat, dateTimeFormat, ISOFormat;
  User user;
</jsp:declaration>

<%
    response.setHeader("Access-Control-Allow-Origin","*");
    dateFormat = new SimpleDateFormat("dd MMM yyyy", Locale.GERMAN);
    dateTimeFormat = new SimpleDateFormat("dd MMM yyyy 'um' HH:mm", Locale.GERMAN);
    ISOFormat = new SimpleDateFormat("yyyy-MM-dd");
    user = (User) session.getAttribute("user");
    if (user == null) {
        // response.sendRedirect("login.jsp");
    }
    Gson gson = new Gson();

/* connect to database using tomcat database pool */
try {
      initContext = new InitialContext();
      envContext  = (Context)initContext.lookup("java:/comp/env");
      ds = (javax.sql.DataSource)envContext.lookup("jdbc/intranet");
      conn = ds.getConnection();
  } catch (Exception ex) {
     System.err.println(ex.getClass().getName() + ": " + ex.getMessage());
	   out.println("Fehler in der Datenbank: " + ex.getClass().getName() + ": " + ex.getMessage());
  }

    boolean isFirst = true;
    String tagFilters[] = request.getParameterValues("tag");
    java.util.Date d;
    if (conn == null) { out.println("{\"docs\":[],\"status\":\"error\", \"message\": \"Kann keine Verbindung mit der Datenbank aufnehmen\"}"); return; }
    stmt = conn.createStatement();
    int oldID = -1;
    Collection<Tag> tags = new ArrayList<Tag>();
    ResultSet rs = stmt.executeQuery("SELECT t.id, t.category, t.label FROM tags t"
        + " WHERE t.deletiondate is null ORDER BY t.category, t.label");
    while (rs.next()) {
      Tag t = new Tag(rs.getInt("t.id"));
      t.setCategory(rs.getString("t.category"));
      t.setLabel(rs.getString("t.label"));
      // TODO: t.setCss();
      tags.add(t);
    }
    out.print("{ \"status\": \"ok\", \"tags\":");
    out.println(gson.toJson(tags));
    out.println("}");
    rs.close();
    stmt.close();
    conn.close();
%>
