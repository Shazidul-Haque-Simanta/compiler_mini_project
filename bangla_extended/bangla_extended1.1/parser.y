%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

int sym[26];
%}

%union {
    int ival;
    char *sval;
}

%token IF THEN ELSE END
%token PRINT ASSIGN
%token PLUS MINUS MUL DIV
%token GT LT EQ
%token <ival> NUMBER
%token <sval> IDENT

%type <ival> expr condition

%left GT LT EQ
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

    | PRINT IDENT ';'
        { printf("%d\n", sym[$2[0]-'a']); }

    | ASSIGN IDENT expr ';'
        { sym[$2[0]-'a'] = $3; }

    | IF condition THEN statements END
        { if ($2) { } }

    | IF condition THEN statements ELSE statements END
        { if ($2) { } else { } }
    ;

condition
    : expr GT expr   { $$ = $1 > $3; }
    | expr LT expr   { $$ = $1 < $3; }
    | expr EQ expr   { $$ = $1 == $3; }
    ;

expr
    : expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr  { $$ = $1 - $3; }
    | expr MUL expr    { $$ = $1 * $3; }
    | expr DIV expr    { $$ = $1 / $3; }
    | NUMBER           { $$ = $1; }
    | IDENT            { $$ = sym[$1[0]-'a']; }
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
