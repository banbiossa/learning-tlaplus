---- MODULE MC ----
EXTENDS TwoPhase, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3
----

\* MV CONSTANT definitions RM
const_161752882982985000 == 
{r1, r2, r3}
----

\* SYMMETRY definition
symm_161752882982986000 == 
Permutations(const_161752882982985000)
----

\* PROPERTY definition @modelCorrectnessProperties:0
prop_161752882982987000 ==
TC!TCSpec
----
=============================================================================
\* Modification History
\* Created Sun Apr 04 18:33:49 JST 2021 by shotashimizu
