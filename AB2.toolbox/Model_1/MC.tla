---- MODULE MC ----
EXTENDS AB2, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
d1, d2, d3
----

\* MV CONSTANT definitions Data
const_161811269902099000 == 
{d1, d2, d3}
----

\* CONSTRAINT definition @modelParameterContraint:0
constr_1618112699020100000 ==
/\ Len(AtoB2) < 4
/\ Len(BtoA2) < 4
----
=============================================================================
\* Modification History
\* Created Sun Apr 11 12:44:59 JST 2021 by shotashimizu
