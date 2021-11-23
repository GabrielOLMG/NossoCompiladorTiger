%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int yylex (void);
void yyerror (char const *);//%type <name> TOK_CHAR
int val;
%}

%union {
	int ival;
  char *sval;
  }

%token  TOK_NUM TOK_CHAR IF THEN ELSE

%type <ival>  TOK_NUM
%type <sval>  op_expC TOK_CHAR op_expN op_arith op_logic assign

%start input
%%

input:
  %empty
  | input head
  ;

head : '\n'
     | head2 '\n'
     ;

head2: assign 
    | op_cond

op_arith: op_expN {$$ = $1;}
    | op_expC {$$ = $1;}
    | op_expN '+' op_arith { strcat($1," + ");strcat($1,$3);$$ = $1;}
    | op_expC '+' op_arith { strcat($1," + ");strcat($1,$3);$$ = $1;}

    | op_expN '-' op_arith { strcat($1," - ");strcat($1,$3);$$ = $1;}
    | op_expC '-' op_arith { strcat($1," - ");strcat($1,$3);$$ = $1;}

    | op_expN '%' op_arith { strcat($1," % ");strcat($1,$3);$$ = $1;}
    | op_expC '%' op_arith { strcat($1," % ");strcat($1,$3);$$ = $1;}

    | op_expN '/' op_arith { strcat($1," / ");strcat($1,$3);$$ = $1;}
    | op_expC '/' op_arith { strcat($1," / ");strcat($1,$3);$$ = $1;}

    | op_expN '*' op_arith { strcat($1," * ");strcat($1,$3);$$ = $1;}
    | op_expC '*' op_arith { strcat($1," * ");strcat($1,$3);$$ = $1;}
    ;

op_logic : op_expN '<' op_arith { strcat($1," < ");strcat($1,$3);$$ = $1;}
    | op_expC '<' op_arith { strcat($1," < ");strcat($1,$3);$$ = $1;}

    | op_expN '>' op_arith { strcat($1," > ");strcat($1,$3);$$ = $1;}
    | op_expC '>' op_arith { strcat($1," > ");strcat($1,$3);$$ = $1;}

    | op_expN '=' op_arith { strcat($1," = ");strcat($1,$3);$$ = $1;}
    | op_expC '=' op_arith { strcat($1," = ");strcat($1,$3);$$ = $1;}

    | op_expN '>''=' op_arith { strcat($1," >= ");strcat($1,$4);$$ = $1;}
    | op_expC '>''=' op_arith { strcat($1," >= ");strcat($1,$4);$$ = $1;}

    | op_expN '<''=' op_arith { strcat($1," <= ");strcat($1,$4);$$ = $1;}
    | op_expC '<''=' op_arith { strcat($1," <= ");strcat($1,$4);$$ = $1;}

    | op_expN '<''>' op_arith { strcat($1," <> ");strcat($1,$4);$$ = $1;}
    | op_expC '<''>' op_arith { strcat($1," <> ");strcat($1,$4);$$ = $1;}


op_cond: IF op_logic THEN assign {printf("(if (%s) then (%s)) \n",  $2, $4 ); }
    ;

assign:op_expC ':' '=' op_arith     {printf("(%s recebe %s) \n",  $1, $4 ); strcat($1," recebe ");strcat($1,$4);$$ = $1;}
    | op_expC ':' '=' op_logic     {printf("(%s recebe %s) \n",  $1, $4 ); }
     ;

op_expN: TOK_NUM {char *buf = (char*)malloc(BUFSIZ*sizeof(char));snprintf(buf, sizeof(buf), "%d", $1); $$ = buf;}
    ;

op_expC: TOK_CHAR {$$ = $1;}
    ;
%%

void yyerror (char const *msg) {
  printf("parse error: %s\n", msg);
  exit(-1);
}
