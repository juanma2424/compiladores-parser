/* JFlex example: partial Java language lexer specification */
package Analizadores;
import java_cup.runtime.*;
import java.util.ArrayList;
/**
    * This class is a simple example lexer.
    */
%%

%public 
%class Analizador_Lexico
%cupsym Symb
%cup
%char
%column
%full
%line
%unicode

%{
  StringBuffer string = new StringBuffer();
  StringBuffer stringN = new StringBuffer();
  public static int banderaN = 0;
  public static int bandera = 0;
  public static int bandera2 = 0;
  public static int bandera3 = 0;
  public static ArrayList<Token> tokens = new ArrayList<>();  
  public static ArrayList<Token> errores = new ArrayList<>();  

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

simbolos = "~" | ")" | "]" |"}"
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]
numbersH       = [0-9]+
lettersH       = [A-F]+
numberN        = [0-9]+ | "."([0-9]+)
L=[a-zA-Z_]+
D=[0-9]+
operadorTable = "!" | "&&"|"^" | "=="|"!="|"||"|"<="|"<" |">="|">" |"&"|"|"|"^"|
"~" | "+" |"-" | "*" |"/" |"%" |"**"| "<<" |">>"|"="|
"[" | "]" | "?"|":" |"{"|"}"|"+="|"-="|"*=" |"/="

/*************************************************************************************/
/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*
/*************************************************************************************/
//--------------------------NUEVO--NO--TOCA---CON--AMOR--JUANMA--11/07/2020-----------//
Identifier =  {L}({L}|{D})*// [:jletter:] [:jletterdigit:]*
numeroD =  [0-9]*(".")[0-9]+ | [0-9]+(".")
numeroEX = (  ( {numbersH} | {numeroD} )+ "e" ("-"|"") {numbersH} )

/*************************************[STATES]************************************************/
%state STRING
%state hexaState
%state hexaStateC
%state hexaStateError
%state hexaStateCError
%state numberState
%state NaturalNumbers
%state Chars
%state stateNosibol
%state filtro
%state otraMas
%%



/*************************************[PRINCIPALES]**********************************************/

/* keywords */
<YYINITIAL> "address" | "as" | "bool" | "break" | "byte" | "bytes"((3[0-2])|([1-2][0-9])|[1-9])? |
"constructor" | "continue" | "contract" | "delete" | "do" | "else" | "enum" | "false" | "for" | "from" | "function" |
"if" | "import" | "int"(256|128|64|32|16|8)? | "internal" | "mapping" | "modifier" | "payable" | "pragma" | "private" |
"public" | "return" | "returns" | "solidity" | "string" | "struct" | "this" | "true" | "ufixed" | "uint"(256|128|64|32|16|8)? |
"var" | "view" | "while" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}


/*************************************[TRANSAC ]**********************************************/

<YYINITIAL> "balance" | "call"| "callcode" | "delegatecall" | "send" | "transfer"
{ tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }



/*************************************[UNITS]**********************************************/
<YYINITIAL> "days" | "ether" | "finney" | "hours" | "minutes" | "seconds" | "szabo" | "weeks"| "wei"| "years"
{ tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }

<YYINITIAL> "hex"\" { string.setLength(0); 
                      string.append(yytext());
                      yybegin(hexaState);}                 
<YYINITIAL> "hex"\' { string.setLength(0); 
                      string.append(yytext());
                      yybegin(hexaStateC);}
