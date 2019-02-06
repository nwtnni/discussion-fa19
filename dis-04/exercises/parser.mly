%{
  open Calculator
%}

%token <int> INT
%token LPAREN RPAREN ADD SUB MUL DIV
%token EOF JUNK

%start exp
%type <Calculator.exp> exp

%%

exp:
  | term EOF { $1 }
  ;

term:
  | term ADD factor { Bin ($1, Add, $3) }
  | term SUB factor { Bin ($1, Sub, $3) }
  | factor          { $1 }
  ;

factor:
  | factor MUL value { Bin ($1, Mul, $3) }
  | factor DIV value { Bin ($1, Div, $3) }
  | value            { $1 }
  ;

value:
  | INT                { Int $1 }
  | LPAREN term RPAREN { $2 }
  ;
