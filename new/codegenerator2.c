#include <stdint.h>
#include "funcoes.h"
#include "pilha.c"
void transExp(Exp exp,int dest);

typedef intptr_t Addr; // endereço (inteiro ou apontador)
typedef enum { MOVE, MOVEI, OPI, OP_, LABEL, JUMP, COND } Opcode; // código da instrução
typedef struct {
    Opcode opcode;
    Opcode opcode2;
    Opcode opcode3;
    operacoes op_;
    ties_cond tc_;
} Codigo;

typedef struct {
    Codigo codigo;
    Addr arg1, arg2, arg3;
} Instr; //opcode = MOVEI arg1 = dest arg2 = exp->val arg3 = NULL;

int temp_count = 0, label_count = 0; //var temporarias e labelcounts
node *PILHA;

int newTemp() {
    return temp_count++;
}
int newLabel () {
    return label_count ++;
}

/*CADA EMIT PRECISA RETORNAR A STRUCT INSTR, que sera completada se necessaria depois*/

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
            printf("T%d T%d ", t2,t1);

        default:
            break;
    }
}


//Opcode opcode_io;

Codigo opcode_operacoes(operacoes op){
  Codigo c;
  c.op_ = op;
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
      c.opcode2 = LABEL;
      return c;
      break;
  }
}
Opcode opcode_ties_cond(ties_cond tc){
  Codigo c;
  c.tc_ = tc;
  switch(tc){
  }
}

void transCond(Exp exp,int dest, int label1,int label2){
  int t1 = newTemp();
  int t2 = newTemp();
  transExp(exp->operacoes.left, t1);
  transExp(exp->operacoes.right, t2);
  Codigo c;
  c.op_ = exp->operacoes.op;
  c.opcode = COND;
  c.opcode2 = LABEL;
  emit3(c,dest,t1,t2);//uma parte da isntrução sera feita aqui
  printf("label%d label%d \n",label1,label2); // subsitutir essa parte por colocar a label na instrução
}

void analisa_tc(Exp exp){
    Codigo c;
    int t1,t2,t3;
    int l1,l2,l3;
    switch(exp->ties_cond.tc){
      case WHILE_DO:
        l1 = newLabel();
        l2 = newLabel();
        l3 = newLabel();
        
        t1 = newTemp();
        
        printf("LABEL label%d\n",l1);
        transCond(exp->ties_cond.left, t1,l2,l3);
        t2 = newTemp();
        printf("LABEL label%d\n",l2);
        transExp(exp->ties_cond.middle, t2);
        printf("JUMP label%d\n",l1);
        printf("LABEL label%d\n",l3);
        
        return;
      default:
        t1 = newTemp();
        t2 = newTemp();

        l1 = newLabel();
        l2 = newLabel();

        transCond(exp->ties_cond.left, t1,l1,l2);
        printf("LABEL label%d\n",l1);
        transExp(exp->ties_cond.middle, t2);
        printf("LABEL label%d\n",l2);
        if(exp->ties_cond.right != NULL){
          t3 = newTemp();
          l3 = newLabel();
          transExp(exp->ties_cond.right, t3);
          printf("LABEL label%d\n",l3);
        }
    }
}

void registra(Exp exp,int dest){
    Exp esq = exp->operacoes.left; //nome da variavel
    node *el = aloca(esq->id,dest);
    PILHA=push(PILHA,el);

    Exp dir = exp->operacoes.right; // valor da variavel
    int t1 = newTemp();
    transExp(exp,t1);

    

}

void transExp(Exp exp,int dest) {
    Codigo c;
    int t1,t2,t3;
    int l1,l2,l3;
    node *el;
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
            analisa_tc(exp);
            break;
        case ID:
            printf("ID ACHADO\n");
            el = search(PILHA, "x");
            printf("%d",el->registro);

            /*pegar na tabela*/
            break;
        case DECL:
            /*colocar na tabela*/
            registra(exp->operacoes.left,dest);
            printf("\nDECL ACHADO\n");

            break;
        default:
            printf("CHAGANDO NO DEFAULT\n");
            break;
    }
}


void intermedio(){
    PILHA = (node *) malloc(sizeof(node));
    PILHA = NULL;
    /*
    node *el = aloca("x",1,NULL);
    node *e2 = aloca("y",2,NULL);
    node *e3 = aloca("z",3,NULL);
    PILHA=push(PILHA,el);
    PILHA=push(PILHA,e2);
    PILHA=push(PILHA,e3);
    node*resultado = pop(PILHA);
    // printf(PILHA)
    node*resultado = search(PILHA, "x");
    if (resultado!=NULL){printf("%d",resultado->registro);}
    else printf("NULL");
    
    */

    

    Exp numero1 =  mk_num(4);
    Exp id_ = mk_id("x");
    Exp assert_ = mk_op(ASSERT,id_,numero1);
    Exp id_dlc = mk_decl(VAR_,assert_,NULL);
    int dest = newTemp();
    transExp(id_dlc,dest);

    

    //transExp(id_,dest);
}

int main(){
    /*
    Exp numero2 =  mk_num(3);
    Exp numero3 =  mk_num(5);
    Exp soma = mk_op(PLUS,numero1,numero2);
    Exp multiplicar = mk_op(TIME,numero3,soma);
    Exp less_than = mk_op(LT,numero1,numero2);
    Exp if_else = mk_tc(IF_,less_than,soma,numero3);
    Exp while_ = mk_tc(WHILE_DO,less_than,if_else,NULL);
    */
    
    intermedio();
    /*
    node *PILHA = (node *) malloc(sizeof(node));
    inicia(PILHA);
    node *el = aloca("x",2,NULL);
    push(PILHA,el);

    node *el_retorno = pop(PILHA);
    printf("%d",el_retorno->registro);
    */
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



