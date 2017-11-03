%{
/*
 *ZJS Bison file
 *Created by Jeremiah Logan
 */

#include <stdio.h>
#include <stdlib.h>
#include "zoomjoystrong.h"
int yyerror(char * s);


%}

%union{
	int iVal;
	float fVal;
	char *sVal;
}

%start statement_list
%token<sVal> LINE
%token<sVal> POINT
%token<sVal> CIRCLE
%token<sVal> RECTANGLE
%token<sVal> SETCOLOR
%token<sVal> END
%token<sVal> END_STATEMENT
%token<iVal> V_INT
%token<fVal> V_FLOAT
%token<sVal> P_ERR

%%

statement_list:  	statement end
			|statement statement_list
			;

statement:		line
			|point
			|circle
			|rectangle
			|sc
			|err
			;

line:			LINE V_INT V_INT V_INT V_INT END_STATEMENT {
			if($2 > WIDTH-1){
			$2 = WIDTH -1;
			}
			if($3 > HEIGHT - 1){
			$3 = HEIGHT - 1;
			}
			if($4 > WIDTH){
			$4 = WIDTH;
			}
			if($5 > HEIGHT){
			$5 = HEIGHT;
			}
			line($2,$3,$4,$5);}
			|LINE V_FLOAT V_FLOAT V_FLOAT V_FLOAT END_STATEMENT {
			if($2 > WIDTH-1){
			$2 = WIDTH -1;
			}
			if($3 > HEIGHT - 1){
			$3 = HEIGHT - 1;
			}
			if($4 > WIDTH){
			$4 = WIDTH;
			}
			if($5 > HEIGHT){
			$5 = HEIGHT;
			}
			line($2,$3,$4,$5);}
			;

point:			POINT V_INT V_INT END_STATEMENT{
			if($2 > WIDTH){
			$2 = WIDTH;
			}
			if($3 > HEIGHT){
			$3 = HEIGHT;
			}
			point($2,$3);}
			|POINT V_FLOAT V_FLOAT END_STATEMENT{
			if($2 > WIDTH){
			$2 = WIDTH;
			}
			if($3 > HEIGHT){
			$3 = HEIGHT;
			}
			point($2,$3);}
			;

circle:		CIRCLE V_INT V_INT V_INT END_STATEMENT {
			if($2 > WIDTH){
			$2 = WIDTH;
			}
			if($3 > HEIGHT){
			$3 = HEIGHT;
			}
			if(($2+$4) > WIDTH){
			$4 = (WIDTH - $2)/2;
			}
			if(($3+$4) > HEIGHT){
			$4 = (HEIGHT - $3)/2;
			}
			circle($2,$3,$4);}
			|CIRCLE V_FLOAT V_FLOAT V_FLOAT END_STATEMENT {
			if($2 > WIDTH){
			$2 = WIDTH;
			}
			if($3 > HEIGHT){
			$3 = HEIGHT;
			}
			if(($2+$4) > WIDTH){
			$4 = (WIDTH - $2)/2;
			}
			if(($3+$4) > HEIGHT){
			$4 = (HEIGHT - $3)/2;
			}
			circle($2,$3,$4);}
			;

rectangle:		RECTANGLE V_INT V_INT V_INT V_INT END_STATEMENT {
			if($2 > WIDTH-1){
			$2 = WIDTH -1;
			}
			if($3 > HEIGHT - 1){
			$3 = HEIGHT - 1;
			}
			if($4 > WIDTH){
			$4 = WIDTH;
			}
			if($5 > HEIGHT){
			$5 = HEIGHT;
			}
			rectangle($2,$3,$4,$5);}
			|RECTANGLE V_FLOAT V_FLOAT V_FLOAT V_FLOAT END_STATEMENT {
			if($2 > (WIDTH-1)){
			$2 = WIDTH -1;
			}
			if($3 > (HEIGHT-1)){
			$3 = HEIGHT -1;
			}
			if($4 > WIDTH){
			$4 = WIDTH;
			}
			if($5 > HEIGHT){
			$5 = HEIGHT;
			}
			rectangle($2,$3,$4,$5);}
			;

sc:			SETCOLOR V_INT V_INT V_INT END_STATEMENT {
			if($2 > 255){
			$2 = 255;
			}
			if($3 > 255){
			$2 = 255;
			}
			if($4 > 255){
			$2 = 255;
			}
			set_color($2,$3,$4);}
			|SETCOLOR V_FLOAT V_FLOAT V_FLOAT END_STATEMENT {
			if($2 > 255){
			$2 = 255;
			}
			if($3 > 255){
			$2 = 255;
			}
			if($4 > 255){
			$2 = 255;
			}
			set_color($2,$3,$4);}
			;

end:			END {finish();}

err:			P_ERR {yyerror($1);}
%%

/*****************************************************************
*Parsing program that reads an instruction set and draws a picture
*using the SmartTurtle Program.
*
*author Jeremiah Logan
*****************************************************************/
int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
}
/*****************************************************************
*Prints out the token that has caused an error in the program
*param s = char array of error text
*****************************************************************/
int yyerror(char * s)
{
 fprintf(stderr,"The following command: %s is not valid",s);
}
