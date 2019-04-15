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
<<<<<<< HEAD
  | "and"       { AND }
  | "or"        { OR }
=======
>>>>>>> bc04b8b171df0f4cd1e3d7cb5d710b14fd2b54c2
  | "print"     { PRINT }
  | "{"         { LBRACE }
  | "}"         { RBRACE }
  | "if"        { IF }
  | "else"      { ELSE }
  | id as v     { VAR(v) }
  | digit+ as n { INT(int_of_string n) }
<<<<<<< HEAD
  | "true"      { TRUE }
  | "false"     { FALSE }
=======
>>>>>>> bc04b8b171df0f4cd1e3d7cb5d710b14fd2b54c2
  | eof         { EOF }
  | _           { token lexbuf }
