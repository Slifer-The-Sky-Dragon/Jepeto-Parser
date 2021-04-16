grammar Jepeto;

//jepeto : complete_statement EOF;
jepeto : func* main func* EOF;

func : FUNC_KEY identifier LPAR (expression(',' expression)*)? RPAR ':' single_complete_statement |
           FUNC_KEY identifier LPAR (expression(',' expression)*)? RPAR ':' LCURBRACE complete_statement RCURBRACE |
           FUNC_KEY identifier LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR ':' single_complete_statement |
           FUNC_KEY identifier LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR ':' LCURBRACE complete_statement RCURBRACE;

//func_body: complete_if_else completed_body | statement_without_if func_body | return completed_body | not_complete_if_else func_body;

//completed_body: ;



not_complete_statement : not_complete_matched_statement temp2 | not_complete_unmatched_statement temp2;
temp2 : not_complete_statement temp2 |;

not_complete_matched_statement : not_complete_matched_rule1 | not_complete_matched_rule2 | not_complete_matched_rule3 | not_complete_matched_rule4 | not_complete_matched_rule5 |
                                not_complete_matched_rule6 | not_complete_matched_rule7 | not_complete_matched_rule8 | not_complete_matched_rule9;
not_complete_matched_rule1 : 'if' expression ':' '{' statement '}' 'else' ':' '{' not_complete_statement '}';
not_complete_matched_rule2 : 'if' expression ':' '{' not_complete_statement '}' 'else' ':' '{' statement '}';
not_complete_matched_rule3 : 'if' expression ':' '{' statement '}' 'else' ':'  not_complete_matched_statement;
not_complete_matched_rule4 : 'if' expression ':' '{' not_complete_statement '}' 'else' ':'  matched_statement;
not_complete_matched_rule5 : 'if' expression ':' matched_statement 'else' ':' '{' not_complete_statement '}';
not_complete_matched_rule6 : 'if' expression ':' not_complete_matched_statement 'else' ':' '{' statement '}';
not_complete_matched_rule7 : 'if' expression ':' matched_statement 'else' ':' not_complete_matched_statement;
not_complete_matched_rule8 : 'if' expression ':' not_complete_matched_statement 'else' ':' matched_statement;
not_complete_matched_rule9 : (print_call | anonymous_call | func_call) ';';

not_complete_unmatched_statement : not_complete_unmatched_rule1 | not_complete_unmatched_rule2 | not_complete_unmatched_rule3 | not_complete_unmatched_rule4
                                    not_complete_unmatched_rule5 | not_complete_unmatched_rule6;
not_complete_unmatched_rule1 : 'if' expression ':' '{' statement '}';
not_complete_unmatched_rule2 : 'if' expression ':' statement;
not_complete_unmatched_rule3 : 'if' expression ':' '{' statement '}' 'else' ':' not_complete_unmatched_statement;
not_complete_unmatched_rule4 : 'if' expression ':' '{' not_complete_statement '}' 'else' ':' unmatched_statement;
not_complete_unmatched_rule5 : 'if' expression ':' matched_statement 'else' ':' not_complete_unmatched_statement;
not_complete_unmatched_rule6 : 'if' expression ':' not_complete_matched_statement 'else' ':' unmatched_statement;



complete_statement : not_complete_statement? complete_matched_statement statement?;
//| statement? complete_unmatched_statement statement?;
single_complete_statement : complete_matched_statement;

complete_matched_statement : complete_matched_rule1 | complete_matched_rule2 | complete_matched_rule3 | complete_matched_rule4 | return_call;
complete_matched_rule1 : 'if' expression ':' '{' (complete_statement) '}' 'else' ':' '{' (complete_statement) '}';
complete_matched_rule2 : 'if' expression ':' '{' (complete_statement) '}' 'else' ':'  complete_matched_statement;
complete_matched_rule3 : 'if' expression ':' complete_matched_statement 'else' ':' '{' (complete_statement) '}';
complete_matched_rule4 : 'if' expression ':' complete_matched_statement 'else' ':' complete_matched_statement;

//complete_unmatched_statement : complete_unmatched_rule1 | complete_unmatched_rule2;
//complete_unmatched_rule1 : 'if' expression ':' '{' (return_call | complete_statement) '}' 'else' ':' complete_unmatched_statement;
//complete_unmatched_rule2 : 'if' expression ':' complete_matched_statement 'else' ':' complete_unmatched_statement;



statement : matched_statement temp | unmatched_statement temp;
temp : statement temp |;

matched_statement : matched_rule1 | matched_rule2 | matched_rule3 | matched_rule4 | matched_rule5;
matched_rule1 : 'if' expression ':' '{' statement '}' 'else' ':' '{' statement '}';
matched_rule2 : 'if' expression ':' '{' statement '}' 'else' ':'  matched_statement;
matched_rule3 : 'if' expression ':' matched_statement 'else' ':' '{' statement '}';
matched_rule4 : 'if' expression ':' matched_statement 'else' ':' matched_statement;
matched_rule5 : (print_call | anonymous_call | func_call) ';' | return_call;

unmatched_statement : unmatched_rule1 | unmatched_rule2 | unmatched_rule3 | unmatched_rule4;
unmatched_rule1 : 'if' expression ':' '{' statement '}';
unmatched_rule2 : 'if' expression ':' statement;
unmatched_rule3 : 'if' expression ':' '{' statement '}' 'else' ':' unmatched_statement;
unmatched_rule4 : 'if' expression ':' matched_statement 'else' ':' unmatched_statement;

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

expression9 : (anonymous_call | anonymous_func | func_call | list | primitive | identifier) (LBRACE expression RBRACE)* | LPAR expression RPAR;

return_call: ('return' 'void' | 'return' expression) ';';

list: LBRACE (expression(',' expression)*)? RBRACE;

print_call: 'print' LPAR expression RPAR;

anonymous_func: LPAR (expression(',' expression)*)? RPAR '->' LCURBRACE 'func_body' RCURBRACE;

anonymous_call: anonymous_func LPAR (expression(',' expression)*)? RPAR |
    anonymous_func LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR;

func_call: identifier LPAR (expression(',' expression)*)? RPAR |
    identifier LPAR (identifier '=' expression(',' identifier '=' expression)*) RPAR;

//
main : MAIN_KEY ':' {System.out.println("Main");} (print_call | func_call) ';';

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
INT : '0' | [1-9][0-9]*;
STRING : '"' ~('"') + '"';
COMMA : ',';
//KEYWORD : 'bool' | 'int' | 'string';
//NEG_OPERATOR : '-';
//BIN_OPERATOR : 'and' | 'or' | 'is' | 'not' | '+' | '*' | '/' | '<' | '>' | '::' | '=';
//UNA_OPERATOR : '~';
//SIZE_OPERATOR : '.size';
