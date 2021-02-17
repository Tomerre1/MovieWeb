%{

#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"
#include <string.h>
//struct of each node on ast
typedef struct node{
	char *value;
	char* type;
	int myLine;
	int label1;
	int label2;
	int label3;
	struct node *branch1;
	struct node *branch2;
	struct node *branch3;
	struct node *branch4;
} node;

//linked list for frame content
typedef struct frame_content{
	char* name;
	char* value;
	int length;
	char* type;
	int isFunction;
	struct frame_content* argument_list;
	struct frame_content* next;
} frame_content;
//stack for each frame
typedef struct frame_stack{
	struct frame_content* data;
	char* name;
	char* type;
	struct frame_stack* next;
} frame_stack;

//function declaration and externals
extern char *yytext;
extern int yylineno;
int yyerror(char* e);
int yylex();
int isType = 0;
int isArgument = 0;
int isDeclaration = 0;
int isFuncCall = 0;
int isAssign = 0;
int LHS = 0;
char* currentType = NULL;
frame_content* tempParameters = NULL;
int finishedGrammar = 0;
int paramsize = 0;
char* check_tree(node* tree);
node* makenode(char * token, char* type, node* b1, node* b2, node* b3, node* b4);
void printtree(node* tree, int tabs, int sameline, int sameindent);
//stack and symbol table functions
void create_stack(frame_stack** headptr);
void create_table(frame_content** headptr);
int is_stack_empty(frame_stack* headptr);
int is_table_empty(frame_content* headptr);
void Push(frame_stack** headptr, frame_content* DataIn);
void Pop(frame_stack** headptr);
frame_content* add_to_table(frame_content** headptr, frame_content** item);
frame_content* search_table(frame_content* headptr, char* varname, int isDuplicate, int isFunction, int Line);
frame_content* search_stack(frame_stack* headptr, char* varname, int isFunction, int Line);
void search_ret_type(frame_stack* headptr, char* type, int Line);
char* search_func_name(frame_stack* headptr);
frame_content* make_variable(char* name, char* vartype, char* value);
frame_content* make_function(char* name, frame_content* arglist, char* rettype);
frame_content* make_string(char* name, int length, char* value);
char* print3AC(node* tree, int truelabel, int falselabel, char* parent, int isR);
int tcounter = 0;
int Lcounter = 0;
frame_stack* stackhead;
%}

//union
%union {
  char* string; 
  struct node* node;
}
//tokens
%token <string> AND DIVIDE INITIALIZATION EQUAL GREATER LESSER GREATEREQUAL LESSEREQUAL MINUS PLUS NOT NOTEQUAL MULT OR ADDRESS POW
%token <string> BOOL CHAR INT REAL STRING INTP CHARP REALP
%token <string> IF ELSE WHILE  VAR FUNC  PROC RETURN TOKNULL 
%token <string> SEMICOLON COLON COMMA LEN OPENCURLY CLOSECURLY OPENBRACKET CLOSEBRACKET OPENSTRBRACKET CLOSESTRBRACKET
%token <string> MAIN TRUE FALSE INTEGERLITERAL REALLITERAL STRINGLITERAL CHARLITERAL ID

//precedence
%left OR
%left AND
%left EQUAL NOTEQUAL LESSER LESSEREQUAL GREATER GREATEREQUAL
%left PLUS MINUS
%left MULT DIVIDE
%right NOT ADDRESS POW
%nonassoc IF
%nonassoc ELSE
%nonassoc ID
//types of rules
%type <node> project code functions function ftype  mainfunc
%type <node> arguments funcargs args funcbody procedurebody
%type <node> block statements statement expr type stringsize stringindex
%type <node> funccall exprlist parameters assign whilestatement 
%type <node>  declares
%type <node> declare varsdeclare varsdeclaration  
%type <node> returnstatement
//start
%start project

%% 
 //general code structure
project: code {finishedGrammar = 1; create_stack(&stackhead); check_tree($1);  printf("\n"); print3AC($1, -1, -1, NULL, 0);};
code: functions mainfunc {$$ = makenode("CODE", NULL, $1, $2,NULL,NULL);};
functions: functions function {$$ = makenode("FUNCCODE", NULL, $1, $2, NULL, NULL);}
	| {$$ = NULL;};
	
	
	//function signature
mainfunc: PROC MAIN OPENBRACKET CLOSEBRACKET OPENCURLY procedurebody
	{$$ = makenode("FUNCTION", "VOID", makenode("main", NULL, NULL, NULL, NULL, NULL), makenode("ARGS NONE", NULL, NULL, NULL,NULL, NULL), makenode("TYPE VOID", NULL, NULL, NULL,NULL, NULL), $6);};
function: FUNC  ID arguments RETURN ftype OPENCURLY funcbody 
	{$$ = makenode("FUNCTION", $5->value, makenode($2, NULL, NULL, NULL, NULL, NULL), $3, $5, $7);}
	| PROC ID arguments OPENCURLY procedurebody 
	{$$ = makenode("FUNCTION", "VOID", makenode($2, NULL, NULL, NULL, NULL, NULL), $3, makenode("TYPE VOID", NULL, NULL, NULL, 															NULL, NULL), $5);};
	
 //types
ftype: INT {$$ = makenode("TYPE INT", NULL, NULL, NULL, NULL, NULL);}
	|REAL {$$ = makenode("TYPE REAL", NULL, NULL, NULL, NULL, NULL);}
	|BOOL {$$ = makenode("TYPE BOOL", NULL, NULL, NULL, NULL, NULL);}
	|CHAR {$$ = makenode("TYPE CHAR", NULL, NULL, NULL, NULL, NULL);}
	|INTP {$$ = makenode("TYPE INTP", NULL, NULL, NULL, NULL, NULL);}
	|REALP {$$ = makenode("TYPE REALP", NULL, NULL, NULL, NULL, NULL);}
	|CHARP {$$ = makenode("TYPE CHARP", NULL, NULL, NULL, NULL, NULL);};
type:INT {$$ = makenode("INT", NULL, NULL, NULL, NULL, NULL);}
	|REAL {$$ = makenode("REAL", NULL, NULL, NULL, NULL, NULL);}
	|BOOL {$$ = makenode("BOOL", NULL, NULL, NULL, NULL, NULL);}
	|CHAR {$$ = makenode("CHAR", NULL, NULL, NULL, NULL, NULL);}
	|INTP {$$ = makenode("INTP", NULL, NULL, NULL, NULL, NULL);}
	|REALP {$$ = makenode("REALP", NULL, NULL, NULL, NULL, NULL);}
	|CHARP {$$ = makenode("CHARP", NULL, NULL, NULL, NULL, NULL);};
 //	function arguments 
arguments: OPENBRACKET funcargs CLOSEBRACKET {$$ = makenode("ARGS", NULL, $2, NULL, NULL, NULL);}
	| OPENBRACKET CLOSEBRACKET {$$ = makenode("ARGS NONE", NULL, NULL, NULL, NULL, NULL);};
	
funcargs:  args COLON type{$$ = makenode("TYPE", NULL, $3, $1, NULL, NULL);}
	|args COLON type SEMICOLON funcargs {$$ = makenode("TYPE", NULL, $3, $1, $5, NULL);};
			
args: ID COMMA args {$$ = makenode($1, "VARIABLE", $3, NULL, NULL, NULL);}
	|ID {$$ = makenode($1, "VARIABLE", NULL, NULL, NULL, NULL);};

 //body of functions	
funcbody: declares statements returnstatement CLOSECURLY {$$ = makenode("BODY", NULL, $1, $2, $3, NULL);}
	| declares returnstatement CLOSECURLY {$$ = makenode("BODY", NULL, $1, $2, NULL, NULL);};
procedurebody: declares statements CLOSECURLY {$$ = makenode("BODY", NULL, $1, $2, NULL, NULL);}
	| declares CLOSECURLY {$$ = makenode("BODY", NULL, $1, NULL, NULL, NULL);};

 //statements
