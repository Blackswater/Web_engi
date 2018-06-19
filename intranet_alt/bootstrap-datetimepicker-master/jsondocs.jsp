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
    String tagFilters[] = request.getParameterValues("tag");
    java.util.Date d;
    if (conn == null) { out.println("{\"docs\":[],\"status\":\"error\", \"message\": \"Kann keine Verbindung mit der Datenbank aufnehmen\"}"); return; }
    stmt = conn.createStatement();
    int oldID = -1;
    Collection<Tag> tags = new ArrayList<Tag>();
    Collection<Document> docs = new ArrayList<Document>();
    // TODO: left outer join the tags, otherwise no tags = no result
    ResultSet rs = stmt.executeQuery("SELECT d.id, d.name, d.filename, d.creationdate, d.archivedate, d.deletiondate, d.mimetype, d.bytelength, o.firstname, o.lastname, o.id, t.id, t.category, t.label FROM documents d, users o,tags t, documenttags dt WHERE d.ownerid=o.id AND dt.tagid=t.id AND dt.documentid=d.id ORDER BY d.id,d.creationdate DESC");
    while (rs.next()) {
	if (rs.getInt(1) != oldID) {
	    Document doc = new Document(rs.getInt(1));
	    doc.setName(rs.getString("name"));
	    doc.setFilename(rs.getString("filename"));
	    doc.setCreationdate(rs.getTimestamp("creationdate"));
	    doc.setArchivedate(rs.getTimestamp("archivedate"));
	    doc.setDeletiondate(rs.getTimestamp("deletiondate"));
	    doc.setMimetype(rs.getString("mimetype"));
	    doc.setBytelength(rs.getInt("bytelength"));
	    // TODO: more fields
	    User u = new User(rs.getInt("o.id"));
	    u.setFirstname(rs.getString("o.firstname"));
	    u.setLastname(rs.getString("o.lastname"));
	    // TODO: more fields
	    doc.setOwner(u);
	    doc.setTags(tags);
	    docs.add(doc);
	    tags.clear();
	}
	Tag t = new Tag(rs.getInt("t.id"));
	t.setCategory(rs.getString("t.category"));
	t.setLabel(rs.getString("t.label"));
	// TODO: t.setCss();
	tags.add(t);
	
	oldID = rs.getInt(1);
	
    }
    out.print("{ \"status\": \"ok\", \"docs\":");
    out.println(gson.toJson(docs));
    out.println("}");
    rs.close();
    stmt.close();
    conn.close();
%>
