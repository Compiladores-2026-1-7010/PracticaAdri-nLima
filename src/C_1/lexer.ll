%{
#include <stdio.h>
#include <stdlib.h>

// Definición de tokens
#define TOK_INT 12
#define TOK_FLOAT 15
#define TOK_IF 11
#define TOK_ELSE 14
#define TOK_WHILE 13
#define TOK_NUMERO 16
#define TOK_IDENTIFICADOR 10
#define TOK_PUNTO_COMA 9
#define TOK_COMA 8
#define TOK_PAREN_IZQ 6
#define TOK_PAREN_DER 7

extern FILE *yyin;
int yylex();
%}

%option noyywrap

digito        [0-9]
letra         [a-zA-Z]
espacio       [ \t\n]
/* CORRECCIÓN: Permitir que empiece con letra o _ */
identificador ([a-zA-Z_])([a-zA-Z0-9_]){0,31}
numero_entero {digito}+
numero_float  {digito}+\.{digito}+([eE][+-]?{digito}+)?

%%

"int"      { printf("%d, %s\n", TOK_INT, yytext); }
"float"    { printf("%d, %s\n", TOK_FLOAT, yytext); }
"if"       { printf("%d, %s\n", TOK_IF, yytext); }
"else"     { printf("%d, %s\n", TOK_ELSE, yytext); }
"while"    { printf("%d, %s\n", TOK_WHILE, yytext); }
{numero_entero} { printf("%d, %s\n", TOK_NUMERO, yytext); }
{numero_float}  { printf("%d, %s\n", TOK_NUMERO, yytext); }
{identificador} { printf("%d, %s\n", TOK_IDENTIFICADOR, yytext); }
";"        { printf("%d, %s\n", TOK_PUNTO_COMA, yytext); }
","        { printf("%d, %s\n", TOK_COMA, yytext); }
"("        { printf("%d, %s\n", TOK_PAREN_IZQ, yytext); }
")"        { printf("%d, %s\n", TOK_PAREN_DER, yytext); }
{espacio}  { /* ignorar espacios */ }
.          { fprintf(stderr, "Error léxico: carácter no válido '%s'\n", yytext); }

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <archivo_entrada>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        fprintf(stderr, "Error: No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }

    yylex();

    fclose(yyin);
    return 0;
}