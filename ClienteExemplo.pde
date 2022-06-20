  

import processing.net.*; 

Client client; 
PFont font;
 
String inputText = "";
ArrayList<String> messages = new ArrayList<String>();

int clientID;

void setup() { 
  size(500, 400); 
  client = new Client(this, "127.0.0.1", 5204); 
  font = createFont("Arial", 16);
  clientID = int(random(0, 99999));
} 
 
void draw() { 
  background(255);
  textFont(font);
  fill(0);
  
  text("Cliente " + clientID, 25, 40);
  text("Clique nessa janela e digite algo. Aperte enter para enviar. ", 25, 60);
  text("Mensagem: " + inputText, 25, 100);
  
  if (client.available() > 0) {
    String bufferData = client.readString();
    String[] messageData = split(bufferData, '…');
    int messageClientId = int(messageData[0]);
    String message = messageData[1];

    if (messageClientId !=(clientID)) {
      messages.add(message);
    }
  }
  
  for (int i = 0; i < messages.size(); i++) {
    String message = messages.get(i);
    text(message, 25, 120 + 20 * i);
  }
}

void keyReleased() {
  if (keyCode == 8 && inputText.length() > 0) { // If the delete key is pressed, remove the last char from the String
    inputText = inputText.substring(0, inputText.length() - 1);
  } else if (key == '\n' ) {
    // If the return/enter key is pressed, save the String and clear it
    client.write(clientID + "…" + inputText); // … is a random charactere used to separate the clientId from the message
    inputText = ""; 
  } else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    inputText = inputText + key; 
  }
}
