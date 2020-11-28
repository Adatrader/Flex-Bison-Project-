%{
#include <stdio.h>

#ifdef YYDEBUG
extern int yydebug;
#endif

%}

// left, right, nonassoc yacc keywords for operator precedence (highest to lowest) 
%right _leftbracket _period
%right _not _unaryminus // Test if unary minus should be seperate token
%left _plus _minus
%left _multiplication _division _mod
%nonassoc _less _lessequal _greater _greaterequal
%nonassoc _equal _notequal
%left _and
%left _or
%nonassoc _assignop

// extra 
%nonassoc "noelse"
%nonassoc _else
%nonassoc _id
%nonassoc "lvalue"


// Tokens we established from Project 1 
%token _boolean
%token _break
%token _class
%token _double
%token _else
%token _extends
%token _for
%token _if
%token _implements
%token _int
%token _interface
%token _new
%token _newarray
%token _null
%token _println
%token _readln
%token _return
%token _string
%token _this
%token _void
%token _while
%token _plus
%token _minus
%token _multiplication
%token _division
%token _mod
%token _less
%token _lessequal
%token _greater
%token _greaterequal
%token _equal
%token _notequal
%token _and
%token _or
%token _not
%token _assignop
%token _semicolon
%token _comma
%token _period
%token _leftparen
%token _rightparen
%token _leftbracket
%token _rightbracket
%token _leftbrace
%token _rightbrace
%token _intconstant
%token _doubleconstant
%token _stringconstant
%token _booleanconstant
%token _id

// // Bridge between lex and y code 
// %union{


// }

%%
// Production rules and actions (Print production number when reducing)
/* 
'+' = P 
'+,' = PC 
'<optional>' = O 
'*' = M 
*/

// rule 1 - c1
PROGRAM: DECL {printf("[reduce 1]"); printf("[accept]\n");}
	| DECL PROGRAM {printf("[reduce 2]");}
;

// rule 2 - c4
DECL: VARIABLEDECL {printf("[reduce 3]");}
	| FUNCTIONDECL {printf("[reduce 4]");}
	| CLASSDECL {printf("[reduce 5]");}
	| INTERFACEDECL {printf("[reduce 6]");}
;


// rule 3 - c1
VARIABLEDECL: VARIABLE _semicolon {printf("[reduce 8] \n");};


// rule 4 - c1
VARIABLE: TYPE _id {printf("[reduce 9] \n");};


// rule 5 - uc
TYPE: _int {printf("[reduce 9]");}
 	| _double {printf("[reduce 10]");}
 	| _boolean {printf("[reduce 11]");}
 	| _string {printf("[reduce 12]");}
 	| TYPE _leftbracket _rightbracket {printf("[reduce 13]");}
 	| _id {printf("[reduce 14]");}
 ;


// rule 6 - c3
FUNCTIONDECL: TYPE _id _leftparen FORMALS _rightparen STMTBLOCK {printf("[reduce 15]");}
    | _void _id _leftparen FORMALS _rightparen STMTBLOCK {printf("[reduce 16]");}
;

// rule 7 - c3
FORMALS: VARIABLE MORE_VARIABLE {printf("[reduce 17]");}
	| EPSILON {printf("[reduce 18]");}
;

// rule 8 - c3
CLASSDECL: _class _id ZOM_EXTENDS ZOM_IMPLEMENTS _leftbrace MORE_FIELD _rightbrace {printf("[reduce 21]");}
    | _class _id ZOM_EXTENDS ZOM_IMPLEMENTS _leftbrace _rightbrace {printf("[reduce 22]");}
;

// rule 9 - c2
FIELD: VARIABLEDECL {printf("[reduce 31]");}
    | FUNCTIONDECL {printf("[reduce 32]");}
;


// rule 10 - c1
INTERFACEDECL: _interface _id _leftbrace ZOM_PROTOTYPE _rightbrace {printf("[reduce 33]");}
;

// rule 11 - c2
PROTOTYPE: TYPE _id _leftparen FORMALS _rightparen _semicolon {printf("[reduce 35]");}
 	| _void _id _leftparen FORMALS _rightparen _semicolon {printf("[reduce 36]");}
;


// rule 12 - c2
STMTBLOCK: _leftbrace ZOM_VARIABLEDECL ZOM_STMT _rightbrace {printf("[reduce 38]");}
;


// rule 13 - c8
STMT: ZOM_EXPR _semicolon {printf("[reduce 43]");}
	| IFSTMT {printf("[reduce 44]");}
	| WHILESTMT {printf("[reduce 45]");}
	| FORSTMT {printf("[reduce 46]");}
	| BREAKSTMT {printf("[reduce 47]");}
	| RETURNSTMT {printf("[reduce 48]");}
	| PRINTSTMT {printf("[reduce 49]");}
	| STMTBLOCK {printf("[reduce 50]");}
;


// rule 14 - c2
IFSTMT: M_IFSTMT {printf("[reduce 53]");}
	| UM_IFSTMT {printf("[reduce 54]");}
;


// rule 15  -c2
WHILESTMT: _while _leftparen EXPR _rightparen STMT {printf("[reduce 57]");}
;


