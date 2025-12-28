#import "/template/template.typ": *
#show: rules


= Nonmanipulable Selections from a Tournament

== Introduction

A #highlight(fill: aqua)[_tournament_] is a binary dominance relation on a set of alternatives $A$, i.e., for every two alternatives $x,y in A$ either $x$ dominates $y$ or $y$ dominates $x$, but not both.

Tournaments are relevant for sports but also for AI, in particular multi-agent systems. \
Tournaments can be used to model:
- a defeat relation between different arguments in argumentation theory
- in multi-criteria decision making
- the majority dominance relation in an election.

In the election context, a voter has a #highlight(fill: aqua)[ranking] over the set of alternatives; alternative $x$ is said to dominate $y$ if the majority of voters prefer $x$ to $y$. \
Condorcet noticed that the majority relation may contain cycles. \
McGarvey established that _any_ tournament can be obtained as the dominance relation of an election.

#problem[winner determination problem][
  How to select the "most desirable" element given a tournament, which is then deemed the winner.
]

We consider #highlight(fill: aqua)[choice rules] that select an alternative given a tournament, that is, functions from the set of all tournaments over $A$ to $A$. The players in our game are the alternatives. \
In our model, an alternative cannot announce that it dominates an alternative that it loses to. However, an alternative can lose on purpose to another alternative. In other words, if $x in A$ dominates $y in A$, $x$ can cheat by reversing the outcome of the match between itself and $y$, but $y$ cannot reverse the outcome of this match unless $x$ agrees.

Specifically, we consider two basic types of #highlight(fill: aqua)[manipulation]:
+ An alternative loses a match, with the purpose of making itself the winner.
+ Two alternatives reverse the result of their match in order to make one of them the winner.
A choice rule that is immune to the former type of manipulation is said to be _monotonic_, whereas a rule that is immune to the latter is called _pairwise non-manipulable_ (PNM).

In addition to non-manipulability, we wish to consider choice rules that satisfy minimal notions of #highlight(fill:aqua)[fairness]. \
One notion is known as _Condorcet-consistency_: the rule must select an alternative that dominates every other alternative, if such an alternative exists in the given tournament. \
_Non-imposition_ is a strictly weaker notion of fairness: the rule must be onto the set of alternatives, that is, any alternative can be selected.

We prove an impossibility result: that there are no choice rules that are both PNM and Condorcet-consistent. \
We therefore relax our fairness criterion by requiring non-imposition. Even then, we establish that when $card(A) = 3$ there are no choice rules that are both PNM and non-imposing. However, we complement this impossibility by a surprising possibility theorem: for any $card(A) neq 3$ there is a choice rule that is PNM, non-imposing and also monotonic.


== Preliminaries

#definition[tournament][
  Let $A$ be a set of alternatives. A _tournament_ $T$ over $A$ is a complete asymmetric binary relation over $A$. In other words, for every two distinct alternatives $x, y in A$, exactly one of the following holds: $x T y$ (read: $x$ dominates $y$), or $y T x$. We denote the set of tournaments over $A$ by $cal(T)(A)$.
]

A tournament $T in cal(T)(A)$ corresponds to a directed graph $G = (V,E)$ where $V = A$, and the directed edge from $x$ to $y$ is in $E$ if and only if $x T y$. In other words $G$ is an orientation of the complete graph on $A$.

A second way to represent a tournament is via as string of bits. Let $card(A) = n$; a tournament $T$ over $A$ has $binom(n,2)$ edges, and each edge has two possible directions. Therefore, we can represent $T$ by a string of $binom(n,2)$ bits. \
We have to specify:
- the correspondence between edges and bits
- which edge direction corresponds to 0.
We can do the second one by fixing some tournament as the all zeros string.

#definition[Hamming distance][
  The _Hamming distance_ between $T in cal(T)(A)$ and $T' in cal(T)(A)$ is the number of edges that must be flipped in $T$ in order to obtain $T'$.
]

#definition[edge-adjacent tournaments][
  For two tournaments $T$ and $T'$ with Hamming distance one, we say that $T$ and $T'$ are _$(x,y)$-adjacent_ if and only if the two tournaments disagree exactly on the edge $(x,y)$, that is, $x T y iff y T' x$, and for all edges $(z,w) neq (x,y)$, $z T w iff z T' w$.
]

#definition[component][
  Let $C subset.eq A$ and $T in cal(T)(A)$. We say that $C$ is a _component_ of $T$ if for all $x,y in C$ and $z in A \\ C$, $x T z iff y T z$.
]
An alternative outside the component either dominates _all_ the alternatives in the component or is dominated by _all_ the alternatives in the component.

We are interested in choice rules $r : cal(T)(A) -> A$ that select a winning alternative given a tournament.

#definition[Condorcet winner][
  Alternative $x$ is a _Condorcet winner_ in $T in cal(T)(A)$ if $x T y$ for all $y in A \\ {x}$.
]
Note that most tournaments do not have a Condorcet winner.

#definition[Condorcet consistency][
  A choice rule $r$ is _Condorcet consistent_ if $r$ always selects a Condorcet winner in a given tournament, if one exists.
]

