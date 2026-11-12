type binop =
    | Add | Sub | Mul | Div
    | Eq | Neq | Lt | Le | Gt | Ge
    | And | Or

type unop =
    | Neg
    | Not

type mutability =
    | Immutable
    | Mutable

type expr =
    | Int of int
    | Bool of bool
    | Var of string

    | BinOp of binop * expr * expr
    | UnOp of unop * expr

    | If of expr * expr * expr
    | Let of mutability * string * expr * expr

    | Lambda of string * expr
    | Apply of expr * expr

    | Block of expr list

type declaration =
    | ValueDecl of mutability * string * expr
    | FunctionDecl of string * string list * expr

type program = declaration list