// rule 16 -c2
FORSTMT: _for _leftparen ZOM_EXPR _semicolon EXPR _semicolon ZOM_EXPR _rightparen STMT {printf("[reduce 58]");}
;


// rule 17 - uc
BREAKSTMT: _break _semicolon {printf("[reduce 58]");}
;


// rule 18 - c1
RETURNSTMT: _return ZOM_EXPR _semicolon {printf("[reduce 60]");}
;


// rule 19 - c1
PRINTSTMT: _println _leftparen MORE_EXPR _rightparen _semicolon {printf("[reduce 61]");}
;


// rule 20 - c3
EXPR: LVALUE _assignop EXPR {printf("[reduce 64]");}
 	| CONSTANT {printf("[reduce 65]");}
 	| LVALUE {printf("[reduce 66]");}
 	| _this {printf("[reduce 66]");}
 	| CALL {printf("[reduce 67]");}
 	| _leftparen EXPR _rightparen  {printf("[reduce 68]");}
 	| EXPR _plus EXPR {printf("[reduce 69]");}
 	| EXPR _minus EXPR {printf("[reduce 70]");}
 	| EXPR _multiplication EXPR {printf("[reduce 71]");}
 	| EXPR _division EXPR {printf("[reduce 72]");}
 	| EXPR _mod EXPR {printf("[reduce 73]");}
 	| _minus EXPR %prec _unaryminus {printf("[reduce 74]");}
 	| EXPR _less EXPR {printf("[reduce 75]");}
 	| EXPR _lessequal EXPR {printf("[reduce 76]");}
 	| EXPR _greater EXPR {printf("[reduce 77]");}
 	| EXPR _greaterequal EXPR {printf("[reduce 78]");}
 	| EXPR _equal EXPR {printf("[reduce 79]");}
 	| EXPR _notequal EXPR {printf("[reduce 80]");}
 	| EXPR _and EXPR {printf("[reduce 81]");}
 	| EXPR _or EXPR {printf("[reduce 82]");}
 	| _not EXPR {printf("[reduce 83]");}
 	| _readln _leftparen _rightparen {printf("[reduce 84]");}
 	| _new _leftparen _id _rightparen {printf("[reduce 84]");}
 	| _newarray _leftparen _intconstant _comma TYPE _rightparen {printf("[reduce 85]");}
;

// rule 21 - c1
LVALUE: _id {printf("[reduce 86]");}
 	| LVALUE _leftbracket EXPR _rightbracket {printf("[reduce 96]");}
 	| LVALUE _leftparen EXPR _rightparen {printf("[reduce 88]");}
;


// rule 22 - c1
CALL: _id _leftparen ACTUALS _rightparen {printf("[reduce 89]");}
	| _id _period _id _leftparen ACTUALS _rightparen {printf("[reduce 90]");}
;


// rule 23 - c2
ACTUALS: MORE_EXPR {printf("[reduce 100]");}
    | EPSILON {printf("[reduce 101]");}
;


// rule 24 - uc
CONSTANT: _intconstant {printf("[reduce 93]");}
	| _doubleconstant {printf("[reduce 93]");}
	| _stringconstant {printf("[reduce 94]");}
	| _booleanconstant {printf("[reduce 95]");}
	| _null {printf("[reduce 96]");}
;

/* ------------------------------------- minor rules ------------------------------------- */
EPSILON: {printf("[reduce 97]");}
;

MORE_VARIABLE: _comma VARIABLE MORE_VARIABLE {printf("[reduce 19]");}
	| EPSILON {printf("[reduce 20]");}
;

ZOM_VARIABLEDECL: VARIABLEDECL ZOM_VARIABLEDECL {printf("[reduce 39]");}
				| EPSILON {printf("[reduce 40]");}
;


MORE_ID: _id _comma MORE_ID {printf("[reduce 29]");}
    | _id {printf("[reduce 30]");}
;

MORE_EXPR: EXPR _comma MORE_EXPR {printf("[reduce 62]");}
    | EXPR {printf("[reduce 63]");}
;

ZOM_EXPR: EXPR {printf("[reduce 51]");}
	| EPSILON {printf("[reduce 52]");}
;

ZOM_STMT: STMT ZOM_STMT {printf("[reduce 41]");}
	| EPSILON {printf("[reduce 42]");}
;

ZOM_EXTENDS: _extends _id {printf("[reduce 25]");}
    | EPSILON {printf("[reduce 26]");}
;

ZOM_IMPLEMENTS: _implements MORE_ID {printf("[reduce 27]");}
    | EPSILON {printf("[reduce 28]");}
;

MORE_FIELD: FIELD MORE_ID {printf("[reduce 23]");}
	| FIELD {printf("[reduce 24]");}
;

ZOM_PROTOTYPE: PROTOTYPE ZOM_PROTOTYPE {printf("[reduce 34]");}
    | EPSILON {printf("[reduce 35]");}
;

UM_IFSTMT: _if _leftparen EXPR _rightbrace STMT {printf("[reduce 55]");}
;

M_IFSTMT: _if _leftparen EXPR _rightparen M_IFSTMT _else M_IFSTMT {printf("[reduce 56]");}
;

%%


void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(){
	// initSwitch();
	// initSymbol();
	// initNext();
    
	return(yyparse());
}
