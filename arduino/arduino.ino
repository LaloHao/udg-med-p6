const int pwmPin = 9;
int command;
float tmpVoltaje, voltajes[] = {0, 0.75, 1.5, 2.25, 3, 3.75, 4.5};

void setup()
{
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
}

void loop()
{
  while(Serial.available() > 0)
  {
    command = Serial.read();
    switch(command)
    {
      case '1':
        tmpVoltaje = voltajes[0];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      case '2':
        tmpVoltaje = voltajes[1];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      case '3':
        tmpVoltaje = voltajes[2];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      case '4':
        tmpVoltaje = voltajes[3];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      case '5':
        tmpVoltaje = voltajes[4];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      case '6':
        tmpVoltaje = voltajes[5];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      case '7':
        tmpVoltaje = voltajes[6];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        delay(500);
        Serial.print(analogRead(A0));
        delay(250);
        Serial.print(analogRead(A1));
        break;
      default:
        tmpVoltaje = voltajes[0];
        tmpVoltaje = tmpVoltaje * (255/ 5);
        analogWrite(pwmPin, tmpVoltaje);
        break;
    }
  }
}

//voltajes[command-1]
