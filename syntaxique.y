%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int nb_ligne=1,nb_colonne=1;
char sauvType[25];
char sauvIdfType[25];
char sauvSig[25];
char op[15];
float val[15];
char chaine[100]="";
float *valf=NULL ;
float a;
char c;
int i;
int j=0;
int n=0;
int nbrIDF=0;
int yylex();
char *GetType();
char * GetCH();
char *GetCode();
float GetValue();
void insererTYPE();
void insertCh ();
void insererTYPETAB();
void insertNbr();
int doubleDeclaration();
void insererCodeCST();
void insererTYPE();
void afficher ();
void initialisation();
int yyerror(char* msg)
{printf("-----------------------------------------------------\n");
printf("Erreur syntaxique dans la ligne : %d colonne : %d\n",nb_ligne,nb_colonne);
return 0;
}
%}
%union{
  int entier ; 
  char*  str ;
  float reel;
  char* chaine;
}
%token mc_id_div mc_program_id mc_data_div mc_working_storage mc_pro_div mc_stop_run
%token <str> mc_integer <str> mc_float <str> mc_char <str>  mc_string 
%token <str> mc_size <str>  mc_line <str>  mc_const 
%token sep_bar sep_2point sep_point aff sep_par_ouv sep_par_fer sep_virgule
%token mc_add mc_sub mc_mul mc_div
%token mc_and mc_or mc_not mc_sup mc_inf mc_sup_eq mc_inf_eq mc_eq mc_diff
%token mc_entree mc_sortie
%token <str> sigf_entier <str> sigf_float <str> sigf_string <str> sigf_char
%token mc_adr 
%token <chaine> idf 
%token parenthese_ouv parenthese_fer guillemet guillemet_ap_g guillemet_ap_d
%token mc_if mc_else mc_end mc_move mc_to
%token <reel> cst_float 
%token <str> cst_string  
%token <str> cst_char  
%token <entier> cst_integer
%left mc_or
%left mc_and
%left mc_sup mc_sup_eq mc_eq mc_diff mc_inf_eq mc_inf 
%left mc_add mc_sub
%left mc_mul mc_div
%start S
%%
S: mc_id_div mc_program_id idf sep_point mc_data_div mc_working_storage DECLARATION  mc_pro_div INSTRUCTION mc_stop_run {printf("syntaxe correcte\n");
YYACCEPT;} ;
DECLARATION :DECLARATIONVAR  DECLARATION| DECLARATIONTAB  DECLARATION| DECLARATIONCONST DECLARATION | ;

