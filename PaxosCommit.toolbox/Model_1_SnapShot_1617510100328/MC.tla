---- MODULE MC ----
EXTENDS PaxosCommit, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a1, a2, a3
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2
----

\* MV CONSTANT definitions Acceptor
const_161751009226266000 == 
{a1, a2, a3}
----

\* MV CONSTANT definitions RM
const_161751009226267000 == 
{r1, r2}
----

\* CONSTANT definitions @modelParameterConstants:0Ballot
const_161751009226268000 == 
{0, 1}
----

\* CONSTANT definitions @modelParameterConstants:2Majority
const_161751009226269000 == 
{{a1, a2}, {a1, a3}, {a2}}
----

\* INVARIANT definition @modelCorrectnessInvariants:1
inv_161751009226271000 ==
TC!TCConsistent
----
=============================================================================
\* Modification History
\* Created Sun Apr 04 13:21:32 JST 2021 by shotashimizu
