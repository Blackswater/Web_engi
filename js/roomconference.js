

var tagArray = { "status": "ok", "tags":[
    {"id":12,"category":"Abteilung","label":"asdhjasdhfsa","cssClass":"tagcat1","creationDate":"May 18, 2018 12:44:21 PM","deletionDate":"May 18, 2018 12:45:50 PM"},
    {"id":2,"category":"Abteilung","label":"Buchhaltung","cssClass":"tagcat1","creationDate":"Mar 8, 2018 2:45:30 PM","deletionDate":"May 18, 2018 11:20:44 AM"},
    {"id":3,"category":"Abteilung","label":"Intern","cssClass":"tagcat1","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":4,"category":"Abteilung","label":"Manufaktur","cssClass":"tagcat1","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":1,"category":"Abteilung","label":"Vertrieb","cssClass":"tagcat1","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":11,"category":"Calendar","label":"Corporate","cssClass":"tagcat4","creationDate":"May 15, 2018 10:29:08 PM","deletionDate":"May 18, 2018 9:08:55 AM"},
    {"id":10,"category":"Kategorie","label":"Ablage","cssClass":"tagcat3","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":9,"category":"Kategorie","label":"DRINGEND","cssClass":"tagcat3","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":8,"category":"Kategorie","label":"WICHTIG","cssClass":"tagcat3","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":5,"category":"Kunde","label":"Heideldruck","cssClass":"tagcat2","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":6,"category":"Kunde","label":"LidlSchwarz","cssClass":"tagcat2","creationDate":"Mar 8, 2018 2:45:30 PM"},
    {"id":7,"category":"BOSS","label":"Kaufland","cssClass":"tagcat2","creationDate":"Mar 8, 2018 2:45:30 PM"}]
}


$("div#Eingabe").toggle();
/* Ajax zum daten runterladen der JsonEvents 
$(document).ready(function () {
    $.get("jsonevents.jsp", function (data, status) {
        if (this.status == "success" && this.readyState == 4) {
            Daten = data.docs;

            console.log(Daten);
            document.getElementById('alert').innerHTML = "<div class='alert alert-success'>Erfolgreich!</div>";
        }
    }, "json").fail(FehlerdatenLaden());
});

/* Ajax zum daten runterladen der JsonTags 
$(document).ready(function () {
    $.get("jsontags.jsp", function (data, status) {
        if (this.status == "success" && this.readyState == 4) {
            Daten = data.docs;

            console.log(Daten);
            document.getElementById('alert').innerHTML = "<div class='alert alert-success'>Erfolgreich!</div>";
        }
    }, "json").fail(FehlerdatenLaden());
});
*/

$(document).ready(function () {
    fillStandardFormular();
});

/* Ajax zum daten runterladen der JsonEvents */
function loadData(jspFile) {
    $(document).ready(function () {
        $.get(jspFile, function (data, status) {
            if (this.status == "success" && this.readyState == 4) {
                return data.docs;
            }
        }, "json").fail(FehlerdatenLaden());
    });
}

/* Anzeige, wenn das Laden fehlgeschlagen ist*/
function FehlerdatenLaden() {
    document.getElementById('alert').innerHTML = "<div class='alert alert-danger'><strong>Fehlgeschlagen!</strong> Herunterladen fehlgeschlagen.</div>";
}
/* Rein laden der Tags in das Formular */

/*Laden der Tags zum auswählen */
function fillStandardFormular() {
   /* for(var tags in loadData("jsontags.jsp")) {
        document.getElementById("tags").innerHTML += "<option>" + tags +"</option>";
    }
    */
     for(TAG in tagArray.tags) {
        document.getElementById("tags").innerHTML += "<option>" + tagArray.tags[TAG].label +"</option>";
    }
}

/*Update der jsonevents.jsp*/
function eventUpdate() {
    var betreff = $("#betreff").val();
    var zeitAnf = $("#zeitAnf").val();
    var zeitEnd = $("#zeitEnd").val();
    var commentar = $("#commentar").val();
    var location = $("#location").val();
    var url = $("#url").val();
    //var tags = $("#tags").val();
    var serverAction = "newevent";
    $.get("update.jsp", {
        /*Tagparameter in der update.jsp für newevent nicht gefunden */
        action: serverAction, name: betreff, dtStart: zeitAnf, dtEnd: zeitEnd, location: location,
        comment: commentar, url: url
    }, function (data) {
        if (!hasValue(data, status) && data.status.toLowerCase() == 'ok') {
            roomBookingSucces();
        } else {
            roomBookingFailed();
        }
    }, "json").fail(roomBookingFailed());
};
function roomBookingFailed() {
    document.getElemntById('alert').innerHTML = "<div class='alert alert-danger'><string>Serverskript oder Anlegen-/Editierfunktion anscheinden nicht vorhanden oder keine Verbindung zum Server!</div>";
}

function roomBookingSuccess() {
    document.getElemntById('alert').innerHTML = "<div class='alert alert-danger'><string>Buchung erfolgreich!</div>";
}
function hasValue(obj) {
    return obj != null && obj != undefined && obj != "";
}