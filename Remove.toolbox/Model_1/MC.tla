---- MODULE MC ----
EXTENDS Remove, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16180227810817000 == 
1..3\X{"a","b"}
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16180227810817000>>)
----

=============================================================================
\* Modification History
\* Created Sat Apr 10 11:46:21 JST 2021 by shotashimizu
