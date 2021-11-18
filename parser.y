%{
#include <stdio.h>
#include <stdlib.h>
int yylex (void);
void yyerror (char const *);//%type <name> TOK_CHAR
%}

%union {
	int ival;
  char sval[20];
  }

%token <ival> TOK_NUM
%token <sval> TOK_CHAR

%%

head : top 
     ;

top : TOK_NUM        { printf("-> %d\n", $1); }
    ;
top : TOK_CHAR       { printf("--> %s\n", $1); }
    ;



%%

void yyerror (char const *msg) {
  printf("parse error: %s\n", msg);
  exit(-1);
}