#definition[non-imposability][
  A choice rule $r$ is _non-imposing_ if it is onto $A$, i.e., for every $x in A$ there exists $T in cal(T)(A)$ such that $r(T) = x$.
]

#remark[
  Clearly Condorcet-consistency implies non-imposition. \
  Indeed, given any alternative $x in A$, consider a tournament $T$ where $x$ is a Condorcet winner; then if $r$ is Condorcet-consistent, $r(T) = x$.
]


== Monotonic Choice Rules

Given a tournament $T$ and $x,y in A$ such that $x T y$, it is plausible to assume that $x$ can lose on purpose to $y$. On the other hand, if $y T x$, $x$ cannot unilaterally reverse this situation. \
In other words, we focus on manipulations where an alternative reverses an edge that is outgoing from itself in the tournament, but assume an alternative cannot reverse an edge that is incoming to itself.

We discuss a setting where an alternative only cares about whether it is selected by the choice rule $r$. In other words, a successful manipulation is one where an alternative is not elected by a rule, but is elected after reversing an outgoing edge. \
We want choice rules that are immune to this type of manipulation.

#definition[monotonicity][
  A choice rule $r : cal(T)(A) -> A$ is _monotonic_ if and only if for all $T in cal(T)(A)$, for all $x in A$ such that $r(T) neq x$, and for all $y in A$ such that $x T y$, if $T$ and $T'$ are $(x,y)$-adjacent then $r(T') neq x$.

  Equivalently: $r$ is monotonic if for all $T$ where $r(T) = x$, and for all $y in A$ such that $y T x$, if $T$ and $T'$ are $(x,y)$-adjacent then $r(T') = x$.
]

#remark[
  The definition of monotonicity implies that an alternative cannot make itself a winner by reversing multiple edges instead of just a single edge.
]

#example[
  _Copeland_ rule: select an alternative with maximum outdegree in the tournament, i.e., an alternative that dominates a maximum number of other alternatives. Since there may be multiple such alternatives, we need some tie-breaking rule, so choose the alternative with lexicographically smallest name. \
  If an alternative loses on purpose it only decreases its outdegree, hence this choice rule is monotonic.

  Voting trees are sequential procedures for choosing from a tournament. A voting tree is given by a binary tree whose leaves are labeled by alternatives. When the tree is applied to a tournament $T$, in every stage two siblings leaves $x$ and $y$ compete according to $T$; the father of the two leaves is labeled by the winner (that is, by $x$ if $x T y$ and by $y$ if $y T x$), and the two leaves are pruned. The label of the root of the tree is the selected alternative. \
  If an alternative reverses an edge against itself, it can only lose in a competition that it could have won. However, if each alternative appears only once in the leaves, an alternative that is eliminated at some stage cannot be ultimately selected, hence the tree is monotonic as a choice rule.
  
  Notice that these rules are also Condorcet-consistent.
]


== Pairwise Non-manipulable Choice Rules

Consider a pair of alternatives with shared interests or goals. Given that neither of the alternatives is elected, the pair may conspire to make one of them a winner by flipping the edge between them. \
A pairwise manipulation is then given by a pair ${x,y}$ and a tournament $T$ such that $r(T) in.not {x,y}$, but $r(T') in {x,y}$, where $T$ and $T'$ are $(x,y)$-adjacent.

#definition[pairwise non-manipulability][
  A choice rule $r : cal(T)(A) -> A$ is _pairwise non-manipulable_ (PNM) if and only if for all $T in cal(T)(A)$ and all $x,y in A$, if $T$ and $T'$ are $(x,y)$-adjacent then $r(T) in {x,y} iff r(T') in {x,y}$.
]

#remark[
  This is similar to a choice set (select a set of winning alternatives) property called _independence of non-winners_ (INW): a reversal of an edge that is incident upon a non-winning alternative cannot change the outcome. \
  In the context of choice _rules_ (which select a single winner), any INW rule must be constant. \
  PNM is much weaker, as the outcome can change, but not in a way that benefits the manipulating pair.
]

#remark[
  PNM is incomparable with monotonicity.

  Indeed, monotonicity clearly does not imply PNM. For example, consider Copeland rule (which is monotonic) on a $3$-cycle $x T y T z T x$: since they have all same outdegree, for tie-breaking $x$ would be the winner; but ${y,z}$ can collude to reverse their outcome and let $z$ win.

  In the other direction, let $A = {a,b}$ such that $a T b$ and $b T' a$ in the only two possible tournaments $T$ and $T'$. Set $r(T) = b$ and $r(T') = a$; then $r$ is vacuously PNM, but is not monotonic, since $a$ can gain by moving from $T$ to $T'$, and $b$ can gain by moving from $T'$ to $T$. \
  Analogously, for more than two alternatives we declare the winner based only on the edge between $a$ and $b$ in the same way. PNM still holds because no other pair can influence the result by changing their outcome, but this is still not monotonic.
]

PNM and Condorcet-consistency are mutually exclusive.

