/* JFlex example: partial Java language lexer specification */
package Analizadores;
import java.util.ArrayList;
import java_cup.runtime.*;
/**
    * This class is a simple example lexer.
    */
%%
%public      
%cupsym Symb 
%cup         
%char        
%full        
%class Lexer
%unicode
%standalone
%line
%column


%{
    StringBuffer string = new StringBuffer();
    public static int bandera = 0;
    public static ArrayList<Token> tokens = new ArrayList<>();  
    public static ArrayList<Token> errores = new ArrayList<>();

    private Symbol symbol(int type) {
      return new Symbol(type, yyline, yycolumn);
    }
     private Symbol symbol(int type, Object value) {
       System.out.println(value + ", " + String.valueOf(type));
      return new Symbol(type, yyline, yycolumn, value);
    }

%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]
numbersH       = [0-9]+
lettersH       = [A-F]+
numberN        = [0-9]+ | "."([0-9]+)
L=[a-zA-Z_]+
D=[0-9]+

operadorTable = "!" | "&&"|"^" | "=="|"!="|"||"|"<="|"<" |">="|">" |"&"|"|"|"^"| 
                 "~" | "+" |"-" | "" |"/" |"%" |"*"| "<<" |">>"|"="|
                 "[" | "]" | "?"|":" |"{"|"}"|"+="|"-="|"*=" |"/="

operadorTableD = "&&"|"=="|"!="|"||"|"<="|"<"|">="|">"| 
                 "+"|"-"|"%"|"="|","|";"|"."|"("|")"|
                 "["|"]"|"?"|"{"|"}"|"+="|"-="

operadorTableI = "&&"|"=="|"!="|"||"|"<="|"<"|">="|">"| 
                 "+"|"-"|"*"|"%"|"="|","|";"|"."|"("|")"|
                 "["|"]"|"?"|"{"|"}"|"+="|"-="

operadorTableX = "^"|"&"|"^"|"~"|"*"|"/="|"<<"|">>"|"/"|"ñ"|"Ñ"|"%"

/*********************************[ COMENTARIOS ]*************************************/
/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*


/*******************************[ IDENTIFICADOR , NUM ]**************************************/
Identifier =  {L}({L}|{D})*
numeroD =  [0-9]*(".")[0-9]+ | [0-9]+(".")
numeroEX = (  ( {numbersH} | {numeroD} )+ "e" ("-"|"") {numbersH} )


/*************************************[STATES]************************************************/
%state STRING
%state Chars
%state hexaState
%state hexaStateC
%state hexaStateError
%state hexaStateCError
%%

/*************************************[PRINCIPALES]**********************************************/

<YYINITIAL> "address" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.address, yytext());}
<YYINITIAL> "as"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "bool"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.bool, yytext());}
<YYINITIAL> "break"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.breakSoli, yytext());}
<YYINITIAL> "byte"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.byteSoli, yytext());}

<YYINITIAL>"bytes1"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_I, yytext());}
<YYINITIAL>"bytes2"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_II, yytext());}
<YYINITIAL>"bytes3"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_III, yytext());}
<YYINITIAL>"bytes4"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_IV, yytext());}
<YYINITIAL>"bytes5"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_V, yytext());}

<YYINITIAL>"bytes6"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_VI, yytext());}
<YYINITIAL>"bytes7"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_VII, yytext());}
<YYINITIAL>"bytes8"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_IIX, yytext());}
<YYINITIAL>"bytes9"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_IX, yytext());}
<YYINITIAL>"bytes10" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_X, yytext());}

<YYINITIAL>"bytes11" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XI, yytext());}
<YYINITIAL>"bytes12" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XII, yytext());}
<YYINITIAL>"bytes13" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XIII, yytext());}
<YYINITIAL>"bytes14" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XIV, yytext());}
<YYINITIAL>"bytes15" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XV, yytext());}

<YYINITIAL>"bytes16" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XVI, yytext());}
<YYINITIAL>"bytes17" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XVII, yytext());}
<YYINITIAL>"bytes18" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XIIX, yytext());}
<YYINITIAL>"bytes19" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XIX, yytext());}
<YYINITIAL>"bytes20" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XX, yytext());}

