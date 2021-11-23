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

[ \t\r]+                     /* skip whitespace */
"if"                            { return IF;}
"then"                          { return THEN;}
"else"                            { return ELSE;}
"while"                            { return WHILE;}
"do"                            { return DO;}
"int"                            { return INT;}
"printi"                            { return PRINTI;}
"scani"                            { return SCANI;}
{digit}+                       { yylval.ival = atoi(yytext); return TOK_NUM; }
({alpha}+{digit}*)+            { yylval.sval = (char*)malloc(7919*sizeof(char)); strcpy(yylval.sval, yytext); return TOK_CHAR; }
"-"                            { return '-';}
">"                            { return '>';}
"<"                            { return '<';}
"%"                            { return '%';}
"/"                            { return '/';}
"+"                            { return '+'; }
"("                            { return '('; }
")"                            { return ')'; }
":"                            { return ':';}
"="                            { return '=';}
"*"                            { return '*'; }
"\n"                            { return '\n'; }
<<EOF>>                        { return EOF; }

%%




