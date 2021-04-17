---- MODULE MC ----
EXTENDS PaxosCommit, TLC

\* CONSTANT definitions @modelParameterConstants:0Ballot
const_161750965160130000 == 
{0, 1}
----

\* CONSTANT definitions @modelParameterConstants:1Acceptor
const_161750965160131000 == 
{"a1", "a2", "a3"}
----

\* CONSTANT definitions @modelParameterConstants:2Majority
const_161750965160132000 == 
{{"a1", "a2"}, {"a1", "a3"}, {"a2"}}
----

\* CONSTANT definitions @modelParameterConstants:3RM
const_161750965160133000 == 
{"r1", "r2"}
----

\* INVARIANT definition @modelCorrectnessInvariants:1
inv_161750965160135000 ==
TC!TCConsistent
----
=============================================================================
\* Modification History
\* Created Sun Apr 04 13:14:11 JST 2021 by shotashimizu