<YYINITIAL>"bytes21" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXI, yytext());}
<YYINITIAL>"bytes22" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXII, yytext());}
<YYINITIAL>"bytes23" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXIII, yytext());}
<YYINITIAL>"bytes24" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXIV, yytext());}
<YYINITIAL>"bytes25" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXV, yytext());}

<YYINITIAL>"bytes26" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXVI, yytext());}
<YYINITIAL>"bytes27" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXVII, yytext());}
<YYINITIAL>"bytes28" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXIIX, yytext());}
<YYINITIAL>"bytes29" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXIX, yytext());}

<YYINITIAL>"bytes30" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXX, yytext());}
<YYINITIAL>"bytes31" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXXI, yytext());}
<YYINITIAL>"bytes32" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.B_XXXII, yytext());}

<YYINITIAL> "constructor" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "continue"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.continueSoli, yytext());}
<YYINITIAL> "contract"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.contract, yytext());}
<YYINITIAL> "delete"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "do"         { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.doSoli, yytext());}
<YYINITIAL> "else"       { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.elseSoli, yytext());}
<YYINITIAL> "enum"       { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.enumSoli, yytext());}
<YYINITIAL> "false"      { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.falseSoli, yytext());}
<YYINITIAL> "for"        { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.forSoli, yytext());}
<YYINITIAL> "from"       { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "function"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.functionSoli, yytext());}
<YYINITIAL> "if"         { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.ifSoli, yytext());}
<YYINITIAL> "import"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "int"        { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.intSoli, yytext());}
<YYINITIAL> "int8"       { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.int_O, yytext());}
<YYINITIAL> "int16"      { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.int_DS, yytext());}
<YYINITIAL> "int32"      { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.int_TD , yytext());}
<YYINITIAL> "int64"      { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.int_SC, yytext());}
<YYINITIAL> "int128"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.int_CVO, yytext());}
<YYINITIAL> "int256"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.int_DCS, yytext());}

<YYINITIAL> "internal"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.internalSoli, yytext());}
<YYINITIAL> "mapping"    { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "modifier"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "payable"    { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.payableSoli, yytext());}
<YYINITIAL>  "pragma"    { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.pragma, yytext());}
<YYINITIAL>  "private"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.privateSoli, yytext());}

<YYINITIAL> "public"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.publicSoli, yytext());}
<YYINITIAL> "return"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.returnSoli, yytext());}
<YYINITIAL> "returns"    { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.returns, yytext());}
<YYINITIAL> "string"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.string, yytext());}
<YYINITIAL> "struct"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.structSoli, yytext());}
<YYINITIAL> "this"       { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.thisSoli, yytext());}
<YYINITIAL> "true"       { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.trueSoli, yytext());}
<YYINITIAL> "ufixed"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));return symbol(Symb.ufixedSoli, yytext());}

<YYINITIAL>  "uint"      { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint, yytext());}
<YYINITIAL>  "uint8"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint_O, yytext());}
<YYINITIAL>  "uint16" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint_DS, yytext());}
<YYINITIAL>  "uint32" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint_TD , yytext());}
<YYINITIAL>  "uint64" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint_SC, yytext());}
<YYINITIAL>  "uint128"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint_CVO, yytext());}
<YYINITIAL>  "uint256"  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.uint_DCS, yytext());}

