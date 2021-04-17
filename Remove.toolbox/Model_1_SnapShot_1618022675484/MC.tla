---- MODULE MC ----
EXTENDS Remove, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16180226719063000 == 
Remove(3, <<1, 2, 3, 4>>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16180226719063000>>)
----

=============================================================================
\* Modification History
\* Created Sat Apr 10 11:44:31 JST 2021 by shotashimizu
