/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_id_div = 258,
     mc_program_id = 259,
     mc_data_div = 260,
     mc_working_storage = 261,
     mc_pro_div = 262,
     mc_stop_run = 263,
     mc_integer = 264,
     mc_float = 265,
     mc_char = 266,
     mc_string = 267,
     mc_size = 268,
     mc_line = 269,
     mc_const = 270,
     sep_bar = 271,
     sep_2point = 272,
     sep_point = 273,
     aff = 274,
     sep_par_ouv = 275,
     sep_par_fer = 276,
     sep_virgule = 277,
     mc_add = 278,
     mc_sub = 279,
     mc_mul = 280,
     mc_div = 281,
     mc_and = 282,
     mc_or = 283,
     mc_not = 284,
     mc_sup = 285,
     mc_inf = 286,
     mc_sup_eq = 287,
     mc_inf_eq = 288,
     mc_eq = 289,
     mc_diff = 290,
     mc_entree = 291,
     mc_sortie = 292,
     sigf_entier = 293,
     sigf_float = 294,
     sigf_string = 295,
     sigf_char = 296,
     mc_adr = 297,
     idf = 298,
     parenthese_ouv = 299,
     parenthese_fer = 300,
     guillemet = 301,
     guillemet_ap_g = 302,
     guillemet_ap_d = 303,
     mc_if = 304,
     mc_else = 305,
     mc_end = 306,
     mc_move = 307,
     mc_to = 308,
     cst_float = 309,
     cst_string = 310,
     cst_char = 311,
     cst_integer = 312
   };
#endif
/* Tokens.  */
#define mc_id_div 258
#define mc_program_id 259
#define mc_data_div 260
#define mc_working_storage 261
#define mc_pro_div 262
#define mc_stop_run 263
#define mc_integer 264
#define mc_float 265
#define mc_char 266
#define mc_string 267
#define mc_size 268
#define mc_line 269
#define mc_const 270
#define sep_bar 271
#define sep_2point 272
#define sep_point 273
#define aff 274
#define sep_par_ouv 275
#define sep_par_fer 276
#define sep_virgule 277
#define mc_add 278
#define mc_sub 279
#define mc_mul 280
#define mc_div 281
#define mc_and 282
#define mc_or 283
#define mc_not 284
#define mc_sup 285
#define mc_inf 286
#define mc_sup_eq 287
#define mc_inf_eq 288
#define mc_eq 289
#define mc_diff 290
#define mc_entree 291
#define mc_sortie 292
#define sigf_entier 293
#define sigf_float 294
#define sigf_string 295
#define sigf_char 296
#define mc_adr 297
#define idf 298
#define parenthese_ouv 299
#define parenthese_fer 300
#define guillemet 301
#define guillemet_ap_g 302
#define guillemet_ap_d 303
#define mc_if 304
#define mc_else 305
#define mc_end 306
#define mc_move 307
#define mc_to 308
#define cst_float 309
#define cst_string 310
#define cst_char 311
#define cst_integer 312




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 39 "syntaxique.y"
{
  int entier ; 
  char*  str ;
  float reel;
  char* chaine;
}
/* Line 1529 of yacc.c.  */
#line 170 "syntaxique.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

