#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum op{PLUS,MINUS,TIME,DIV,MOD,GT,LT,GE,LE,EQ,NE,ASSERT,EXP_SEQ} ;
enum ties_cond{IF_,IF_ELSE,WHILE_DO};
enum io{PRINTI_,SCANI_};

typedef enum io io_;
typedef enum op operacoes;
typedef enum ties_cond ties_cond;
struct _exp{
  enum {ID,NUM,OP,TC,IO} tag;
  union{
    int val;
    char*id;
    struct{
      operacoes op;
      struct _exp *left, *right;
    } operacoes;

    struct{
      ties_cond tc;
      struct _exp *left,*middle, *right;
    } ties_cond;

    struct{
      io_ io;
      struct _exp *value;
    } io_;
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

