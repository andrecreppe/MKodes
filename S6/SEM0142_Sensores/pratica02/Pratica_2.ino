#define VERDE 13
#define AMARELO 12
#define VERMELHO 11
#define POTENC A5

int data = 0;
float volts = 0;
float angulo = 0;

void setup() {
  pinMode(VERDE, OUTPUT);
  pinMode(AMARELO, OUTPUT);
  pinMode(VERMELHO, OUTPUT);
  pinMode(POTENC, INPUT);
  
  Serial.begin(9600);
  
  digitalWrite(VERDE, HIGH);
  digitalWrite(AMARELO, HIGH);
  digitalWrite(VERMELHO, HIGH);

  delay(1000);

  digitalWrite(VERDE, LOW);
  digitalWrite(AMARELO, LOW);
  digitalWrite(VERMELHO, LOW);
}

void loop() {
  data = analogRead(POTENC);
  volts = (float) ((0.0048828125) * data);
  angulo = ((volts * 180) / 5);
  
  if(angulo < 59) {
    digitalWrite(VERDE, HIGH);
    digitalWrite(AMARELO,LOW);
    digitalWrite(VERMELHO, LOW);
  }
  
  if((angulo < 119) && (angulo > 59)) {
    digitalWrite(VERDE, LOW);
    digitalWrite(AMARELO,HIGH);
    digitalWrite(VERMELHO, LOW);
  }
  
  if((angulo < 180) && (angulo > 119)) {
    digitalWrite(VERDE, LOW);
    digitalWrite(AMARELO,LOW);
    digitalWrite(VERMELHO, HIGH);
  }
  
  Serial.print("Angulo: ");
  Serial.println(angulo);
  delay(100);
}
