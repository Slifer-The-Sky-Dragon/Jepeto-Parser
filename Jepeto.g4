grammar Jepeto;

jepeto : func* main func* EOF;

func : FUNC_KEY identifier LPAR (expression(',' expression)*)? RPAR ':' 'func_body' |
           FUNC_KEY identifier LPAR (expression(',' expression)*)? RPAR ':' LCURBRACE ('func_body')+ RCURBRACE |
           FUNC_KEY identifier LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR ':' 'func_body' |
           FUNC_KEY identifier LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR ':' LCURBRACE ('func_body')+ RCURBRACE;

//delete left recursion

expression : expression 'or' expression1 | expression1;
//expression : expression1 a | expression1;
//a: 'or' expression1 a | 'or' expression1;

expression1 : expression1 'and' expression2 | expression2;
//expression1 : expression2 b | expression2;
//b: 'and' expression2 b | 'and' expression2;

expression2 : expression2 'is' expression3 | expression2 'not' expression3 | expression3;
//expression2 : expression3 c | expression3;
//c: 'is' expression3 c | 'not' expression3 c | 'is' expression3 | 'not' expression3;

expression3 : expression3 '<' expression4 | expression3 '>' expression4 | expression4;
//expression3 : expression4 d | expression4;
//d: '<' expression4 d | '>' expression4 d | '<' expression4 | '>' expression4;

expression4 : expression4 '+' expression5 | expression4 '-' expression5 | expression5;
//expression4 : expression5 e | expression5;
//e: '+' expression5 e | '-' expression5 e | '+' expression5 | '-' expression5;

expression5 : expression5 '*' expression6 | expression5 '/' expression6 | expression6;
//expression5 : expression6 f | expression6;
//f: '*' expression6 f | '/' expression6 f | '*' expression6 | '/' expression6;

expression6 : '-' expression6 | '~' expression6 | expression7;

expression7 : expression7 '::' expression8 | expression8;
//expression7 : expression8 g | expression8;
//g: '::' expression8 g | '::' expression8;

expression8 : expression8 '.size' | expression9;
//expression8 : expression9 h | expression9;
//h: '.size' h | '.size';

expression9 : (anonymous_call | anonymous_func | func_call | list | primitive | identifier) (LBRACE expression RBRACE)? | LPAR expression RPAR;

return: 'return' 'void' | 'return' expression;

list: LBRACE (expression(',' expression)*)? RBRACE;

print_call: 'print' LPAR expression RPAR;

anonymous_func: LPAR (expression(',' expression)*)? RPAR '->' LCURBRACE 'func_body' RCURBRACE;

anonymous_call: anonymous_func LPAR (expression(',' expression)*)? RPAR |
    anonymous_func LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR;

func_call: identifier LPAR (('expression')(',' ('expression'))*)? RPAR |
    identifier LPAR (identifier '=' ('expression')(',' identifier '=' ('expression'))*) RPAR;

main : MAIN_KEY ':' print_call | func_call;

primitive : INT | BOOL | STRING;

identifier : IDENTIFIER;

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
