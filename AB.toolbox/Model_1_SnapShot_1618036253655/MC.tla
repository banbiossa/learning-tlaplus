---- MODULE MC ----
EXTENDS AB, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
d1, d2, d3
----

\* MV CONSTANT definitions Data
const_161803625062870000 == 
{d1, d2, d3}
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_161803625062871000 ==
/\ Len(AtoB) =< 3
/\ Len(BtoA) =< 3
----
=============================================================================
\* Modification History
\* Created Sat Apr 10 15:30:50 JST 2021 by shotashimizu
