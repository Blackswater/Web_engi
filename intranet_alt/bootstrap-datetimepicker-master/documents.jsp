<!doctype html>
<html>
<head>
   <meta charset="utf-8">
   <title>Intranet Document Manager</title>
   <link rel="stylesheet"
         href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
         integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
         crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.13/dist/vue.js"></script>
    <script type="application/javascript" src="js/multiupload.js"></script>
    <script type="application/javascript" src="js/intranet.js"></script>
    <link rel="stylesheet" href="css/intranet.css">
</head>

<body>

<div id="wrapper" class="container">
    <div class="logo">
        <a href='index.jsp'><img src="images/intranet_logo.jpg" alt="Intranet-Logo" /></a>
    </div>

    <nav id="tabs">
        <ul class="nav nav-tabs">
            <li><a class="nav-link active" data-toggle="tab" href="#tabs-1">Meine aktuellen Dokumente</a></li>
            <li><a class="nav-link" data-toggle="tab" href="#tabs-2">Mein Archiv</a></li>
            <li><a class="nav-link" data-toggle="tab" href="#tabs-4">Upload</a></li>
            <li><a class="nav-link" data-toggle="tab" href="#tabs-5">Tags (Admin only)</a></li>
	  </ul>
   </nav>

<div class="tab-content">
        <div id="tabs-1" class="tab-pane fade show active">
            <h2>Meine aktuellen Dokumente</h2>

	<div class="tags-box" id="tags-box">
	  Suche: <input id="docSearch" size="15" placeholder="Titelsuche"
	  style="width: 160px; height: 22px;">
	  Filter:  <span class="btn tag tag_inactive tag_kunde" onClick="$('#doc1').toggle(200); tag(this);">LidlSchwarz</span>
	    <span class="btn tag tag_inactive tag_abteilung" onClick="$('#doc1').toggle(200); tag(this);">Buchhaltung</span>
	    <span class="btn tag tag_inactive tag_kategorie" onClick="$('#doc1').toggle(200); tag(this);">DRINGEND</span>
	  </div>
  <div class="docs-box" id="docs-box">
                <div class=doc onClick="document.location='testdocument.pdf'"><img src="images/pdf.png" width=32> Abrechnung Feb-Lidl<BR>
                    <span class=author>Richard Hofreiter, 23. 02. 2016</span><BR>
                    <span class="tag_abteilung tag tag_active">Abteilung:Buchhaltung</span>
                    <span class="tag_kunde tag tag_active">Kunde:SchwarzLidl</span>
                    <span class="tag_kategorie tag tag_active">DRINGEND</span>
                </div>
                <div class=doc
	  onClick="document.location='testdocument.pdf'"><img
	  src="images/pdf.png" width=32> Auftrag Kaufland<BR>
                    <span class=author>Wolfgang A. Mozart, 23. 02. 2016</span><BR>
                    <span class="tag_abteilung tag tag_active">Abteilung:Buchhaltung</span>
                    <span class="tag_kunde tag tag_active">Kunde:SchwarzLidl</span>
                    <span class="tag_kategorie tag tag_active">DRINGEND</span>
                </div>
                <div class=doc
	  onClick="document.location='testdocument.pdf'"><img
	  src="images/pdf.png" width=32> Bildnachweis<BR>
                    <span class=author>Little Richard, 23. 02. 2016</span><BR>
                    <span class="tag_abteilung tag tag_active">Abteilung:Buchhaltung</span>
                    <span class="tag_kunde tag tag_active">Kunde:SchwarzLidl</span>
                    <span class="tag_kategorie tag tag_active">DRINGEND</span>
                </div>
                <div class=doc onClick="document.location='testdocument.pdf'"><img src="images/pdf.png" width=32> Abrechnung Feb-Lidl<BR>
                    <span class=author>Sir Elton John, 23. 02. 2016</span><BR>
                    <span class="tag_abteilung tag tag_active" onClick='tag(this)'>Abteilung:Buchhaltung</span>
                    <span class="tag_kunde tag tag_active" onClick='tag(this)'>Kunde:SchwarzLidl</span>
                    <span class="tag_kategorie tag tag_active" onClick='tag(this)'>DRINGEND</span>
                </div>
                <div class=doc onClick="document.location='testdocument.pdf'"><img src="images/pdf.png" width=32> Abrechnung Feb-Lidl<BR>
                    <span class=author>Michael Janich, 23. 02. 2016</span><BR>
                    <span class="tag_abteilung tag tag_active" onClick='tag(this)'>Abteilung:Buchhaltung</span>
                    <span class="tag_kunde tag tag_active" onClick='tag(this)'>Kunde:SchwarzLidl</span>
                    <span class="tag_kategorie tag tag_active" onClick='tag(this)'>DRINGEND</span>
                </div>
  </div>
        <div style="clear:both;"></div>
        </div>

        <div id="tabs-2"  class="tab-pane fade">
            <h2>Archivierte Dokumente</h2>
            <div class="docs-box">
                <div class=doc onClick="document.location='testdocument.pdf'"><img src="images/pdf.png" width=32> Abrechnung Feb-Lidl<BR>
                    <span class=author>Richard Hofreiter, 23. 02. 2016</span><BR>
                    <span class="tag_abteilung tag tag_active" onClick='tag(this)'>Abteilung:Buchhaltung</span>
                    <span class="tag_kunde tag tag_active" onClick='tag(this)'>Kunde:SchwarzLidl</span>
                    <span class="tag_kategorie tag tag_active" onClick='tag(this)'>DRINGEND</span>
                </div>
                <div style="clear:both;"></div>
            </div>
        </div>

        <div id="tabs-3" class="tab-pane fade">
            <h2>Text Suche</h2>

            <form><input id="docSearch2" size="50" placeholder="Suche im Titel des Dokuments">

            <h2>Tag Suche</h2>
            <p>Abteilung:
                <span class="tag_abteilung tag tag_inactive" onClick="tag(this)">Buchhaltung</span>
                <span class="tag_abteilung tag tag_inactive" onClick='tag(this)'>Vertrieb</span>
                <span class="tag_abteilung tag tag_inactive" onClick='tag(this)'>Herstellung</span>
            </p>
            <p>Kunde:
                <span class="tag_kunde tag tag_inactive" onClick='tag(this)'>Heideldruck</span>
                <span class="tag_kunde tag tag_inactive" onClick='tag(this)'>LidlSchwarz</span>
                <span class="tag_kunde tag tag_inactive" onClick='tag(this)'>Aldi</span>
                <span class="tag_kunde tag tag_inactive" onClick='tag(this)'>DHBW</span>
                <span class="tag_kunde tag tag_inactive" onClick='tag(this)'>IBM</span>
            </p>
            <p>Kategorie:
                <span class="tag_kategorie tag tag_inactive" onClick='tag(this)'>WICHTIG</span>
                <span class="tag_kategorie tag tag_inactive" onClick='tag(this)'>Auftrag</span>
                <span class="tag_kategorie tag tag_inactive" onClick='tag(this)'>Ablage</span>
            </p>
	  <h2>Zeitraum Suche</h2>
	  <P><input class="datum" type="date" name="datefrom"> - <input class="datum" type="date" name="dateto"></P>

    <p>
        <button class="submit" type="submit" name="submitHandler" value="Suchen" id="submitButton">
            <img src="images/suche.png" alt="upload" width="30" />  <span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;Suchen</span>
        </button>
    </p>
	  </form>
        </div>

        <div id="tabs-4" class="tab-pane fade">
            <h2>Upload-Center</h2>
            <div id="dragAndDropFiles" class="uploadArea">
                Dateien hier ablegen
            </div>

        <div id=rechte>
        <form>
        <p><input size="40" maxlength="100" placeholder="Beschreibung des Dokuments"></p>
        </form>
        <h2>Zugriffsrechte</h2>

