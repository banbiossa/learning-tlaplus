----------------------------- MODULE MinMax1 ----------------------------
EXTENDS Integers, Sequences

setMax(S) == CHOOSE t \in S: \A s \in S: t >= s
setMin(S) == CHOOSE t \in S: \A s \in S: t <= s

CONSTANTS Hi, Lo, Both, None
ASSUME {Lo, Hi, Both, None} \cap Int = {}

VARIABLES x, turn, y
vars == <<x, turn, y>>

Init == /\ x = None
        /\ turn = "input"
        /\ y = {}

InputNum == /\ turn = "input"
            /\ turn' = "output"
            /\ x' \in Int
            /\ y' = y


Respond ==  /\ turn = "output"
            /\ turn' = "input"
            /\ y' = y \cup {x}
            /\ x' = IF x = setMax(y')
                      THEN IF x = setMin(y') THEN Both ELSE HI
                      ELSE IF x = setMin(y') THEN Lo   ELSE None

Next == InputNum \/ Respond

Spec == Init /\ [][Next]_vars

===============================================