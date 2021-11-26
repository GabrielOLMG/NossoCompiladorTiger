%{
#include "estruturas.h"
#include "funcoes.h"
#include <stdio.h>
#include <stdlib.h>
int yylex (void);
void yyerror (char const *);
%}

%token TOK_NUM
%token T_NEWLINE

%union {
    int ival;
    char *sval;
    struct _exp * exp;
}

%type <ival>  TOK_NUM
%type <exp>  term exp

%start programa

%%

programa :
    | new_line programa
    ;

new_line : exp  { printaExp($1); printf("\n");}
    | T_NEWLINE
    ;

exp : term          { $$ = $1; }
    | exp '+' term  { $$ = mk_op(PLUS,$1, $3); }
    | exp '-' term  { $$ = mk_op(MINUS,$1, $3); }
    | exp '/' term  { $$ = mk_op(DIV,$1, $3); }
    | exp '%' term  { $$ = mk_op(MOD,$1, $3); }
    | exp '*' term  { $$ = mk_op(TIME,$1, $3); }
    ;


term : TOK_NUM      {$$ = mk_num($1);}
    ;

%%

void yyerror (char const *msg) {
  printf("parse error: %s \n", msg);
  exit(-1);
}