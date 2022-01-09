#include <stdint.h>
#include "estruturas.h" 
#include "funcoes.h"

typedef intptr_t Addr; // endereço (inteiro ou apontador)
typedef enum { MOVE, MOVEI, OPI, OP_, LABEL, JUMP, COND } Opcode; // código da instrução
typedef struct {
        Opcode opcode;
        operacoes op_;
} Codigo;

typedef struct { 
    Codigo codigo;
    Addr arg1, arg2, arg3;
} Instr; //opcode = MOVEI arg1 = dest arg2 = exp->val arg3 = NULL;

int temp_count = 0, label_count = 0; //var temporarias e labelcounts

int newTemp() {
    return temp_count++;
}
int newLabel () {
    return label_count ++;
}



void emit1(Codigo opcode_,int t1){
    switch(opcode_.opcode){
        case LABEL:
            break;
            printf("LABEL T%d\n",t1);
        case JUMP:
            /*criar struct Instr*/
            printf("JUMP T%d\n",t1); 
            break;
        default:
            break;
    }
}

void emit2(Codigo opcode_,int dest,int t1){
    switch(opcode_.opcode){
        case MOVE:
            break;
            printf("MOVE T%d T%d\n",dest,t1);
        case MOVEI:
            /*criar struct Instr*/
            printf("MOVEI T%d %d\n",dest,t1); 
            break;
        default:
            break;
    }
}

void emit3(Codigo opcode_,int dest,int t1, int t2){
    switch(opcode_.opcode){
        case OP_:
            printf("OP ");
            printaEnumOp(opcode_.op_);
            printf("T%d T%d T%d\n",dest,t1,t2);
            break;
        case OPI:
            /*criar struct Instr*/
            printf("OPI T%d T%d\n",dest,t1); 
            break;
        case COND:
            printf("COND ");
            printaEnumOp(opcode_.op_);
            printf("T%d T%d \n", t2,t1);

        default:
            break;
    }
}


//Opcode opcode_ties_cond;
//Opcode opcode_io;

Codigo opcode_operacoes(operacoes op){
    Codigo c;
    c.op_=op;
	switch(op){
		case ASSERT:
            c.opcode = MOVE;
			return c;
        case EXP_SEQ:
            printf("FAZER");
            c.opcode = MOVE;
			return c;
        case VAR_:
            printf("FAZER");
            c.opcode = MOVE;
			return c;
        case MINUS:
        case TIME:
        case DIV:
        case MOD:
        case PLUS:
            c.opcode = OP_;
            return c;	
        default:
            c.opcode = COND;
            return c;
            break;
	}
    
}



void transExp(Exp exp,int dest) {
    Codigo c;
    int t1,t2,t3;
    int l1,l2,l3;

    switch(exp->tag) {
        case OP:
            t1 = newTemp();
            t2 = newTemp();
            transExp(exp->operacoes.left, t1); // lado esquerdo
            transExp(exp->operacoes.right, t2); // lado direito
            emit3(opcode_operacoes(exp->operacoes.op), dest, t1, t2); // instrução final
            
            break;
        case NUM:
            c.opcode = MOVEI;
            emit2(c,dest,exp->val);
            return;
            break;
        case TC:
            t1 = newTemp();
            t2 = newTemp();
            transExp(exp->operacoes.left, t1); // lado esquerdo da cond
            transExp(exp->operacoes.right, t2); // lado direito da cond
            emit3(opcode_operacoes(exp->operacoes.op), 1, t1, t2);
            printf("L%d L%d\n",0,1);
        /*
        case ID:
            //temp = lookup(id,table);
            int temp = 3;
                break;
        */
        default:
            break;
    }
}


int main(){
    Exp numero1 =  mk_num(4);
    Exp numero2 =  mk_num(3);
    // Exp numero3 =  mk_num(5);
    // Exp soma = mk_op(PLUS,numero1,numero2);
    // Exp multiplicar = mk_op(TIME,numero3,soma);
    Exp less_than = mk_op(LT,numero1,numero2);
    Exp if_else = mk_tc(IF_,less_than,numero1,NULL);
    int dest = newTemp();
    transExp(if_else,dest);


    return 0;
}


/*
HASKELL -- EXEMPLO AULA 11

let expr = Op Mult (Num 3) (Op Plus (Num 4) (Num 5))
> runState (transExpr expr Map.empty "x") (0,0)


([MOVEI "t0" 3, MOVEI "t2" 4, MOVEI "t3" 5,
OP Plus "t1" "t2" "t3", OP Mult "x" "t0" "t1"], (4,0))
*/

/*
1arg -> LABEL loop
2arg -> MOVEI "t0" 3
3arg -> OP Plus "t1" "t2" "t3"
*/


/*
5 * (4+3)

(1-) OP
dest = 0
esq (5)
dir (4+3)
emit3.1

(2-) NUM 5
dest = 1
t1=5

(3-) OP 4+3
dest = 2
esq 4
dir 3
emit3.2

(4-) NUM 4
T3 = 4

(5-) NUM 3
T4 = 3

(6-) emit3.2 (4+3) (T3 + T4)
T2 = T3 + T4

(7-) emit3.1 t1*(T2)


*/