block: OPENCURLY declares statements CLOSECURLY {$$ = makenode("BLOCK", NULL, $2, $3, NULL, NULL);}
	|OPENCURLY declares CLOSECURLY {$$ = makenode("BLOCK", NULL, $2, NULL, NULL, NULL);};

statements: statements statement {$$ = makenode("STMNT", NULL, $1, $2, NULL, NULL);}
	|statement {$$ = makenode("STMNT", NULL, $1, NULL, NULL, NULL);};

statement: IF OPENBRACKET expr CLOSEBRACKET statement {$$ = makenode("IF", NULL, $3, $5, NULL, NULL);} %prec IF
	|IF OPENBRACKET expr CLOSEBRACKET statement ELSE statement {$$ = makenode("IF-ELSE", NULL, $3, $5, $7, NULL);}
	|funccall SEMICOLON {$$ = $1;}
	|assign {$$ = $1;}
	|whilestatement {$$ = $1;}
	|block {$$ = $1;}


 //expressions
expr: expr MULT expr {$$ = makenode("*", NULL, $1, $3, NULL, NULL);}
	|expr DIVIDE expr {$$ = makenode("/", NULL, $1, $3, NULL, NULL);}
	|expr PLUS expr {$$ = makenode("+", NULL, $1, $3, NULL, NULL);}
	|expr MINUS expr {$$ = makenode("-", NULL, $1, $3, NULL, NULL);}
	|expr AND expr {$$ = makenode("&&", NULL, $1, $3, NULL, NULL);}
	|expr OR expr {$$ = makenode("||", NULL, $1, $3, NULL, NULL);}
	|expr EQUAL expr {$$ = makenode("==", NULL, $1, $3, NULL, NULL);}
	|expr GREATEREQUAL expr {$$ = makenode(">=", NULL, $1, $3, NULL, NULL);}
	|expr GREATER expr {$$ = makenode(">", NULL, $1, $3, NULL, NULL);}
	|expr LESSEREQUAL expr {$$ = makenode("<=", NULL, $1, $3, NULL, NULL);}
	|expr LESSER expr {$$ = makenode("<", NULL, $1, $3, NULL, NULL);}
	|expr NOTEQUAL expr {$$ = makenode("!=", NULL, $1, $3, NULL, NULL);}
	|LEN ID LEN {$$ = makenode("|LENGTH|", NULL, makenode($2, "VARIABLE", NULL, NULL, NULL, NULL), NULL, NULL, NULL);}
	|NOT expr {$$ = makenode("!", NULL, $2, NULL, NULL, NULL);}
	|MINUS expr {$$ = makenode("-", NULL, $2, NULL, NULL, NULL);}
	|ADDRESS expr {$$ = makenode("&", NULL, $2, NULL, NULL, NULL);}

	|POW expr {$$ = makenode("DEREFERENCE", NULL, $2, NULL, NULL, NULL);}
	|OPENBRACKET expr CLOSEBRACKET {$$ = makenode("(_)", NULL, $2, NULL, NULL, NULL);}
	|INTEGERLITERAL {$$ = makenode($1, "INT", NULL, NULL, NULL, NULL);}
	|REALLITERAL {$$ = makenode($1, "REAL", NULL, NULL, NULL, NULL);}
	|CHARLITERAL {$$ = makenode($1, "CHAR", NULL, NULL, NULL, NULL);}
	|ID {$$ = makenode($1, "VARIABLE", NULL, NULL, NULL, NULL);}
	|TRUE {$$ = makenode("true", "BOOL", NULL, NULL, NULL, NULL);}
	|FALSE {$$ = makenode("false", "BOOL", NULL, NULL, NULL, NULL);}
	|ID stringindex {$$ = makenode($1, "VARIABLE", $2, NULL, NULL, NULL);}
	|TOKNULL {$$ = makenode("null", "NULL", NULL, NULL, NULL, NULL);}
	|funccall {$$ = $1;};

 //function call
funccall: ID OPENBRACKET parameters CLOSEBRACKET {$$ = makenode("FUNCTION CALL", NULL, makenode($1, NULL, NULL, NULL, NULL, NULL), $3, NULL, NULL);}
	| ID OPENBRACKET CLOSEBRACKET {$$ = makenode("FUNCTION CALL", NULL, makenode($1, NULL, NULL, NULL, NULL, NULL), NULL, NULL, NULL);};

parameters: exprlist {$$ = makenode("PARAMETERS", NULL, $1, NULL, NULL, NULL);};
exprlist: expr COMMA exprlist {$$ = makenode("PARAMETER", NULL, $1, $3, NULL, NULL);}
	|expr {$$ = makenode("PARAMETER", NULL, $1, NULL, NULL, NULL);};

 //assign
assign: ID INITIALIZATION expr SEMICOLON {$$ = makenode("=", NULL, makenode($1, "VARIABLE", NULL, NULL, NULL, NULL), $3, NULL, NULL);}
	|ID INITIALIZATION STRINGLITERAL SEMICOLON {$$ = makenode("=", NULL, makenode($1, "VARIABLE", NULL, NULL, NULL, NULL), makenode($3, "STRING", NULL, NULL, NULL, NULL), NULL, NULL);}
	|ID stringindex INITIALIZATION expr SEMICOLON {$$ = makenode("=", NULL, makenode($1, "VARIABLE", $2, NULL, NULL, NULL), $4, NULL, NULL);}
	|POW ID INITIALIZATION expr SEMICOLON 
	{$$ = makenode("=", NULL, makenode("DEREFERENCE", NULL, makenode($2, "VARIABLE", NULL, NULL, NULL, NULL), NULL, NULL, NULL), $4, NULL, NULL);};

 // loop statements
whilestatement: WHILE OPENBRACKET expr CLOSEBRACKET statement {$$ = makenode("WHILE", NULL, $3, $5, NULL, NULL);};


 //declares
declares: declares declare {$$ = makenode("DECLARE", NULL, $1, $2, NULL, NULL);}
	|declares function {$$ = makenode("FUNCCODE", NULL, $1, $2, NULL, NULL);}
	| {$$ = NULL;};
	

declare: VAR varsdeclare COLON type SEMICOLON {$$ = makenode("VAR", NULL, $4, $2, NULL, NULL);}
	|VAR varsdeclare COLON STRING stringsize SEMICOLON  
	{$$ = makenode("STRING", "STRING", $2, NULL, NULL, NULL);};

varsdeclare: varsdeclaration COMMA varsdeclare {$$ = makenode("DECLARATION", NULL, $1, $3, NULL, NULL);}
	|varsdeclaration {$$ = makenode("DECLARATION", NULL, $1, NULL, NULL, NULL);};

varsdeclaration: ID {$$ = makenode($1, "VARIABLE", NULL, NULL, NULL, NULL);};
	
//string size and index
stringsize: OPENSTRBRACKET INTEGERLITERAL CLOSESTRBRACKET {$$ = makenode("STRING SIZE", NULL, makenode($2, NULL, NULL, NULL, NULL, NULL), NULL, NULL, NULL);};
stringindex: OPENSTRBRACKET expr CLOSESTRBRACKET {$$ = makenode("STRING INDEX", NULL, $2, NULL, NULL, NULL);};
 //return

returnstatement: RETURN expr SEMICOLON {$$ = makenode("RET", NULL, $2, NULL, NULL, NULL);};

%%
 //main
int main(){
	return yyparse();
}
 //make new node
node *makenode(char * token, char* type, node* b1, node* b2, node* b3, node* b4){
	node *newnode = (node*)malloc(sizeof(node));
	newnode->value = token;
	newnode->type = type;
	newnode->myLine = yylineno;
	newnode->label1 = -1;
	newnode->label2 = -1;
	newnode->label3 = -1;
	newnode->branch1 = b1;
	newnode->branch2 = b2;
	newnode->branch3 = b3;
	newnode->branch4 = b4;
	return newnode;

}

