import java_cup.runtime.*;

      
%%
   
%class MyLexer

%line
%column
    
%cup
   
%{   

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   

//LineTerminator = \r|\n|\r\n
   
//WHISTESPACESpace     = {LineTerminator} | [ \t\f]
space = " "
tab= "  "
WHISTESPACE = \t|\r|\n|\f|{space}
/*NameStart     =  [:jletter:] | "_" | ":" //<- tag może zaczynać się takim znakiem
NameChar      =  [:jletter:] | [:jletterdigit:] | "." | "-" | "_" | ":" //dopuszczalne znaki w nazwie tagu
Name = {NameStart} {NameChar}* //nazwa tagu
STAG = "<"{Name} {WHISTESPACE}? ">" //otwierajacy
TEKST = [a-z]*
TRESC = {TEKST}
ETAG =  "</"{Name} {WHISTESPACE}? ">" //zamykajacy
xmlElement = {STAG}{TEKST}{ETAG}
SNTAG = {STAG}{WHISTESPACE}*{STAG}
DSTAG =  {STAG}{STAG}**/

NAGLOWEK = <\?xml.*  
TEMP = "<banan>"
NTEXT = [a-z | A-Z]+
TEXT = [.*]+
TAG_START = "<"{NCONTEXT}">"

%%

/* ------------------------Lexical Rules Section---------------------- */
      
<YYINITIAL> {

{WHISTESPACE}      	{  }

/*
{SNTAG}            {System.out.print(""+yytext().replace(">", "\":").replace("<", "\""));}
{STAG}             {System.out.print(""+yytext().replace("<", "\"").replace(">", "\": "));}}
{TEKST}            {System.out.println("\""+yytext()+"\"");}
{ETAG}             {}//System.out.println("}");}
{DSTAG}            {}//System.out.println("STag="+yytext().replace("<", "\"").replace(">", "\": {"));}
{xmlElement}       {}//System.out.println("SNTag="+yytext().replaceFirst("(</[a-z]*)", "").replace("<", "\"").replace(">", ":\""));}
*/

{TEMP}              { return symbol(sym.TEMP,        new String("pomarancza\n")); }
{NAGLOWEK}          { return symbol(sym.NAGLOWEK,    new String("{\n")); }
"<"                 { return symbol(sym.DZIOBL,      new String("")); }
">"                 { return symbol(sym.DZIOBP,      new String("")); }
"</"                { return symbol(sym.DZIOBLC,     new String("")); }
{NTEXT}             { return symbol(sym.NTEKST,      new String(yytext())); }
{TEXT}              { return symbol(sym.TEKST,       new String(yytext())); }

}

[^]   { throw new Error("Nieoczekiwany znak <"+yytext()+">"); }

//(<\?xml.*)