DECLARATIONVAR :idf TYPE sep_point  { /*vérification de double déclaration*/
 if (doubleDeclaration($1)==0){insererTYPE($1,sauvType);}
else {printf("erreur Sémantique: double déclation de %s, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
} 
| idf sep_bar DECLARATIONVAR { /*vérification de double déclaration*/
 if (doubleDeclaration($1)==0){insererTYPE($1,sauvType);}
else {printf("erreur Sémantique: double déclation de %s, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
}  ;
DECLARATIONTAB : idf mc_line cst_integer sep_virgule mc_size cst_integer TYPE sep_point  
{if ($6<0) {printf("%d:erreur: taille du tableau %s < 0 \n",nb_ligne,$1); YYACCEPT;}
/*vérification de double déclaration*/
 if (doubleDeclaration($1)==0){insererTYPETAB($1,sauvType);}
else {printf("erreur Sémantique: double déclation de %s, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}

}
| idf sep_bar DECLARATIONTAB {/*vérification de double déclaration*/
 if (doubleDeclaration($1)==0){insererTYPETAB($1,sauvType);}
else {printf("erreur Sémantique: double déclation de %s, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}};

DECLARATIONCONST : mc_const idf aff CANSTANTE sep_point 
{ /*vérification de double déclaration*/
 if (doubleDeclaration($2)==0){insererTYPE($2,sauvType);

 insererCodeCST($2);// pour dire que ce idf est une cst 
 // pour avoir la valuer :
 if ((strcmp(sauvType,"STRING")==0)||(strcmp(sauvType,"CHAR")==0)){insertCh($2,chaine);}
 else {insertNbr($2,valf); printf("\n\n val : %f \n\n",*valf);}
 }
else {printf("erreur Sémantique: double déclation de %s, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}

}
| mc_const idf TYPE sep_point { /*vérification de double déclaration*/
 if (doubleDeclaration($2)==0){insererTYPE($2,sauvType); insererCodeCST($2);// pour dire que ce idf est une cst 
 }
else {printf("erreur Sémantique: double déclation de %s, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
};
INSTRUCTION :BOUCLE INSTRUCTION |AFFECTATION INSTRUCTION |ENTREES INSTRUCTION | Sortie INSTRUCTION 
|IF_STATEMENT INSTRUCTION| ;
IF_STATEMENT : mc_if parenthese_ouv CONDITION  parenthese_fer sep_2point INSTRUCTION mc_else sep_2point INSTRUCTION mc_end sep_point 
| mc_if parenthese_ouv CONDITION  parenthese_fer sep_2point INSTRUCTION mc_end sep_point  ;
CONDITION : Y | A  |Y B Y |parenthese_ouv A parenthese_fer B parenthese_ouv A  parenthese_fer |NOT;
NOT :mc_not Y |  mc_not parenthese_ouv NOT parenthese_fer |  mc_not parenthese_ouv A  parenthese_fer
|mc_not parenthese_ouv Y B Y  parenthese_fer |mc_not parenthese_ouv parenthese_ouv A parenthese_fer B parenthese_ouv A  parenthese_fer  parenthese_fer;
A:parenthese_ouv A B A parenthese_fer B parenthese_ouv A B A parenthese_fer |parenthese_ouv Y B Y parenthese_fer B parenthese_ouv Y B Y parenthese_fer ;
B:SIGNECOMPARAISON | LI;
LI:mc_and |mc_or; 
BOUCLE : mc_move idf mc_to idf INSTRUCTION mc_end 
{

if (doubleDeclaration($2)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$2, nb_ligne);YYACCEPT;}
// verifier si idf est déclaré
if (doubleDeclaration($4)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$4, nb_ligne);YYACCEPT;}
// verifier si idf est déclaré
if(strcmp(GetType($2),GetType($4))!=0)
{printf("erreur Sémantique: %s et %s ne sont pas du meme type, à la ligne %d\n",$2,$4, nb_ligne);YYACCEPT;} 

// vérifier si les 2 idf sont du meme type 
if (strcmp(GetType($2),"STRING")==0)
{
printf("erreur Sémantique: %s est une chaine de car, à la ligne %d\n",$2, nb_ligne);YYACCEPT;
}
//vérifier si l'idf esr une cst :
if (strcmp("idf cst",GetCode($2))==0)
{
 printf("erreur Sémantique: %s est une cst on peut pas la modifier, à la ligne %d\n",$2, nb_ligne);
  YYACCEPT;
}

if(GetValue($4)==88888){printf("erreur Sémantique: %s n'est pas initailisé, à la ligne %d\n",$4, nb_ligne);YYACCEPT;}


}
| mc_move idf mc_to CANSTANTE INSTRUCTION mc_end 
{

if (doubleDeclaration($2)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$2, nb_ligne);YYACCEPT;}
// verifier si idf est déclaré

if(strcmp(GetType($2),sauvType)!=0)
{printf("erreur Sémantique: %s ne recoit pas une valuer de son type, à la ligne %d\n",$2, nb_ligne);YYACCEPT;} 
if (strcmp(sauvType,"STRING")==0)
{
printf("erreur Sémantique: %s est une chaine de car, à la ligne %d\n",$2, nb_ligne);YYACCEPT;
}
//vérifier si l'idf esr une cst :
if (strcmp("idf cst",GetCode($2))==0)
{
 printf("erreur Sémantique: %s est une cst on peut pas la modifier, à la ligne %d\n",$2, nb_ligne);
  YYACCEPT;
}




}
|mc_move  CANSTANTE mc_to CANSTANTE INSTRUCTION mc_end 

;

ENTREES :mc_entree parenthese_ouv guillemet_ap_g SIGNEDEFORMATAGE guillemet_ap_d sep_2point mc_adr idf parenthese_fer sep_point 
{
// verifier si idf est déclaré:
if (doubleDeclaration($8)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$8, nb_ligne);YYACCEPT;}
//sauvarder le type du idf 
printf("%s",GetType($8));
if (strcmp(GetType($8),"INTEGER")==0)
sauvIdfType[0]='i';
if (strcmp(GetType($8),"FLOAT")==0)
sauvIdfType[0]='f';
if (strcmp(GetType($8),"CHAR")==0)
sauvIdfType[0]='c';
if (strcmp(GetType($8),"STRING")==0)
sauvIdfType[0]='s';

if(sauvSig[0]!=sauvIdfType[0])
{
  printf("erreur Sémantique: des sig sans des idf , à la ligne %d\n",nb_ligne);
      YYACCEPT;
}

}
;
PIDF :sep_virgule  idf PIDF
{
// verifier les  idf sont déclaré:
if (doubleDeclaration($2)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$2, nb_ligne);YYACCEPT;}
//sauvarder les type des idf
if(n==0)
{n=1;}
else{
n++;}
if (strcmp(GetType($2),"INTEGER")==0)
sauvIdfType[n]='i';
if (strcmp(GetType($2),"FLOAT")==0)
sauvIdfType[n]='f';
    
if (strcmp(GetType($2),"CHAR")==0)
sauvIdfType[n]='c';

if (strcmp(GetType($2),"STRING")==0)
sauvIdfType[n]='s';
printf("%s",GetType($2));

}|;
Sortie :mc_sortie parenthese_ouv cst_string sep_2point idf PIDF parenthese_fer sep_point

{
  
// verifier si idf est déclaré:
if (doubleDeclaration($5)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$5, nb_ligne);YYACCEPT;}
//sauvarder le type du idf 
nbrIDF=0;
printf("%s",GetType($5));
if (strcmp(GetType($5),"INTEGER")==0)
sauvIdfType[nbrIDF]='i';
if (strcmp(GetType($5),"FLOAT")==0)
sauvIdfType[nbrIDF]='f';
    
if (strcmp(GetType($5),"CHAR")==0)
sauvIdfType[nbrIDF]='c';

if (strcmp(GetType($5),"STRING")==0)
sauvIdfType[nbrIDF]='s';


 
  // sauvgarder les signe de formatiage : dans la chaine 
  strcpy(chaine , $3) ;
  j=0;
  for(i=0;i<strlen(chaine);i++)
  {
    if('$'==chaine[i] && j<25) {sauvSig[j]='i';j++;}
    if('%'==chaine[i] && j<25) {sauvSig[j]='f';j++;}
    if('#'==chaine[i] && j<25) {sauvSig[j]='s';j++;}
    if('&'==chaine[i] && j<25) {sauvSig[j]='c';j++;}
 
  }

  if(j!=n+1)
  {
    printf("erreur Sémantique: on a pas le meme nombre de sig et idf , à la ligne %d\n",nb_ligne);
    YYACCEPT;
  }
  else 
  {
    if(sauvSig[0]!=sauvIdfType[0])
      {
      printf("erreur Sémantique: le sig n'est pas compatible avec le type de l idf  , à la ligne %d\n",nb_ligne);
      YYACCEPT;
      }
      nbrIDF=n;
    for(j=1;j<=n;j++)
    {

      if(sauvSig[j]!=sauvIdfType[nbrIDF])
      {
      printf("erreur Sémantique: le sig n'est pas compatible avec le type de l idf  , à la ligne %d\n",nb_ligne);
      YYACCEPT;
      }
      nbrIDF--;
    }

  }
  printf("\n\n\n%s %s\n\n\n",sauvSig,sauvIdfType);
  nbrIDF=0;
  n=0;
  j=0;
}
|mc_sortie parenthese_ouv cst_string parenthese_fer sep_point 
{
    strcpy(chaine , $3) ;
  j=0;
  for(i=0;i<strlen(chaine);i++)
  {
    if('$'==chaine[i] && j<25) {sauvSig[j]='i';j++;}
    if('%'==chaine[i] && j<25) {sauvSig[j]='f';j++;}
    if('#'==chaine[i] && j<25) {sauvSig[j]='s';j++;}
    if('&'==chaine[i] && j<25) {sauvSig[j]='c';j++;}
    
    
  }
  if(j!=0){printf("erreur Sémantique: des sig sans des idf , à la ligne %d\n",nb_ligne);
      YYACCEPT;}
}
;


AFFECTATION : idf aff idf  sep_point {
if (doubleDeclaration($1)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
// verifier si idf est déclaré
if (doubleDeclaration($3)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$3, nb_ligne);YYACCEPT;}
// verifier si idf est déclaré
if(strcmp(GetType($1),GetType($3))!=0)
{printf("erreur Sémantique: %s et %s ne sont pas du meme type, à la ligne %d\n",$1,$3, nb_ligne);YYACCEPT;} 
// vérifier si les 2 idf sont du meme type 
//vérifier si l'idf esr une cst :
if (strcmp("idf cst",GetCode($1))==0)
{
  // si l'idf est initailisé alors erreur la cst ne change pas 
  if(GetValue($1)!=88888) {printf("erreur Sémantique: %s est une cst deja initailisé on peut pas la modifier, à la ligne %d\n",$1, nb_ligne);
  YYACCEPT;}
}

if(GetValue($3)==88888){printf("erreur Sémantique: %s n'est pas initailisé, à la ligne %d\n",$3, nb_ligne);YYACCEPT;}
else {
  
  if ((strcmp(sauvType,"STRING")==0)||(strcmp(sauvType,"CHAR")==0)){insertCh($1,GetCH($3));}
  else{
  *valf=GetValue($3);
  insertNbr($1,valf);
  }
}
}
|idf aff CANSTANTE  sep_point
{
if (doubleDeclaration($1)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
// verifier si idf est déclaré
if(strcmp(GetType($1),sauvType)!=0)
{printf("erreur Sémantique: %s ne recoit pas une valuer de son type, à la ligne %d\n",$1, nb_ligne);YYACCEPT;} 
// vérifier si les 2 idf sont du meme type 
//vérifier si l'idf esr une cst :
if (strcmp("idf cst",GetCode($1))==0)
{
  // si l'idf est initailisé alors erreur la cst ne change pas 
  if(GetValue($1)!=88888) {
    printf("erreur Sémantique: %s est une cst deja initailisé on peut pas la modifier, à la ligne %d\n",$1, nb_ligne);
    YYACCEPT;
    }
}

if ((strcmp(sauvType,"STRING")==0)||(strcmp(sauvType,"CHAR")==0)){insertCh($1,chaine);}
 else {insertNbr($1,valf); printf("\n\n val : %f \n\n",*valf);}
 }
|idf aff EXPRESSIONARITHMETIQUE sep_point
 {
   // verifier si idf est déclaré
   if (doubleDeclaration($1)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
  //vérifier si l'idf esr une cst :
  if (strcmp("idf cst",GetCode($1))==0)
  {
    // si l'idf est initailisé alors erreur la cst ne change pas :
    if(GetValue($1)!=88888) {
      printf("erreur Sémantique: %s est une cst deja initailisé on peut pas la modifier, à la ligne %d\n",$1, nb_ligne);
      YYACCEPT;
      }
  }
 for(j=0;j<nbrIDF-1;j++)
 {
   if(sauvIdfType[j]!=sauvIdfType[j+1])
   {
printf("erreur Sémantique: des operation entre idf avec un type diff à la ligne %d\n", nb_ligne);YYACCEPT;
   }
 }
 if (sauvIdfType[0]=='i')
strcpy(sauvType,"INTEGER");

if (sauvIdfType[0]=='f')
strcpy(sauvType,"FLOAT");
    
if (sauvIdfType[0]=='c')
strcpy(sauvType,"CHAR");

if (sauvIdfType[0]=='s')
strcpy(sauvType,"STRING");

 if(strcmp(GetType($1),sauvType)!=0)
{printf("erreur Sémantique: %s ne recoit pas une valuer de son type, à la ligne %d\n",$1, nb_ligne);YYACCEPT;} 
 nbrIDF=0;}

;



SIGNEDEFORMATAGE : sigf_entier {sauvSig[0]='i';}
| sigf_float {sauvSig[0]='f';}
| sigf_string {sauvSig[0]='s';}
| sigf_char {sauvSig[0]='c';};
TYPE :mc_integer { strcpy(sauvType,$1); }| 
mc_float { strcpy(sauvType,$1); }| 
mc_char { strcpy(sauvType,$1); }| 
mc_string{ strcpy(sauvType,$1); };

CANSTANTE : cst_float { strcpy(sauvType,"FLOAT");  valf=&$1;  }
| cst_string { strcpy(sauvType,"STRING");strcpy(chaine , $1) ; }
| cst_char { strcpy(sauvType,"CHAR");strcpy(chaine , $1) ; }
| cst_integer { strcpy(sauvType,"INTEGER"); a=(float)$1; valf=&a; } ;
SIGNECOMPARAISON : mc_sup | mc_sup_eq | mc_eq mc_diff | mc_inf_eq | mc_inf; 



EXPRESSIONARITHMETIQUE : EXPRESSION OPERATEURSARITHMETIQUE EXPRESSIONARITHMETIQUE|
 EXPRESSION OPERATEURSARITHMETIQUE EXPRESSION  | EXPRESSION mc_div cst_integer
 {
if ($3==0) {printf("%d:erreur : division par 0\n",nb_ligne); YYACCEPT;}

}
 | EXPRESSION mc_div idf {if(GetValue($3)==0){printf("%d:erreur : division par 0\n",nb_ligne); YYACCEPT;}}

 | EXPRESSION mc_div cst_float
 {
if ($3==0) {printf("%d:erreur : division par 0\n",nb_ligne); YYACCEPT;}

}
 ; 
Y:EXPRESSIONARITHMETIQUE |EXPRESSION  ;
EXPRESSION:
CANSTANTE 
{

if (strcmp(sauvType,"INTEGER")==0)
sauvIdfType[nbrIDF]='i';
if (strcmp(sauvType,"FLOAT")==0)
sauvIdfType[nbrIDF]='f';
    
if (strcmp(sauvType,"CHAR")==0)
sauvIdfType[nbrIDF]='c';

if (strcmp(sauvType,"STRING")==0)
sauvIdfType[nbrIDF]='s';
if (nbrIDF==0) {nbrIDF++;}
}
| idf 
{
  if (doubleDeclaration($1)==0){printf("erreur Sémantique: %s n'est pas déclaré, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
  if(GetValue($1)==88888){printf("erreur Sémantique: %s n'est pas initailisé, à la ligne %d\n",$1, nb_ligne);YYACCEPT;}
  //sauvarder les type des idf

if (strcmp(GetType($1),"INTEGER")==0)
sauvIdfType[nbrIDF]='i';
if (strcmp(GetType($1),"FLOAT")==0)
sauvIdfType[nbrIDF]='f';
    
if (strcmp(GetType($1),"CHAR")==0)
sauvIdfType[nbrIDF]='c';

if (strcmp(GetType($1),"STRING")==0)
sauvIdfType[nbrIDF]='s';
if (nbrIDF==0) {nbrIDF++;}
}
;  

OPERATEURSARITHMETIQUE: mc_add | mc_sub  | mc_mul  ; 
%%
int main()
{
 initialisation();
yyparse();
afficher(); 
return 0; 
}
int yywrap()
{
  return 0;
}