//print the ast tree
void printtree(node* tree, int tabs, int sameline, int sameindent){
	//flags
	int nexttabs;
	int skipline = 0;
	int matchedpara = 0;
	if (strcmp(tree->value, "FUNCCODE")==0 || strcmp(tree->value, "STMNT")==0
	|| strcmp(tree->value, "DECLARATION")==0 || strcmp(tree->value, "PARAMETER")==0
	|| strcmp(tree->value, "DECLARE")==0){
		sameindent = 1;
		skipline = 1;
	}

	//printing tabs before node value
	if (sameline == 0 && skipline == 0){
		for(int i = 0; i < tabs; i++)
			printf("\t");
	}
	// if chaining several different types within the same function argument list
	if (sameline == 1){
		if (strcmp(tree->value, "TYPE") == 0){
			for(int i = 0; i < tabs; i++)
				printf("\t");
		}
	}
	//if ( is needed
	if (strcmp(tree->value, "TYPE") == 0 || strcmp(tree->value, "FUNCTION") == 0 || strcmp(tree->value, "CODE") == 0
	|| strcmp(tree->value, "ARGS") == 0 || strcmp(tree->value, "BODY") == 0 || strcmp(tree->value, "BLOCK") == 0 
	|| strcmp(tree->value, "IF") == 0 || strcmp(tree->value, "IF-ELSE") == 0 || strcmp(tree->value, "FUNCTION CALL") == 0
	 || strcmp(tree->value, "=") == 0 || strcmp(tree->value, "WHILE") == 0 
	 || strcmp(tree->value, "INIT") == 0 || strcmp(tree->value, "UPDATE") == 0 
	 || strcmp(tree->value, "STRING") == 0 || strcmp(tree->value, "RET") == 0  || strcmp(tree->value, "ARGS NONE") == 0
	 || strcmp(tree->value, "VAR") == 0 || strcmp(tree->value, "TYPE REAL") == 0 || strcmp(tree->value, "TYPE CHARP") == 0
	 || strcmp(tree->value, "TYPE VOID") == 0 || strcmp(tree->value, "TYPE INT") == 0 || strcmp(tree->value, "TYPE CHAR") == 0
	 || strcmp(tree->value, "TYPE BOOL") == 0 || strcmp(tree->value, "TYPE INTP") == 0 || strcmp(tree->value, "TYPE REALP") == 0
	 || strcmp(tree->value, "*") == 0 || strcmp(tree->value, "/") == 0 || strcmp(tree->value, "&") == 0
	 || strcmp(tree->value, "+") == 0 || strcmp(tree->value, "-") == 0 || strcmp(tree->value, "&&") == 0
	 || strcmp(tree->value, "||") == 0 || strcmp(tree->value, "==") == 0 || strcmp(tree->value, ">=") == 0
	 || strcmp(tree->value, ">") == 0 || strcmp(tree->value, "<=") == 0 || strcmp(tree->value, "<") == 0
	 || strcmp(tree->value, "!=") == 0 || strcmp(tree->value, "!") == 0 || strcmp(tree->value, "STRING SIZE") == 0
	 || strcmp(tree->value, "STRING INDEX") == 0 || strcmp(tree->value, "PARAMETERS") == 0
	  || strcmp(tree->value, "(_)") == 0 || strcmp(tree->value, "|LENGTH|") == 0 || strcmp(tree->value, "DEREFERENCE") == 0){
		printf("(");
		matchedpara = 1;
	}

	//if i want to stay within the same line and the same indentation
	if (strcmp(tree->value, "TYPE") == 0 || strcmp(tree->value, "TYPE REAL") == 0 || strcmp(tree->value, "TYPE CHARP") == 0
	|| strcmp(tree->value, "TYPE VOID") == 0 || strcmp(tree->value, "TYPE INT") == 0 || strcmp(tree->value, "TYPE CHAR") == 0
	|| strcmp(tree->value, "TYPE BOOL") == 0 || strcmp(tree->value, "TYPE INTP") == 0 || strcmp(tree->value, "TYPE REALP") == 0
	|| strcmp(tree->value, "ARGS NONE")  == 0){
		sameline = 1;
		sameindent = 1;
		isType = 1;
	} // for operators, staying within the same line
	else if (strcmp(tree->value, "*") == 0 || strcmp(tree->value, "/") == 0 || strcmp(tree->value, "&") == 0
	 || strcmp(tree->value, "+") == 0 || strcmp(tree->value, "-") == 0 || strcmp(tree->value, "&&") == 0
	 || strcmp(tree->value, "||") == 0 || strcmp(tree->value, "==") == 0 || strcmp(tree->value, ">=") == 0
	 || strcmp(tree->value, ">") == 0 || strcmp(tree->value, "<=") == 0 || strcmp(tree->value, "<") == 0
	 || strcmp(tree->value, "!=") == 0 || strcmp(tree->value, "!") == 0 || strcmp(tree->value, "=") == 0
	 || strcmp(tree->value, "RET") == 0  || strcmp(tree->value, "(_)") == 0 || strcmp(tree->value, "|LENGTH|") == 0
	  || strcmp(tree->value, "DEREFERENCE") == 0)
		sameline = 1;

	//printing spaces if printing on same line and not before certain tokens
	if(sameline == 1 && !(strcmp(tree->value, "TYPE REAL") == 0 || strcmp(tree->value, "TYPE INT") == 0 ||
	strcmp(tree->value, "TYPE VOID") == 0 || strcmp(tree->value, "TYPE CHAR") == 0 ||
	strcmp(tree->value, "TYPE REALP") == 0 || strcmp(tree->value, "TYPE INTP") == 0 ||
	strcmp(tree->value, "TYPE CHARP") == 0 || strcmp(tree->value, "INT") == 0 ||
	strcmp(tree->value, "REAL") == 0 || strcmp(tree->value, "CHAR") == 0 ||
	strcmp(tree->value, "INTP") == 0 || strcmp(tree->value, "REALP") == 0 ||
	strcmp(tree->value, "CHARP") == 0 || strcmp(tree->value, "=") == 0 ||
	strcmp(tree->value, "*") == 0 || strcmp(tree->value, "/") == 0 || strcmp(tree->value, "&") == 0
	 || strcmp(tree->value, "+") == 0 || strcmp(tree->value, "-") == 0 || strcmp(tree->value, "&&") == 0
	 || strcmp(tree->value, "||") == 0 || strcmp(tree->value, "==") == 0 || strcmp(tree->value, ">=") == 0
	 || strcmp(tree->value, ">") == 0 || strcmp(tree->value, "<=") == 0 || strcmp(tree->value, "<") == 0
	 || strcmp(tree->value, "!=") == 0 || strcmp(tree->value, "!") == 0 ||
	 strcmp(tree->value, "RET") == 0 || strcmp(tree->value, "ARGS NONE") == 0
	 || strcmp(tree->value, "TYPE") == 0 || strcmp(tree->value, "BOOL") == 0 || strcmp(tree->value, "TYPE BOOL") == 0
	  || strcmp(tree->value, "(_)") == 0 || strcmp(tree->value, "|LENGTH|") == 0 || strcmp(tree->value, "DEREFERENCE") == 0)){
		printf(" ");
	}

	
	//printing the value of the current node
	if (skipline == 0 && strcmp(tree->value, "TYPE") != 0){
		printf("%s", tree->value);
		sameindent = 0;
	}

	//new line if we dont need to skip the current line and if not printing on the same line
	if(sameline == 0 && skipline == 0){
		printf("\n");
	}

	//calculating number of tabs for the next line
	if(sameindent == 1)
		nexttabs = tabs;
	else
		nexttabs = tabs + 1;


	//recursion
	if(tree->branch1){
		//new line if one of the branches of an operator is also an aperator
		if (sameline == 1 && (strcmp(tree->branch1->value, "*") == 0 || strcmp(tree->branch1->value, "/") == 0 || strcmp(tree->branch1->value, "&") == 0
		|| strcmp(tree->branch1->value, "+") == 0 || strcmp(tree->branch1->value, "-") == 0 || strcmp(tree->branch1->value, "&&") == 0
		|| strcmp(tree->branch1->value, "||") == 0 || strcmp(tree->branch1->value, "==") == 0 || strcmp(tree->branch1->value, ">=") == 0
		|| strcmp(tree->branch1->value, ">") == 0 || strcmp(tree->branch1->value, "<=") == 0 || strcmp(tree->branch1->value, "<") == 0
		|| strcmp(tree->branch1->value, "!=") == 0 || strcmp(tree->branch1->value, "!") == 0  || strcmp(tree->branch1->value, "(_)") == 0
		|| strcmp(tree->branch1->value, "|LENGTH|") == 0 || strcmp(tree->branch1->value, "FUNCTION CALL") == 0
		|| strcmp(tree->branch1->value, "STRING INDEX")  == 0 || strcmp(tree->branch1->value, "STRING SIZE") == 0
		|| strcmp(tree->branch1->value, "DEREFERENCE") == 0)){
			printf("\n");
			sameline = 0;	
		}
		else if (sameline == 1 && tree->branch1->branch1){
			if(strcmp(tree->branch1->branch1->value, "STRING INDEX") == 0 || strcmp(tree->branch1->branch1->value, "STRING SIZE") == 0){
				printf("\n");
				sameline = 0;
			}
		}
		//entering first branch via recursion
		printtree(tree->branch1, nexttabs, sameline, sameindent);
	}
	if(tree->branch2){
		//new line if one of the branches of an operator is also an aperator
		if (sameline == 1 && (strcmp(tree->branch2->value, "*") == 0 || strcmp(tree->branch2->value, "/") == 0 || strcmp(tree->branch2->value, "&") == 0
		|| strcmp(tree->branch2->value, "+") == 0 || strcmp(tree->branch2->value, "-") == 0 || strcmp(tree->branch2->value, "&&") == 0
		|| strcmp(tree->branch2->value, "||") == 0 || strcmp(tree->branch2->value, "==") == 0 || strcmp(tree->branch2->value, ">=") == 0
		|| strcmp(tree->branch2->value, ">") == 0 || strcmp(tree->branch2->value, "<=") == 0 || strcmp(tree->branch2->value, "<") == 0
		|| strcmp(tree->branch2->value, "!=") == 0 || strcmp(tree->branch2->value, "!") == 0 || strcmp(tree->branch2->value, "(_)") == 0
		|| strcmp(tree->branch2->value, "STRING SIZE") == 0 || strcmp(tree->branch2->value, "|LENGTH|") == 0
		|| strcmp(tree->branch2->value, "FUNCTION CALL") == 0 || strcmp(tree->branch2->value, "STRING INDEX")  == 0
		|| strcmp(tree->branch2->value, "DEREFERENCE") == 0)){
			printf("\n");
			sameline = 0;
			
		}
		else if (sameline == 1 && tree->branch2->branch1){
			if(strcmp(tree->branch2->branch1->value, "STRING INDEX") == 0){
				printf("\n");
				sameline = 0;
			}
		}
		//recursion for second branch
		printtree(tree->branch2, nexttabs, sameline, sameindent);
	}
	//recursion for third branch
	if(tree->branch3){
		printtree(tree->branch3, nexttabs, sameline, sameindent);
	}
	//recursion for fourth branch
	if(tree->branch4)
		printtree(tree->branch4, nexttabs, sameline, sameindent);


	//post recursion
	//if current line wasn't skipped
	if (!(strcmp(tree->value, "FUNCCODE")==0 || strcmp(tree->value, "STMNT")==0
	|| strcmp(tree->value, "DECLARATION")==0 || strcmp(tree->value, "PARAMETER")==0
	|| strcmp(tree->value, "DECLARE")==0)){	
		//in function arguments, printing close bracket after the last variable of the current type 
		if (sameline == 1 && !tree->branch1 && !tree->branch2 && !tree->branch3 && !tree->branch4){
			if (strcmp(tree->value, "INT") != 0 && strcmp(tree->value, "REAL") != 0 && strcmp(tree->value, "CHAR") != 0 
			&& strcmp(tree->value, "BOOL") != 0 && strcmp(tree->value, "INTP") != 0 && strcmp(tree->value, "REALP") != 0
			&& strcmp(tree->value, "CHARP") != 0){
				if(isType == 1){
					printf(")\n");
					isType = 0;
				}
			}
		}

		//if current value is an operator, either print tabs or don't
		if (strcmp(tree->value, "*") == 0 || strcmp(tree->value, "/") == 0 || strcmp(tree->value, "&") == 0
			|| strcmp(tree->value, "+") == 0 || strcmp(tree->value, "-") == 0 || strcmp(tree->value, "&&") == 0
			|| strcmp(tree->value, "||") == 0 || strcmp(tree->value, "==") == 0 || strcmp(tree->value, ">=") == 0
			|| strcmp(tree->value, ">") == 0 || strcmp(tree->value, "<=") == 0 || strcmp(tree->value, "<") == 0
			|| strcmp(tree->value, "!=") == 0 || strcmp(tree->value, "!") == 0 || strcmp(tree->value, "=") == 0
			|| strcmp(tree->value, "RET") == 0 || strcmp(tree->value, "(_)") == 0 || strcmp(tree->value, "|LENGTH|") == 0
			|| strcmp(tree->value, "FUNCTION CALL") == 0 || strcmp(tree->value, "DEREFERENCE") == 0){
			if (sameline == 0){
				for(int i = 0; i < tabs; i++)
					printf("\t");
			}
			printf(")\n");
					
		}
		//for every other keyword that requires a close bracket, print tabs and close bracket
		else if(matchedpara == 1 && sameline == 0 && strcmp(tree->value, "TYPE") != 0){
			for(int i = 0; i < tabs; i++)
				printf("\t");
			printf(")\n");
		}
	}
}

