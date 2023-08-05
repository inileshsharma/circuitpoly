## ZK Circuit Implementation

Polygon is asking you to design a new zkSNARK circuit that implements some logical operations. You need to implement the circuit and deploy a verifier on-chain to verify proofs generated from this circuit, we will create a circuit using the circom programming language.

## Circuit Diagram 

![image](https://github.com/inileshsharma/circuitpoly/assets/108680890/789ff1eb-7fa2-436a-b1e2-f790420ea5cd)


## Quick Start
Compile the Multiplier2() circuit and verify it against a smart contract verifier

```
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
```
### Install
`npm i`

### Compile
`npx hardhat circom` 
This will generate the **out** file with circuit intermediaries and geneate the **MultiplierVerifier.sol** contract

### Prove and Deploy
`npx hardhat run scripts/deploy.ts`
This script does 4 things  
1. Deploys the MultiplierVerifier.sol contract
2. Generates a proof from circuit intermediaries with `generateProof()`
3. Generates calldata with `generateCallData()`
4. Calls `verifyProof()` on the verifier contract with calldata

**contracts**
```
contracts
└── MultiplierVerifier.sol
```

## Deploy to Polygon Mumbai Network

1. import dotenv/config.
2. Create a .env file
3. Paste metamask account private key which is on Polygon mumbai testnet and has test matics.
4. inside your hardhat.config.ts file add the following  networks:{   mumbai: { url :`https://rpc.ankr.com/polygon_mumbai` ,   accounts: [process.env.MUMBAIPRIVATEKEY]  } }

Now Enter the command in your Terminal:- npx hardhat run scripts/deploy.ts --network mumbai 


## Authors
gmchad.

Nilesh Sharma.
