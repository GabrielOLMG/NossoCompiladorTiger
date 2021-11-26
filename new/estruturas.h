#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {PLUS,MINUS,TIME,DIV,MOD} operacoes;

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


