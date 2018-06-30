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

function fillStandardFormular() {
    for(var tags in loadData("jsontags.jsp")) {
        document.getElementById("tags").innerHTML += "<option>" + tags +"</option>";
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