<%@ page import="com.chimerasys.User" %>
<%  User u = (User) session.getAttribute("user");
    if (u != null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
    String email = request.getParameter("email");  
    String password = request.getParameter("password");
    if (email != null && password != null) {
        u = new User(1);
        u.setEmail(email);
        u.setFirstname("Michael");
        u.setLastname("Janich");
        session.setAttribute("user", u);
        response.sendRedirect(request.getContextPath() + "/index.jsp");
     }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Intranet Login</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="js/multiupload.js"></script>
    <script type='application/javascript' src="js/intranet.js"></script>
    <link rel="stylesheet" href="css/intranet.css">
</head>

<body>
<div id="wrapper">
    <div class="logo">
        <img src="images/intranet_logo.jpg" alt="Intranet-Logo" />
    </div>

    <h1>Intranet Login</h1>
 
    <form action='login.jsp' method='POST'>
    <input type='email' name='email' focus placeholder='username@example.de'><br>
    <input type='password' name='password'><br>
    <input type='submit' value='Einloggen'>
    </form>
    
</div>

</html>
