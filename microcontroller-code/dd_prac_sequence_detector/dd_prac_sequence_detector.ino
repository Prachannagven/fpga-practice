#define CLK 8
#define SIG 9
#define RST 10
#define LED 13
#define CLK_PRD 500

boolean dataReady = false;
String inputBits = "";

void setup() {
  // Setting up the pins
  pinMode(CLK, OUTPUT);
  pinMode(RST, OUTPUT);
  pinMode(SIG, OUTPUT);
  pinMode(LED, OUTPUT);

  // Initializing Everything
  digitalWrite(LED, LOW);
  digitalWrite(CLK, LOW);
  digitalWrite(SIG, LOW);
  digitalWrite(RST, LOW);
  delay(CLK_PRD);
  digitalWrite(RST, HIGH);

  Serial.begin(9600);
  Serial.println("Enter a binary string (e.g., 101010) or type 'reset':");
}

void loop() {
  // Read input string from Serial
  while (Serial.available()) {
    char c = Serial.read();
    if (c == '\n' || c == '\r') {
      dataReady = true;
    } else {
      inputBits += c;
    }
  }

  // Handle full input
  if (dataReady) {
    inputBits.trim(); // Remove any leading/trailing whitespace

    if (inputBits.equalsIgnoreCase("reset")) {
      digitalWrite(RST, LOW);
      delay(CLK_PRD);
      digitalWrite(RST, HIGH);
      delay(CLK_PRD);
      Serial.println("Reset the Flip Flops");
    } else {
      Serial.println("Sending bits: " + inputBits);
      for (int i = 0; i < inputBits.length(); i++) {
        char bit = inputBits.charAt(i);
        if (bit == '0' || bit == '1') {
          digitalWrite(SIG, bit == '1' ? HIGH : LOW);

          // Clock pulse
          digitalWrite(CLK, HIGH);
          delay(CLK_PRD);
          digitalWrite(CLK, LOW);
          delay(CLK_PRD);
        }
      }
      Serial.println("Done sending. Enter another binary string or type 'reset':");
    }

    // Reset state
    inputBits = "";
    dataReady = false;
  }
}
