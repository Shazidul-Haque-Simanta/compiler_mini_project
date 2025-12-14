%option noyywrap

%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"যদি"        { return IF; }
"তারপর"      { return THEN; }
"কিন্তু"     { return ELSE; }
"শেষ"        { return END; }

"print"      { return PRINT; }
"assign"     { return ASSIGN; }

"যোগ"        { return PLUS; }
"বিয়োগ"      { return MINUS; }
"গুন"        { return MUL; }
"ভাগ"        { return DIV; }

"বড়"         { return GT; }
"ছোট"        { return LT; }
"সমান"       { return EQ; }

[0-9]+       { yylval.ival = atoi(yytext); return NUMBER; }

[A-Za-z_][A-Za-z0-9_]* {
    yylval.sval = strdup(yytext);
    return IDENT;
}

";"          { return ';'; }
"("          { return '('; }
")"          { return ')'; }

[ \t\n]+     ;
.            { return yytext[0]; }

%%