<YYINITIAL> "solidity" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.solidity, yytext());}
<YYINITIAL> "view"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL>  "var"     { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL>  "while"   { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada")); return symbol(Symb.whileSoli, yytext());}


/*************************************[TRANSAC ]**********************************************/
<YYINITIAL> "balance"      { tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "call"         { tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "callcode"     { tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "delegatecall" { tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL>  "send"        { tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "transfer"     { tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }


/*************************************[UNITS]**********************************************/
<YYINITIAL> "days"       { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "finney"     { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "hours"      { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL>  "minutes"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "seconds"    { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "szabo"      { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "weeks"      { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "wei"        { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "years"      { tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }



/*************************************[HEX]**********************************************/
<YYINITIAL> "hex"\" { string.setLength(0); 
                      string.append(yytext());
                      yybegin(hexaState);}                 
<YYINITIAL> "hex"\' { string.setLength(0); 
                      string.append(yytext());
                      yybegin(hexaStateC);}
<YYINITIAL> "hex"  {  tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}



<YYINITIAL> {


/*************************************[  NUMEROS ]************************************************/
{numbersH}+ {Identifier}+ {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}
{numeroD}+ {Identifier}+  {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}
{numeroEX}+ {Identifier}+  {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}
{numbersH} { tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero")); return symbol(Symb.numero, yytext()); } 
{numeroD}  { tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero")); return symbol(Symb.numero, yytext()); } 
{numeroEX} { tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero")); return symbol(Symb.numero, yytext()); }
(( {numbersH} | {numeroD})+ ("e")+ ("-"|"")* {numeroD})   {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}



/*************************************[  IDENTIFICADORES ]************************************************/
{operadorTableX}+ {Identifier}+ | {operadorTableX}+ {Identifier}+ {operadorTableX}+ | {Identifier}+{operadorTableX}+  {errores.add(new Token(yytext(), yyline, yycolumn, "Error: identificador"));}
{operadorTableX}+ {Identifier}+ {operadorTableX}+ {Identifier}* {errores.add(new Token(yytext(), yyline, yycolumn, "Error: identificador"));}
{Identifier}+ {operadorTableX}+ {Identifier} {errores.add(new Token(yytext(), yyline, yycolumn, "Error: identificador"));}
{Identifier}+ {operadorTableX}+ {Identifier}+ {errores.add(new Token(yytext(), yyline, yycolumn, "Error: identificador"));}
{Identifier} { tokens.add(new Token(yytext(), yyline, yycolumn, "Identificador")); return symbol(Symb.ident,yytext()); }


/*************************************[ OPERADORES ]************************************************/
\" { 
  string.setLength(0); yybegin(STRING); bandera = yycolumn;
}

\' { 
  string.setLength(0); yybegin(Chars); bandera = yycolumn;
}

"!"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.negacion, yytext());           }
"&&"  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.op_and, yytext());             }
"^"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.techo, yytext());              }
"=="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.igual_igual, yytext());        }
"!="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.diferente, yytext());          }
"||"  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.op_or, yytext());              }
"<="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.menor_igual, yytext());        }
"<"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.menor, yytext());              }
">="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.mayor_igual, yytext());        }
">"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));  return symbol(Symb.mayor, yytext());              }
"&"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"|"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"~"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"+"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.mas, yytext());              }
"-"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.menos, yytext());            }
"*"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.por, yytext());              }
"/"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.div, yytext());              }
"%"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.porcentaje, yytext());       }
"**"  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<<"  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">>"  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"="   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.igual, yytext());             }
","   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.coma, yytext());              }
";"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.punto_coma, yytext());        }
"."   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.punto, yytext());             }
"("   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.O_Parent_R, yytext());        }
")"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.C_Parent_R, yytext());        }
"["   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.O_Parent_C , yytext());       }
"]"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.C_Parent_C, yytext());        }
"?"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.interrogacion_C, yytext());   }
":"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.punto_punto, yytext());       }
"{"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.O_Parent_L , yytext());       }
"}"   { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.C_Parent_L, yytext());        }
"+="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.mas_igual, yytext());         }
"-="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.menos_igual, yytext());       }
"*="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.por_igual, yytext());         }
"/="  { tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); return symbol(Symb.div_igual, yytext());         }

//corchete

/*************************************[ COMENTARIOS ]************************************************/
/* comments */
{Comment} { /* ignore */}

/* whitespace */
{WhiteSpace} { /* ignore */}



/*************************************[ NO SIMBOLOS ]************************************************/
{Identifier}* [^ A-Za-z0-9\n\r\f\t\!\&\^\=\|\<\>\~\+\-\/\%\,\;\.\(\)\[\]\?\:\{\} ]+  {Identifier}*  {
    errores.add(new Token(yytext(), yyline, yycolumn, "Error: identificador 4"));
  }

}