<span class="tag_rechte tag tag_active" onClick='tag(this)'>Buchhaltung nur lesen</span>
<span class="tag tag_rechte tag_inactive" onClick='tag(this)'>Buchhaltung lesen+aendern</span>

<span class="tag tag_rechte tag_active" onClick='tag(this)'>Vertrieb nur lesen</span>
<span class="tag tag_rechte tag_inactive" onClick='tag(this)'>Vertrieb lesen+aendern</span>

<span class="tag tag_rechte tag_active" onClick='tag(this)'>Herstellung nur lesen</span>
<span class="tag tag_rechte tag_inactive" onClick='tag(this)'>Herstellung lesen+aendern</span>
</div>

<div id=kategorien>
<h2>Tags</h2>

<P>Abteilungen:
<span class="tag tag_abteilung tab_abteilung tag_inactive" onClick='tag(this)'>Buchhaltung</span>
<span class="tag tag_abteilung tab_abteilung tag_inactive" onClick='tag(this)'>Vertrieb</span>
<span class="tag tag_abteilung tab_abteilung tag_inactive" onClick='tag(this)'>Herstellung</span>

<P>Kunden:
<span class="tag tag_kunde tag_inactive" onClick='tag(this)'>Heideldruck</span>
<span class="tag tag_kunde tag_inactive" onClick='tag(this)'>LidlSchwarz</span>
<span class="tag tag_kunde tag_inactive" onClick='tag(this)'>Aldi</span>
<span class="tag tag_kunde tag_inactive" onClick='tag(this)'>DHBW</span>
<span class="tag tag_kunde tag_inactive" onClick='tag(this)'>IBM</span>

<P>Kategorien:
<span class="tag tag_kategorie tag_inactive" onClick='tag(this)'>DRINGEND</span>
<span class="tag tag_kategorie tag_inactive" onClick='tag(this)'>Auftrag</span>
<span class="tag tag_kategorie tag_inactive" onClick='tag(this)'>Ablage</span>
</div>

<form name="demoFiler" id="demoFiler" enctype="multipart/form-data">
    <input type="file" name="multiUpload" id="multiUpload" multiple />

    <button class="submit" type="submit" name="submitHandler" value="Upload" id="submitButton">
        <img src="images/upload.png" alt="upload" width="30" />  <span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;Upload</span>
    </button>
</form>

<div class="progressBar">
<div class="status"></div></div>
</div>

<div id="tabs-5" class="tab-pane fade">

  <h2>Tag Manager</h2>
  <P>TODO:</P>
  <ul>
    <li>Load all tags from "jsontags.jsp"
    <li>Display all tags, offer "edit" ✎ and "delete" 🗑 functions
    <li>Off "add" as a plus, eg. <span class="btn tag">+</span>
  </ul>

</div>
</div>
</div>
</div>

</html>