#theorem[
  Let $A$ such that $card(A) >= 3$. Any PNM choice rule $r : cal(T)(A) -> A$ is not Condorcet-consistent.
]
#proof[
  Let $A = {a,b,c,...}$, and assume for contradiction that $r$ is both PNM and Condorcet-consistent; we define a tournament $T in cal(T)(A)$ as follows. We let $C = {a,b,c}$ be a component in $T$, where $C T x$ for all $x in A \\ C$. Moreover, inside $C$ we have that $a T b$, $b T c$ and $c T a$. \
  Now, there must be at least two alternatives (there might be three) from $C$ that are different from $r(T)$; without loss of generality $r(T) in.not {a,b}$. Let $T'$ be an adjacent tournament such that $b T' a$. Crucially, $b$ is a Condorcet winner in $T'$. Since $r$ is Condorcet-consistent, it must hold that $r(T') = b$, in contradiction to PNM.
]

In the context of sports it is common practice to use Condorcet-consistent solutions, e.g., select the Copeland winner. Hence the theorem implies that sports tournaments are prone to simple manipulation by pairs of alternatives; any "reasonable" selection of a winner from a sports tournament is susceptible to match fixing! \
However, in social choice theory Condorcet-consistency is far from being universally accepted since, especially in voting-related interpretations of tournaments, it precludes other very basic properties (e.g., _participation_: voters might be hurt by participating in the election).

It is therefore quite natural to ask whether we can obtain PNM by relaxing the notion of Condorcet-consistency. \
We ask whether there is a choice rule that is both PNM and non-imposing. Notice that if there is one alternative or two alternatives, there clearly exists such a rule. \
However, it turns out that there is no such rule when there are exactly three alternatives.

#theorem[
  Let $A$ such that $card(A) = 3$. Any PNM choice rule $r : cal(T)(A) -> A$ is not non-imposing.
]
#proof[
  Let $A = {a,b,c}$ and assume for contradiction that $r$ is PNM and non-imposing. We represent tournaments over $A$ by a string of three bits, where the leftmost, middle and rightmost bits represent the direction of the edges $(a,b)$, $(a,c)$ and $(b,c)$, respectively. Fix an arbitrary tournament as $000$. \
  Assume without loss of generality that $r(000) = a$. By PNM we have:
  - $r(001) = a$, otherwise the coalition ${b,c}$ can gain by switching from $000$ to $001$;
  - $r(100) in {a,b}$, otherwise the coalition ${a,b}$ can gain by switching from $100$ to $000$;
  - $r(010) in {a,c}$, otherwise the coalition ${a,c}$ can gain by switching from $010$ to $000$.
  
  We differentiate two cases:
  
  _Case 1_: $r(111) in {b,c}$. \
  By symmetry, we can assume WLOG that $r(111) = b$. \
  By PNM, $r(101) = b$, $r(110) in {b,c}$, $r(011) in {a,b}$. \
  By non-imposition we must have a tournament where $c$ wins under $r$. By the above, we only have two options, $010$ and $110$. \
  By PNM, since the two tournaments are $(a,b)$-adjacent, if the winner in one of these two tournaments is $c$, the winner in the other is $c$ as well, hence it holds that $r(010) = c$, $r(110) = c$. \
  From $r(110) = c$ and PNM it follows that $r(100) in {a,c}$. We already know that $r(100) in {a,b}$, hence $r(100) = a$. \
  Now by PNM $r(101) = a$, in contradiction to our previous conclusion that $r(101) = b$.

  _Case 2_: $r(111) = a$. \
  By PNM we conclude that $r(110) = a$, $r(101) in {a,c}$ and $r(011) in {a,b}$. \
  By non-imposition we must have a tournament where $b$ wins. We have only two options, $100$ and $011$.  \
  If $r(100) = b$, by PNM $r(110) = b$, in contradiction to $r(110) = a$. \
  Symmetrically, if $r(011) = b$, we must have $r(001) = b$, in contradiction to $r(001) = a$.
]

Surprisingly, the above impossibility result is false if $card(A) > 3$. We establish that for any number of alternatives except three there is a choice rule that satisfies both properties. Moreover, the choice rule we construct is also monotonic.

#theorem[
  Let $A$ such that $card(A) neq 3$. There exists a choice rule $r : cal(T)(A) -> A$ that is monotonic, PNM and non-imposing.
]
#proof[
  #highlight(fill: red)[Omitted.] \
  _Idea_: The construction is inductive; we design a function that switches between the outcomes in ${a,b,c}$ based only on the direction of the edges $(a,b)$ and $(a,c)$. In order to achieve non-imposition, one of the four configurations of the two edges gives us outcomes in $A \\ {a,b,c}$; in order to decide between alternatives in this set, we use the function for $card(A) - 3$ alternatives whose existence is guaranteed by the induction assumption. \
  This technique does not work for three alternatives as the set $A \\ {a,b,c}$ is empty. \
  The main obstacle is using the same technique to obtain a monotonic, PNM, non-imposing rule for six alternatives (despite the impossibility result for three).
]