{
  open Parser
}

let digit = ['0'-'9']
let id = ['a'-'z'] ['a'-'z' '0'-'9' ''' '_']*

rule token = parse
  | '\n'        { Lexing.new_line lexbuf; token lexbuf }
  | "("         { LPAREN }
  | ")"         { RPAREN }
  | "let"       { LET }
  | "="         { EQ }
  | "+"         { ADD }
	| "-"         { SUB }
	| "*"         { MUL }
  | "/"         { DIV }
  | "and"       { AND }
  | "or"        { OR }
  | "print"     { PRINT }
  | "{"         { LBRACE }
  | "}"         { RBRACE }
  | "if"        { IF }
  | "else"      { ELSE }
  | id as v     { VAR(v) }
  | digit+ as n { INT(int_of_string n) }
  | "true"      { TRUE }
  | "false"     { FALSE }
  | eof         { EOF }
  | _           { token lexbuf }
