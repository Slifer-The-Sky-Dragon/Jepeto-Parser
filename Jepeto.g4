grammar Jepeto;

jepeto : not_completed_program EOF;

not_completed_program : function not_completed_program | main completed_program;
completed_program : function completed_program |;

function : FUNC_KEY identifier LPAR (expression(',' expression)*)? RPAR ':' 'func_body'|
           FUNC_KEY identifier LPAR (expression(',' expression)*)? RPAR ':' '{' ('func_body')+ '}'|
           FUNC_KEY identifier LPAR (identifier '=' expression(',' identifier '=' expression)*)? RPAR ':' 'func_body'|
           FUNC_KEY identifier LPAR (identifier '=' expression(',' identifier '=' expression)*)? RPAR ':' '{' ('func_body')+ '}';

expression : expression1 'or' expression | expression1;
expression1 : expression2 'and' expression1 | expression2;
expression2 : expression3 'is' expression2 | expression3 'not' expression2 | expression3;
expression3 : expression4 '<' expression3 | expression4 '>' expression3 | expression4;
expression4 : expression5 '+' expression4 | expression5 '-' expression4 | expression5;
expression5 : expression6 '*' expression5 | expression6 '/' expression5 | expression6;
expression6 : '-' expression6 | '~' expression6 | expression7; //left-to-right
expression7 : expression8 '::' expression7 | expression8;
expression8 : expression8 '.size' | expression9;
expression9 : '[' expression9 ']' | expression10;
expression10 : '(' expression ')' | primitive | anonymous_call | func_call | identifier;

return: 'return' 'void' | 'return' expression;

print_call: 'print' LPAR expression RPAR;

anonymous_func: LPAR (expression(',' expression)*)? RPAR '->' '{' 'func_body' '}';

anonymous_call: anonymous_func LPAR (expression(',' expression)*)? RPAR |
    anonymous_func LPAR (identifier '=' expression(',' identifier '=' expression)*)? RPAR;

func_call: identifier LPAR ((expression|anonymous_func)(',' (anonymous_func|expression))*)? RPAR |
    identifier LPAR (identifier '=' (anonymous_func|expression)(',' identifier '=' (anonymous_func|expression))*)? RPAR;

main : MAIN_KEY ':' print_call | func_call;

primitive : INT | BOOl | STRING;

identifier : IDENTIFIER;

function_call : FUNC_KEY;

FUNC_KEY : 'func';
MAIN_KEY : 'main';
IDENTIFIER : [_A-Za-z][_A-Za-z0-9]*;
LCURBRACE : '{';
RCURBRACE : '}';
LPAR : '(';
RPAR : ')';
LBRACE : '[';
RBRACE : ']';
BOOL : 'true' | 'false';
WS : [ \t\r\n]+ -> skip;
INT : [1-9][0-9]*;
STRING : '"' ~('"') + '"';
COMMA : ',';
//KEYWORD : 'bool' | 'int' | 'string';
//NEG_OPERATOR : '-';
//BIN_OPERATOR : 'and' | 'or' | 'is' | 'not' | '+' | '*' | '/' | '<' | '>' | '::' | '=';
//UNA_OPERATOR : '~';
//SIZE_OPERATOR : '.size';