char* check_tree(node* tree){
	char* Rtype = "empty";
	char* Ltype = "empty";
	//finding if current statement is a declaration
	if(strcmp(tree->value, "VAR") == 0 || strcmp(tree->value, "STRING") == 0  || strcmp(tree->value, "TYPE") == 0){
		isDeclaration = 1;
		if(strcmp(tree->value, "STRING") == 0)
			currentType = tree->type;
		else {
			currentType = tree->branch1->value;
		}
	}
	//finding if the current code is part of a function arguments
	if(strcmp(tree->value, "ARGS") == 0)
		isArgument = 1;
	//finding if the current code an assignment statement
	if(strcmp(tree->value, "=") == 0)
		isAssign = 1;
	
	//pushing new symbol table into the stack upon enetering a new frame
	if(strcmp(tree->value, "CODE") == 0 || strcmp(tree->value, "BLOCK") == 0 ){
		Push(&stackhead, NULL);
		stackhead->name = NULL;
		stackhead->type = NULL;
	} else if(strcmp(tree->value, "FUNCTION") == 0){
		if(stackhead->data){
				search_table(stackhead->data, tree->branch1->value, 1, 1, tree->branch3->myLine);
		}
		frame_content* new_function = (frame_content*)malloc(sizeof(frame_content));
		new_function = make_function(tree->branch1->value, NULL, tree->branch3->value);
		stackhead->data = add_to_table(&(stackhead->data), &new_function);
		Push(&stackhead, NULL);
		stackhead->name = new_function->name;
		stackhead->type = new_function->type;
	}

	//creating a new link list for the symbol table and adding it
	if(tree->type){
		if(isDeclaration == 1 && strcmp(tree->type, "VARIABLE") == 0){
			if((isAssign == 1 && LHS == 1) || isAssign == 0){
				if(stackhead->data){
					search_table(stackhead->data, tree->value, 1, 0, tree->myLine);
				}
				frame_content* new_variable = (frame_content*)malloc(sizeof(frame_content));
				if(strcmp(currentType, "STRING") != 0){
					new_variable = make_variable(tree->value, currentType, "empty");
					stackhead->data = add_to_table(&(stackhead->data), &new_variable);
					if(isArgument == 1){
						frame_content* new_arg = (frame_content*)malloc(sizeof(frame_content));
						new_arg = make_variable(tree->value, currentType, "empty");
						add_to_table(&(search_stack(stackhead, search_func_name(stackhead), 1, tree->myLine)->argument_list), &new_arg);
					}
				} else {
					new_variable = make_string(tree->value, 5, "empty");
					stackhead->data = add_to_table(&(stackhead->data), &new_variable);
				}
			}
		}
	}
	//recursive calls
	if (tree->branch1){
		if(strcmp(tree->value, "=") == 0)
			LHS = 1;
		Ltype = check_tree(tree->branch1);
		if(strcmp(tree->value, "=") == 0)
			LHS = 0;
	}
	if (tree->branch2)
		Rtype = check_tree(tree->branch2);
	if(tree->branch3)
		check_tree(tree->branch3);
	if(tree->branch4)
		check_tree(tree->branch4);

	//popping current symbol table upon exiting it
	if(strcmp(tree->value, "CODE") == 0 || strcmp(tree->value, "FUNCTION") == 0 || strcmp(tree->value, "BLOCK") == 0)
		Pop(&stackhead);

	//finding if existing a declaration
	if(strcmp(tree->value, "VAR") == 0 || strcmp(tree->value, "STRING") == 0)
		isDeclaration = 0;
	//finding if exiting function arguments
	if(strcmp(tree->value, "ARGS") == 0)
		isArgument = 0;
	//finding if exiting an assignment statement
	if(strcmp(tree->value, "=") == 0)
		isAssign = 0;

	//checking if operands' types can work with  the current operator 
	if(strcmp(tree->value, "(_)") == 0){
		return Ltype;
	}
	//adding the parameters to the temp parameters list
	else if(strcmp(tree->value, "PARAMETER") == 0){
		frame_content* new_parameter = (frame_content*)malloc(sizeof(frame_content));
		new_parameter = make_variable("PARAMETER", Ltype, "empty");
		new_parameter->next = tempParameters;
		tempParameters = new_parameter;
		tree->type = Ltype;///x3-del line
	}
	else if(strcmp(tree->value, "+") == 0){
		if(strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "INT") == 0)
			return "INT";
		else if(strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "REAL") == 0)
			return "REAL";
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "REAL") == 0) || (strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "INT") == 0))
			return "REAL";
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "CHARP") == 0) || (strcmp(Ltype, "CHARP") == 0 && strcmp(Rtype, "INT") == 0))
			return "CHARP";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator +");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "-") == 0){
		if((strcmp(Ltype, "INT") == 0 || strcmp(Ltype, "REAL") == 0) && strcmp(Rtype, "empty") == 0){
			if(strcmp(Ltype, "INT") == 0)
				return "INT";
			else return "REAL";
		}
		else if(strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "INT") == 0)
			return "INT";
		else if(strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "REAL") == 0)
			return "REAL";
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "REAL") == 0) || (strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "INT") == 0))
			return "REAL";
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "CHARP") == 0) || (strcmp(Ltype, "CHARP") == 0 && strcmp(Rtype, "INT") == 0))
			return "CHARP";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator -");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "*") == 0){
		if(strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "INT") == 0)
			return "INT";
		else if(strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "REAL") == 0)
			return "REAL";
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "REAL") == 0) || (strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "INT") == 0))
			return "REAL";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator *");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "/") == 0){
		if(strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "INT") == 0)
			return "INT";
		else if(strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "REAL") == 0)
			return "REAL";
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "REAL") == 0) || (strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "INT") == 0))
			return "REAL";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator /");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "&&") == 0){
		if(strcmp(Ltype, "BOOL") == 0 && strcmp(Rtype, "BOOL") == 0){
			tree->label1 = Lcounter;
			Lcounter++;
			tree->label2 = Lcounter;
			Lcounter++;
			tree->label3 = Lcounter;
			Lcounter++;
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator &&");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "||") == 0){
		if(strcmp(Ltype, "BOOL") == 0 && strcmp(Rtype, "BOOL") == 0){
			tree->label1 = Lcounter;
			Lcounter++;
			tree->label2 = Lcounter;
			Lcounter++;
			tree->label3 = Lcounter;
			Lcounter++;
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator ||");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "<") == 0){
		if((strcmp(Ltype, "INT") == 0 || strcmp(Ltype, "REAL") == 0) && (strcmp(Rtype, "REAL") == 0 || strcmp(Rtype, "INT") == 0)){
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator <");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "<=") == 0){
		if((strcmp(Ltype, "INT") == 0 || strcmp(Ltype, "REAL") == 0) && (strcmp(Rtype, "REAL") == 0 || strcmp(Rtype, "INT") == 0)){
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator <=");
			exit(0);
		}
	}
	else if(strcmp(tree->value, ">") == 0){
		if((strcmp(Ltype, "INT") == 0 || strcmp(Ltype, "REAL") == 0) && (strcmp(Rtype, "REAL") == 0 || strcmp(Rtype, "INT") == 0)){
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator >");
			exit(0);
		}
	}
	else if(strcmp(tree->value, ">=") == 0){
		if((strcmp(Ltype, "INT") == 0 || strcmp(Ltype, "REAL") == 0) && (strcmp(Rtype, "REAL") == 0 || strcmp(Rtype, "INT") == 0)){
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type is illegal for the operator >=");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "==") == 0){
		if (strcmp(Ltype, "STRING") == 0 || strcmp(Rtype, "STRING") == 0){
			yylineno = tree->myLine;
			yyerror("Operator == does not work with string-type operands");
			exit(0);
		}
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "INT") == 0) || (strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "REAL") == 0)
		|| (strcmp(Ltype, "CHAR") == 0 && strcmp(Rtype, "CHAR") == 0) || (strcmp(Ltype, "BOOL") == 0 && strcmp(Rtype, "BOOL") == 0)
		|| (strcmp(Ltype, "INTP") == 0 && strcmp(Rtype, "INTP") == 0)  || (strcmp(Ltype, "REALP") == 0 && strcmp(Rtype, "REALP") == 0)
		|| (strcmp(Ltype, "CHARP") == 0 && strcmp(Rtype, "CHARP") == 0)){
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operands' type must match for operator ==");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "!=") == 0){
		if (strcmp(Ltype, "STRING") == 0 || strcmp(Rtype, "STRING") == 0){
			yylineno = tree->myLine;
			yyerror("Operator != does not work with string-type operands");
			exit(0);
		}
		else if((strcmp(Ltype, "INT") == 0 && strcmp(Rtype, "INT") == 0) || (strcmp(Ltype, "REAL") == 0 && strcmp(Rtype, "REAL") == 0)
		|| (strcmp(Ltype, "CHAR") == 0 && strcmp(Rtype, "CHAR") == 0) || (strcmp(Ltype, "BOOL") == 0 && strcmp(Rtype, "BOOL") == 0)
		|| (strcmp(Ltype, "INTP") == 0 && strcmp(Rtype, "INTP") == 0)  || (strcmp(Ltype, "REALP") == 0 && strcmp(Rtype, "REALP") == 0)
		|| (strcmp(Ltype, "CHARP") == 0 && strcmp(Rtype, "CHARP") == 0)){
			return "BOOL";
		}
		else {
			yylineno = tree->myLine;
			yyerror("Operands' type must match for operator !=");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "|LENGTH|") == 0){
		if(strcmp(Ltype, "STRING") == 0)
			return "INT";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type must be string for the |LENGTH| operator");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "!") == 0){
		if(strcmp(Ltype, "BOOL") == 0)
			return "BOOL";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type must be bool for the ! operator");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "null") == 0){
		return "NULL";
	}
	else if(strcmp(tree->value, "=") == 0){
		if(strcmp(Ltype, Rtype) == 0 || (strcmp(Ltype, "INTP") == 0 && strcmp(Rtype, "NULL") == 0)
		|| (strcmp(Ltype, "REALP") == 0 && strcmp(Rtype, "NULL") == 0) || (strcmp(Ltype, "CHARP") == 0 && strcmp(Rtype, "NULL") == 0))
			return Ltype;
		else {
			yylineno = tree->myLine;
			yyerror("assignment types must match");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "&") == 0){
		if(strcmp(Ltype, "INT") == 0)
			return "INTP";
		else if(strcmp(Ltype, "REAL") == 0)
			return "REALP";
		else if(strcmp(Ltype, "CHAR") == 0)
			return "CHARP";
		else {
			yylineno = tree->myLine;
			yyerror("Operand's type must either be int, real, or char for the & operator");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "DEREFERENCE") == 0){
		if(strcmp(Ltype, "REALP") == 0)
			return "REAL";
		else if(strcmp(Ltype, "INTP") == 0)
			return "INT";
		else if(strcmp(Ltype, "CHARP") == 0)
			return "CHAR";
		else{
			yylineno = tree->myLine;
			yyerror("Operand's type must either be a pointer for the derefernce operator");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "STRING INDEX") == 0){
		if(strcmp(Ltype, "INT") == 0)
			return "INT";
		else {
			yylineno = tree->myLine;
			yyerror("The expression inside the [] operator must return an integer");
			exit(0);
		}
	}
	else if(strcmp(tree->value, "IF") == 0 || strcmp(tree->value, "IF-ELSE") == 0){
		if(strcmp(Ltype, "BOOL") == 0){
			tree->label1 = Lcounter;
			Lcounter++;
			if (strcmp(tree->value, "IF-ELSE") == 0){
				tree->label2 = Lcounter;
				Lcounter++;
			}
			return Ltype;		
			}
		else {
			yylineno = tree->branch1->myLine;
			yyerror("conditional expressions for 'if' statements must return a bool");
			exit(0);
		}
	}
	
	else if(strcmp(tree->value, "WHILE") == 0){
		if(strcmp(Ltype, "BOOL") == 0){
			tree->label1 = Lcounter;
			Lcounter++;
			tree->label2 = Lcounter;
			Lcounter++;
			return Ltype;
		}
		else {
		
			yylineno = tree->branch1->myLine;
			yyerror("conditional expressions for 'while' statements must return a bool");
			exit(0);
		}
	}
	
	else if(strcmp(tree->value, "RET") == 0){
		search_ret_type(stackhead, Ltype, tree->myLine);
		return Ltype;
	}
	else if(strcmp(tree->value, "FUNCTION CALL") == 0){
		frame_content* called_func = (frame_content*)malloc(sizeof(frame_content));
		frame_content* current;
		called_func = search_stack(stackhead, tree->branch1->value, 1, tree->myLine);
		current = called_func->argument_list;
		if((current == NULL && tempParameters != NULL) || (current != NULL && tempParameters == NULL)){
			yylineno = tree->myLine;
			yyerror("number of parameters in the function call must match the number of arguments in the function's signature");
			exit(0);
		}
		while(current && tempParameters){
			if((current->next == NULL && tempParameters->next != NULL) || (current->next != NULL && tempParameters->next == NULL)){
				yylineno = tree->myLine;
				yyerror("number of parameters in the function call must match the number of arguments in the function's signature");
				exit(0);
			}
			if (strcmp(current->type, tempParameters->type) != 0){
				yylineno = tree->myLine;
				yyerror("parameter type does not match the argument type in the function's signature");
				exit(0);
			}
			current = current->next;
			tempParameters = tempParameters->next;
		}
		while(current){
			current = tempParameters;
			tempParameters = tempParameters->next;
			free(current);
		}
		tempParameters = NULL;
		char* rettype = search_stack(stackhead, tree->branch1->value, 1, tree->myLine)->type;
		if(strcmp(rettype, "TYPE INT") == 0)
			return "INT";
		else if(strcmp(rettype, "TYPE REAL") == 0)
			return "REAL";
		else if(strcmp(rettype, "TYPE CHAR") == 0)
			return "CHAR";
		else if(strcmp(rettype, "TYPE BOOL") == 0)
			return "BOOL";
		else if(strcmp(rettype, "TYPE INTP") == 0)
			return "INTP";
		else if(strcmp(rettype, "TYPE REALP") == 0)
			return "REALP";
		else if(strcmp(rettype, "TYPE CHARP") == 0)
			return "CHARP";
		else return "other";
	}
	else if(tree->type && strcmp(tree->value, "PARAMETER") != 0){
		if(strcmp(tree->type, "INT") == 0)
			return "INT";
		else if(strcmp(tree->type, "CHAR") == 0)
			return "CHAR";
		else if(strcmp(tree->type, "REAL") == 0)
			return "REAL";
		else if(strcmp(tree->value, "true") == 0 || strcmp(tree->value, "false") == 0)
			return "BOOL";
		else if(strcmp(tree->type, "STRING") == 0)
			return "STRING";
		else if(strcmp(tree->type, "VARIABLE") == 0 && ((isDeclaration == 0) || (isDeclaration == 1 && isAssign == 1 && LHS == 0))){
			char* gottype = search_stack(stackhead, tree->value, 0, tree->myLine)->type;
			if(strcmp(gottype, "STRING") == 0){
				if(tree->branch1){
					if(strcmp(tree->branch1->value, "STRING INDEX") == 0)
						return "CHAR";
					else return "STRING";
				} else return gottype;
			} else{
				if(tree->branch1){
					if(strcmp(tree->branch1->value, "STRING INDEX") == 0){
						yylineno = tree->myLine;
						yyerror("Operator [] must work only with string-type variables");
						exit(0);
					} else return gottype;
				} else if(strcmp(gottype, "BOOL") == 0)
					tree->label1 = -2;
				return gottype;
			}
		}
		else if(strcmp(tree->type, "VARIABLE") == 0 && isDeclaration == 1 && isAssign == 1 && LHS == 1){
			return currentType;
		} return "other";
	} 
	else return "other";
}