<YYINITIAL> "hex" { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> {


/*************************************[  NUMEROS ]************************************************/
{numbersH}+ {Identifier}+  {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}
{numeroD}+ {Identifier}+  {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}
{numeroEX}+ {Identifier}+  {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}

// {numbersH} {tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero1"));} 
{numbersH} {return symbol(Symb.numero, yytext());} 

{numeroD}  {tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero"));} 

{numeroEX} {tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero"));}

(( {numbersH} | {numeroD})+ ("e")+ ("-"|"")* {numeroD})   {errores.add(new Token(yytext(), yyline, yycolumn, "Error: Numero"));}

/*************************************[  IDENTIFICADORES ]************************************************/
{Identifier}+ {operadorTable}+ {errores.add(new Token(yytext(), yyline, yycolumn, "Error Identificador"));}
{simbolos}+ {Identifier}+ {
  string.setLength(0);
  string.append(yytext());
  errores.add(new Token(string.toString(), yyline, yycolumn, "Error Decimal"));//WHY ERROR
  yybegin(YYINITIAL);
}

{Identifier} {
stringN.setLength(0);
string.setLength(0);
string.append(yytext());
stringN.append(yytext());
yybegin(filtro);
}

/*************************************[ OPERADORES ]************************************************/
\" { 
  string.setLength(0); yybegin(STRING); bandera = yycolumn;
}


\' { 
  string.setLength(0); yybegin(Chars); bandera = yycolumn;
}

"!"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"&&"  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"^"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"=="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"!="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"||"  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"&"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"|"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"^"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"~"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"+"   {return symbol(Symb.mas, yytext());}
"-"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"*"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"/"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"%"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"**"  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<<"  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">>"  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"="   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
","   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
";"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"."   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"("   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
")"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"["   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"]"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"?"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
":"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"{"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"}"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"+="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"-="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"*="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"/="  {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}

/*************************************[ comments ]************************************************/
/* comments */
{Comment} { /* ignore */ ;banderaN =0;}

/* whitespace */
{WhiteSpace} { /* ignore */ ;banderaN =0;}
//Aqui

/*************************************[ No simbolos ]************************************************/
[^A-Za-z0-9\n\r\f\t\!\&\^\=\|\<\>\~\+\-\*\/\%\,\;\.\(\)\[\]\?\:\{\}] {
     stringN.setLength(0);
     stringN.append(yytext());
     yybegin(stateNosibol);
   }
}
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////



/*************************************[ filtro ]************************************************/
<filtro>{    
  "!" | "&&"|"^" | "=="|"!="|"||"|"<="|"<" |">="|">" |"&"|"|"|"^"|
  "+" |"-" | "*" |"/" |"%" |"**"| "<<" |">>"|"="|"," |";"|"."|
  "(" | ")" |"[" | "]" | "?"|":" |"{"|"}"|"+="|"-="|"*=" |"/=" 
  {  
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Identificador"));
    tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
    yybegin(YYINITIAL);
  }

  {simbolos}  {string.append(yytext()) ;
              errores.add(new Token(string.toString(), yyline, yycolumn, "Error Identificador"));
              yybegin(YYINITIAL);}

  [^ A-Za-z0-9\n\r\f\t\!\&\^\=\|\<\>\~\+\-\*\/\%\,\;\.\(\)\[\]\?\:\{\} ]   {
    stringN.append(yytext());
    yybegin(stateNosibol);
  }


  [^]   {
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Identificador"));
    yybegin(YYINITIAL);
  }            

}


/*************************************[ No simbolos filtros ]************************************************/
<stateNosibol>{
   ("{" | "}" | "(" | ")" | ";" | "[" | "]" |"//" | ",")  {  
        tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));     
        errores.add(new Token(stringN.toString(), yyline, yycolumn, "Error: identificador"));
        yybegin(YYINITIAL);
  }
  ({WhiteSpace})  {   
        errores.add(new Token(stringN.toString(), yyline, yycolumn, "Error: identificador"));
        yybegin(YYINITIAL);
  }
  [^]  {stringN.append(yytext());yybegin(stateNosibol);}
}



/*************************************[ strings  ]************************************************/
<STRING> {
  \" {
    yybegin(YYINITIAL);
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Literal string"));
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
  }

  \' {
    string.append(yytext());
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error: comillas de cierre incorrectas"));
    yybegin(YYINITIAL);
  }

  ";" {
    tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); 
    errores.add(new Token("Comillas", yyline, yycolumn, "Error: hexadecimal sin cierre"));
    yybegin(YYINITIAL);
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
  }

  \" {
    string.append( yytext() ); 
    errores.add(new Token(string.toString(), yyline, yycolumn, "Error: comillas de cierre incorrectas"));
    yybegin(YYINITIAL);
  }

  ";" {
    tokens.add(new Token(yytext(), yyline, yycolumn, "Operador")); 
    errores.add(new Token("Comillas", yyline, yycolumn, "Error: hexadecimal sin cierre"));
    yybegin(YYINITIAL);
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