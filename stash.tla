------------------------------ MODULE TwoPhase ------------------------------
(***************************************************************************)
(* This specification is discussed in "Two-Phase Commit", Lecture 6 of the *)
(* TLA+ Video Course.  It describes the Two-Phase Commit protocol, in      *)
(* which a transaction manager (TM) coordinates the resource managers      *)
(* (RMs) to implement the Transaction Commit specification of module       *)
(* TCommit.  In this specification, RMs spontaneously issue Prepared       *)
(* messages.  We ignore the Prepare messages that the TM can send to the   *)
(* RMs.                                                                    *)
(*                                                                         *)
(* For simplicity, we also eliminate Abort messages sent by an RM when it  *)
(* decides to abort.  Such a message would cause the TM to abort the       *)
(* transaction, an event represented here by the TM spontaneously deciding *)
(* to abort.                                                               *)
(***************************************************************************)
CONSTANT RM  \* The set of resource managers

VARIABLES
  rmState,       \* rmState[r] is the state of resource manager r.
  tmState,       \* The state of the transaction manager.
  tmPrepared,    \* The set of RMs from which the TM has received "Prepared"
                 \* messages.
  msgs
    (***********************************************************************)
    (* In the protocol, processes communicate with one another by sending  *)
    (* messages.  For simplicity, we represent message passing with the    *)
    (* variable msgs whose value is the set of all messages that have been *)
    (* sent.  A message is sent by adding it to the set msgs.  An action   *)
    (* that, in an implementation, would be enabled by the receipt of a    *)
    (* certain message is here enabled by the presence of that message in  *)
    (* msgs.  For simplicity, messages are never removed from msgs.  This  *)
    (* allows a single message to be received by multiple receivers.       *)
    (* Receipt of the same message twice is therefore allowed; but in this *)
    (* particular protocol, that's not a problem.                          *)
    (***********************************************************************)

Messages ==
  (*************************************************************************)
  (* The set of all possible messages.  Messages of type "Prepared" are    *)
  (* sent from the RM indicated by the message's rm field to the TM.       *)
  (* Messages of type "Commit" and "Abort" are broadcast by the TM, to be  *)
  (* received by all RMs.  The set msgs contains just a single copy of     *)
  (* such a message.                                                       *)
  (*************************************************************************)
  [type : {"Prepared"}, rm : RM]  \cup  [type : {"Commit", "Abort"}]

TPTypeOK ==
  (*************************************************************************)
  (* The type-correctness invariant                                        *)
  (*************************************************************************)
  /\ rmState \in [RM -> {"working", "prepared", "committed", "aborted"}]
  /\ tmState \in {"init", "done"}
  /\ tmPrepared \subseteq RM
  /\ msgs \subseteq Messages

TPInit ==
  (*************************************************************************)
  (* The initial predicate.                                                *)
  (*************************************************************************)
  /\ rmState = [r \in RM |-> "working"]
  /\ tmState = "init"
  /\ tmPrepared   = {}
  /\ msgs = {}

-----------------------------------------------------------------------------
(***************************************************************************)
(* We now define the actions that may be performed by the processes, first *)
(* the TM's actions, then the RMs' actions.                                *)
(***************************************************************************)
TMRcvPrepared(r) ==
  (*************************************************************************)
  (* The TM receives a "Prepared" message from resource manager r.  We     *)
  (* could add the additional enabling condition r \notin tmPrepared,      *)
  (* which disables the action if the TM has already received this         *)
  (* message.  But there is no need, because in that case the action has   *)
  (* no effect; it leaves the state unchanged.                             *)
  (*************************************************************************)
  /\ tmState = "init"
  /\ [type |-> "Prepared", rm |-> r] \in msgs
  /\ tmPrepared' = tmPrepared \cup {r}
  /\ UNCHANGED <<rmState, tmState, msgs>>

(*************************************************************************)
(* my stuff *)
(*************************************************************************)

\* TMCommit ==
\*   (*************************************************************************)
\*   (* Allows steps where the TM sends commit messages to the RMs and        *)
\*   (* sets tmState to "done" *)
\*   (* The messages are sent by adding [type |-> "commit"] to msgs *)
\*   (*************************************************************************)
\*   /\ tmState = "init"
\*   /\ tmPrepared = RM
\*   /\ msgs' = msgs \cup [type |-> "Commit"]
\*   /\ tmState' = "done"
\*   /\ UNCHANGED << rmState, tmPrepared >>
\*
\* TMAbort ==
\*   (*************************************************************************)
\*   (* TM sends abort messages to the RMs and sets tmState to "done" *)
\*   (*************************************************************************)
\*   /\ tmState = "init"
\*   /\ msgs' = msgs \cup [type |-> "Abort"]
\*   /\ tmState' = "done"
\*   /\ UNCHANGED << rmState, tmPrepared >>
\*
\* RMPrepare(r) ==
\*   (*************************************************************************)
\*   (* RM r sets the state to "prepared" and sends a Prepared message to the *)
\*   (* TM *)
\*   (*************************************************************************)
\*   /\ tmState = "init"
\*   /\ rmState[r] = "working"
\*   /\ msgs' = msgs \cup [type |-> "Prepared", rm |-> r]
\*   /\ rmState' = [rmState EXCEPT ![r] = "prepared"]
\*   /\ TMRcvPrepared(r)
\*   /\ UNCHANGED << tmState, tmPrepared >>
\*
\* RMChooseToAbort(r) ==
\*   (*************************************************************************)
\*   (* When in its "working" state, RM r can go to the aborted state *)
\*   (* RMs dont' send abort messages (TMs do) *)
\*   (*************************************************************************)
\*   /\ rmState[r] = "working"
\*   /\ rmState' = [rmState EXCEPT ![r] = "aborted"]
\*   /\ UNCHANGED << tmState, tmPrepared, msgs >>
\*
\* RMRcvCommitMsg(r) ==
\*   (*************************************************************************)
\*   (* RM r receives a "commit" message and sets it's state *)
\*   (*************************************************************************)
\*   /\ rmState[r] = "prepared"
\*   /\ rmState' = [rmState EXCEPT ![r] = "committed"]
\*   /\ UNCHANGED << tmState, tmPrepared, msgs >>
\*
\* RMRcvAbortMsg(r) ==
\*   (*************************************************************************)
\*   (* RM r receives an "abort" message and sets it's state *)
\*   (*************************************************************************)
\*   /\ rmState[r] = "prepared"
\*   /\ rmState' = [rmState EXCEPT ![r] = "aborted"]
\*   /\ UNCHANGED << tmState, tmPrepared, msgs >>
\*
\* TPNext ==
\*   (*************************************************************************)
\*   (*************************************************************************)
\*   \/ TMCommit
\*   \/ TMAbort
\*   \/ \E r \in RM:
\*     \/ TMRcvPrepared(r)
\*     \/ RMPrepare(r)
\*     \/ RMChooseToAbort(r)
\*     \/ RMRcvCommitMsg(r)
\*     \/ RMRcvCommitMsg(r)
\*
\*
\* (*************************************************************************)
\* (* Original stuff *)
\* (*************************************************************************)


TMCommit ==
  (*************************************************************************)
  (* The TM commits the transaction; enabled iff the TM is in its initial  *)
  (* state and every RM has sent a "Prepared" message.                     *)
  (*************************************************************************)
  /\ tmState = "init"
  /\ tmPrepared = RM
  /\ tmState' = "done"
  /\ msgs' = msgs \cup {[type |-> "Commit"]}
  /\ UNCHANGED <<rmState, tmPrepared>>

TMAbort ==
  (*************************************************************************)
  (* The TM spontaneously aborts the transaction.                          *)
  (*************************************************************************)
  /\ tmState = "init"
  /\ tmState' = "done"
  /\ msgs' = msgs \cup {[type |-> "Abort"]}
  /\ UNCHANGED <<rmState, tmPrepared>>

RMPrepare(r) ==
  (*************************************************************************)
  (* Resource manager r prepares.                                          *)
  (*************************************************************************)
  /\ rmState[r] = "working"
  /\ rmState' = [rmState EXCEPT ![r] = "prepared"]
  /\ msgs' = msgs \cup {[type |-> "Prepared", rm |-> r]}
  /\ UNCHANGED <<tmState, tmPrepared>>

RMChooseToAbort(r) ==
  (*************************************************************************)
  (* Resource manager r spontaneously decides to abort.  As noted above, r *)
  (* does not send any message in our simplified spec.                     *)
  (*************************************************************************)
  /\ rmState[r] = "working"
  /\ rmState' = [rmState EXCEPT ![r] = "aborted"]
  /\ UNCHANGED <<tmState, tmPrepared, msgs>>

RMRcvCommitMsg(r) ==
  (*************************************************************************)
  (* Resource manager r is told by the TM to commit.                       *)
  (*************************************************************************)
  /\ [type |-> "Commit"] \in msgs
  /\ rmState' = [rmState EXCEPT ![r] = "committed"]
  /\ UNCHANGED <<tmState, tmPrepared, msgs>>

RMRcvAbortMsg(r) ==
  (*************************************************************************)
  (* Resource manager r is told by the TM to abort.                        *)
  (*************************************************************************)
  /\ [type |-> "Abort"] \in msgs
  /\ rmState' = [rmState EXCEPT ![r] = "aborted"]
  /\ UNCHANGED <<tmState, tmPrepared, msgs>>

TPNext ==
  \/ TMCommit \/ TMAbort
  \/ \E r \in RM :
       TMRcvPrepared(r) \/ RMPrepare(r) \/ RMChooseToAbort(r)
         \/ RMRcvCommitMsg(r) \/ RMRcvAbortMsg(r)
-----------------------------------------------------------------------------
(***************************************************************************)
(* The material below this point is not discussed in Video Lecture 6.  It  *)
(* will be explained in Video Lecture 8.                                   *)
(***************************************************************************)

TPSpec == TPInit /\ [][TPNext]_<<rmState, tmState, tmPrepared, msgs>>
  (*************************************************************************)
  (* The complete spec of the Two-Phase Commit protocol.                   *)
  (*************************************************************************)

THEOREM TPSpec => []TPTypeOK
  (*************************************************************************)
  (* This theorem asserts that the type-correctness predicate TPTypeOK is  *)
  (* an invariant of the specification.                                    *)
  (*************************************************************************)
-----------------------------------------------------------------------------
(***************************************************************************)
(* We now assert that the Two-Phase Commit protocol implements the         *)
(* Transaction Commit protocol of module TCommit.  The following statement *)
(* imports all the definitions from module TCommit into the current        *)
(* module.                                                                 *)
(***************************************************************************)
INSTANCE TCommit

THEOREM TPSpec => TCSpec
  (*************************************************************************)
  (* This theorem asserts that the specification TPSpec of the Two-Phase   *)
  (* Commit protocol implements the specification TCSpec of the            *)
  (* Transaction Commit protocol.                                          *)
  (*************************************************************************)
(***************************************************************************)
(* The two theorems in this module have been checked with TLC for six      *)
(* RMs, a configuration with 50816 reachable states, in a little over a    *)
(* minute on a 1 GHz PC.                                                   *)
(***************************************************************************)

=============================================================================
\* Modification History
\* Last modified Sun Mar 28 19:55:32 JST 2021 by shotashimizu
\* Last modified Tue Jul 17 11:38:20 CEST 2018 by max
\* Created Tue Jul 17 11:37:58 CEST 2018 by max

{{"a1", "a2"}, {"a1", "a3"}, {"a2"}}

{{a1, a2}, {a1, a3}, {a2}}

{a1, a2, a3}
{r1, r2}
{r1, r2}
{r1, r2, r3}
{{a1, a2}, {a1, a3}, {a2}}
{{a1, a2}, {a1, a3}, {a2}}