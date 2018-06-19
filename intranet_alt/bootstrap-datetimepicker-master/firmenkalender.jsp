    <%@ page contentType="text/html; charset=UTF-8" %>
        <%@ page import="com.chimerasys.User" %>
            <%
    User u = (User) session.getAttribute("user");

    if (u == null) {

       response.sendRedirect(request.getContextPath() + "/login.jsp");

    }
%>
        <!doctype html>
        <html>
        <!--
        TODO KOMMENTIERUNG
        TODO SORTIERUNG NACH DATUM IMPLEMENTIEREN
        TODO JS IN EXTRA DATEI AUSLAGERN
        TODO WEBLINKS ALS "RICHTIGEN" LINK DARSTELLEN
        -->
        <head>
        <title>Corporate Calendar</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
        integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
        <link rel="stylesheet" href="css/firmenkalender.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script>
        $(document).ready(function () {
        $("#myInput").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#calendarContainer *").filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
        });
        });
        </script> <!-- jQuery Filterbar -->
        </head>

        <body>

        <div class="jumbotron text-center">
        <img src="images/dhbw_mosbach_2014.gif" height="75" width="360" align="justify"/>
        </div>

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark" id="navBar">
        <ul class="navbar-nav">
        <li class="nav-item">
        <a class="nav-link" href="#">Startseite</a>
        </li>
        <li class="nav-item">
        <a class="nav-link" onclick="renderTileView()">Kachelansicht</a>
        </li>
        <li class="nav-item">
        <a class="nav-link" onclick="renderListView()">Listenansicht</a>
        </li>
        <li class="nav-item">
        <a class="nav-link" href="#">Kalenderansicht</a>
        </li>
        </ul>
        <input id="myInput" type="text" placeholder="Search..">
        </nav>

        <div class="container" id="calendarContainer">

        </div>
        <script>
        function renderListView() {
        document.getElementById("calendarContainer").innerHTML = (null);
        var xmlhttp = new XMLHttpRequest();
        var url = "../JavaScript/calendar.json";

        xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
        var jsonevents = JSON.parse(this.responseText);

        for (var i = 0; i < jsonevents.events.length; i++) {
        var accordionButton = document.createElement("BUTTON");

        accordionButton.innerHTML = (jsonevents.events[i].name + " " + jsonevents.events[i].dtStart);
        accordionButton.setAttribute("class", "accordion");
        accordionButton.setAttribute("data-date", jsonevents.events[i].dtStart);

        var chapterContent = document.createElement("DIV");
        chapterContent.setAttribute("class", "panel");

        chapterContent.innerHTML = (
        "Ersteller: " + jsonevents.events[i].owner.firstname + " " + jsonevents.events[i].owner.lastname + " (" +
        jsonevents.events[i].owner.email + ") <br />" +
        "Terminbeginn: " + jsonevents.events[i].dtStart + "<br />" +
        "Terminende: " + jsonevents.events[i].dtEnd + "<br />" +
        "Kommentare: " + jsonevents.events[i].comment + "<br />" +
        "Weblinks: " + jsonevents.events[i].url + "<br />" +
        "Tags: " + jsonevents.events[i].tags[0].label + " " + jsonevents.events[i].tags[0].category + "<br />"
        );

        document.getElementById('calendarContainer').appendChild(accordionButton);
        document.getElementById('calendarContainer').appendChild(chapterContent);
        }
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
        this.classList.toggle("active");
        var panel = this.nextElementSibling;
        if (panel.style.display === "block") {
        panel.style.display = "none";
        } else {
        panel.style.display = "block";
        }
        });
        }
        }
        };

        xmlhttp.open("GET", url, true);
        xmlhttp.send();
        }
        </script>
        <script>
        function renderTileView() {
        document.getElementById("calendarContainer").innerHTML = (null);
        var xmlhttp = new XMLHttpRequest();
        var url = "../JavaScript/calendar.json";

        xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
        var jsonevents = JSON.parse(this.responseText);

        var cardColumnsContainer = document.createElement("DIV");
        cardColumnsContainer.setAttribute("class", "card-columns");
        document.getElementById('calendarContainer').appendChild(cardColumnsContainer);

        for (var i = 0; i < jsonevents.events.length; i++) {

        var cardElement = document.createElement("DIV");
        cardElement.setAttribute("class", "card");
        cardElement.setAttribute("data-date", jsonevents.events[i].dtStart);
        cardColumnsContainer.appendChild(cardElement);

        var cardElementCentering = document.createElement("DIV");
        cardElementCentering.setAttribute("class", "card-body text-center accordion");

        cardElementCentering.innerHTML = (
        jsonevents.events[i].name + " " + jsonevents.events[i].dtStart + "<br />" +

        "Ersteller: " + jsonevents.events[i].owner.firstname + " " + jsonevents.events[i].owner.lastname + " (" +
        jsonevents.events[i].owner.email + ") <br />" +
        "Terminbeginn: " + jsonevents.events[i].dtStart + "<br />" +
        "Terminende: " + jsonevents.events[i].dtEnd + "<br />" +
        "Kommentare: " + jsonevents.events[i].comment + "<br />" +
        "Weblinks: " + jsonevents.events[i].url + "<br />" +
        "Tags: " + jsonevents.events[i].tags[0].label + " " + jsonevents.events[i].tags[0].category + "<br />"
        );
        cardElement.appendChild(cardElementCentering);

        //TODO: KEINE AUFKLAPPFUNTKION; DIE TERMINE WERDEN SOFORT VOLLSTÄNDIG ANGEZEIGT
        }

        }
        };

        xmlhttp.open("GET", url, true);
        xmlhttp.send();
        }
        </script>
        <script src="../JavaScript/getJson.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
        </body>
        </html>
