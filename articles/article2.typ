#import "/template/template.typ": *
#show: rules


= Nonmanipulable Randomized Tournament Selections

== Introduction

Participants in sporting tournaments often act selfishly in order to increase their potential gains. Situations such as a team deliberately throwing a match, or several teams colluding to fix the outcome of a match are common and undesirable. This introduces the need for tournament designs that are resistant to such manipulations.

A #highlight(fill: aqua)[_tournament_] is a complete pairwise dominance relation over a set of agents $A$. \
In previous works, a choice rule was defined as selecting a non-empty subset of the alternatives, members of which are tied for winning the tournament. Such #highlight(fill: aqua)[set selection rules] make no attempt to break such ties. \
Our notion of #highlight(fill: aqua)[tournament choice rules] explicitly assigns winning probabilities to each alternative. These can be interpreted as an actually lottery to determine the winner, or a prescribed division of a monetary prize.

Choice rules from tournaments are directly tied to #highlight(fill: lime)[voting], where a tournament is used to represent the pairwise majority relation in an election; that is, an alternative $x$ wins a match against alternative $y$ if a majority of the voters prefer $x$ to $y$. \
Such majority relationships frequently admit cycles. \
Any tournament may arise from an election with at least three voters, therefore tournament choice rules are equivalent to election methods that only consider pairwise majority.

A previous paper introduced choice rules that select an alternative given a tournament, that is, functions from the set of all tournaments over $A$ to $A$. The players in this setting are the alternatives. In their model, as in this paper, an alternative cannot announce that it dominates an alternative that it loses to. However, an alternative can lose on purpose to another alternative. In other words, if $x in A$ dominates $y in A$, $x$ can cheat by reversing the outcome of the match between itself and $y$, but $y$ cannot reverse the outcome of this match unless $x$ agrees. \
They have studied manipulations of such #highlight(fill: aqua)[deterministic choice rules] by a single agent throwing a match, or by a pair of agents fixing a match. They have shown a strong negative result for the existence of deterministic Condorcet-consistent non-manipulable choice rules.

In this paper we extend this framework to consider #highlight(fill: aqua)[randomized choice rules] which allow lotteries among the alternatives. Randomized choice rules can be used as a fair way of breaking ties in a tournament, and can also be viewed as a means of dividing a title or prize amongst the co-winners of a tournament. \
We consider two distinct ways of extending the notion of non-manipulability to the randomized setting: in the weaker version, #highlight(fill: aqua)[Pareto non-manipulability (PNM)], we consider only manipulations where all manipulators stand to gain, or at least not lose from the manipulation. \
In contrast, #highlight(fill: aqua)[Strong non-manipulability (SNM)] requires immunity to any manipulation where the sum of the manipulators’ utilities increases.


== Tournaments and Manipulations

#definition[tournament][
  Let $A$ be a set of alternatives. A _tournament_ $T$ over $A$ is a complete asymmetric binary relation over $A$. In other words, for every two distinct alternatives $x,y in A$, exactly one of the following holds: $x T y$ (read: $x$ _dominates_ $y$), or $y T x$. We denote the set of tournaments over $A$ by $cal(T)$.
]

A common visual way to represent tournaments is via graphs. A tournament $T in cal(T)$ corresponds to a directed graph $G = (V, E)$, where $V = A$, and the directed edge from $x$ to $y$ is in $E$ if and only if $x T y$. In other words, $G$ is an orientation of the complete graph on $A$. \
In the sequel we will use the terms alternatives, participants, nodes, and agents interchangeably.

#definition[choice rule][
  A _choice rule_ is a mapping $r : cal(T) -> Delta(A union {epsilon})$ that maps each tournament to a probability distribution over the alternatives, with a possibility of selecting no alternative ($epsilon$).
  
  A tournament choice rule is called _strict_ if $r_T (epsilon) = 0$ for all $T in cal(T)$. \
  A tournament choice rule is called _deterministic_ if $r_T (a) in {0,1}$ for all $T in cal(T)$ and $a in A$.
]

A simple requirement from a randomized choice rule is to be independent of the names of the alternatives. This requirement is reasonable since ties could always be broken using randomization.

#definition[anonymity][
  A choice rule $r$ is called _anonymous_ if for every tournament $T in cal(T)$ and for every permutation $pi$ of $A$: $pi(r_T) eq.triple r_pi(T)$.
]