//func for creating new stack
void create_stack(frame_stack** headptr) {
	*headptr = NULL;
}

//func for creating new symbol table
void create_table(frame_content** headptr){
	*headptr = NULL;
}

//func for checking if the stack is empty
int is_stack_empty(frame_stack* headptr) {
	if (headptr == NULL)
		return 1;
	else
		return 0;
}

//func for checking if the symbol table is empty
int is_table_empty(frame_content* headptr) {
	if (headptr == NULL)
		return 1;
	else
		return 0;
}

//func for pushing an item into the stack
void Push(frame_stack** headptr, frame_content* DataIn) {
	//pushing item and moving head to new item
	frame_stack* temp = (frame_stack*)malloc(sizeof(frame_stack));
	temp->data = (frame_content*)malloc(sizeof(frame_content));
	if(DataIn)
		*(temp->data) = *DataIn;
	else create_table(&(temp->data));
	temp->next = *headptr;
	*headptr = temp;
}

//func for popping an item from the stack
void Pop(frame_stack** headptr) {
	//returning data from top of the stack (head of linked list) and moving head
	if (!is_stack_empty(*headptr)) {
		frame_content* temp;
		while ((*headptr)->data != NULL)
		{
			temp = (*headptr)->data;
			if (temp->argument_list){
				frame_content* temp2;
				while(temp->argument_list){
					temp2 = temp->argument_list;
					temp->argument_list = temp->argument_list->next;
					free(temp2);
				}
			}
			(*headptr)->data = (*headptr)->data->next;
			free(temp);
		}
		frame_stack* TempPtr = *headptr;
		(*headptr) = TempPtr->next;
		free(TempPtr);
	}
}

