uint8_t currentVal, oldVal;

int mapPinValue(int p) {
  return p+3;
}

uint8_t readSignal() {
  uint8_t data = 0;
  for (uint8_t i = 0; i < 7; i++) {
    data |= uint8_t(digitalRead(mapPinValue(i))) << i;
  }
  return data;
}

bool isSignalDifferent(uint8_t oldBuf, uint8_t currentBuf) {
  return oldBuf != currentBuf;
}

void setup() {
  oldVal = currentVal = 0;
  Serial.begin(9600);
}

void loop() {
  currentVal = readSignal();
  
  if (isSignalDifferent(oldVal, currentVal)) {
    Serial.println(currentVal);
    oldVal = currentVal;
  }
}
