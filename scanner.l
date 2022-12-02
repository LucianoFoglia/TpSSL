%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include "y.tab.h"
void yyerror(char *);
void errorLexico();
void yyparse();
%}

/*SECCION DE OPCIONES*/
/*Para que flex lea solo un fichero de entrada*/
%option noyywrap
/*Para obtener el numero de linea*/
%option yylineno


/* TOKENS*/

NUMERO              [0-4]
LETRA               [a-p]
ID                  {LETRA}({LETRA}|{NUMERO})*l
DIGITO              {NUMERO}+
PUNTOYCOMA          [";"]
ENTER               ["\n"]

/* PALABRAS RESERVADAS */

PRAPERTURA          "hola"
PRCIERRE            "chola"
PRSALIDA            "mbappe"
PRENTRADA           "maidana"

/* OPERADORES */
OPERADORADI         ["+"]
OPERADORSUSTRA      ["-"]
OPERADORPRODUC      ["*"]
OPEASIGNACION       ["="]
PARAPERT            ["("]
PARCIER             [")"]

%%
{PRAPERTURA}       {printf("\nPRAPERTURA (%s) \n", yytext);return PRAPERTURA;}
{PRCIERRE}         {printf("\nPRCIERRE (%s) \n" ,yytext);return PRCIERRE;}
{PRSALIDA}         {printf("\nPRSALIDA (%s) \n",yytext);return PRSALIDA;}
{PRENTRADA}        {printf("\nPRENTRADA (%s) \n",yytext);return PRENTRADA;}
{PUNTOYCOMA}       {printf("\nPUNTOYCOMA (%s) \n",yytext);return PUNTOYCOMA;}


{OPERADORADI}      {printf("\nOPERADORADI (%s) \n" ,yytext);return OPERADORADI;}
{OPERADORSUSTRA}   {printf("\nOPERADORSUSTRA (%s) \n" ,yytext);return OPERADORSUSTRA;}
{OPERADORPRODUC}   {printf("\nOPERADORPRODUC (%s) \n" ,yytext);return OPERADORPRODUC;}
{OPEASIGNACION}    {printf("\nOPEASIGNACION (%s) \n" ,yytext);return OPEASIGNACION;}
{PARAPERT}         {printf("\nPARAPERT (%s) \n" ,yytext); return PARAPERT;}
{PARCIER}          {printf("\nPARCIER (%s) \n" ,yytext); return PARCIER;}
{ID}               {printf("\nID (%s) \n",yytext);return ID;}
{DIGITO}           {printf("\nDIGITO (%s) \n",yytext); return DIGITO;}
{ENTER}            {return ENTER;}
" "
.                  {errorLexico();}
%%

int main(int argc, char *argv[]) {
    if(argc == 2) 
    {
        if(yyin = fopen(argv[1], "rt"))
        {
            printf("\nEl archivo se abrio en forma correcta \n");
            yylex();
            printf("\nFLEX finalizo la lectura del archivo \n");
            yyparse();
            printf("\nBISON finalizo la lectura del archivo \n");
            fclose(yyin);
        }
        else
          printf("\nEl archivo no existe. \n");  
    }
    else {
    printf("\nNo se pudo abrir el archivo correctamente. \n");
    } 
    
    return 0;       
}

void errorLexico(){
    printf("\nError lexico: Caracter invalido: %s\n" , yytext);
}