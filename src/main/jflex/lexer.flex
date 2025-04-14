package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identation =  [ \t\f]

Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"

Assig = "="

OpenBracket = "("
CloseBracket = ")"

OpenCurlyBracket = "{"
CloseCurlyBracket = "}"

OpenSquareBracket = "["
CloseSquareBracket = "]"

Comma = ","
Colon = ":"


Letter = [a-zA-Z]
Digit = [0-9]
Float = {Digit}+"."{Digit}+ | {Digit}+"." | "."{Digit}+
//String = \".*\"
// REVISAR
String = \"[^*]~\"


WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*
IntegerConstant = {Digit}+

Comment = "#+"[^*]~"+#"

%%


/* keywords */

<YYINITIAL> {
  /* identifiers */
  {Identifier}                             { return symbol(ParserSym.IDENTIFIER, yytext()); }
  /* Constants */
  {IntegerConstant}                        { return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }

  /* operators */
  {Plus}                                    { return symbol(ParserSym.PLUS); }
  {Sub}                                     { return symbol(ParserSym.SUB); }
  {Mult}                                    { return symbol(ParserSym.MULT); }
  {Div}                                     { return symbol(ParserSym.DIV); }

  {Assig}                                   { return symbol(ParserSym.ASSIG); }

  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }

  {OpenCurlyBracket}                        { return symbol(ParserSym.OPEN_CURLY_BRACKET); }
  {CloseCurlyBracket}                       { return symbol(ParserSym.CLOSE_CURLY_BRACKET); }

  {OpenSquareBracket}                        { return symbol(ParserSym.OPEN_SQUARE_BRACKET); }
  {CloseSquareBracket}                       { return symbol(ParserSym.CLOSE_SQUARE_BRACKET); }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  {Comment}                      { /* ignore */ }

  /* WHILE */

  /* Comparadores */

  /* IF / IF - ELSE*/

  /* INIT FLOAT STRING INT*/

  /* AND OR NOT */

  /* READ WRITE*/

  /* REORDER */

  /* NEGATIVE CALCULATION */

}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
