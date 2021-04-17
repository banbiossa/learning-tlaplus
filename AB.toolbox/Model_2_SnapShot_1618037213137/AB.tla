----------------------------- MODULE AB ----------------------------
EXTENDS Integers, Sequences
CONSTANT Data

Remove(i, seq) ==
  (*************************************************************************)
  (* The sequence obtained by removing the ith element from the *)
  (* sequence seq *)
  (*************************************************************************)
  [j \in 1..(Len(seq)-1) |-> IF j < i THEN seq[j] ELSE seq[j+1]]


VARIABLES AVar, BVar, AtoB, BtoA

vars == <<AVar, BVar, AtoB, BtoA>>

TypeOK == /\ AVar \in Data \X {0, 1}
          /\ BVar \in Data \X {0, 1}
          /\ AtoB \in Seq(Data \X {0, 1})
          /\ BtoA \in Seq({0, 1})

Init == /\ AVar \in Data \X {1}
        /\ BVar = AVar
        /\ AtoB = <<>>
        /\ BtoA = <<>>

ASnd == /\ AtoB' = Append(AtoB, AVar)
        /\ UNCHANGED <<AVar, BtoA, BVar>>

ARcv == /\ BtoA # <<>>
        /\ IF Head(BtoA) = AVar[2]
            THEN \E d \in Data:
                AVar' = <<d, 1-AVar[2]>>
            ELSE AVar' = AVar
        /\ BtoA' = Tail(BtoA)
        /\ UNCHANGED <<BVar, AtoB>>

BSnd == /\ BtoA' = Append(BtoA, BVar[2])
        /\ UNCHANGED <<AVar, BVar, AtoB>>

BRcv == /\ AtoB # <<>>
        /\ IF Head(AtoB)[2] # BVar[2]
            THEN BVar' = Head(AtoB)
            ELSE BVar' = BVar
        /\ AtoB' = Tail(AtoB)
        /\ UNCHANGED <<AVar, BtoA>>

LoseMsg == /\ \/  /\ \E i \in 1..Len(AtoB):
                      AtoB' = Remove(i, AtoB)
                  /\  BtoA' = BtoA
              \/  /\ \E i \in 1..Len(BtoA):
                      BtoA' = Remove(i, BtoA)
                  /\  AtoB' = AtoB
           /\ UNCHANGED <<AVar, BVar>>

Next == \/ ASnd
        \/ ARcv
        \/ BSnd
        \/ BRcv
        \/ LoseMsg

Spec == Init /\ [][Next]_vars

FairSpec == /\ Spec
            /\ SF_vars(ARcv)
            /\ SF_vars(BRcv)
            /\ WF_vars(ASnd)
            /\ WF_vars(BSnd)

------------------------------------------------------------
(***************************************************************************)
(* We now assert that the AB protocol implements ABSpec *)
(***************************************************************************)
ABS == INSTANCE ABSpec

THEOREM Spec => ABS!Spec
THEOREM FairSpec => ABS!FairSpec

=============================================================================