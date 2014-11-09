int pwmPin = 9, command, tmpVoltaje;
float voltajes[] = {0, 0.75, 1.5, 2.25, 3, 3.75, 4.5};

void setup()
{
  Serial.begin(9600);
  pinMode(pwmPin, OUTPUT);
}

void loop()
{
  tmpVoltaje = 0;
  while(Serial.available() > 0)
  {
    command = Serial.read()-30;
    if(command >= 1 && command <= 7)
      tmpVoltaje = 255 * (voltajes[1] / 5);
    analogWrite(pwmPin, tmpVoltaje);
  }
}

