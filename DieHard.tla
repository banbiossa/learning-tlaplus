------------------------------ MODULE DieHard ------------------------------
EXTENDS Integers
VARIABLES small, big

TypeOK ==   /\ small \in 0..3
            /\ big \in 0..5

Init ==     /\ big = 0
            /\ small = 0

FillSmall ==    /\ small' = 3
                /\ big' = big

FillBig ==  /\ big' = 5
            /\ small' = small

EmptySmall ==   /\ small' = 0
                /\ big' = big

EmptyBig == /\ big' = 0
            /\ small' = small

SmallToBig ==   IF big + small <= 5
                    THEN    /\ big' = big + small
                            /\ small' = 0
                    ELSE    /\ big' = 5
                            /\ small' = big + small - 5

BigToSmall ==   IF big <= 3
                    THEN    /\ small' = big
                            /\ big' = 0
                    ELSE    /\ small' = 3
                            /\ big' = big - 3

Next ==     \/ FillSmall
            \/ FillBig
            \/ EmptySmall
            \/ EmptyBig
            \/ SmallToBig
            \/ BigToSmall

=============================================================================
\* Modification History
\* Last modified Sun Mar 28 16:28:32 JST 2021 by shotashimizu
\* Created Sun Mar 28 16:04:18 JST 2021 by shotashimizu
