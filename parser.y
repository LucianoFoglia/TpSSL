%{    
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "y.tab.h"
  
  int yylex(void);
  void yyerror(char *s);

   extern int yylineno;
   void parseError(char*);
   void removeChar(char*, char);
 %} 

%token PRAPERTURA
%token PRCIERRE
%token DIGITO
%token LETRA
%token ID
%token PUNTOYCOMA
%token PRSALIDA
%token PRENTRADA
%token OPERADORADI
%token OPERADORSUSTRA
%token OPERADORPRODUC
%token OPEASIGNACION
%token PARAPERT
%token PARCIER
%token ENTER
%token ' '


%start INICIO

%%

INICIO:
    PRAPERTURA ENTER RECUSENTENCIADATOS ENTER PRCIERRE
;

RECUSENTENCIADATOS:
    RECUSENTENCIADATOS ENTER SENTENCIADATOS |
    SENTENCIADATOS
;

SENTENCIADATOS:
    ASIGNACION  |
    SALIDA      |
    PRENTRADA ID DECLARACION
;

ASIGNACION:
    ID OPEASIGNACION DIGITO PUNTOYCOMA
;

SALIDA:
    PRSALIDA DIGITO PARCIER PUNTOYCOMA |
    PRSALIDA ID PARCIER PUNTOYCOMA
;

DECLARACION:
    PRENTRADA ID FINDECLARACION
;

FINDECLARACION:
    DIGITO PUNTOYCOMA |
    PUNTOYCOMA
;

%%


void yyerror(char *texto) {
    char* textoError = strdup(texto);
    printf("Error Sintactico: ");
    parseError(textoError);   
    printf("en la linea %d.\n", yylineno);
}

void parseError(char* textoError){
    removeChar(textoError, ',');
    char* token = strtok(textoError, " ");
    while(token != NULL) {
        if (strcmp(token, "syntax") != 0 && strcmp(token, "error") != 0){
            if (strcmp(token, "unexpected") == 0){
                token = strtok(NULL, " ");
                printf("se recibio %s y se esperadaba ", token);
            } else if (strcmp(token, "expecting") == 0 || strcmp(token, "or") == 0) {
                if (strcmp(token, "or") == 0){
                    printf("o ");
                }
                token = strtok(NULL, " ");
                printf("%s ", token);
            }
        }
        token = strtok(NULL, " ");
    }
}

void removeChar(char* str, char charToRemove){
    int i, j;
    int len = strlen(str);
    for(i=0; i<len; i++)
    {
        if(str[i] == charToRemove)
        {
            for(j=i; j<len; j++)
            {
                str[j] = str[j+1];
            }
            len--;
            i--;
        }
    }
}