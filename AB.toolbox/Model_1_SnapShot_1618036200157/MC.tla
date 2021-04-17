---- MODULE MC ----
EXTENDS AB, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
d1, d2, d3
----

\* MV CONSTANT definitions Data
const_161803619712767000 == 
{d1, d2, d3}
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_161803619712868000 ==
/\ Len(AtoB) =< 3
/\ Len(BtoA) =< 3
----
=============================================================================
\* Modification History
\* Created Sat Apr 10 15:29:57 JST 2021 by shotashimizu
