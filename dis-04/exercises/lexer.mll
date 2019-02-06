{
  open Parser
}

rule token = parse
  | [' ' '\t']        { token lexbuf }
  | ['0' - '9']+ as n { INT (int_of_string n) }
  | '+'               { ADD }
  | '-'               { SUB }
  | '*'               { MUL }
  | '/'               { DIV }
  | '('               { LPAREN }
  | ')'               { RPAREN }
  | eof               { EOF }
  | _                 { JUNK }
