grammar Jepeto;

jepeto : func* main func* EOF;

func : FUNC_KEY funcname  LPAR (func_args(',' func_args)*)? RPAR ':' single_complete_statement |
           FUNC_KEY funcname LPAR (func_args(',' func_args)*)? RPAR ':' LCURBRACE complete_statement RCURBRACE;


funcname : IDENTIFIER {System.out.println("FunctionDec : " + $IDENTIFIER.getText());};
func_args : IDENTIFIER {System.out.println("ArgumentDec : " + $IDENTIFIER.getText());};
if_rule : 'if' {System.out.println("Conditional : if");};
else_rule : 'else' {System.out.println("Conditional : else");};

not_complete_statement : single_not_complete_statement not_complete_statement | single_not_complete_statement;
single_not_complete_statement : not_complete_matched_statement | not_complete_unmatched_statement;

not_complete_matched_statement : not_complete_matched_rule1 | not_complete_matched_rule2 | not_complete_matched_rule3 | not_complete_matched_rule4 | not_complete_matched_rule5 |
                                not_complete_matched_rule6 | not_complete_matched_rule7 | not_complete_matched_rule8 | not_complete_matched_rule9;
not_complete_matched_rule1 : if_rule expression ':' '{' statement '}' else_rule ':' '{' not_complete_statement '}';
not_complete_matched_rule2 : if_rule expression ':' '{' not_complete_statement '}' else_rule ':' '{' statement '}';
not_complete_matched_rule3 : if_rule expression ':' '{' statement '}' else_rule ':'  not_complete_matched_statement;
not_complete_matched_rule4 : if_rule expression ':' '{' not_complete_statement '}' else_rule ':'  matched_statement;
not_complete_matched_rule5 : if_rule expression ':' matched_statement else_rule ':' '{' not_complete_statement '}';
not_complete_matched_rule6 : if_rule expression ':' not_complete_matched_statement else_rule ':' '{' statement '}';
not_complete_matched_rule7 : if_rule expression ':' matched_statement else_rule ':' not_complete_matched_statement;
not_complete_matched_rule8 : if_rule expression ':' not_complete_matched_statement else_rule ':' matched_statement;
not_complete_matched_rule9 : (print_call | anonymous_call | {System.out.println("FunctionCall");} func_call ) ';';

not_complete_unmatched_statement : not_complete_unmatched_rule1 | not_complete_unmatched_rule2 | not_complete_unmatched_rule3 | not_complete_unmatched_rule4
                                    not_complete_unmatched_rule5 | not_complete_unmatched_rule6;
not_complete_unmatched_rule1 : if_rule expression ':' '{' statement '}';
not_complete_unmatched_rule2 : if_rule expression ':' single_statement;
not_complete_unmatched_rule3 : if_rule expression ':' '{' statement '}' else_rule ':' not_complete_unmatched_statement;
not_complete_unmatched_rule4 : if_rule expression ':' '{' not_complete_statement '}' else_rule ':' unmatched_statement;
not_complete_unmatched_rule5 : if_rule expression ':' matched_statement else_rule ':' not_complete_unmatched_statement;
not_complete_unmatched_rule6 : if_rule expression ':' not_complete_matched_statement else_rule ':' unmatched_statement;



complete_statement : not_complete_statement? complete_matched_statement statement?;
single_complete_statement : complete_matched_statement;

complete_matched_statement : complete_matched_rule1 | complete_matched_rule2 | complete_matched_rule3 | complete_matched_rule4 | return_call;
complete_matched_rule1 : if_rule expression ':' '{' complete_statement '}' else_rule ':' '{' complete_statement '}';
complete_matched_rule2 : if_rule expression ':' '{' complete_statement '}' else_rule ':'  complete_matched_statement;
complete_matched_rule3 : if_rule expression ':' complete_matched_statement else_rule ':' '{' complete_statement '}';
complete_matched_rule4 : if_rule expression ':' complete_matched_statement else_rule ':' complete_matched_statement;



statement: single_statement statement | single_statement;
single_statement : matched_statement | unmatched_statement;

matched_statement : matched_rule1 | matched_rule2 | matched_rule3 | matched_rule4 | matched_rule5;
matched_rule1 : if_rule expression ':' '{' statement '}' else_rule ':' '{' statement '}';
matched_rule2 : if_rule expression ':' '{' statement '}' else_rule ':'  matched_statement;
matched_rule3 : if_rule expression ':' matched_statement else_rule ':' '{' statement '}';
matched_rule4 : if_rule expression ':' matched_statement else_rule ':' matched_statement;
matched_rule5 : (print_call | anonymous_call | {System.out.println("FunctionCall");} func_call) ';' | return_call;

