%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);



typedef enum {
    NODE_ASSIGN,
    NODE_PRINT,
    NODE_OP,
    NODE_NUM,
    NODE_VAR,
    NODE_STR,
    NODE_IF,
    NODE_SEQ
} NodeType;   

typedef struct Node {
    NodeType type;

    int op;
    struct Node *left;
    struct Node *right;
    struct Node *condition;
    struct Node *else_branch;

    double dval;
    char *sval;
} Node;



Node *new_node(NodeType type) {
    Node *n = malloc(sizeof(Node));
    memset(n, 0, sizeof(Node));
    n->type = type;
    return n;
}

Node *new_num(double val) {
    Node *n = new_node(NODE_NUM);
    n->dval = val;
    return n;
}

Node *new_var(char *s) {
    Node *n = new_node(NODE_VAR);
    n->sval = s;
    return n;
}

Node *new_str(char *s) {
    Node *n = new_node(NODE_STR);
    n->sval = strdup(s);
    return n;
}

Node *new_op(int op, Node *l, Node *r) {
    Node *n = new_node(NODE_OP);
    n->op = op;
    n->left = l;
    n->right = r;
    return n;
}

Node *new_assign(char *var, Node *val) {
    Node *n = new_node(NODE_ASSIGN);
    n->sval = var;
    n->left = val;
    return n;
}

Node *new_print(Node *val) {
    Node *n = new_node(NODE_PRINT);
    n->left = val;
    return n;
}

Node *new_if(Node *cond, Node *ifb, Node *elseb) {
    Node *n = new_node(NODE_IF);
    n->condition = cond;
    n->left = ifb;
    n->else_branch = elseb;
    return n;
}

Node *new_seq(Node *a, Node *b) {
    Node *n = new_node(NODE_SEQ);
    n->left = a;
    n->right = b;
    return n;
}



struct Symbol {
    char *name;
    double value;
};

struct Symbol sym[100];
int symc = 0;

void set_var(char *n, double v) {
    for (int i = 0; i < symc; i++)
        if (!strcmp(sym[i].name, n)) {
            sym[i].value = v;
            return;
        }
    sym[symc].name = strdup(n);
    sym[symc].value = v;
    symc++;
}

double get_var(char *n) {
    for (int i = 0; i < symc; i++)
        if (!strcmp(sym[i].name, n))
            return sym[i].value;
    return 0;
}

double eval(Node *n);

%}



%code requires {
    typedef struct Node Node;
}




%union {
    int ival;
    float fval;
    char *sval;
    Node *node;
}

%token DHORI DEKHAO JOG BIYOG GOON VAG SEMICOLON
%token JODI OTHOBA HOY SOMAN LBRACE RBRACE
%token <sval> VARIABLE STRING
%token <ival> INTEGER
%token <fval> FLOAT

%type <node> program statements statement expression assignment print_stmt block

%left SOMAN
%left JOG BIYOG
%left GOON VAG

%%

program:
    statements { eval($1); }
;

statements:
    statement
  | statements statement { $$ = new_seq($1, $2); }
;

statement:
    assignment
  | print_stmt
  | JODI expression HOY block
        { $$ = new_if($2, $4, NULL); }
  | JODI expression HOY block OTHOBA block
        { $$ = new_if($2, $4, $6); }
;

block:
    LBRACE statements RBRACE { $$ = $2; }
;

assignment:
    DHORI VARIABLE expression SEMICOLON { $$ = new_assign($2, $3); }
  | VARIABLE SOMAN expression SEMICOLON { $$ = new_assign($1, $3); }
;

print_stmt:
    DEKHAO expression SEMICOLON { $$ = new_print($2); }
  | DEKHAO STRING SEMICOLON     { $$ = new_print(new_str($2)); }
;

expression:
    expression JOG expression     { $$ = new_op(JOG, $1, $3); }
  | expression BIYOG expression   { $$ = new_op(BIYOG, $1, $3); }
  | expression GOON expression    { $$ = new_op(GOON, $1, $3); }
  | expression VAG expression     { $$ = new_op(VAG, $1, $3); }
  | expression SOMAN expression   { $$ = new_op(SOMAN, $1, $3); }
  | VARIABLE                      { $$ = new_var($1); }
  | INTEGER                       { $$ = new_num($1); }
  | FLOAT                         { $$ = new_num($1); }
;

%%

double eval(Node *n) {
    if (!n) return 0;

    switch (n->type) {
        case NODE_NUM: return n->dval;
        case NODE_VAR: return get_var(n->sval);
        case NODE_ASSIGN: {
            double v = eval(n->left);
            set_var(n->sval, v);
            return v;
        }
        case NODE_PRINT:
    if (n->left->type == NODE_STR) {
        printf("%s\n", n->left->sval);
    } else {
        printf("%g\n", eval(n->left));
    }
    return 0;

        case NODE_OP: {
            double l = eval(n->left);
            double r = eval(n->right);
            if (n->op == JOG) return l + r;
            if (n->op == BIYOG) return l - r;
            if (n->op == GOON) return l * r;
            if (n->op == VAG) return l / r;
            if (n->op == SOMAN) return l == r;
        }
        case NODE_SEQ:
            eval(n->left);
            eval(n->right);
            return 0;
        case NODE_IF:
            if (eval(n->condition))
                eval(n->left);
            else if (n->else_branch)
                eval(n->else_branch);
            return 0;
        default:
            return 0;
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