We observe that any choice rule can be made into an anonymous choice rule by randomly permuting the names of the alternatives before applying a choice rule. Therefore, in the remainder of this paper we will implicitly limit our discussion to anonymous choice rules.

We would expect a desirable choice rule to use randomization only when there is some kind of tie for winner. In particular, we would like a clear-cut winner, which beats all other participants to always win the tournament.

#definition[Condorcet consistency][
  Alternative $x$ is a _Condorcet winner_ in $T in cal(T)$ if $x T y$ for all $y in A \\ {x}$.
  
  A tournament choice rule $r$ is called _Condorcet consistent_ if for all $T in cal(T)$ such that $c$ is a Condorcet winner in $T$: $r_T (c) = 1$.
]

Similarly, we can define the notion of a Condorcet loser, which should never win a tournament:

#definition[Condorcet loser consistency][
  Alternative $x$ is a _Condorcet loser_ in $T in cal(T)$ if $y T x$ for all $y in A \\ {x}$.
  
  A tournament choice rule $r$ is called _Condorcet loser consistent_ (CLC) if for all $T in cal(T)$ such that $c$ is a Condorcet loser in $T$: $r_T (c) = 0$.
]

Our main focus in this paper is resistance to manipulations by a pair of participants. Such manipulations involve the flipping of an edge in the tournament graph. This brings rise to the following definition of adjacency:

#definition[adjacent tournaments][
  We say that $T$ and $T'$ are _$S$-adjacent_ for some $S subset.eq A$ if and only if the two tournaments disagree only on edges in $S$, that is for all ${z,w} subset.eq.not S : z T w iff z T' w$.
]

The most simple manipulation a single participant may consider is throwing a match, that is losing a match they could have won. Resistance to this kind of manipulation coincides with the property of _monotonicity_, which means winning a match cannot reduce the winner’s probability of winning the tournament.

#definition[monotonicity][
  A choice rule $r$ is _monotonic_ if and only if for all $T eq.not T' in cal(T)$ that are ${x,y}$-adjacent and $x T y$: $r_T (x) >= r_T' (x)$. \
  Such a rule is _strictly monotonic_ if these inequalities are strict.
]

When considering manipulations by a pair of participants, we consider two distinct utility models. When utility is #highlight(fill: lime)[not transferable], a manipulation is valid only if neither of the manipulators are worse off and at least one of the manipulators is better off. We call this Pareto Manipulation:

#definition[Pareto non-manipulability][
  A choice rule $r$ is _Pareto non-Manipulable for coalitions of size $k$_ ($k$-PNM) if for every $S subset.eq A$ such that $card(S) <= k$ and for every $T,T' in cal(T)$ that are $S$-adjacent: $exists x in S : r_T (x) > r_T' (x)$ or $forall x in S : r_T (x) >= r_T' (x)$. \
  We say that $r$ is PNM if it is $k$-PNM for any $k in NN$.
]

If we assume #highlight(fill: lime)[transferable] utility, a much stronger manipulation resistance is required, as the manipulators only care about their combined probability of winning the tournament:

#definition[Strong non-manipulability][
  A choice rule $r$ is _Strongly non-Manipulable for coalitions of size $k$_ ($k$-SNM) if for every $S subset.eq A$ such that $card(S) <= k$ and for every $T,T' in cal(T)$ that are $S$-adjacent: $sum_(x in S) r_T (x) = sum_(x in S) r_T' (x)$. \
  We say that $r$ is SNM if it is $k$-SNM for any $k$.
]

Note that in the case of deterministic choice rules the above definitions of non-manipulability are equivalent, and both variants of non-manipulability are extensions of the non-manipulability property for deterministic choice rules.


== Pareto Manipulation

The intuition behind Condorcet consistency can be extended to any tournament using the concept of a top cycle:

#definition[top cycle][
  A set of alternatives $C subset.eq A$ is the _top cycle_ in $T in cal(T)$ [notation: $C = T C(T)$] if for all $x in C, y in A \\ C$: $x T y$ and $C$ is the minimal such set.
]

The top cycle is well-defined since the set of all alternatives $A$ satisfies the condition and the minimal set is unique.

#remark[
  If there is a Condorcet winner, then the top cycle is just a singleton (namely the Condorcet winner itself).
]

We can now define the following special case of Condorcet consistency.