unmatched_statement : unmatched_rule1 | unmatched_rule2 | unmatched_rule3 | unmatched_rule4;
unmatched_rule1 : if_rule expression ':' '{' statement '}';
unmatched_rule2 : if_rule expression ':' single_statement;
unmatched_rule3 : if_rule expression ':' '{' statement '}' else_rule ':' unmatched_statement;
unmatched_rule4 : if_rule expression ':' matched_statement else_rule ':' unmatched_statement;



//delete left recursion
//expression : expression 'or' expression1 {System.out.println("Operator : or");} | expression1;
expression : expression1 a | expression1;
a: 'or' expression1 {System.out.println("Operator : or");} a | 'or' expression1 {System.out.println("Operator : or");};

//expression1 : expression1 'and' expression2 {System.out.println("Operator : and");} | expression2;
expression1 : expression2 b | expression2;
b: 'and' expression2 {System.out.println("Operator : and");} b | 'and' expression2 {System.out.println("Operator : and");};

//expression2 : expression2 'is' expression3 {System.out.println("Operator : is");}|
//              expression2 'not' expression3 {System.out.println("Operator : not");} | expression3;
expression2 : expression3 c | expression3;
c: 'is' expression3 {System.out.println("Operator : is");} c |
   'not' expression3 {System.out.println("Operator : not");} c |
   'is' expression3 {System.out.println("Operator : is");} |
   'not' expression3 {System.out.println("Operator : not");};

//expression3 : expression3 '<' expression4 {System.out.println("Operator : <");} |
//              expression3 '>' expression4 {System.out.println("Operator : >");} | expression4;

expression3 : expression4 d | expression4;
d: '<' expression4 {System.out.println("Operator : <");} d |
   '>' expression4 {System.out.println("Operator : >");} d |
   '<' expression4 {System.out.println("Operator : <");}|
   '>' expression4 {System.out.println("Operator : >");};

//expression4 : expression4 '+' expression5 {System.out.println("Operator : +");} |
//              expression4 '-' expression5 {System.out.println("Operator : -");}| expression5;
expression4 : expression5 e | expression5;
e: '+' expression5 {System.out.println("Operator : +");} e |
   '-' expression5 {System.out.println("Operator : -");} e |
   '+' expression5 {System.out.println("Operator : +");}|
   '-' expression5 {System.out.println("Operator : -");};

//expression5 : expression5 '*' expression6 {System.out.println("Operator : *");} |
//              expression5 '/' expression6 {System.out.println("Operator : /");} | expression6;
expression5 : expression6 f | expression6;
f: '*' expression6 {System.out.println("Operator : *");} f |
   '/' expression6 {System.out.println("Operator : /");} f |
   '*' expression6 {System.out.println("Operator : *");} |
   '/' expression6 {System.out.println("Operator : /");};

expression6 : '-' expression6 {System.out.println("Operator : -");} |
              '~' expression6 {System.out.println("Operator : ~");} | expression7;

//expression7 : expression7 '::' expression8 {System.out.println("Operator : ::");} | expression8;
expression7 : expression8 g | expression8;
g: '::' expression8 {System.out.println("Operator : ::");} g | '::' expression8 {System.out.println("Operator : ::");};

//expression8 : expression8 '.size' {System.out.println("Size");} | expression9;
expression8 : expression9 h | expression9;
h: '.size' {System.out.println("Size");} h | '.size' {System.out.println("Size");};

expression9 : (anonymous_call | anonymous_func | func_call | list | primitive | IDENTIFIER) (LBRACE expression RBRACE)* | LPAR expression RPAR;

return_call: {System.out.println("Return");} ('return' 'void' | 'return' expression) ';';

list: LBRACE (expression(',' expression)*)? RBRACE;

print_call: {System.out.println("Built-in : print");} 'print' LPAR expression RPAR;

anonymous_func: {System.out.println("Anonymous Function");} LPAR (func_args(',' func_args)*)? RPAR '-' '>' LCURBRACE complete_statement RCURBRACE;

anonymous_call: anonymous_func LPAR (expression(',' expression)*)? RPAR |
    anonymous_func LPAR (IDENTIFIER '=' expression(',' IDENTIFIER '=' expression)*) RPAR;

func_call: IDENTIFIER (LPAR (expression(',' expression)*)? RPAR | LPAR (IDENTIFIER '=' expression(',' IDENTIFIER '=' expression)*) RPAR)+;

main : MAIN_KEY ':' {System.out.println("Main");} (print_call | {System.out.println("FunctionCall");} func_call) ';';

primitive : INT | BOOL | STRING;

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
