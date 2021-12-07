%{
#include <stdlib.h>
#include "parser.tab.h"

/* variáveis de estado (globais)
   yylval : valor de um token (int)
*/



%}
%option noyywrap

alpha        [_a-zA-Z]
digit        [0-9]

%%

[ \t\r]+                       /* skip whitespace */

"if"                           { return IF; }
[\n]*"else"[\n]*               { return ELSE; }
[\n]*"then"[\n]*               { return THEN; }  
"while"                        { return WHILE; }
[\n]*"do"[\n]*                      { return DO; }


{digit}+                       { yylval.ival = atoi(yytext); return TOK_NUM; }
({alpha}+{digit}*)+            { yylval.sval = (char*)malloc(100*sizeof(char)); strcpy(yylval.sval, yytext); return TOK_CHAR; }


"+"                            { return '+'; }
"*"                            { return '*'; }
"/"                            { return '/'; }
"%"                            { return '%'; }
"-"                            { return '-'; }


">"                            { return '>'; }
"<"                            { return '<'; }
"="                            { return '='; }


"("                            { return '('; }
")"                            { return ')'; }


":"                            { return ':'; }
";"                            { return ';'; }
"\n"                           { return T_NEWLINE; }
<<EOF>>                        { return EOF; }

[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]    { printf("COMENTARIO AQUI\n");}
.                              { printf("Mystery character %s\n", yytext); }


%%
