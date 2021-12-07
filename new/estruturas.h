#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum op{PLUS,MINUS,TIME,DIV,MOD,GT,LT,GE,LE,EQ,ASSERT,EXP_SEQ} ;
typedef enum op operacoes;
struct _exp{
  enum {ID,NUM,OP} tag;
  union{
    int val;
    char*id;
    struct{
      operacoes op;
      struct _exp *left, *right;
    } operacoes;
  };
};typedef struct _exp *Exp;


/*struct _assert{
  Exp esquerda;
  Exp direita;
};typedef struct _assert *Assert;*/

/*struct _seq{
  Exp esquerda;
  Exp direita;
};typedef struct _seq *Seq; */
