package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import lyc.compiler.constants.Constants;
import javax.management.RuntimeErrorException;import static lyc.compiler.constants.Constants.*;

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

WhiteSpace = {LineTerminator} | {Identation}

Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"

Equal = "=="
NotEqual = "!="
LessEqual = "<="
GreaterEqual = ">="
Less = "<"
Greater = ">"

Assig = "="

OpenBracket = "("
CloseBracket = ")"

OpenCurlyBracket = "{"
CloseCurlyBracket = "}"

OpenSquareBracket = "["
CloseSquareBracket = "]"

Comma = ","
Colon = ":"

While = "while"
If = "if"
Else = "else"
Init = "init"
IntType = "int"
FloatType = "float"
StringType = "string"

Read = "read"
Write = "write"

And = "and"
Or = "or"
Not = "not"

ReorderFunction = "reorder"
NegativeCalculationFunction = "negativeCalculation"

Letter = [a-zA-Z]
Digit = [0-9]

Identifier = {Letter} ({Letter}|{Digit})*

IntegerConstant = 0 | [1-9]{Digit}*
FloatConstant = {Digit}\.{Digit}+ | {Digit}\. | \.{Digit}+
StringConstant = \"(.*)\"

Comment = "#+"[^*]~"+#"

%%

/* keywords */

<YYINITIAL> {
  /* Constants */
    {IntegerConstant}                       {
                                                String value = yytext();
                                                try {
                                                    Short.valueOf(value);
                                                } catch (NumberFormatException e){
                                                    // TODO I DON'T THINK IS A GOOD PRACTICE TO THROW A DIFFRENT TYPE OF ERROR
                                                    throw new InvalidIntegerException("Invalid integer: " + value) ;
                                                }
                                                return symbol(ParserSym.INTEGER_CONSTANT, value);
                                            }


  {FloatConstant}                           {
                                              String value = yytext();
                                              try {
                                                  Float f = Float.valueOf(value);
                                                  if (f.isNaN() || f.isInfinite())
                                                  {
                                                      throw new NumberFormatException("Invalid float: " + value);
                                                  }
                                              } catch (NumberFormatException e){
                                                  // TODO I DON'T THINK IS A GOOD PRACTICE TO THROW A DIFFRENT TYPE OF ERROR
                                                  throw new InvalidFloatException("Invalid float: " + value) ;
                                              }
                                              return symbol(ParserSym.FLOAT_CONSTANT, value);
                                            }

  {StringConstant}                          {
                                                if (yylength() > STRING_MAX_LENGTH){
                                                    throw new InvalidLengthException("String lenght is beyond maximum lenght for: " + yytext());
                                                } else {
                                                    return symbol(ParserSym.STRING_CONSTANT, yytext());
                                                }
                                            }

  /* operators */
  {Plus}                                    { return symbol(ParserSym.PLUS); }
  {Sub}                                     { return symbol(ParserSym.SUB); }
  {Mult}                                    { return symbol(ParserSym.MULT); }
  {Div}                                     { return symbol(ParserSym.DIV); }

  {Equal}                                   { return symbol(ParserSym.EQUAL); }
  {NotEqual}                                { return symbol(ParserSym.NOT_EQUAL); }
  {LessEqual}                               { return symbol(ParserSym.LESS_EQUAL); }
  {GreaterEqual}                            { return symbol(ParserSym.GREATER_EQUAL); }
  {Less}                                    { return symbol(ParserSym.LESS); }
  {Greater}                                 { return symbol(ParserSym.GREATER); }

  {Assig}                                   { return symbol(ParserSym.ASSIG); }

  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }

  {OpenCurlyBracket}                        { return symbol(ParserSym.OPEN_CURLY_BRACKET); }
  {CloseCurlyBracket}                       { return symbol(ParserSym.CLOSE_CURLY_BRACKET); }

  {OpenSquareBracket}                       { return symbol(ParserSym.OPEN_SQUARE_BRACKET); }
  {CloseSquareBracket}                      { return symbol(ParserSym.CLOSE_SQUARE_BRACKET); }

  {Comma}                                   { return symbol(ParserSym.COMMA); }
  {Colon}                                   { return symbol(ParserSym.COLON); }

  {While}                                   { return symbol(ParserSym.WHILE); }
  {If}                                      { return symbol(ParserSym.IF); }
  {Else}                                    { return symbol(ParserSym.ELSE); }
  {Init}                                    { return symbol(ParserSym.INIT); }
  {IntType}                                 { return symbol(ParserSym.TYPE_INT); }
  {FloatType}                               { return symbol(ParserSym.TYPE_FLOAT); }
  {StringType}                              { return symbol(ParserSym.TYPE_STRING); }

  {And}                                     { return symbol(ParserSym.AND); }
  {Or}                                      { return symbol(ParserSym.OR); }
  {Not}                                     { return symbol(ParserSym.NOT); }

  {Read}                                    { return symbol(ParserSym.READ); }
  {Write}                                   { return symbol(ParserSym.WRITE); }

  {ReorderFunction}                         { return symbol(ParserSym.REORDER_FUNCTION); }
  {NegativeCalculationFunction}             { return symbol(ParserSym.NEGATIVE_CALCULATION_FUNCTION); }

  /* identifiers */
  {Identifier}                              { return symbol(ParserSym.IDENTIFIER, yytext()); }

  /* whitespace */
  {WhiteSpace}                              { /* ignore */ }

  {Comment}                                 { /* ignore */ }
}

/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
