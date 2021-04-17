---- MODULE MC ----
EXTENDS ABSpec, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
fred, george, mary
----

\* MV CONSTANT definitions Data
const_161803331588251000 == 
{fred, george, mary}
----

\* PROPERTY definition @modelCorrectnessProperties:0
prop_161803331588254000 ==
\A v \in Data \X {0, 1}: (AVar=v) ~> (BVar =v)
----
=============================================================================
\* Modification History
\* Created Sat Apr 10 14:41:55 JST 2021 by shotashimizu
