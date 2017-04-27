Set Warnings "-notation-overridden".

Require Import Category.Lib.
Require Export Category.Theory.Category.
Require Export Category.Theory.Functor.
Require Export Category.Theory.Natural.
Require Export Category.Structure.Cartesian.
Require Export Category.Structure.Cocartesian.
Require Export Category.Structure.Closed.
Require Export Category.Structure.Initial.
Require Export Category.Structure.Terminal.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Set Implicit Arguments.

(* The category of propositions. Note that since proofs are opaque, we must
   assert proof irrelevance and judge them always equivalent if they have the
   same type. *)

Program Instance Props : Category := {
  ob      := Prop;
  hom     := Basics.impl;
  homset  := fun P Q =>
               {| equiv := fun f g => forall x, proof_eq (f x) (g x) |};
  id      := fun _ x => x;
  compose := fun _ _ _ g f x => g (f x)
}.
Next Obligation. equivalence; autounfold in *; congruence. Qed.
Next Obligation. proper; autounfold in *; congruence. Qed.

Program Instance Props_Terminal : @Terminal Props := {
  One := True;
  one := fun _ _ => I
}.
Next Obligation. apply proof_irrelevance. Qed.

Program Instance Props_Initial : @Initial Props := {
  Zero := False;
  zero := fun _ _ => False_rect _ _
}.

Program Instance Props_Cartesian : @Cartesian Props := {
  Prod := and;
  fork := fun _ _ _ f g x => conj (f x) (g x);
  exl  := fun _ _ p => proj1 p;
  exr  := fun _ _ p => proj2 p
}.
Obligation 1. proper; congruence. Qed.
Obligation 2. firstorder; apply proof_irrelevance. Qed.

Program Instance Props_Cocartesian : @Cocartesian Props := {
  Coprod := or;
  merge := fun _ _ _ f g x =>
            match x with
            | or_introl v => f v
            | or_intror v => g v
            end;
  inl  := fun _ _ p => or_introl p;
  inr  := fun _ _ p => or_intror p
}.
Obligation 1. proper; apply proof_irrelevance. Qed.
Obligation 2. firstorder; apply proof_irrelevance. Qed.

Program Instance Props_Closed : @Closed Props _ := {
  Exp := Basics.impl;
  exp_iso := fun _ _ _ =>
    {| to   := {| morphism := fun f a b => f (conj a b) |}
     ; from := {| morphism := fun f p => f (proj1 p) (proj2 p) |} |}
}.
Next Obligation. proper; apply proof_irrelevance. Qed.
Next Obligation. proper; apply proof_irrelevance. Qed.
Next Obligation. apply proof_irrelevance. Qed.
Next Obligation. apply proof_irrelevance. Qed.
Next Obligation. apply proof_irrelevance. Qed.