Inductive bool :=
| true
| false.

Definition orb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

Theorem orb_left_identity :
  forall (b: bool), orb true b = true.
Proof.
  intros b.
  destruct b.
  - (* b = true *)
    simpl. reflexivity.
  - (* b = false *)
    simpl. reflexivity.
Qed.

Theorem orb_left_identity' :
  forall (b1 b2 : bool),
  b1 = true -> orb b1 b2 = true.
Proof.
  intros.
  rewrite H.
  apply orb_left_identity.
Qed.

Inductive natlist :=
| nil
| cons (x : nat) (l : natlist).

Notation "x :: l" := (cons x l)
                     (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) ..).

Fixpoint app (l1 l2 : natlist) : natlist :=
  match l1 with
  | nil => l2
  | h :: t => h :: (app t l2)
  end.

Notation "x ++ y" := (app x y)
                     (right associativity, at level 60).

Theorem app_left_identity :
  forall (l : natlist),
  [] ++ l = l.
Proof.
  intros. destruct l.
  - (* l = [] *)
    simpl. reflexivity.
  - (* l = h :: t *)
    simpl. reflexivity.
Qed.

Theorem app_assoc :
  forall (l1 l2 l3 : natlist),
  l1 ++ (l2 ++ l3) = (l1 ++ l2) ++ l3.
Proof.
 intros. induction l1.
 - (* l1 = [] *)
   simpl. reflexivity.
 - (* l1 = h :: t *)
   simpl.
   rewrite IHl1.
   reflexivity.
Qed.


