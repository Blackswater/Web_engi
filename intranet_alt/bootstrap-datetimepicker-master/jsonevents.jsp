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
    User user = (User) session.getAttribute("user");
    if (user == null) {
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
    String tagFilters[] = request.getParameterValues("tag");
    java.util.Date d;
    if (conn == null) { out.println("{\"events\":[],\"status\":\"error\", \"message\": \"Kann keine Verbindung mit der Datenbank aufnehmen\"}"); return; }
    stmt = conn.createStatement();
    int oldID = -1;
    Collection<Tag> tags = new ArrayList<Tag>();
    Collection<Event> events = new ArrayList<Event>();
    // TODO: left outer join the tags (otherwise, no tags, no result)
    ResultSet rs = stmt.executeQuery("SELECT e.id, e.name, e.dtstart, e.dtend, e.creationdate, e.deletiondate, e.comment, e.url, o.id, o.firstname, o.lastname, o.email, t.id, t.category, t.label FROM events e, users o, tags t, eventtags et WHERE e.ownerid=o.id AND et.tagid=t.id AND et.eventid=e.id ORDER BY e.dtstart DESC");
    while (rs.next()) {
	if (rs.getInt(1) != oldID) {
	    Event evt = new Event(rs.getInt(1));
	    evt.setName(rs.getString("name"));
	    evt.setComment(rs.getString("comment"));
	    evt.setUrl(rs.getString("url"));
	    evt.setStartdate(rs.getTimestamp("dtstart"));
	    evt.setEnddate(rs.getTimestamp("dtend"));
	    evt.setCreationdate(rs.getTimestamp("creationdate"));
	    evt.setDeletiondate(rs.getTimestamp("deletiondate"));
	    // TODO: more fields
	    User u = new User(rs.getInt("o.id"));
	    u.setFirstname(rs.getString("o.firstname"));
	    u.setLastname(rs.getString("o.lastname"));
	    u.setEmail(rs.getString("o.email"));
	    // TODO: more fields
	    evt.setOwner(u);
	    evt.setTags(tags);
	    events.add(evt);
	    tags.clear();
	}
	Tag t = new Tag(rs.getInt("t.id"));
	t.setCategory(rs.getString("t.category"));
	t.setLabel(rs.getString("t.label"));
	// TODO: t.setCss();
	tags.add(t);
	
	oldID = rs.getInt(1);
	
    }
    out.print("{ \"status\": \"ok\", \"events\":");
    out.println(gson.toJson(events));
    out.println("}");
    rs.close();
    stmt.close();
    conn.close();
%>
