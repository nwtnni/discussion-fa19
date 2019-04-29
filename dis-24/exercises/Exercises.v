Inductive bool :=
| true
| false.

Definition orb (b1 : bool) (b2 : bool) : bool
  . Admitted.

Theorem orb_left_identity :
  forall (b: bool), orb true b = true.
Proof.
Admitted.

Theorem orb_left_identity' :
  forall (b1 b2 : bool),
  b1 = true -> orb b1 b2 = true.
Proof.
Admitted.

Inductive natlist :=
| nil
| cons (x : nat) (l : natlist).

Notation "x :: l" := (cons x l)
                     (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) ..).

Fixpoint app (l1 l2 : natlist) : natlist
 . Admitted.

Notation "x ++ y" := (app x y)
                     (right associativity, at level 60).

Theorem app_left_identity :
  forall (l : natlist),
  [] ++ l = l.
Proof.
Admitted.

Theorem app_assoc :
  forall (l1 l2 l3 : natlist),
  l1 ++ (l2 ++ l3) = (l1 ++ l2) ++ l3.
Proof.
Admitted.


