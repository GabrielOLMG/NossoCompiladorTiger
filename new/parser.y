%{
#include "estruturas.h"
#include "funcoes.h"
#include <stdio.h>
#include <stdlib.h>
int yylex (void);
void yyerror (char const *);
%}

%token TOK_NUM TOK_CHAR T_NEWLINE IF THEN ELSE

%union {
    int ival;
    char *sval;
    struct _exp * exp_;
    struct _assert * assert_;
}


%type <sval> TOK_CHAR
%type <ival> TOK_NUM
%type <exp_> term exp exp2
%type <assert_> assert

%start programa

%%

programa :
    | new_line programa
    ;

new_line : assert    { printaAssert($1); printf("\n");}
    | T_NEWLINE
    ;

exp : exp2
    | exp2 '+' exp2      { $$ = mk_op(PLUS,$1, $3); }
    | exp2 '-' exp2      { $$ = mk_op(MINUS,$1, $3); }
    | exp2 '/' exp2      { $$ = mk_op(DIV,$1, $3); }
    | exp2 '%' exp2      { $$ = mk_op(MOD,$1, $3); }
    | exp2 '*' exp2      { $$ = mk_op(TIME,$1, $3); }
    | exp2 '>' exp2      { $$ = mk_op(GT,$1, $3); }
    | exp2 '<' exp2      { $$ = mk_op(LT,$1, $3); }
    | exp2 '=' exp2      { $$ = mk_op(EQ,$1, $3); }
    | exp2 '>' '=' exp2  { $$ = mk_op(GE,$1, $4); }
    | exp2 '<' '=' exp2  { $$ = mk_op(LE,$1, $4); }
    ;

exp2 : term              { $$ = $1; }
    | '(' exp ')'        { $$ = $2; }
    ;

assert : TOK_CHAR ':' '=' exp {$$ = mk_assert(mk_id($1),$4);}
    ;

//seq : assert ';' assert;

term : TOK_NUM      {$$ = mk_num($1);}
    | TOK_CHAR      {$$ = mk_id($1);}
    ;

%%

void yyerror (char const *msg) {
  printf("parse error: %s \n", msg);
  exit(-1);
}