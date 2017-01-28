%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#define YYSTYPE double
	#include "1207002.tab.h"
	
%}



id          [a-zA-Z][a-zA-Z0-9#@$_&]*
digit       [0-9]+
punctuation cl|hash|at_the_rate_of|doller|power|asteris
number	[-]?{digit}*[.]?{digit}+

%%
{number}	{
	sscanf(yytext, "%lf", &yylval);
	return VALUE;
	}

"null power_house"     { return voidMain;}
"real"            {return FLOAT;}
"natural"         {return INT;}
"character"       {return CHAR;}
"cm"              {return comma;}
"sm"	          {return semicolon;}
"++"		      { return PLUS; }
"--"		      { return MINUS; }
"//"		      { return SLASH; }
"%%"		      { return MOD; }
"**"		      { return ASTERISK; }
":="              { return ASSIGN;}
"^"               { return POW; }
"sin"             { return sine; }
"cos"             { return cosine; }
"tan"             { return tangent; }
"log"             { return Log; }
"("               { return FBS; }
")"               { return FBE; } 
"{"               { return SBS; }
"}"               { return SBE; } 

"either"		  { return IF;		}
"or"		      { return ELSE;		}
"GT"              { return GreaterThan; }
"LT"              { return LessThan; }


[<][!].*       { printf("\n\nsingle line comment found\n\n");}
"<<"(.*|\n)*">>" { printf("\n\n Multiple line comment found \n\n"); }

[ \t\n]* 	; 	/* skip whitespace */

.   {printf("");}

{id}	        {   //functionId(yytext);
	                yylval = *yytext - 'a';
	                return ID;
	            }



%%

int main()
{
	yyin = freopen("input.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();

}

