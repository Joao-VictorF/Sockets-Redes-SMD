import processing.net.*;

Server myServer;
int dataIn = 220;

void setup() {
  frameRate = 1;
  size(200, 200);
  myServer = new Server(this, 5204); 
  noLoop();
}

void draw() {
 background(dataIn);
}

void serverEvent(Server someServer, Client someClient) {
  println("Cliente conectado!");
}

void disconnectEvent(Client someClient){
  println("Cliente desconectado!");
}

void clientEvent(Client client) {
  String message = client.readString();
  println("Mensagem recebida!");
  println(message);
  myServer.write(message);
}