#definition[top cycle condition][
  A choice rule $r$ satisfies the _top cycle condition_ (TCC) if for every tournament $T in cal(T)$: $r_T (x) > 0$ implies $x in T C(T)$. \
  The rule $r$ further satisfies the _strong top cycle condition_ if for every tournament $T$: $x in T C(T)$ also implies $r_T (x) > 0$.
]

Another useful property of a choice rule is consistent behavior between different sizes of tournaments.

#definition[Condorcet loser removal condition][
  A choice rule $r$ satisfies the _Condorcet loser removal condition_ (CLR) if for every tournament $T in cal(T)$ such that there exists a Condorcet loser $c in A$: $r_T eq.triple r_(T\\{c})$. That is, $r$ assigns the same probability distribution for $T$ and $T$ where $c$ is removed.
]

Note that for strict choice rules, the CLR implies that a Condorcet loser must be chosen with zero probability.

We shall now present several examples of strict choice rules that satisfy 2-PNM, monotonicity, strong TCC, and CLR:
- The _Iterative Condorcet Rule_ (ICR) is defined algorithmically as follows: Let $T$ be the input tournament. If $x$ is a Condorcet winner in $T$, output $x$ and stop. Otherwise, remove a random alternative $y in A$ and repeat.
- The _Randomized Voting Caterpillar_ (RVC) selects a random permutation $pi$ of $A$ and then selects the winner of the voting caterpillar defined by $pi$. That is, the winner of iterative pairwise matches between the previous winner and next participant according to $pi$.
- The _Top Cycle Rule_ (TCR) simply assigns probability $vfrac( 1, card(T C(T)) )$ for all elements in $T C(T)$ and zero otherwise.

The three rules defined above are all different. #highlight(fill: orange)[To do.]

#proposition[
  ICR, RVC, and TCR satisfy 2-PNM, monotonicity, strong TCC, and CLR. \
  Moreover, TCR satisfies PNM while ICR and RVC do not satisfy 3-PNM.
]
#proof[
  #highlight(fill: orange)[To do.]
]


== Strong Non-manipulability

In this section we discuss the stronger notion of manipulations where utility is transferable. We begin by noting that the impossibility theorem for deterministic rules equally applies to strongly non-manipulable randomized rules.

#proposition[
  There exist no 2-SNM Condorcet-consistent choice rules.
]

This impossibility result requires us to weaken either the non-manipulability or Condorcet-consistency requirement. We have already discussed a weaker version of non-manipulability, therefore we will now focus on choice rules that are approximately Condorcet consistent. Specifically, we aim to maximize the approximation ratio while maintaining non-manipulability.

#definition[Condorcet consistency value][
  A choice rule $r$ has _Condorcet consistency value_ $alpha : NN |-> [0,1]$ if for all $T in cal(T)$ such that $c$ is a Condorcet winner in $T$: $r_T (c) >= alpha(card(A))$.
]

The following simple choice rule could serve as a lower bound for the Condorcet consistency value of SNM choice rules.

#proposition[
  There exists a SNM, strictly monotone, CLC, strict choice rule which has Condorcet consistency value of $vfrac(2,n)$.
]
#proof[
  The required choice rule simply selects two alternatives uniformly at random, and then chooses the winner of the pairwise match between them. Equivalently, every alternative is chosen with probability
  $
    r_T (x) = 2 / n(n-1) dot card({y : x T y})
  $
  If $x$ is a Condorcet winner, then $card({y : x T y}) = n-1$ and $r_T (x) = vfrac(2,n)$.

  - strict: one alternative is always picked since the dominance relation is complete;
  - strictly monotone: losing on purpose reduces the number of winning matches;
  - CLC: a Condorcet loser cannot win any match, in other words $card({y : x T y}) = 0$;
  - SNM: since we can only reverse edges in $S$, we are just moving the counting of the winning matches from one addend to the other; for example, if we have the tournaments $T, T'$ such that they are ${x,x'}$-adjacent, $x dominates(T) x'$ and $x' dominates(T') x$, then $card({y : x dominates(T) y}) = card({y' : x' dominates(T') y'})$.
]

This lower bound is tight in the case where non-manipulability is required for coalitions of size $3$:

#theorem[
  There exists no choice rule that is $3$-SNM and has a Condorcet consistency value $alpha > vfrac(2,n)$.
]
#proof[
  Assume for contradiction choice rule $r$ satisfying the conditions of the theorem. \
  Let $T$ be a tournament of size $n$ where for all $i < j in A$: $j T i$. In particular alternative $n$ is a Condorcet winner in $T$, and by consistency we have $r_T (n) > vfrac(2,n)$. \
  Consider any three agents $i-1, i, i+1 in A$. Consider the tournament $T'$ which is ${i−1, i+1}$-adjacent to $T$ such that $(i−1) T' (i+1)$. This manipulation creates a $3$-cycle in the graph: $i T' (i−1) T' (i+1) T' i$, where agents $i−1, i, i+1$ are completely symmetric. 
  Since this is a manipulation by $i−1$ and $i+1$, we have
  $
    r_T' (i-1) + r_T' (i+1) = r_T (i-1) + r_T (i+1)
  $
  and by symmetry 
  $
    r_T' (i-1) = r_T' (i+1) = 1/2 [r_T (i-1) + r_T (i+1)]
  $

  However, this could also be seen as a manipulation by the trio $(i−1, i, i+1)$, and hence 
  $
    r_T' (i-1) + r_T' (i) + r_T' (i+1) = r_T (i-1) + r_T (i) + r_T (i+1)
  $
  by symmetry
  $
    r_T' (i-1) = r_T' (i) = r_T' (i+1) = 1/3 [r_T (i-1) + r_T (i) + r_T (i+1)]
  $
  
  Equating the two expressions for $r_T' (i-1)$
  $ 
    1/2 [r_T (i-1) + r_T (i+1)] = 1/3 [r_T (i-1) + r_T (i) + r_T (i+1)]
  \
    cancel(3) [r_T (i-1) + r_T (i+1)] = 2 [cancel(r_T (i-1)) + r_T (i) + cancel(r_T (i+1))]
  \
    2 r_T (i) = r_T (i+1) + r_T (i−1)
  $

  This recurrence means the sequence $(r_T (1), ..., r_T (n))$ is an arithmetic progression:
  $
    cases(
      r_T (1) = a,
      r_T (k) = a + (k-1) d \, quad k = 1\, ...\, n
    )
  \
    2 [a + (i-1) d] = [a + i d] + [a + (i-2) d]
  $
  Our goal is to find an upper bound on the value of $r_T (n)$.
  
  Combined with conditions $r_T (k) >= 0 half forall k in {1,...,n}$ and $sum_(k=1)^n r_T (k) <= 1$~#fmark, we get that
  $
    sum_(k=1)^n r_T (k) = a dot n + d dot n(n-1) / 2 <= 1
  $
  #ftext[
    Remember the no-alternative $epsilon$.
  ]
  
  The maximum value of $a$, given a fixed $d$, is
  $
    a_max = vfrac( 1 - d dot n(n-1) / 2, n )
  $
  and the condition $a_max >= a = r_T (1) >= 0$ is equivalent to $d <= vfrac(2, n(n-1))$. Plugging in
  $
    r_T (n) &<= a_max + (n-1) d \
            &= 1/n - d dot (n-1)/2 + (n-1) d \
            &= 1/n + d dot (n-1)/2
  $
  Now we maximize by plugging the maximum valued of $d$
  $
    r_T (n) &<= 1/n + d_max dot (n-1)/2 \
            &= 1/n + vfrac(cancel(2), n cancel((n-1))) dot cancel((n-1)) / cancel(2) \
            &= 2/n
  $
  in contradiction to our assumption.
]

For coalitions of size 2, we know the following upper
bound on $alpha$:

#proposition[
  There exist no 2-SNM choice rules that have Condorcet-consistency value $alpha > vfrac(2,3)$.
]
#proof[
  Assume for contradiction a choice rule $r$ that satisfies the requirements, and consider a tournament $T$ of arbitrary size $n$ with a top cycle of three elements ${a,b,c}$. Any pair of these elements may manipulate to make one of them a Condorcet winner, gaining at least $alpha$. Hence,
  $
    r_T (a) + r_T (b) > 2/3 \
    r_T (a) + r_T (c) > 2/3 \
    r_T (b) + r_T (c) > 2/3
  $
  and therefore, by summing
  $
    2 [r_T (a) + r_T (b) + r_T (c)] > 3 dot 2/3 = 2
  \
    r_T (a) + r_T (b) + r_T (c) > 1
  $
  which is a contradiction.
]

Given a tournament size $n$, the problem of finding a choice rule with a maximal Condorcet consistency value for $2$-SNM tournaments of that size could be expressed as a linear program: #highlight(fill: red)[Omitted.]