---- MODULE MC ----
EXTENDS PaxosCommit, TLC

\* CONSTANT definitions @modelParameterConstants:0Ballot
const_16175083940747000 == 
{0, 1}
----

\* CONSTANT definitions @modelParameterConstants:1Acceptor
const_16175083940748000 == 
{"a1", "a2", "a3"}
----

\* CONSTANT definitions @modelParameterConstants:2Majority
const_16175083940749000 == 
{{"a1", "a2"}, {"a1", "a3"}, {"a2", "a3"}}
----

\* CONSTANT definitions @modelParameterConstants:3RM
const_161750839407410000 == 
{"r1", "r2"}
----

=============================================================================
\* Modification History
\* Created Sun Apr 04 12:53:14 JST 2021 by shotashimizu