//func for adding a variable or a function to the symbol table
frame_content* add_to_table(frame_content** headptr, frame_content** item){
	if(is_table_empty(*headptr)){
		*headptr = *item;
		return *headptr;
	} else {
		frame_content* current = (frame_content*)malloc(sizeof(frame_content));
		current = *headptr;
		while(current->next != NULL)
			current = current->next;
		current->next = *item;
		return *headptr;
	}
}

//func for searching symbol table
frame_content* search_table(frame_content* headptr, char* varname, int isDuplicate, int isFunction, int Line){
	frame_content* current = (frame_content*)malloc(sizeof(frame_content));
	current = headptr;
	while(current != NULL){
		if(strcmp(current->name, varname) == 0 && current->isFunction == isFunction){
			if (isDuplicate == 1){
				yylineno = Line;
				yyerror(strcat(varname, " already exists"));
				exit(0);
			}
			return current;
		}
		current = current->next;
	}
	return NULL;
}

//func for searching stack without popping it
frame_content* search_stack(frame_stack* headptr, char* varname, int isFunction, int Line){
	frame_stack* current = (frame_stack*)malloc(sizeof(frame_stack));
	frame_content* found_var = (frame_content*)malloc(sizeof(frame_content));
	current = headptr;
	while(current != NULL){
		found_var = search_table(current->data, varname, 0, isFunction, Line);
		if(found_var)
			return found_var;
		current = current->next;
	}
	yylineno = Line;
	yyerror(strcat(varname, " is undefined"));
	exit(0);
}

