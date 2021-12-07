%{
#include "estruturas.h"
#include "funcoes.h"
#include <stdio.h>
#include <stdlib.h>
int yylex (void);
void yyerror (char const *);
%}

%token TOK_NUM TOK_CHAR T_NEWLINE IF THEN ELSE DO WHILE

%union {
    int ival;
    char *sval;
    struct _exp * exp_;
    //struct _assert * assert_;
}


%type <sval> TOK_CHAR
%type <ival> TOK_NUM
%type <exp_> term exp exp_seq
//%type <assert_> assert

%start programa

%%

programa :
    | new_line programa
    ;

new_line : exp    { printaExp($1); printf("\n");}
    | T_NEWLINE
    ;

exp : term                         { $$ = $1; }
    | '(' exp_seq ')'              { $$ = $2; }
    | TOK_CHAR ':' '=' exp         { $$ = mk_op(ASSERT,mk_id($1),$4);}
    | exp '+' exp                  { $$ = mk_op(PLUS,$1, $3); }
    | exp '-' exp                  { $$ = mk_op(MINUS,$1, $3); }
    | exp '/' exp                  { $$ = mk_op(DIV,$1, $3); }
    | exp '%' exp                  { $$ = mk_op(MOD,$1, $3); }
    | exp '*' exp                  { $$ = mk_op(TIME,$1, $3); }
    | exp '>' exp                  { $$ = mk_op(GT,$1, $3); }
    | exp '<' exp                  { $$ = mk_op(LT,$1, $3); }
    | exp '=' exp                  { $$ = mk_op(EQ,$1, $3); }
    | exp '>' '=' exp              { $$ = mk_op(GE,$1, $4); }
    | exp '<' '=' exp              { $$ = mk_op(LE,$1, $4); }
    | exp '<' '>' exp              { $$ = mk_op(NE,$1, $4); }
    | IF exp THEN exp              { $$ = mk_tc(IF_,$2, $4,NULL); }
    | IF exp THEN exp ELSE exp     { $$ = mk_tc(IF_ELSE,$2, $4,$6); }
    | WHILE exp DO exp              { $$ = mk_tc(WHILE_DO,$2, $4,NULL); }
    ;

exp_seq : exp           { $$ = $1; }
    | exp_seq ';' exp   {$$ = mk_op(EXP_SEQ,$1,$3);}

term : TOK_NUM      {$$ = mk_num($1);}
    | TOK_CHAR      {$$ = mk_id($1);}
    ;



%%

void yyerror (char const *msg) {
  printf("parse error: %s \n", msg);
  exit(-1);
}