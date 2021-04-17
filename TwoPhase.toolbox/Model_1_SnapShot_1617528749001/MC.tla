---- MODULE MC ----
EXTENDS TwoPhase, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3
----

\* MV CONSTANT definitions RM
const_161752874395774000 == 
{r1, r2, r3}
----

\* SYMMETRY definition
symm_161752874395775000 == 
Permutations(const_161752874395774000)
----

=============================================================================
\* Modification History
\* Created Sun Apr 04 18:32:23 JST 2021 by shotashimizu
