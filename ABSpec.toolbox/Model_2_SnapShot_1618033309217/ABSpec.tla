----------------------------- MODULE ABSpec ----------------------------
EXTENDS Integers
CONSTANT Data
VARIABLES AVar, BVar

TypeOK == /\ AVar \in Data \X {0, 1}
          /\ BVar \in Data \X {0, 1}

vars == <<AVar, BVar>>

Init == /\ AVar \in Data \X {1}
        /\ BVar = AVar

A == /\ AVar = BVar
     /\ \E d \in Data: AVar' = <<d, 1-AVar[2]>>
     /\ BVar' = BVar

B == /\ AVar # BVar
     /\ BVar' = AVar
     /\ AVar' = AVar

Next == A \/ B

Spec == Init /\ [][Next]_<<vars>>

FairSpec  == Init /\ [][Next]_<<vars>> /\ WF_vars(Next)
FairSpec2 == Init /\ [][Next]_<<vars>> /\ WF_vars(A) /\ WF_vars(B)

Inv == (AVar[2] = BVar[2]) => (AVar=BVar)

Liveness ==
  \A v \in Data \X {0, 1}: (AVar=v) ~> (BVar =v)
  (* <> P = \not [] \not P*)
  (* eventually P = not always not P *)

WeakFairness ==
  WF_vars(A)

Equiv ==
  /\ FairSpec  => FairSpec2
  /\ FairSpec2 => FairSpec
=============================================================================