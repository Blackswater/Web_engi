<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8"/>
    <title>Intranet User Manager</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous"/>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1,shrink-to-fit=no"/>
    <link rel="stylesheet" href="css/intranet.css"/>
  </head>

  <body>
    <div id="wrapper" class="container">
      <div class="logo">
        <a href="index.jsp"><img src="images/intranet_logo.jpg" alt="Intranet-Logo"/></a>
      </div>

      <nav id="tabs">
        <ul class="nav nav-tabs">
          <li><a class="nav-link active" data-toggle="tab" href="#tabs-1">Aktive User</a></li>
          <li><a class="nav-link" data-toggle="tab" href="#tabs-2">Archiv</a></li>
          <li><a class="nav-link" data-toggle="tab" href="#tabs-3">Neuen User Anlegen</a></li>
        </ul>
      </nav>

      <div class="tab-content">
        <div id="tabs-1" class="tab-pane fade show active">
          <h2>Alle Aktiven Nutzer</h2>

          <input type="text" placeholder="Suche nach Namen" id="uSearch" name="uSearch">
            <div class="user-box">
              <div class="card user">
                <div class="card-body">
                  <h1 class="card-title">Walter Scheel</h1>
                  <h6 class="card-subtitle creation">Angelegt am: 13. Apr 2014</h6>
                  <span class="deluser">
                    <button class="btn">Delete</button>
                  </span>
                  <span class="deluser">
                    <button class="btn">Neues Passwort</button>
                  </span>
                </div>
              </div>

              <div class="card user">
                <div class="card-body">
                  <h1 class="card-title">Richard von Weizsäcker</h1>
                  <span class="creation">Angelegt am: 9. Dez 2015</span>
                  <span class="deluser">
                    <button class="btn">Delete</button>
                  </span>
                  <span class="deluser">
                    <button class="btn">Neues Passwort</button>
                  </span>
                </div>
              </div>

              <div class="card user">
                <div class="card-body">
                  <h1 class="card-title">Heinrich Luebke</h1>
                  <span class="creation">Angelegt am: 21. Feb 2013</span>
                  <span class="deluser">
                    <button class="btn">Delete</button>
                  </span>
                  <span class="deluser">
                    <button class="btn">Neues Passwort</button>
                  </span>
                </div>
              </div>

              <div style="clear:both;"></div>

            </div>
          </div>

          <div id="tabs-2" class="tab-pane container fade">
            <h2>Geloeschte User</h2>
            <div class="user-box">
              <div class="user">
                <h1>Alfons Stresemann</h1>
                <span class="creation">Angelegt am: 4. Jun 2013</span>
                <span class="creation">Geloescht am: 17. Feb 2016</span>
                <span calss="deluser">
                  <button>Reaktivieren</button>
                </span>
              </div>
              <div style="clear:both;"></div>
            </div>
          </div>

          <div id="tabs-3" class="tab-pane container fade">
            <h2>Neuen User Anlegen</h2>

            <form>
              <input size="50" placeholder="Vorname"/>
              <input size="50" placeholder="Nachname"/>
              <input size="50" placeholder="max@musterman.de" type="email"/>
              <input size="16" placeholder="Passwort" type="password"/>
              <input size="16" placeholder="Passwort Wiederholung" type="password"/>
              <input type="submit" value="Speichern"/>
            </form>
          </div>

        </div>
      </div>
    </div>
  </div>

</html>
