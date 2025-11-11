type 'a list = Empty
             | Cons of 'a * 'a list

let puzzle : int list list =
  Cons ( Cons (1000, Cons (2000, Cons (3000, Empty))),
         Cons ( Cons (4000, Empty),
                Cons ( Cons (5000, Cons (6000, Empty)),
                       Cons ( Cons (7000, Cons (8000, Cons (9000, Empty))),
                              Cons ( Cons (10000, Empty),
                                     Empty)))))

let rec map f xs =
  match xs with
  | Empty -> Empty
  | Cons (first, rest) -> Cons (f first, map f rest)

let rec fold f acc xs =
  match xs with
  | Empty -> acc
  | Cons (first, rest) -> f first (fold f acc rest)

let sum = fold Int.add 0

let list_max = fold Int.max Int.min_int
