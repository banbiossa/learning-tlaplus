---- MODULE MC ----
EXTENDS PaxosCommit, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a1, a2, a3
----

\* MV CONSTANT definitions Acceptor
const_161750991251342000 == 
{a1, a2, a3}
----

\* CONSTANT definitions @modelParameterConstants:0Ballot
const_161750991251343000 == 
{0, 1}
----

\* CONSTANT definitions @modelParameterConstants:2Majority
const_161750991251344000 == 
{{a1, a2}, {a1, a3}, {a2}}
----

\* CONSTANT definitions @modelParameterConstants:3RM
const_161750991251345000 == 
{"r1", "r2"}
----

\* INVARIANT definition @modelCorrectnessInvariants:1
inv_161750991251347000 ==
TC!TCConsistent
----
=============================================================================
\* Modification History
\* Created Sun Apr 04 13:18:32 JST 2021 by shotashimizu
