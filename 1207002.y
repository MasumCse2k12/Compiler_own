
%{
	#include <stdio.h>
	#include <math.h>
	#define YYSTYPE double
	void yyerror(char *);
	int sym[26];
	int i, temp1 , temp2 ;
%}

/* BISON Declarations */

%token VALUE NEWLINE ID NUMBER PLUS MINUS SLASH ASTERISK ASSIGN POW sine cosine tangent Log FBS FBE INT FLOAT CHAR comma semicolon IF ELSE GreaterThan LessThan MOD voidMain SBS SBE
%nonassoc IFX
%nonassoc ELSE

%left GreaterThan LessThan
%left PLUS MINUS
%left ASTERISK SLASH
%left MOD
%left POW

/* Grammar follows */

%%

program : voidMain FBS FBE SBS input SBE { printf("\n\nValid main function declaration !!!! \n");}
          ;

input: input line 

      |declaration 

      | /* empty string */
        
	;
declaration: dataTYPE ID1 semicolon	{ 
					printf("\nValid Declaration\n");
					
				}


dataTYPE : INT	{ }

     | FLOAT	{ }

     | CHAR	{  }
     ;

ID1  : ID1 comma ID	{ }

     |ID		{ }
     ;



line:  semicolon {}
       
       |exp    semicolon { printf("Value of the expression in line :\t%.2lf\n",$1); }
         
       | ID ASSIGN exp semicolon { i=$1; sym[i] = $3; 
				    printf("Value of the variable : %.2lf\t\n",$3);
				    //printf("Value of the variable: %d\n",sym[$1]);
				  }  
       
       | if_stmt
       
   	;
if_stmt:
      | IF FBS exp FBE  line  %prec IF {
								if($3)
								{
									printf("\nvalue of expression in IF: %.2lf\n",$5);
								}
								else
								{
									printf("condition value zero in IF block\n");
								}
							}

	 | IF FBS exp FBE  line  ELSE   line {
								 	if($3)
									{
										printf(" if else value of expression in IF: %.2lf\n",$5);
									}
									else
									{
										printf("value of expression in ELSE: %.2lf\n",$7);
									}
								   }
       ;
exp: VALUE { }
         
       
        | ID { i = $1; $$ = sym[i];  }

        | exp PLUS exp   	{ $$ = $1 + $3; }

        | exp MINUS exp 	{ $$ = $1 - $3; }

        | exp MOD exp 	{ temp1 = $1; temp2 = $3; $$ = temp1 % temp2; }

        | exp ASTERISK exp 	{ $$ = $1 * $3; }

        | exp SLASH exp  	{ 	if($3) 
							  	{
							     		
							     		$$ = $1 / $3;
							  	}
							  	else
							  	{
									$$ = 0;
									printf("\ndivision by zero\n\n");
							  	} 	
							  	
				            }

        | exp POW exp        {$$=pow($1,$3);}


        | FBS exp FBE      { $$=$2;}

        | sine FBS exp FBE { $$=sin($3); }

        | cosine FBS exp FBE { $$=cos($3); }

        | tangent FBS exp FBE { $$=tan($3); }

        | Log FBS exp FBE { $$=log($3); }

        | exp LessThan exp	{ $$ = $1 < $3; printf("check Lt : %lf\n",$$) ;}

	    | exp GreaterThan exp	{ $$ = $1 > $3; printf("check GT : %lf\n",$$) ; }
;

%%

/* Additional C code */

/* Error processor for yyparse */


void yyerror(char *s) /* called by yyparse on error */
{
	fprintf(stderr,"%s\n",s);
}

/* The controlling function */

int yywrap()
{
	return 1;
	
}
