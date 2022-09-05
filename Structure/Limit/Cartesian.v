Set Warnings "-notation-overridden".

Require Import Category.Lib.
Require Export Category.Structure.Limit.
Require Export Category.Structure.Cartesian.
Require Export Category.Instance.Two.Discrete.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Unset Transparent Obligations.

Theorem Cartesian_Limit (C : Category) :
  (∀ F : Two_Discrete ⟶ C, Limit F) ↔ @Cartesian C.
Proof.
  split; intros.
  - construct.
    + exact (vertex_obj[X (Pick_Two X0 X1)]).
    + simpl.
      given (cone : Cone (Pick_Two y z)). {
        unshelve (refine {| vertex_obj := x |}); intros.
        - destruct x0; simpl; auto.
        - destruct x0, y0; cat;
          pose proof (TwoDHom_inv _ _ f0) as H; inv H.
      }
      destruct (@ump_limits _ _ _ (X (Pick_Two y z)) cone).
      apply unique_obj.
    + simpl.
      destruct (X (Pick_Two x y)).
      destruct limit_cone.
      apply (vertex_map TwoDX).
    + simpl.
      destruct (X (Pick_Two x y)).
      destruct limit_cone.
      apply (vertex_map TwoDY).
    + proper.
      apply uniqueness; simpl; intros.
      destruct x2; simpl.
      * rewrite X0.
        destruct (ump_limits _).
        apply (unique_property TwoDX).
      * rewrite X1.
        destruct (ump_limits _).
        apply (unique_property TwoDY).
    + simpl.
      destruct (ump_limits _); simpl in *.
      split; intros.
      * split.
        ** rewrite X0.
           apply (unique_property TwoDX).
        ** rewrite X0.
           apply (unique_property TwoDY).
      * destruct X0.
        symmetry.
        apply uniqueness; intros.
        destruct x0; auto.
  - construct.
    + construct.
      * exact (product_obj (fobj[F] TwoDX) (fobj[F] TwoDY)).
      * destruct x.
        ** apply exl.
        ** apply exr.
      * simpl.
        destruct x, y;
        pose proof (TwoDHom_inv _ _ f) as H; inv H.
        ** now rewrite fmap_id, id_left.
        ** now rewrite fmap_id, id_left.
    + unshelve eexists.
      * apply fork.
        ** apply vertex_map.
        ** apply vertex_map.
      * intros.
        destruct x; simpl.
        ** now rewrite exl_fork.
        ** now rewrite exr_fork.
      * intros.
        simpl in *.
        rewrite <- !X0.
        rewrite fork_comp.
        rewrite fork_exl_exr.
        cat.
Qed.
