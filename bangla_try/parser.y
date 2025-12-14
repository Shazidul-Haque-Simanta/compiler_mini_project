%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int ival;
    char *sval;
}

%token IF THEN ELSE END
%token PRINT ASSIGN
%token PLUS MINUS MUL DIV
%token <ival> NUMBER
%token <sval> IDENT




%type <ival> expr

%left PLUS MINUS
%left MUL DIV

%%

program
    : statements
    ;

statements
    : statement
    | statements statement
    ;

statement
    : PRINT expr ';'
        { printf("%d\n", $2); }
    | IDENT ASSIGN expr ';'
        { /* assignment logic here */ }
    | IF expr THEN statements END
        { /* if logic here */ }
    | IF expr THEN statements ELSE statements END
        { /* if-else logic here */ }
    ;

expr
    : expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr  { $$ = $1 - $3; }
    | expr MUL expr    { $$ = $1 * $3; }
    | expr DIV expr    { $$ = $1 / $3; }
    | NUMBER           { $$ = $1; }
    | IDENT            { $$ = 0; }   /* lookup variable later */
    | '(' expr ')'     { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
