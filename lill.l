%{
#include "syntaxique.tab.h"
#include "tab.h"
extern int nb_ligne;
extern int nb_colonne; 
extern YYSTYPE yylval ;
int j;
%}
lettre [a-z]
chiffre [0-9]
IDF [A-Z]({lettre}|{chiffre})*
COMMENTAIRE "#"([^"\n"])*"!"
CST_FLOAT \([+-]({chiffre}+"."{chiffre}+)\)|({chiffre}+"."{chiffre}+)
CST_INTEGER "("[+-]{chiffre}+")"|{chiffre}+
CST_CHAR ['][^'][']
CST_STRING ["][^"]*["]
%%
"IDENTIFICATION DIVISION."   {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_ID_DIV reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_id_div;
                             }
"PROGRAM-ID."                {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_PROGRAM-ID reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_program_id;}
"DATA DIVISION."             {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_DATA_DIV reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_data_div;
                             }
"WORKING-STORAGE SECTION."   {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_WORKING-STORAGE_SECTION reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_working_storage;
                             }
"PROCEDURE DIVISION."        {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_PROCEDURE_DIV reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_pro_div;
                             }
"STOP RUN"                   {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_STOP_RUN reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_stop_run;
                             }                     
INTEGER                      {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_INTGER reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_integer;
                             }
FLOAT                        {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_FLOAT reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_float;
                             }
CHAR                         {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_CHAR reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_char;
                             }
STRING                       {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_STRING reconnue \n");
                             nb_colonne=nb_colonne + strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_string;
                             }
LINE                         {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_LINE reconnue \n");
                             nb_colonne=nb_colonne + strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_line;
                             }
SIZE                         {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_SIZE reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_size;
                             }
CONST                        {
                             rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_CONST reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             yylval.str= strdup (yytext);
                             return mc_const;
                             }
"|"                          {rechercher (yytext, "separateur",0,0,2);
                             printf("separateur | est reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return sep_bar;
                             }
":"                          {rechercher (yytext, "separateur",0,0,2);
                             printf("separateur : est reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return sep_2point;
                             }
"."                          {rechercher (yytext, "separateur",0,0,2);
                             printf("separateur point reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return sep_point;
                             }
"+"                          {rechercher (yytext, "separateur",0,0,2);
                             printf("Mc_ADD reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_add;
                             }
"-"                          {rechercher (yytext, "separateur",0,0,2);
                             printf("Mc_SUB reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_sub;
                             }
"*"                          {rechercher (yytext, "separateur",0,0,2);
                             printf("Mc_MUL reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_mul;
                             }
"/"                          {rechercher (yytext, "separateur",0,0,2);
                              printf("sep_DIV reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_div;
                             }
AND                          {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_AND reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_and;
                             }
OR                           {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_OR reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_or;
                             }
NOT                          {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_NOT reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_not;
                             }
".G."                        {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_SUP reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_sup;}
".L."                        {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_INF reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_inf;
                             }
".GE."                       {rechercher (yytext, "mot cle",0,0,1);
                             printf("Mc_SUP_ou_EQ reconnue \n");
                             nb_colonne=nb_colonne+ strlen(yytext);
                             return mc_sup_eq;
                             }
".LE."                       {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_INF_ou_EQ reconnue\n");
                             return mc_inf_eq;
                             }
".EQ."                       {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_EQ reconnue \n");
                             return mc_eq;
                             }
".DI."                       {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_DIFF reconnue \n");
                             return mc_diff;
                             }
ACCEPT                       {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_Entree reconnue \n");
                             return mc_entree;
                             }
DISPLAY                      {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_Sortie reconnue \n");
                             return mc_sortie;
                             }
{COMMENTAIRE}                {nb_colonne=nb_colonne+ strlen(yytext);}
"$"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("signe de formatage pour idf_entier reconnue \n");
                             yylval.str=strdup(yytext);
                             return sigf_entier;
                             }
"%"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("signe de formatage pour idf_float reconnue \n");
                             yylval.str=strdup(yytext);
                             return sigf_float;
                             }
"#"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("signe de formatage pour idf_string reconnue \n");
                             yylval.str=strdup(yytext);
                             return sigf_string;
                             }
"&"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("signe de formatage pour idf_char reconnue \n");
                             yylval.str=strdup(yytext);
                             
                             return sigf_char;
                             }
"@"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_adr reconnue \n");
                             return mc_adr;
                             }
\(                           {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+strlen(yytext);
                             printf("parenthese ouverante\n");
                             return parenthese_ouv;
                             }
\)                           {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("parenthese FERMANTE\n");
                             return parenthese_fer;
                             }
"\""                         {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("guillemet reconnue \n");
                             return guillemet ;
                             }
IF                           {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_IF reconnue \n");
                             return mc_if;
                             }
ELSE                         {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_ELSE reconnue \n");
                             return mc_else;
                             }
END                          {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_END reconnue \n"); 
                             return mc_end;
                             }
MOVE                         {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_MOVE reconnue \n");
                             return mc_move;
                             }
TO                           {rechercher (yytext, "mot cle",0,0,1);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Mc_TO reconnue \n");
                             return mc_to;
                             }
"="                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Affectation reconnue \n");
                             return aff;
                             }
","                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("separateur, reconnue \n");
                             return sep_virgule;
                             }
"“"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Guillemet-apostrophe double gauche, reconnue \n");
                             return guillemet_ap_g;
                             }
"”"                          {rechercher (yytext, "separateur",0,0,2);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("Guillemet-apostrophe double droite, reconnue \n");
                             return guillemet_ap_d;
                             }                           
{CST_FLOAT}                  {char myStr[100]="";
                             if(yytext[0]=='(')
                             {
                             for(j=1;j<yyleng-1;j++)
                             {
                              myStr[j-1] =yytext[j];
                             }
                             
                             rechercher (yytext, "cst float","FLOAT",atof(myStr),0);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("CST réelle reconnue \n");
                             yylval.reel= atof(myStr);
                             return cst_float;

                             }
                             else{
                             rechercher (yytext, "cst float","FLOAT",atof(yytext),0);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("CST réelle reconnue \n");
                             yylval.reel= atof(yytext);
                             return cst_float;
                             }
                             }
{CST_INTEGER}                {char myStr[100]="";
                             if(yytext[0]=='(')
                             {
                             for(j=1;j<yyleng-1;j++)
                             {
                              myStr[j-1] =yytext[j];
                             }
                             rechercher (yytext, "cst integer","INTEGER",atof(myStr),0);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             if (atoi(myStr) <(-32768)  || atoi(myStr)>32767  )  {printf("erreur lexical dans la ligne : %d colonne :%d \n",nb_ligne,nb_colonne);
                             break;}
                             printf("CST_INTEGER reconnue \n");
                             yylval.entier= atoi(myStr);
                             return cst_integer;
                             }
                             else {
                             rechercher (yytext, "cst integer","INTEGER",atof(yytext),0);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             if (atoi(yytext) <(-32768)  || atoi(yytext)>32767  )  {printf("erreur lexical dans la ligne : %d colonne :%d \n",nb_ligne,nb_colonne);
                             break;}
                             printf("CST_INTEGER reconnue \n");
                             yylval.entier= atoi(yytext);
                             return cst_integer;
                             }
                             }
{CST_CHAR}                   {char myStr[100]="";
                             myStr[0] =yytext[1];                
                             rechercherCh (yytext,"cst char", "CHAR" ,myStr); 
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("CST_CHAR reconnue \n");
                             yylval.str=strdup(myStr);
                             return cst_char;
                             }
{CST_STRING}                 {char myStr[100]="";
                             for(j=1;j<yyleng-1;j++)
                             {
                              myStr[j-1] =yytext[j];
                             }
                             rechercherCh (yytext,"cst string", "STRING" ,myStr); 
                             nb_colonne=nb_colonne+ strlen(yytext);
                             printf("CST_STRING reconnue \n");
                             yylval.str=strdup(myStr);
                             return cst_string;
                             }
{IDF}                        {char myStr[100]="";
                             rechercher (yytext, "idf","",88888,0);
                             nb_colonne=nb_colonne+ strlen(yytext);
                             if (yyleng > 8 ) { printf("erreur lexical : taille de IDF est superieure a 8 dans la ligne : %d colonne : %d \n",nb_ligne,nb_colonne);
                             break;}
                             printf("l entite lexical idf est reconnue %s \n",yytext);
                             yylval.chaine=strdup(yytext);
                             return idf;
                             }       
[ \t]                        {nb_colonne=nb_colonne+ strlen(yytext);}
"\n" {nb_ligne++; nb_colonne=1;}
. {printf("erreur lexical dans la ligne : %d colonne :%d  \n",nb_ligne,nb_colonne); nb_colonne=nb_colonne+ strlen(yytext);}
