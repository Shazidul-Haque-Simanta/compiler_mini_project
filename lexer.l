%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

void yyerror(const char *s);
%}

%option noyywrap

%%

"dhori"     { return DHORI; }
"jodi"      { return JODI; }
"hoy"       { return HOY; }
"othoba"    { return OTHOBA; }
"soman"     { return SOMAN; }


"dekhao"    { return DEKHAO; }
"jog"       { return JOG; }
"biyog"     { return BIYOG; }
"goon"      { return GOON; }
"vag"       { return VAG; }




[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return VARIABLE; }


[0-9]+      { yylval.ival = atoi(yytext); return INTEGER; }
[0-9]*\.[0-9]+ { yylval.fval = atof(yytext); return FLOAT; }
\"[^"]*\"   { yylval.sval = strdup(yytext); return STRING; }
'[^']*'  { yylval.sval = strdup(yytext); return STRING; }

";"         { return SEMICOLON; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
[ \t\n]     { /* ignore whitespace */ }
"//".*      { /* ignore comments */ }
.           { yyerror("Unknown character"); }
