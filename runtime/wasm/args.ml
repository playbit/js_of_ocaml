let () =
  for i = 1 to Array.length Sys.argv - 1 do
    if
      not (List.mem (Filename.basename Sys.argv.(i)) [ "playbit.wat"; "playbit_sys.wat" ])
    then
      Format.printf
        "%s:%s@."
        (Filename.chop_suffix (Filename.basename Sys.argv.(i)) ".wat")
        Sys.argv.(i)
  done
