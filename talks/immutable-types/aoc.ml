type 'a list = Nil
             | Cons of 'a * 'a list

(* Convenience function. 10 & 20 & Nil => Cons (10, Cons (20, Nil)) *)
let (&) x xs = Cons (x, xs)

let puzzle_input : int list list =
  (1000 & 2000 & 3000 & Nil) &
    (4000 & Nil) &
      (5000 & 6000 & Nil) &
        (7000 & 8000 & 9000 & Nil) &
          (10000 & Nil) &
            Nil


(* Apply f to every element of xs *)
let rec map f xs =
  match xs with
  | Nil -> Nil
  | Cons (x, rest) -> Cons (f x, map f rest)

(* Keep a running total by applying f to it and the next element of xs *)
let rec fold f init xs =
  match xs with
  | Nil -> init
  | Cons (x, rest) ->
     f x (fold f init rest)

let sum = fold Int.add 0

let list_max = fold Int.max Int.min_int

let () = list_max (map sum puzzle_input)
         |> string_of_int
         |> print_endline



    
