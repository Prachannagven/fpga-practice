#define CMD0_PIN 4    //b
#define CMD1_PIN 5    //a
#define DOUT_PIN 10   //DOUT from the FPGA, DIN to the muC
#define DIN_PIN 11    //DIN to the FPGA, DOUT to the muC
#define CLK_PIN 6

#define WIDTH 16
#define DELAY 200

void do_reset();
void do_write();
void do_sum();
void do_read();
void cycle_clock();

//Initializing the three registers on this side to track changes
int a_ref = 0;
int b_ref = 0;
int c_ref = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(CMD0_PIN, OUTPUT);
  pinMode(CMD1_PIN, OUTPUT);
  pinMode(DOUT_PIN, INPUT);
  pinMode(DIN_PIN, OUTPUT);

  digitalWrite(CLK_PIN, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:

}

void do_reset(){
  digitalWrite(CMD0_PIN, LOW);
  digitalWrite(CMD1_PIN, LOW);
  cycle_clock();

  a_ref = 0;
  b_ref = 0;
  c_ref = 0;
  printref();
}

void do_write(uint16_t a, uint16_t b){
  //Putting ab = 01 onto the command lines so that fpga understands that we're writing to the registers
  //This signal has to stay on the lines for as long as the write is being sent, otherwise it'll just die
  digitalWrite(CMD0_PIN, HIGH);
  digitalWrite(CMD1_PIN, LOW);

  //Important to send b, then a since the bits go first through a and then into b by our architecture
  //Putting b onto the lines and pushing into the second shift register
  for(int i = 0; i< WIDTH; i++){
    digitalWrite(DIN_PIN, (b >> i) & 1);
    cycle_clock();
  } 

  //Putting a onto the lines and pushing into the first shift register
  for(int i = 0; i< WIDTH; i++){
    digitalWrite(DIN_PIN, (a >> i) & 1);
    cycle_clock();
  }

  a_ref = a;
  b_ref = b;
  printref();
}

void do_sum(){
  digitalWrite(CMD0_PIN, 0);
  digitalWrite(CMD1_PIN, 1);
  cycle_clock();

  c_ref += a_ref*b_ref;
  printref();
}

void do_read(){
  int val = 0;

  digitalWrite(CMD0_PIN, 1);
  digitalWrite(CMD1_PIN, 1);

  for(int i = 0; i<2*WIDTH; i++){
    val = (val << i) | digitalRead(DOUT_PIN);
    cycle_clock();
  }
}

void cycle_clock(){
  delay(DELAY);
  digitalWrite(CLK_PIN, HIGH);
  delay(DELAY);
  digitalWrite(CLK_PIN, LOW);
  delay(DELAY);
}

void printref(){
  sprintf("A Reg: %d \n", a_ref);
  sprintf("B Reg: %d \n", b_ref);
  sprintf("C Reg: %d \n", c_ref);
}