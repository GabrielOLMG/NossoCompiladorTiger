%{
#include <stdio.h>
#include <stdlib.h>

int yylex (void);
void yyerror (char const *);//%type <name> TOK_CHAR
int val;
%}

%union {
	int ival;
  char *sval;
  }

%token  TOK_NUM TOK_CHAR

%type <ival> op_expN op_exp_func TOK_NUM
%type <sval>  op_expC TOK_CHAR

%start input
%%

input:
  %empty
  | input head
  ;

head : '\n'
     | op_exp2 '\n'
     | assign '\n'
     ;


op_exp2 :op_expN {printf("NUM = %d\n",  $1); }
    | op_expC {printf("CHAR= %s\n",  $1); }
    ;

op_exp_func: TOK_NUM {$$ = $1;}
    | TOK_NUM '+' op_exp_func {$$ = $1 + $3;}
    | TOK_NUM '-' op_exp_func {$$ = $1 - $3;}
    | TOK_NUM '%' op_exp_func {$$ = $1 % $3;}
    | TOK_NUM '/' op_exp_func {$$ = $1 / $3;}
    | TOK_NUM '*' op_exp_func {$$ = $1 * $3;}


assign:TOK_CHAR ':' '=' TOK_CHAR   {printf("(%s recebe %s) \n",  $1, $4 ); }
     |TOK_CHAR ':' '=' op_exp_func     {printf("(%s recebe %d) \n",  $1, $4 ); }
     ;

op_expN: TOK_NUM {$$ = $1;}
    ;

op_expC: TOK_CHAR {$$ = $1;}
    ;
%%

void yyerror (char const *msg) {
  printf("parse error: %s\n", msg);
  exit(-1);
}
