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

%type <ival> op_expN TOK_NUM
%type <sval>  op_expC TOK_CHAR

%start head
%%


head : op_exp2
     ;


op_exp2 :
    | op_expN {printf("num e num = %d\n",  $1); }
    | op_expC {printf("num e num = %s\n",  $1); }
    | op_expC '+' op_expN {printf("num e num = %s %d\n",  $1,$3); }
    ;

op_expN: TOK_NUM {$$ = $1;}
    ;

op_expC: TOK_CHAR {$$ = $1;}
    ;




































/*
assign:
     |TOK_CHAR ':' '=' TOK_NUM    {printf("assingn %s a %d \n",  $1, $4 ); } 
     |TOK_CHAR ':' '=' TOK_CHAR   {printf("assingn %s a %d \n",  $1, $4 ); }
     |TOK_CHAR ':' '=' op_exp     {printf("assingn %s a %d \n",  $1, $4 ); }
     ;

op : '+'  {printf("PLUS"); }
    |'-'
    |'*'
    |'%'
    |'/'
    ;

op_exp: 
    |TOK_NUM '+' TOK_NUM    {printf("num e num = %d\n",  $1 + $3 ); }
    |TOK_CHAR op TOK_NUM
    |TOK_NUM op TOK_CHAR
    |TOK_NUM op op_exp
    ; 



top : TOK_NUM        { printf("TOK_NUM %d\n", $1); }
    ;
top : TOK_CHAR       { printf("TOK_CHAR %s\n", $1); }
    ;

*/

%%

void yyerror (char const *msg) {
  printf("parse error: %s\n", msg);
  exit(-1);
}

