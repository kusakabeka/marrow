let () =
    let open Marrow_frontend in
    let expression = Ast.Int (((34 + 4) * (12 + 3)) / 2) in
    print_endline (Ast_printer.string_of_expr expression)
