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

{digit}+                       { yylval.ival = atoi(yytext); return TOK_NUM; }

"+"                            { return '+'; }
"*"                            { return '*'; }
"/"                            { return '/'; }
"%"                            { return '%'; }
"-"                            { return '-'; }


"("                            { return '('; }
")"                            { return ')'; }
"\n"                           { return T_NEWLINE; }
<<EOF>>                        { return EOF; }
.                              { printf("Mystery character %s\n", yytext); }


%%