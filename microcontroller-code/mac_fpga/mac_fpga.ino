#define CMD0_PIN    //b
#define CMD1_PIN    //a
#define RST_PIN
#define DOUT_PIN
#define DIN_PIN
#define CLK_PIN

#define WIDTH 16
#define DELAY 200

void do_reset();
void do_write();
void do_sum();
int do_read();
void cycle_clock();

void setup() {
  // put your setup code here, to run once:
  pinMode(cmd_0, OUTPUT);
  pinMode(cmd_1, OUTPUT);
  pinMode(rst, OUTPUT);
  pinMode(d_out, OUTPUT);
  pinMode(d_in, INPUT);

  digitalWrite(CLK_PIN, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:

}

void do_reset(){
  digitalWrite(CMD0_PIN, LOW);
  digitalWrite(CMD1_PIN, LOW);
  cycle_clock();
}

void do_write(uint16_t a, uint16_t b){
  //Putting ab = 01 onto the command lines so that fpga understands that we're writing to the registers
  //This signal has to stay on the lines for as long as the write is being sent, otherwise it'll just die
  digitalWrite(CMD0_PIN, HIGH);
  digitalWrite(CMD1_PIN, LOW);

  //Important to send b, then a since the bits go first through a and then into b by our architecture
  //Putting b onto the lines and pushing into the second shift register
  for(int i = 0; i< 2*WIDTH; i++){
    digitalWrite(DOUT_PIN, (b >> i) & 1);
    cycle_clock();
  } 

  //Putting a onto the lines and pushing into the first shift register
  for(int i = 0; i< 2*WIDTH; i++){
    digitalWrite(DOUT_PIN, (a >> i) & 1);
    cycle_clock();
  }
}

void do_sum(){
  digitalWrite(CMD0)
}


void cycle_clock(){
  delay(DELAY);
  digitalWrite(CLK_PIN, HIGH);
  delay(DELAY);
  digitalWrite(CLK_PIN, LOW);
  delay(DELAY);
}