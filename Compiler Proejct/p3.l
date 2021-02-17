%{

#include<stdio.h>
#include<string.h>
#include "y.tab.h"
%}

 
%x comment

%%

"&&" {return AND;}
"/" {return DIVIDE;}
"=" {return INITIALIZATION;}
"==" {return EQUAL;}
">" {return GREATER;}
"<" {return LESSER;}
"<=" {return LESSEREQUAL;}
">=" {return GREATEREQUAL;}
"-" {return MINUS;}
"+" {return PLUS;}
"!" {return NOT;}
"!=" {return NOTEQUAL;}
"||" {return OR;}
"*" {return MULT;}
"^" {return POW;}
"&" {return ADDRESS;}


bool {return BOOL;}
char {return CHAR;}
int {return INT;}
real {return REAL;}
string {return STRING;}
int\* {return INTP;}
char\* {return CHARP;}
real\* {return REALP;}


if {return IF;}
else {return ELSE;}
while {return WHILE;}
var {return VAR;}
func {return FUNC;}
proc {return PROC;}
return {return RETURN;}
null {return TOKNULL;}


";" {return SEMICOLON;}
":" {return COLON;}
"," {return COMMA;}
"|" {return LEN;}
"{" {return OPENCURLY;}
"}" {return CLOSECURLY;}
"(" {return OPENBRACKET;}
")" {return CLOSEBRACKET;}
"[" {return OPENSTRBRACKET;}
"]" {return CLOSESTRBRACKET;}

Main {return MAIN;}
true {return TRUE;}
false {return FALSE;}
(-?0+|([1-9][0-9]*))|(-?0(x|X)[0-9A-F]+) {yylval.string = strdup(yytext); return INTEGERLITERAL;}
(-?[0-9]+"."[0-9]+)|(-?(([0-9]+"."[0.9]+)|([1-9][0-9]*))[eE][-+][1-9][0-9]*) {yylval.string = strdup(yytext); return REALLITERAL;}
\"[^"\n]*\" {yylval.string = strdup(yytext); return STRINGLITERAL;}
\'.\' {yylval.string = strdup(yytext); return CHARLITERAL;}
[a-zA-Z][0-9a-zA-Z_]* {yylval.string = strdup(yytext);  return ID;}

 
"/%" {BEGIN comment;}
<comment>"%/" {BEGIN INITIAL;}
<comment>[\n] {yylineno++;}
<comment>.

[\n] {yylineno++;}
[ \t]+
. return yytext[0];
%%
