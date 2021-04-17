---- MODULE MC ----
EXTENDS PaxosCommit, TLC

\* CONSTANT definitions @modelParameterConstants:0Ballot
const_161750882213718000 == 
{0, 1}
----

\* CONSTANT definitions @modelParameterConstants:1Acceptor
const_161750882213719000 == 
{"a1", "a2", "a3"}
----

\* CONSTANT definitions @modelParameterConstants:2Majority
const_161750882213720000 == 
{{"a1", "a2"}, {"a1", "a3"}, {"a2", "a3"}}
----

\* CONSTANT definitions @modelParameterConstants:3RM
const_161750882213721000 == 
{"r1", "r2"}
----

\* INVARIANT definition @modelCorrectnessInvariants:1
inv_161750882213723000 ==
TC!TCConsistent
----
=============================================================================
\* Modification History
\* Created Sun Apr 04 13:00:22 JST 2021 by shotashimizu
