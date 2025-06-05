#define CMD0_PIN 3
#define CMD1_PIN 4
#define D_OUT 5
#define CLK_PIN 6

#define DELAY 250 // ms

//Command Table:
/*
cmd 0       cmd1          function
  0           0             reset
  0           1             enable
  1           0             read serially
  1           1             disable
*/

void setup() {
  pinMode(CLK_PIN, OUTPUT);
  pinMode(D_OUT, OUTPUT);
  pinMode(CMD1_PIN, OUTPUT);
  pinMode(CMD0_PIN, OUTPUT);

  //Ref the command table to see why the command pins are set as they are
  digitalWrite(CLK_PIN, LOW);
  digitalWrite(D_OUT, LOW);
  digitalWrite(CMD0_PIN, HIGH);
  digitalWrite(CMD1_PIN, HIGH);

  //Resetting the entire shift register
  digitalWrite(RESET, HIGH);
  delay(DELAY);
  digitalWrite(RESET, LOW);

  shift6BitOut(0b00111011);

}

void loop() {
  /*
  digitalWrite(RESET, HIGH);
  cycleClock();
  digitalWrite(RESET, LOW);
  for(int i = 0; i<6; i++){
    digitalWrite(D_OUT, HIGH);
    cycleClock();
  }
  */
}

void shift6BitOut(uint8_t OP){
  for(int i = 0; i<6; i++){
    //enable the sipo
    digitalWrite(CMD1_PIN, 0);
    digitalWrite(CMD0_PIN, 1);
    digitalWrite(D_OUT, (OP>>i & 0b00000001));    //Writing the bottom most bit to the data line
    cycleClock();                                 //Cycling the clock
    //Going back to disabled mode
    digitalWrite(CMD1_PIN, 1);
    digitalWrite(CMD0_PIN, 1);
  }

  //Disabling everything at the end
  digitalWrite(CMD1_PIN, 1);
  digitalWrite(CMD0_PIN, 1);
}

uint8t_t read6Bits(){
  uint8t_t readByte = 0;
  digitalWrite(CMD0_PIN, 0);
  digitalWrite(CMD1_PIN, 1);
  for(int i = 0; i<6; i++){
    readByte = (readByte << i)||
  }
}

void cycleClock() {
  delay(DELAY);
  digitalWrite(CLK_PIN, HIGH);
  delay(DELAY);
  digitalWrite(CLK_PIN, LOW);
  delay(DELAY);
}


