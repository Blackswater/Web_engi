<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <title>Erwin Dietz GmbH - Intranet</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="application/javascript" src="js/multiupload.js"></script>
    <script type="application/javascript" src="js/intranet.js"></script>
    <link rel="stylesheet" href="css/intranet.css">
</head>

<body>
<div id="wrapper">
    <div class="logo">
        <a href="index.jsp"><img src="images/intranet_logo.jpg" alt="Iintranet-Logo" /></a>
    </div>

    <h1>Chat</h1>

<span id="status">0 Benutzer im Chat</span>
  <!-- beispiel: 1 user online -->

<div id="historyMsg">
<!-- hier kommen die nachrichten hin -->
</div>

<div class="controls" >

       <div class="items">
            <input id="colorStyle" type="color" placeHolder='#000' title="font color" width=8 />
            <input id="emoji" type="button" value="emoji" title="emoji" />
            <label for="sendImage" class="imageLable">
            <input type="button" value="image"  />
            <br>Bild senden:<br><input id="sendImage" type="file" value="image"/>
            </label>
            <input id="clearBtn" type="button" value="clear" title="clear screen" />
        </div>
                <textarea id="messageInput" placeHolder="enter to send"></textarea>
                <button class="submit" type="submit" name="submitHandler" value="Suchen" id="sendBtn">
                    <img src="images/chat_senden.png" alt="upload" width="30" />  <span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;Nachricht senden</span>
                </button>

                <div id="emojiWrapper">
                </div>
            </div>
        <div id="loginWrapper">
            <p id="info">Serververbindung aufbauen...</p>
            <div id="nickWrapper">
                <input type="text" placeHolder="Ihr Chatname" id="nicknameInput" />
                <input type="button" value="OK" id="loginBtn" />
            </div>
        </div>
        <script src="js/socket.io.js"></script>
        <script src="js/hichat.js"></script>

</div>
</div>
</div>

</html>
