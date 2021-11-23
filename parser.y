%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX 10000

int yylex (void);
void yyerror (char const *);//%type <name> TOK_CHAR
int val;
%}

%union {
	int ival;
  char *sval;
  }

%token  TOK_NUM TOK_CHAR IF ELSE THEN WHILE DO INT PRINTI SCANI

%type <ival>  TOK_NUM
%type <sval>  op_expC TOK_CHAR op_expN op_arith op_logic op_cond head2 assign op_while types /*op_input_output*/
%start input
%%

input:
  %empty
  | input head
  ;

head : '\n'
    |head2  {printf("%s \n", $1);}
    ;

head2: assign {$$ = $1;}
    |	'\n' assign  {$$ = $2;}
    |  assign '\n' {$$ = $1;}

    |  op_cond  {$$ = $1;}
    |  op_cond '\n' {$$ = $1;}
    |  '\n' op_cond  {$$ = $2;}

    | '\n' op_while {$$ = $2;}
    | op_while {$$ = $1;}
    | op_while '\n'{$$ = $1;}

    |types {$$ = $1;}

    |  op_arith  {$$ = $1;}
    ;

op_arith: op_expN {$$ = $1;}
    | op_expC {$$ = $1;}
    | op_expN '+' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s + %s)", $1,$3);$$ = buf;}
    | op_expC '+' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s + %s)", $1,$3);$$ = buf;}

    | op_expN '-' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s - %s)", $1,$3);$$ = buf;}
    | op_expC '-' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s - %s)", $1,$3);$$ = buf;}

    | op_expN '%' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s %% %s)", $1,$3);$$ = buf;}
    | op_expC '%' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s %% %s)", $1,$3);$$ = buf;}

    | op_expN '/' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s / %s)", $1,$3);$$ = buf;}
    | op_expC '/' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s / %s)", $1,$3);$$ = buf;}

    | op_expN '*' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s * %s)", $1,$3);$$ = buf;}
    | op_expC '*' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s * %s)", $1,$3);$$ = buf;}
    ;

op_logic : op_expN {$$ = $1;}
    | op_expC {$$ = $1;}

    | op_expN '<' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s < %s)", $1,$3);$$ = buf;}
    | op_expC '<' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s < %s)", $1,$3);$$ = buf;}
    | op_arith '<' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s < %s)", $1,$3);$$ = buf;}

    | op_expN '>' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s > %s)", $1,$3);$$ = buf;}
    | op_expC '>' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s > %s)", $1,$3);$$ = buf;}
    | op_arith '>' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s > %s)", $1,$3);$$ = buf;}

    | op_expN '=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s = %s)", $1,$3);$$ = buf;}
    | op_expC '=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s = %s)", $1,$3);$$ = buf;}
    | op_arith '=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s = %s)", $1,$3);$$ = buf;}

    | op_expN '>''=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s >= %s)", $1,$4);$$ = buf;}
    | op_expC '>''=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s >= %s)", $1,$4);$$ = buf;}
    | op_arith '>''=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s >= %s)", $1,$4);$$ = buf;}

    | op_expN '<''=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s <= %s)", $1,$4);$$ = buf;}
    | op_expC '<''=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s <= %s)", $1,$4);$$ = buf;}
    | op_arith '<''=' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s <= %s)", $1,$4);$$ = buf;}

    | op_expN '<''>' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s <> %s)", $1,$4);$$ = buf;}
    | op_expC '<''>' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s <> %s)", $1,$4);$$ = buf;}
    | op_arith '<''>' op_arith {char *buf = (char*)malloc(MAX*sizeof(char));
                            snprintf(buf, MAX, "(%s <> %s)", $1,$4);$$ = buf;}



op_cond: IF op_logic THEN head2 {char *buf = (char*)malloc(MAX*sizeof(char));
                                snprintf(buf, MAX, "(if %s then %s)", $2,$4);
                                $$ = buf;}
    |IF op_logic THEN head2 ELSE head2 {char *buf = (char*)malloc(MAX*sizeof(char));
                                snprintf(buf, MAX, "(if %s then %s else %s)", $2,$4,$6);
                                $$ = buf;}
  ;

op_while: WHILE op_logic DO head2{char *buf = (char*)malloc(MAX*sizeof(char));
                                snprintf(buf, MAX, "(while %s do %s)", $2,$4);
                                $$ = buf;}

assign:op_expC ':' '=' op_arith     {char *buf = (char*)malloc(MAX*sizeof(char));
                                    snprintf(buf, MAX, "(%s = %s)", $1,$4);$$ = buf;}
    | op_expC ':' '=' op_logic     {char *buf = (char*)malloc(MAX*sizeof(char));
                                    snprintf(buf, MAX, "(%s = %s)", $1,$4);$$ = buf;}
     ;

op_expN: TOK_NUM {char *buf = (char*)malloc(MAX*sizeof(char));snprintf(buf, sizeof(buf), "%d", $1); $$ = buf;}
    ;

op_expC: TOK_CHAR {$$ = $1;}
    ;

types: INT op_expC {char *buf = (char*)malloc(MAX*sizeof(char));
                                snprintf(buf, MAX, "(int %s)", $2);
                                $$ = buf;}
    | INT assign {char *buf = (char*)malloc(MAX*sizeof(char));
                                snprintf(buf, MAX, "(int %s)", $2);
                                $$ = buf;}

//op_input_output : PRINTI op_expC ':' 

%%



void yyerror (char const *msg) {
  printf("parse error: %s\n", msg);
  exit(-1);
}


