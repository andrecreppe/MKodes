#include <Wire.h>
#include <AS5600.h>
#include <SparkFun_TB6612.h>

// Definição dos pinos do motor e controle
#define AIN1 22   // Pino AIN1 do motor
#define AIN2 23   // Pino AIN2 do motor
#define PWMA 2    // Pino PWM do motor
#define STBY 24   // Pino Standby do motor

// Definição dos pinos do sensor ultrassônico
#define TRIG_PIN 53 // Pino TRIG do sensor ultrassônico
#define ECHO_PIN 51 // Pino ECHO do sensor ultrassônico

// Configuração do motor
const int offsetA = 1;
Motor motor1 = Motor(AIN1, AIN2, PWMA, offsetA, STBY); // Inicialização do motor

// Configuração do sensor Hall
AS5600 as5600;

// Variáveis do PID de posição
float Kp_pos = 100.0, Ki_pos = 0.0, Kd_pos = 6.0; // Ganhos do PID de posição
float erro_pos = 0, erro_pos_anterior = 0, erro_acumulado_pos = 0;

// Variáveis do PID de ângulo
float Kp_ang = 14, Ki_ang = 0.0, Kd_ang = 4.0; // Ganhos do PID de ângulo
float erro_ang = 0, erro_ang_anterior = 0, erro_acumulado_ang = 0;

// Alvos
float targetDistance = 15;  // Distância alvo em cm
float targetAngle = 0;      // Ângulo alvo em graus
float initAngle = 0;

bool pidAnguloAtivo = true;

void setup() {
  Serial.begin(9600); // Inicializa a comunicação serial com o baud rate de 9600

  // Inicializar o sensor ultrassônico
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  // Inicializar o sensor Hall (AS5600)
  Wire.begin(); // Para Arduino Mega, SDA (20) e SCL (21) já são atribuídos automaticamente
  as5600.begin();

  // Verifica se o sensor Hall está conectado
  if (as5600.isConnected()) {
    Serial.println("Sensor Hall conectado.");
  } else {
    Serial.println("Erro: Sensor Hall não conectado.");
  }

  initAngle = as5600.readAngle() * 0.0879;

  // Inicializa o motor no estado ativo
  digitalWrite(STBY, HIGH);
  Serial.println("Configuração concluída.");
}

void loop() {
  // Recebe comandos via Serial
  receberDadosSerial();

  // === LEITURA DOS SENSORES ===
  float distance = getUltrasonicDistance(); // Distância do sensor ultrassônico
  int rawAngle = as5600.readAngle();
  float angleInDegrees = rawAngle * 0.0879 - initAngle; // Ângulo em graus
  
  // === CÁLCULO DO PID DE ÂNGULO (ATIVO OU NÃO) ===
  erro_ang = targetAngle - angleInDegrees;
  erro_acumulado_ang += erro_ang;
  float derivada_ang = erro_ang - erro_ang_anterior;
  float forca_ang = Kp_ang * erro_ang + Ki_ang * erro_acumulado_ang + Kd_ang * derivada_ang;
  erro_ang_anterior = erro_ang;

  // === CÁLCULO DO PID DE POSIÇÃO ===
  erro_pos = targetDistance - distance;
  erro_acumulado_pos += erro_pos;
  float derivada_pos = erro_pos - erro_pos_anterior;
  float forca_pos = Kp_pos * erro_pos + Ki_pos * erro_acumulado_pos + Kd_pos * derivada_pos;
  erro_pos_anterior = erro_pos;

  // === CONTROLE DO MOTOR ===
  float forca_total;
  if (pidAnguloAtivo) {
    forca_total = -forca_pos + forca_ang;  // Usa PID de ângulo
  } else {
    forca_total = -forca_pos;  // Apenas PID de posição
  }

  // Limita o valor de força total para o intervalo permitido do motor
  forca_total = constrain(forca_total, -255, 255);

  // Aplica a força ao motor
  if (forca_total > 0) {
    motor1.drive(-forca_total); // Para frente
  } else {
    motor1.drive(-forca_total); // Para trás
  }

  // === DEBUG NO SERIAL ===
  Serial.print("Distância: ");
  Serial.print(distance);
  Serial.print(" cm, Ângulo: ");
  Serial.print(angleInDegrees);
  Serial.print(" graus, Força Total: ");
  Serial.println(forca_total);

  delay(100); // Intervalo de controle
}

float getUltrasonicDistance() {
  // Envia um pulso de 10 microsegundos no pino TRIG
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  // Calcula a duração do pulso no ECHO
  long duration = pulseIn(ECHO_PIN, HIGH);

  // Calcula a distância em centímetros
  float distance = duration * 0.034 / 2;
  return distance;
}

void receberDadosSerial() {
  // Verifica se há dados disponíveis na porta serial
  if (Serial.available()) {
    String comando = Serial.readStringUntil('\n'); // Lê o comando até o caractere '\n'

    // Se o comando começar com 'T', define a posição alvo
    if (comando.startsWith("T")) {
      targetDistance = comando.substring(1).toFloat(); // Extrai o valor após 'T'
      Serial.print("Nova posição alvo: ");
      Serial.println(targetDistance);
    } 
    // Ativa ou desativa o PID de ângulo
    else if (comando == "A1") {
      pidAnguloAtivo = true;  // Ativa o PID de ângulo
      Serial.println("PID de Ângulo: Ativado");
    } 
    else if (comando == "A0") {
      pidAnguloAtivo = false;  // Desativa o PID de ângulo
      Serial.println("PID de Ângulo: Desativado");
    }
  }
}