//function for searching the return type of current function
void search_ret_type(frame_stack* headptr, char* type, int Line){
	frame_stack* current = (frame_stack*)malloc(sizeof(frame_stack));
	current = headptr;
	while(current != NULL){
		if(current->type){
			if((strcmp(type, "BOOL") == 0 && strcmp(current->type, "TYPE BOOL") != 0) || (strcmp(type, "INT") == 0 && strcmp(current->type, "TYPE INT") != 0)
			|| (strcmp(type, "REAL") == 0 && strcmp(current->type, "TYPE REAL") != 0) || (strcmp(type, "CHAR") == 0 && strcmp(current->type, "TYPE CHAR") != 0)
			|| (strcmp(type, "INTP") == 0 && strcmp(current->type, "TYPE INTP") != 0) || (strcmp(type, "REALP") == 0 && strcmp(current->type, "TYPE REALP") != 0)
			|| (strcmp(type, "CHARP") == 0 && strcmp(current->type, "TYPE CHARP") != 0)){
				yylineno = Line;
				yyerror("return type does not match the type in the function signature");
				exit(0);
			} else if((strcmp(type, "BOOL") == 0 && strcmp(current->type, "TYPE BOOL") == 0) || (strcmp(type, "INT") == 0 && strcmp(current->type, "TYPE INT") == 0)
			|| (strcmp(type, "REAL") == 0 && strcmp(current->type, "TYPE REAL") == 0) || (strcmp(type, "CHAR") == 0 && strcmp(current->type, "TYPE CHAR") == 0)
			|| (strcmp(type, "INTP") == 0 && strcmp(current->type, "TYPE INTP") == 0) || (strcmp(type, "REALP") == 0 && strcmp(current->type, "TYPE REALP") == 0)
			|| (strcmp(type, "CHARP") == 0 && strcmp(current->type, "TYPE CHARP") == 0))
				return;
			else if(strcmp(current->type, "TYPE VOID") == 0){
				yylineno = Line;
				yyerror("void functions cannot have return statements");
				exit(0);
			}
		}
		current = current->next;
	}
}

//function for searching current function's name
char* search_func_name(frame_stack* headptr){
	frame_stack* current = (frame_stack*)malloc(sizeof(frame_stack));
	current = headptr;
	while(current != NULL){
		if(current->name){
			return current->name;
		}
		current = current->next;
	}
	return NULL;
}

//function for making a new variable
frame_content* make_variable(char* name, char* vartype, char* value){
	frame_content* new_variable = (frame_content*)malloc(sizeof(frame_content));
	new_variable->name = name;
	new_variable->isFunction = 0;
	new_variable->type=vartype;
	new_variable->value=value;
	new_variable->length= 0;
	new_variable->argument_list = NULL;
	new_variable->next = NULL;
	return new_variable;
}

//function for making a new string-type variable
frame_content* make_string(char* name, int length, char* value){
	frame_content* new_str_variable=(frame_content*)malloc(sizeof(frame_content));
	new_str_variable->name = name;
	new_str_variable->length = length;
	new_str_variable->isFunction = 0;
	new_str_variable->value=value;
	new_str_variable->type = "STRING";
	new_str_variable->argument_list = NULL;
	new_str_variable->next = NULL;
	return new_str_variable;		
}

//function for makig a new function link for symbol tables
frame_content* make_function(char* name, frame_content* arglist, char* rettype){
	frame_content* new_function=(frame_content*)malloc(sizeof(frame_content));
	new_function->name=name;
	new_function->length = 0;
	new_function->isFunction = 1;
	new_function->value = NULL;
	new_function->argument_list=arglist;
	new_function->type=rettype;
	new_function->next = NULL;
	return new_function;
	
}

