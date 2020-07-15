/* JFlex example: partial Java language lexer specification */
import java.util.ArrayList;
/**
    * This class is a simple example lexer.
    */
%%
%public      //NUEVO
%cupsym Symb //NUEVO
%cup         //NUEVO
%char        //NUEVO
%full        //NUEVO
%class Lexer
%unicode
%standalone
%line
%column


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
%state Chars
%state hexaState
%state hexaStateC
%state hexaStateError
%state hexaStateCError
%state stateNosibol
%state filtro
%state operator
%%



/*************************************[PRINCIPALES]**********************************************/

/* keywords */
<YYINITIAL> "address"{ return symbol(Symb.address, yytext());            tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "as"     { return symbol(Symb.as, yytext());                 tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "bool"   { return symbol(Symb.bool, yytext());               tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "break"  { return symbol(Symb.break, yytext());              tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "byte"   { return symbol(Symb.byte, yytext());               tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "bytes"((3[0-2])|([1-2][0-9])|[1-9])?  { return symbol(Symb.bytes, yytext());  tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "constructor"{ return symbol(Symb.constructor, yytext());    tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "continue"   { return symbol(Symb.continue, yytext());       tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "contract"   { return symbol(Symb.contract, yytext());       tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "delete"     { return symbol(Symb.delete, yytext());         tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "do"         { return symbol(Symb.do, yytext());             tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "else"       { return symbol(Symb.else, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "enum"       { return symbol(Symb.enum, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "false"      { return symbol(Symb.false, yytext());          tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "for"        { return symbol(Symb.for, yytext());            tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "from"       { return symbol(Symb.from, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "function"   { return symbol(Symb.function, yytext());       tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "if"         { return symbol(Symb.if, yytext());             tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "import"     { return symbol(Symb.import, yytext());         tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "int"(256|128|64|32|16|8)?  {return symbol(Symb.int, yytext());  tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "internal" { return symbol(Symb.internal, yytext());         tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "mapping"  { return symbol(Symb.mapping, yytext());          tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "modifier" { return symbol(Symb.modifier, yytext());         tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "payable"  { return symbol(Symb.payable, yytext());          tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL>  "pragma"  { return symbol(Symb.pragma, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL>  "private" { return symbol(Symb.private, yytext());          tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "public"   { return symbol(Symb.public yytext());            tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "return"   { return symbol(Symb.return, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "returns"  { return symbol(Symb.returns, yytext());          tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "string"   { return symbol(Symb.string, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "struct"   { return symbol(Symb.struct, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "this"     { return symbol(Symb.this, yytext());             tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "true"     { return symbol(Symb.true, yytext());             tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "ufixed"   { return symbol(Symb.ufixed, yytext());           tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL>  "uint"(256|128|64|32|16|8)?  { tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}

<YYINITIAL> "solidity" { return symbol(Symb.solidity, yytext());         tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL> "view"     { return symbol(Symb.view, yytext());             tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL>  "var"     { return symbol(Symb.var, yytext());              tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}
<YYINITIAL>  "while"   { return symbol(Symb.while, yytext());            tokens.add(new Token(yytext().trim(), yyline, yycolumn, "Palabra reservada"));}


/*************************************[TRANSAC ]**********************************************/
<YYINITIAL> "balance"      { return symbol(Symb.balance, yytext());                tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "call"         { return symbol(Symb.call, yytext());                   tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "callcode"     { return symbol(Symb.callcode, yytext());               tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "delegatecall" { return symbol(Symb.delegatecall, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL>  "send"        { return symbol(Symb.send, yytext());                   tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }
<YYINITIAL> "transfer"     { return symbol(Symb.transfer, yytext());               tokens.add(new Token(yytext(), yyline, yycolumn, "Transac")); }


/*************************************[UNITS]**********************************************/
<YYINITIAL> "days"       { return symbol(Symb.days, yytext());              tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "finney"     { return symbol(Symb.finney, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "hours"      { return symbol(Symb.hours, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL>  "minutes"   { return symbol(Symb.minutes, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "seconds"    { return symbol(Symb.seconds, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "szabo"      { return symbol(Symb.szabo, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "weeks"      { return symbol(Symb.weeks, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "wei"        { return symbol(Symb.wei, yytext());               tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }
<YYINITIAL> "years"      { return symbol(Symb.years, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Units")); }



/*************************************[HEX]**********************************************/
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

{numbersH} { return symbol(Symb.numeroN, yytext());      tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero"));} 
{numeroD}  { return symbol(Symb.numeroD, yytext());      tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero"));} 
{numeroEX} { return symbol(Symb.numeroEXP, yytext());    tokens.add(new Token(yytext(), yyline, yycolumn, "Literal: Numero"));}

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

"!"   { return symbol(Symb.dif, yytext());              tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"&&"  { return symbol(Symb.andD, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"^"   { return symbol(Symb.techo, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"=="  { return symbol(Symb.igualD, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"!="  { return symbol(Symb.difIgual, yytext());         tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"||"  { return symbol(Symb.oD, yytext());               tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<="  { return symbol(Symb.menorI, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<"   { return symbol(Symb.menor, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">="  { return symbol(Symb.mayorI, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">"   { return symbol(Symb.mayor, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"&"   { return symbol(Symb.and, yytext());              tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"|"   { return symbol(Symb.o, yytext());              tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"^"   {tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}//REPETIDO????
"~"   {return symbol(Symb.techoT, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"+"   { return symbol(Symb.mas, yytext());              tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"-"   { return symbol(Symb.menos, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"*"   { return symbol(Symb.asterisco, yytext());        tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"/"   { return symbol(Symb.div, yytext());              tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"%"   { return symbol(Symb.porcentaje, yytext());       tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"**"  { return symbol(Symb.asteriscoD, yytext());       tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"<<"  { return symbol(Symb.menorD, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
">>"  { return symbol(Symb.mayorD, yytext());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"="   { return symbol(Symb.igual, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
","   { return symbol(Symb.coma, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
";"   { return symbol(Symb.puntoComa, yytext());        tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"."   { return symbol(Symb.punto, yytext());            tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"("   { return symbol(Symb.parentesisA, yytext());      tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
")"   { return symbol(Symb.parentesisB, yytext());      tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"["   { return symbol(Symb.parentesisCA, yytext());     tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"]"   { return symbol(Symb.parentesisCB, yytext());     tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"?"   { return symbol(Symb.preg, yytext());        tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
":"   { return symbol(Symb.dosP, yytext());             tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"{"   { return symbol(Symb.corcheteA, yytext());        tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"}"   { return symbol(Symb.corcheteB, yytext());        tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"+="  { return symbol(Symb.masIgual, yytext());         tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"-="  { return symbol(Symb.menosIgual, yytext());       tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"*="  { return symbol(Symb.asteriscoIgual, yytext());   tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}
"/="  { return symbol(Symb.divIgual, yytext());         tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));}

//corchete

/*************************************[ comments ]************************************************/
/* comments */
{Comment} { /* ignore */}

/* whitespace */
{WhiteSpace} { /* ignore */}



/*************************************[ No simbolos ]************************************************/
[^A-Za-z0-9\n\r\f\t\!\&\^\=\|\<\>\~\+\-\*\/\%\,\;\.\(\)\[\]\?\:\{\}] {
     stringN.setLength(0);
     stringN.append(yytext());
     yybegin(stateNosibol);
   }
}



/*************************************[ operator ]************************************************/
<operator>{
  [^]  {
if (string.toString().equals("!"))        return symbol(Symb.dif,   string.toString());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
if (string.toString().equals("&&"))       return symbol(Symb.andD,  string.toString());           tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals("^"))        return symbol(Symb.techo, string.toString());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
if (string.toString().equals("=="))       return symbol(Symb.igualD, string.toString());          tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals("!="))       return symbol(Symb.difIgual,string.toString());         tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "||"))      return symbol(Symb.oD, string.toString());              tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals("<="))       return symbol(Symb.menorI,string.toString());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "<" ))      return symbol(Symb.menor,string.toString());            tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals(">="))       return symbol(Symb.mayorI,string.toString());           tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
if (string.toString().equals(">"))        return symbol(Symb.mayor, string.toString());           tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals("&" ))       return symbol(Symb.and,string.toString());              tokens.add(new Token(yytext(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "|"))       return symbol(Symb.o, string.toString());               tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "~"))       return symbol(Symb.techoT,string.toString());           tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "+" ))      return symbol(Symb.mas, string.toString());             tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "-" ))      return symbol(Symb.menos,string.toString());            tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "*" ))      return symbol(Symb.asterisco,string.toString());        tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "/"))       return symbol(Symb.div,string.toString());              tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "%" ))      return symbol(Symb.porcentaje,string.toString());       tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "**"))      return symbol(Symb.asteriscoD,string.toString());       tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals("<<"))       return symbol(Symb.menorD,string.toString());           tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( ">>"))      return symbol(Symb.mayorD,string.toString());           tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "="))       return symbol(Symb.igual,string.toString());            tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( ","))       return symbol(Symb.coma,string.toString());             tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( ";"))       return symbol(Symb.puntoComa,string.toString());        tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "."))       return symbol(Symb.punto,string.toString());            tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "("))       return symbol(Symb.parentesisA,string.toString());      tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( ")"))       return symbol(Symb.parentesisB,string.toString());      tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "["))       return symbol(Symb.parentesisCA,string.toString());     tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "]"))       return symbol(Symb.parentesisCB,string.toString());     tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "?"))       return symbol(Symb.preg,string.toString());             tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( ":"))       return symbol(Symb.dosP,string.toString());             tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "{"))       return symbol(Symb.corcheteA,string.toString());        tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "}"))       return symbol(Symb.corcheteB,string.toString());        tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "+="))      return symbol(Symb.masIgual,string.toString());         tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "-="))      return symbol(Symb.menosIgual,string.toString());       tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "*="))      return symbol(Symb.asteriscoIgual,string.toString());   tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
if (string.toString().equals( "/="))      return symbol(Symb.divIgual, string.toString());        tokens.add(new Token(string.toString(), yyline, yycolumn, "Operador"));
yybegin(YYINITIAL);}
} 


/*************************************[ filtro ]************************************************/
<filtro>{    
  "!" | "&&"|"^" | "=="|"!="|"||"|"<="|"<" |">="|">" |"&"|"|"|"^"|
  "+" |"-" | "*" |"/" |"%" |"**"| "<<" |">>"|"="|"," |";"|"."|
  "(" | ")" |"[" | "]" | "?"|":" |"{"|"}"|"+="|"-="|"*=" |"/=" 
  {         
    return symbol(Symb.ID, yytext());  //OJO AQUI
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Identificador"));
    string.setLength(0);
    string.append(yytext());
    yybegin(operator);
  }

  {simbolos}  {string.append(yytext()) ;
              errores.add(new Token(string.toString(), yyline, yycolumn, "Error Identificador"));
              yybegin(YYINITIAL);}

  [^ A-Za-z0-9\n\r\f\t\!\&\^\=\|\<\>\~\+\-\*\/\%\,\;\.\(\)\[\]\?\:\{\} ]   {
    stringN.append(yytext());
    yybegin(stateNosibol);
  }

  [^]   {
    return symbol(Symb.ID, yytext());  //OJO AQUI
    tokens.add(new Token(string.toString(), yyline, yycolumn, "Identificador"));
    yybegin(YYINITIAL);
  }            

}

/*************************************[ No simbolos filtros ]************************************************/
<stateNosibol>{
   ("{" | "}" | "(" | ")" | ";" | "[" | "]" |"//" | ",")  {      
        errores.add(new Token(stringN.toString(), yyline, yycolumn, "Error: identificador"));
        string.setLength(0);
        string.append(yytext());
         yybegin(operator);
        
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
    return symbol(Symb.cadena, yytext());  
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
    return symbol(Symb.numhex, yytext());  
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
    return symbol(Symb.puntoComa, yytext());  
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
    return symbol(Symb.numhexc, yytext());
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
    return symbol(Symb.puntoComa, yytext());  
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