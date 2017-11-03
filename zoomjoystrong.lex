%{
/*
 *ZJS Flex File
 *Created by Jeremiah Logan
 */

#include <stdio.h>
#include <stdlib.h>
#include "zoomjoystrong.tab.h"
int i;
float f;

%}

%%

^end;			{return END;}
[;]			{yylval.sVal = yytext;return END_STATEMENT;}
^point			{yylval.sVal = yytext;return POINT;}
^line			{yylval.sVal = yytext;return LINE;}
^circle			{yylval.sVal = yytext;return CIRCLE;}
^rectangle			{yylval.sVal = yytext;return RECTANGLE;}
^set_color			{yylval.sVal = yytext;return SETCOLOR;}
[0-9]+			{yylval.iVal = atoi(yytext); return V_INT;}
[0-9]*\.[0-9]+			{yylval.fVal = atof(yytext); return V_FLOAT;}
[\s]			{;}
[A-Za-z0-9]+			{yylval.sVal = yytext;return P_ERR;}

%%