char* print3AC(node* tree, int truelabel, int falselabel, char* parent, int isR){
	char* Lt = NULL;
	char* Rt = NULL;
	char* tnum = (char*)malloc(sizeof(char) * 12);
	char* Myt = (char*)malloc(sizeof(char) * 15);
	Myt[0] = 't';
	if(strcmp(tree->value, "FUNCTION") == 0){
		tcounter = 0;
		printf("%s:\n\tBeginFunc\n", tree->branch1->value);
	}
	//recursive calls
	if(strcmp(tree->value, "WHILE") == 0 )
		printf("L%d:", tree->label1);
	
	if (tree->branch1){
		if (strcmp(tree->value, "(_)") == 0 ){
			Lt = print3AC(tree->branch1, truelabel, falselabel, parent, isR);
		}else{
			if(strcmp(tree->value, "=") == 0 )
				LHS = 1;
			Lt = print3AC(tree->branch1, tree->label1, tree->label2, tree->value, 0);
			if(strcmp(tree->value, "=") == 0 )
				LHS = 0;
		}
	}
	if(strcmp(tree->value, "WHILE") == 0 )
		printf("\tif %s == 0 goto L%d\n", Lt, tree->label2);
	if(strcmp(tree->value, "IF") == 0 )
		printf("\tif %s == 0 goto L%d\n", Lt, tree->label1);
	else if(strcmp(tree->value, "IF-ELSE") == 0 )
		printf("\tif %s == 0 goto L%d\n", Lt, tree->label1);

	if (tree->branch2){
		Rt = print3AC(tree->branch2, tree->label1, tree->label2, tree->value, 1);
	}
	
	if(strcmp(tree->value, "WHILE") == 0 )
		printf("\tgoto L%d\nL%d:", tree->label1, tree->label2);
	
	if(strcmp(tree->value, "IF-ELSE") == 0 ){
		printf("\tgoto L%d\n", tree->label2);
		printf("L%d:", tree->label1);
		}
	if(strcmp(tree->value, "IF") == 0 ){
		printf("L%d:", tree->label1);
	}
	if (strcmp(tree->value, "WHILES") != 0 ){
		if(tree->branch3)
			print3AC(tree->branch3, tree->label1, tree->label2, tree->value, 0);
		if(strcmp(tree->value, "IF-ELSE") == 0 )
			printf("L%d:", tree->label2);
		if(tree->branch4)
			print3AC(tree->branch4, tree->label1, tree->label2, tree->value, 0);
	} else {
		if(tree->branch4)
			print3AC(tree->branch4, tree->label1, tree->label2, tree->value, 0);
		if(tree->branch3)
			print3AC(tree->branch3, tree->label1, tree->label2, tree->value, 0);
			printf("\tgoto L%d\nL%d:", tree->label1, tree->label2);
	}
	if (strcmp(tree->value, "*") == 0 || strcmp(tree->value, "/") == 0 || strcmp(tree->value, "&") == 0
		|| strcmp(tree->value, "+") == 0 || strcmp(tree->value, "-") == 0
		|| strcmp(tree->value, "|LENGTH|") == 0 || strcmp(tree->value, "DEREFERENCE") == 0){
		if (Lt && Rt){
			printf("\tt%d = %s %s %s\n", tcounter, Lt, tree->value, Rt);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		} else if(Lt && !Rt){
			if(strcmp(tree->value, "DEREFERENCE") == 0){
				if (LHS == 0){
					printf("\tt%d = *%s\n", tcounter, Lt);
					sprintf(tnum, "%d", tcounter);
					strcat(Myt, tnum);
					tcounter++;
					return Myt;
				} else return "other";
			}
			else {
				printf("\tt%d = %s %s\n", tcounter, tree->value, Lt);
				sprintf(tnum, "%d", tcounter);
				strcat(Myt, tnum);
				tcounter++;
				return Myt;
			}
		}
	}
	else if (strcmp(tree->value, "==") == 0	|| strcmp(tree->value, ">=") == 0 || strcmp(tree->value, ">") == 0
		|| strcmp(tree->value, "<=") == 0 || strcmp(tree->value, "<") == 0 || strcmp(tree->value, "!=") == 0
		|| strcmp(tree->value, "!") == 0){
		if(strcmp(parent, "&&") == 0){
			if(strcmp(tree->value, "!") == 0)
				printf("\tt%d = %s%s\n", tcounter, tree->value, Lt);
			else printf("\tt%d = %s %s %s\n", tcounter, Lt, tree->value, Rt);
			if(isR == 0)
				printf("\tif t%d == 0 goto L%d\n", tcounter, falselabel);
			if(isR == 1)
				printf("\tif t%d == 0 goto L%d\n", tcounter, falselabel);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		}
		else if(strcmp(parent, "||") == 0){
			if(strcmp(tree->value, "!") == 0)
				printf("\tt%d = %s%s\n", tcounter, tree->value, Lt);
			else printf("\tt%d = %s %s %s\n", tcounter, Lt, tree->value, Rt);
			if(isR == 0)
				printf("\tif t%d goto L%d\n", tcounter, truelabel);
			if(isR == 1)
				printf("\tif t%d == 0 goto L%d\n", tcounter, falselabel);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		} else {
			printf("\tt%d = %s %s %s\n", tcounter, Lt, tree->value, Rt);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		}
	}
	else if (strcmp(tree->value, "&&") == 0	|| strcmp(tree->value, "||") == 0){
		if(strcmp(parent, "&&") == 0){
			printf("L%d:\tt%d = true\n", tree->label1, tcounter);
			printf("\tgoto L%d\n", tree->label3);
			printf("L%d:\tt%d = false\n", tree->label2, tcounter);
			if(isR == 0)
				printf("L%d:\tif t%d == 0 goto L%d\n", tree->label3, tcounter, falselabel);
			if(isR == 1)
				printf("L%d:\tif t%d == 0 goto L%d\n", tree->label3, tcounter, falselabel);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		}
		else if(strcmp(parent, "||") == 0){
			printf("L%d:\tt%d = true\n", tree->label1, tcounter);
			printf("\tgoto L%d\n", tree->label3);
			printf("L%d:\tt%d = false\n", tree->label2, tcounter);
			if(isR == 0)
				printf("L%d:\tif t%d goto L%d\n", tree->label3, tcounter, truelabel);
			if(isR == 1)
				printf("L%d:\tif t%d == 0 goto L%d\n", tree->label3, tcounter, falselabel);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		} else {
			printf("L%d:\tt%d = true\n", tree->label1, tcounter);
			printf("\tgoto L%d\n", tree->label3);
			printf("L%d:\tt%d = false\n", tree->label2, tcounter);
			printf("L%d:", tree->label3);
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		}
	}
	else if (strcmp(tree->value, "=") == 0){
		if (strcmp(tree->branch1->value, "DEREFERENCE") == 0)
			printf("\t*%s = %s\n", tree->branch1->branch1->value, Rt);
		else if (tree->branch1->branch1){
			if (strcmp(tree->branch1->branch1->value, "STRING INDEX") == 0)
				printf("\t*%s = %s\n", Lt, Rt);
		}
		else printf("\t%s = %s\n", Lt, Rt);
		return Lt;
	}
	else if(strcmp(tree->value, "FUNCTION") == 0){
		printf("\tEndFunc\n\n");
		return "other";
	}
	else if(strcmp(tree->value, "RET") == 0){
		printf("\tReturn %s\n", Lt);
		return Lt;
	}
	else if(strcmp(tree->value, "(_)") == 0){
		return Lt;
	}
	else if(strcmp(tree->value, "STRING INDEX") == 0){
		return Lt;
	}
	else if(strcmp(tree->value, "PARAMETER") == 0){
		printf("\tPushParam %s\n", Lt);
		if(strcmp(tree->type, "CHAR") == 0)
			paramsize++;
		else if(strcmp(tree->type, "REAL") == 0)
			paramsize+=8;
		else paramsize +=4;
		return Lt;
	}
	else if(strcmp(tree->value, "FUNCTION CALL") == 0){
		printf("\tt%d = LCall %s\n", tcounter, tree->branch1->value);
		printf("\tPopParams %d\n", paramsize);
		paramsize = 0;
		sprintf(tnum, "%d", tcounter);
		strcat(Myt, tnum);
		tcounter++;
		return Myt;
	}
	else if(tree->type){
		if (strcmp(tree->type, "INT") == 0 || strcmp(tree->type, "REAL") == 0 || strcmp(tree->type, "CHAR") == 0
		|| strcmp(tree->type, "BOOL") == 0 || strcmp(tree->type, "NULL") == 0 || 
		(strcmp(tree->type, "STRING") == 0 && strcmp(tree->value, "STRING") != 0)){
			printf("\tt%d = %s\n", tcounter, tree->value);
			if (strcmp(tree->type, "BOOL") == 0 && (strcmp(parent, "&&") == 0 || strcmp(parent, "||") == 0)){
				if(strcmp(parent, "&&") == 0){
					if(isR == 0)
						printf("\tif t%d == 0 goto L%d\n", tcounter, falselabel);
					if(isR == 1)
						printf("\tif t%d == 0 goto L%d\n", tcounter, falselabel);
				}
				else if(strcmp(parent, "||") == 0){
					if(isR == 0)
						printf("\tif t%d goto L%d\n", tcounter, truelabel);
					if(isR == 1)
						printf("\tif t%d == 0 goto L%d\n", tcounter, falselabel);
				}
			}
			sprintf(tnum, "%d", tcounter);
			strcat(Myt, tnum);
			tcounter++;
			return Myt;
		} else if (strcmp(tree->type, "VARIABLE") == 0){
			if (Lt){
				if (strcmp(tree->branch1->value, "STRING INDEX") == 0){
					printf("\tt%d = %s + %s\n", tcounter, tree->value, Lt);
					tcounter++;
					if (LHS == 0){
						printf("\tt%d = *t%d\n", tcounter, tcounter - 1);
						sprintf(tnum, "%d", tcounter);
						strcat(Myt, tnum);
						tcounter++;
						return Myt;
					}
					sprintf(tnum, "%d", tcounter - 1);
					strcat(Myt, tnum);
					return Myt;
				} else return tree->value;
			}
			if (tree->label1 == -2 && (strcmp(parent, "&&") == 0 || strcmp(parent, "||") == 0)){
				if(strcmp(parent, "&&") == 0){
					if(isR == 0)
						printf("\tif %s == 0 goto L%d\n", tree->value, falselabel);
					if(isR == 1)
						printf("\tif %s == 0 goto L%d\n", tree->value, falselabel);
				}
				else if(strcmp(parent, "||") == 0){
					if(isR == 0)
						printf("\tif %s goto L%d\n", tree->value, truelabel);
					if(isR == 1)
						printf("\tif %s == 0 goto L%d\n", tree->value, falselabel);
				}
			}
			return tree->value;
		}
	}
	else return "other";
}

//printing errors
int yyerror(char *e){
	printf("%s: line %d. ", e, yylineno);
	if(finishedGrammar == 0)
		printf("Cannot proceed beyond '%s'\n", yytext);
	else printf("\n");
	return 0;
}
