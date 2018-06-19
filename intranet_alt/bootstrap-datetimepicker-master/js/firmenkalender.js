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
                    "Ersteller: " + jsonevents.events[i].owner.firstname + " " + jsonevents.events[i].owner.lastname + " (" + jsonevents.events[i].owner.email + ") <br />" +
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

                    "Ersteller: " + jsonevents.events[i].owner.firstname + " " + jsonevents.events[i].owner.lastname + " (" + jsonevents.events[i].owner.email + ") <br />" +
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