/*************************************[ STRINGS  ]************************************************/
<STRING> {
  \" {
    yybegin(YYINITIAL);
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Literal string"));
    return symbol(Symb.stringSoli, yytext());  
  }

  {LineTerminator} { 
    errores.add(new Token(string.toString(), yyline, bandera, "Error stringASAD"));
    yybegin(YYINITIAL);
  }
    
  [^\n\r\"\']+ { 
    string.append( yytext() );  
  }
    
  [^] {
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error string"));
    yybegin(YYINITIAL);
  }
}

/*************************************[ chars ]************************************************/
<Chars> {
  \' {
    yybegin(YYINITIAL);
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Literal char"));
    return symbol(Symb.charss, yytext());  
  }

  {LineTerminator} { 
    string.append( yytext() );
    errores.add(new Token(string.toString(), yyline, bandera, "Error char"));
    yybegin(YYINITIAL);
  }

  [^\n\r\"\']+ {
    string.append( yytext() );
  }

  [^] {
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error char"));
    yybegin(YYINITIAL);
  }
}

/*************************************[ hexa ]************************************************/
<hexaState> {
  \" { 
    yybegin(YYINITIAL);
    string.append( yytext() ); 
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Literal hexadecimal/Palabra Reservada")); 
    return symbol(Symb.numero, yytext());  
  }

  \' {
    string.append(yytext());
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error: comillas de cierre incorrectas"));
    yybegin(YYINITIAL);
  }


/////////////////////////////////////////////////////////// OJO//////////////////////////////DUDA
  ";" {
    tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); 
    errores.add(new Token("Comillas", yyline, yycolumn, "Error: hexadecimal sin cierre"));
    yybegin(YYINITIAL);
    return symbol(Symb.punto_coma, yytext());  
  }

  {lettersH} {
    string.append( yytext() );
  }

  {numbersH} {
    string.append( yytext() ); 
  }

  [^A-F0-9\;\"\'] {
    string.append(yytext());
    yybegin(hexaStateError);
  }
}

/*************************************[ hexa error ]************************************************/
<hexaStateError> {
  {WhiteSpace}   { yybegin(YYINITIAL); errores.add(new Token(string.toString(), yyline, yycolumn, "Error: Numero no es hexadecimal")); }
  \" | \; { 
    yybegin(YYINITIAL);
    string.append(yytext());
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error: Numero no es hexadecimal"));
  }

  [^] {
    string.append(yytext());
  }
}

/*************************************[ hexa comillas simples ]************************************************/
<hexaStateC> {
  \' {
    yybegin(YYINITIAL);
    string.append( yytext() ); 
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Literal hexadecimal/Palabra Reservada")); 
    return symbol(Symb.numero, yytext());
  }

  \" {
    string.append( yytext() ); 
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error: comillas de cierre incorrectas"));
    yybegin(YYINITIAL);
  }


/////////////////////////////////////////////////////////////////////ojo
  ";" {
    tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); 
    errores.add(new Token("Comillas", yyline, yycolumn, "Error: hexadecimal sin cierre"));
    yybegin(YYINITIAL);
    return symbol(Symb.punto_coma, yytext());  
  }

  {lettersH} { 
    string.append( yytext() ); 
  }

  {numbersH} {
    string.append( yytext() ); 
  }

  [^A-F0-9\;\'\"] {
    string.append(yytext());
    yybegin(hexaStateCError);
  }
}
/*************************************[ hexa error  ]************************************************/
<hexaStateCError> { 
  \' | \; { 
    yybegin(YYINITIAL);
    string.append(yytext());
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error: Numero no es hexadecimal"));
  }

  [^] {
    string.append(yytext());
  }
}

/************************************[ error fallback ]************************************************/
[^] {
  System.out.println(yyline);
  System.out.println(yycolumn); 
  // throw new Error("Illegal character <"+ yytext()+">"); 
}