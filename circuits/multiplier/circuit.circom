pragma circom 2.0.0;

/*This circuit template checks that c is the multiplication of a and b.*/  

template Multiplier2 () {  

   signal input a;
   signal input b;

   // Logic gates Outputs
   signal x;
   signal y;

   signal output Q; // FINAL OUTPUT

   // component gates used to create assessment circuit
   
   component AGate = AND();
   component NGate = NOT();
   component OGate = OR();

   // circuit logic
   AGate.a <== a;
   AGate.b <== b;
   x <== AGate.out;

   NGate.in <== b;
   y <== NGate.out;

   OGate.a <== x;
   OGate.b <== y;
   Q <== OGate.out;

   log("OUTPUT OF A(0) and B(1) is : ", Q);  
}

template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a*b;
}

template OR() {
    signal input a;
    signal input b;
    signal output out;

    out <== a + b - a*b;
}

template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2*in;
}

component main = Multiplier2();