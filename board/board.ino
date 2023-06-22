#include <ESP8266WiFi.h>            
#include <ESP8266WebServer.h>
#include <Servo.h>
ESP8266WebServer server(80);  
Servo servo;
void setup() {

Serial.begin(9600);
servo.attach(5);
WiFi.begin("Oppo A3s", "");
if (WiFi.status() != WL_CONNECTED)  {
    Serial.println(WiFi.localIP());
  }
  server.on("/securebox", securebox);
  server.begin();
}

void standby()  {
  Serial.print("Standby");
  }

void securebox()  {
    Serial.println(server.arg("status"));
    if (server.arg("status") == "open") {
      servo.write(0);
      
      } else if (server.arg("status" == "close")) {
          servo.write(180);
        }
      delay(250);
      servo.write(90);
      server.send(200, "text/plain", "Door is " + server.arg("status"));
      
  }

void loop() {
  server.handleClient();
  }
