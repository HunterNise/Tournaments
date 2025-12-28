#import "/template/template.typ": *
#show: rules


= Toward Fair and Strategyproof Tournament Rules for Tournaments with Partially Transferable Utilities

== Introduction

A #highlight(fill: aqua)[tournament] on $n$ agents is a complete oriented graph in which the agents are vertices and an edge from agent $i$ to agent $j$ means "agent $i$ defeats agent $j$". \
These structures frequently arise in sports as the outcome of $binom(n,2)$ pairwise matches between $n$ agents or teams. However, tournaments can arise whenever the performance of every two agents is comparable (e.g., agents are candidates in an election and edges are pairwise majority votes).

A #highlight(fill: aqua)[tournament rule] maps a tournament to a probability distribution over the agents. These probabilities encode the likelihood that each agent is declared the tournament winner, or prescribe how to divide up a monetary reward. \
While a tournament rule should be #highlight(fill: lime)[fair] in that it chooses some qualified agent who beats many other agents, it also should not reward #highlight(fill: lime)[manipulations]: for example, losing a match on purpose should not improve an agent’s or their co-conspirator’s chances of winning the tournament. If the rule is manipulable, then agents may act in ways that undermine the primary goal of choosing a highly qualified winner.

Unfortunately, prior work has shown that fairness and non-manipulability are largely incompatible. \
A prevailing notion of fairness is #highlight(fill: aqua)[Condorcet consistency]. A tournament rule is Condorcet consistent if, whenever one agent beats all other agents, the undefeated agent wins the tournament with certainty.

#highlight(fill: yellow)[Any deterministic rule that satisfies this notion is susceptible to pairwise manipulations]: for any Condorcet consistent rule, there exist tournaments in which two agents can influence the choice of winner by colluding to reverse the outcome of their match.

[...] extended this work to #highlight(fill: aqua)[randomized rules] that map tournaments to probability distributions over agents. They showed that #highlight(fill: yellow)[there exist Condorcet consistent and pairwise non-manipulable rules when two agents collude only if one of them can strictly improve her probability of winning at no cost to the other]. Rules that are pairwise non-manipulable under this assumption are said to be #highlight(fill: aqua)[2-Pareto non-manipulable] (2-PNM). \
However, #highlight(fill: yellow)[no Condorcet consistent rule exists when utility is completely transferable] -- that is, when two agents only care about the probability that at least one of them wins the tournament. Instead, the authors demonstrated rules that are approximately Condorcet consistent and pairwise non-manipulable in this setting, which the authors term #highlight(fill: aqua)[2-strongly non-manipulable] (2-SNM).

Motivated by the fact that collusion and the deliberate throwing of matches in sports occur less frequently than the negative results of prior work imply, we extend prior work to the setting in which utility is partially transferable. These settings are natural. \
For example, consider a setting in which a tournament rule is used to prescribe a division of monetary reward among the participants. Because the reward is divisible, if two agents could improve their share of the reward by fixing the outcome of their match, then they may choose to do so and redistribute their winnings later so that the collusion is mutually beneficial. \
But collusions are rarely so frictionless in reality. There could be uncertainty as to whether the agent that benefits from fixing the outcome of the match will follow through with the redistribution. There could be penalties for agents found to have thrown their matches. Or there could be factors beyond the outcome of the tournament that matter, such as an agent’s reputation, that a loss would negatively affect. \
With these frictions, agents would not be completely altruistic to their partner (fully transferable utility) nor completely selfish (non-transferable utility). Instead, agents would care more about winning themselves but may be willing to sacrifice their own probability if it achieves a significant proportional gain for their partner.

We model each agent’s values for her own probability of winning and for her collusion partner’s probability of winning as being in some ratio and extend prior notions of non-manipulability by introducing a term that accounts for the range of selfishness of agents. \
More specifically, we say a rule is #box(fill: aqua, outset: (bottom: 4pt, top: 2pt))[$2\-"NM"_lambda$] if no agent can collude with another to improve her probability of winning by at least a $lambda + 1$ factor of the decrease in probability witnessed by her colluding partner. Stated another way, under a $2$-$"NM"_lambda$ rule, no pairwise collusions would occur if we assume that each agent would not sacrifice her own chances of winning unless her partner gains at least $lambda + 1$ times the amount that she loses.

In a separate direction, we introduce another notion of fairness, termed #highlight(fill: aqua)[dominant sub-tournament consistency] (DSTC), and show that several natural rules satisfy this condition. Intuitively, a rule is DSTC if the addition of an agent that loses to the original agents does not affect their probabilities. \
A closely related notion is #highlight(fill: aqua)[top cycle consistency] (TCC), which requires the winner to come from the top cycle with certainty. \
We show that within these notions of fairness, the problem of finding a rule that is $2\-"NM"_lambda$ reduces to the problem of finding a rule that witnesses gains from manipulation that vanish as the number of agents increases.

=== Related works

RSEB 2-SNM-1/3 and Condorcet consistent [Schneider et al., 2017] \
RKotH 2-SNM-1/3 and cover consistent [Schvartzman et al., 2020] \
3-SNM-31/60 [Dinev and Weinberg, 2022] \
3-SNM-1/2 [Mikšaník et al., 2024]


== Preliminaries

#definition[Tournament][
  A _tournament_ $T = (A, dominates(T))$ is a pair where $A$ is a finite set of agents and $dominates(T)$ is a complete asymmetric binary relation over $A$ that describes the outcomes of the $binom(card(A), 2)$ matches played between each pair of distinct agents. \
  For agents $i neq j in A$, we write $i dominates(T) j$ if $i$ _dominates_ $j$ in $T$. \
  Let $cal(T)_n$ denote the set of tournaments where $[n]$ is the set of agents.
]

#definition[Tournament rule][
  A _tournament rule on $n$ agents_ $r^((n)) : cal(T)_n -> Delta^n$ maps a tournament $T in cal(T)_n$ to a probability distribution over the agents. \
  A _tournament rule_ $r$ is a family of tournament rules on $n$ agent ${r^((n))}_(n=1)^oo$. \
  For all $n in N$ and $T in cal(T)_n$, we write $r(T) := r^((n))(T)$, and for $i in [n]$, we write $r_i (T)$ to denote the probability that $i$ wins $T$ under $r$.
]

=== Fairness Properties

A desirable tournament rule should choose the most qualified agent as the winner of a tournament. In line with this reasoning, we want a tournament rule to choose an undefeated agent with probability $1$ since this agent is clearly better than the rest of her opponents.

#definition[Condorcet consistency][
   A tournament rule on $n$ agents $r^((n))$ is _Condorcet consistent_ (CC) if for all $T in cal(T)_n$, $r^((n))_i (T) = 1$ whenever there exists $i in [n]$ such that $i dominates(T) j$ for all $j in [n] \\ {i}$. \
   A tournament rule $r$ is CC if $r^((n))$ is CC for all $n$.
]

Note that Condorcet consistency is quite a minimal notion of fairness since it is binding only when there is an agent that is clearly superior than the others. \
Unfortunately, it is often the case that no such agent exists. \
The following notions of fairness seek to restrict the subset of agents that should be named the winner in such cases by eliminating those who are in some sense clearly worse than her opponents.

#definition[Top cycle consistency][
  A subset of agents $S$ is the _top cycle_ in tournament $T$ if it is the minimal subset of agents such that $i dominates(T) j$ for all $i in S$, $j in [n] \\ S$. The top cycle of a tournament always exists and is unique. Let $T C(T)$ denote the top cycle of $T$.
  
  A tournament rule on $n$ agents $r^((n))$ is _top cycle consistent_ (TCC) if for all $T in cal(T)_n$, $r^((n))_i (T) = 0$ for all $i in [n] \\ T C(T)$. \
  A tournament rule $r$ is TCC if $r^((n))$ is TCC for all $n$.
]

Top cycle consistency extends Condorcet consistency quite naturally: Condorcet consistency requires that an undefeated agent be declared the winner, while top cycle consistency requires this winner to come from the smallest undefeated subset. \
Moreover, since the agents in the top cycle are undefeated by those outside of the top cycle, they are in some sense better. On the other hand, no agent in the top cycle is clearly superior than the others since every agent in the top cycle is defeated by another in the top cycle.

#definition[Cover consistency][
  For $i neq j$, we say $i$ _covers_ $j$ if $i dominates(T) j$ and $j dominates(T) k => i dominates(T) k$ for all $k in [n] \\ {i,j}$. \
  Moreover, we say $j$ is _covered_ if there exists $i in [n]$ such that $i$ covers $j$.
  
  A tournament rule on $n$ agents $r^((n))$ is _cover consistent_ if for all $T in cal(T)_n$, $r^((n))_j (T) = 0$ whenever $j$ is covered. \
  A tournament rule $r$ is cover consistent if $r^((n))$ is cover consistent for all $n$.
]

Cover consistency refines top cycle consistency by further restricting the set of potential winners. If $i$ covers $j$, then not only did $i$ defeat $j$, but $i$ also defeated everyone that $j$ defeated. Thus, covered agents are worse than the agents that cover them in some sense.

#definition[Dominant sub-tournament consistency][
  For a subset of agents $S subset.eq [n]$ and a tournament $T in cal(T)_n$, let $T|_S = (S, {(i,j) in S times S : i dominates(T) j})$ denote the subgraph induced by $S$.
  
  $T|_S$ is a _dominant sub-tournament_ in tournament $T$ if $i dominates(T) j$ for all $i in S$, $j in [n] \\ S$.
  
  A tournament rule $r$ is _dominant sub-tournament consistent_ (DSTC) if $r_i (T|_S) = r_i (T)$ for all $i in S$.
]

Dominant sub-tournament consistency strengthens top cycle consistency in a different direction than cover consistency. Rather than narrow down the set of potential winners, dominant sub-tournament consistency requires that the probability of choosing a certain member of the top cycle as the winner is the same as the probability of choosing her if the agents outside the top cycle were removed.

#proposition[Fairness hierarchy][
  Any tournament rule that satisfies either cover consistency or DSTC satisfies TCC. \
  Moreover, any TCC rule is CC.
]
#proof[
   Let $T in cal(T)_n$. Suppose $r$ is a cover consistent tournament rule, and consider any $j in.not T C(T)$. \
   Observe that any $i in T C(T)$ covers $j$ since by definition of the top cycle, we have that $i dominates(T) j$, and for any $k in [n]$ such that $j dominates(T) k$, we have that $k in.not T C(T)$, so $i dominates(T) k$. \
   Since $r$ is cover consistent and $j$ is covered, we have that $r_j (T ) = 0$. Thus, $r$ is TCC.

   Now, suppose $r$ is a DSTC tournament rule. \
   By definition, $T C(T )$ is a dominant sub-tournament of $T$. Thus, 
   $ sum_(i in T C(T)) r_i (T) = sum_(i in T C(T)) r_i (T|_(T C(T))) = 1 \. $
   It follows that $r_i (T) = 0$ for all $i in [n] \\ T C(T )$, so $r$ is TCC.

   Now, suppose $r$ satisfies TCC, and note that whenever some agent $i$ is undefeated in $T$, $i$ is the only member of $T C(T )$: $i$ dominates every $j neq i$, and no proper subset of ${i}$ satisfies this property. Thus, $r_i (T) = 1$ and $r$ is CC.
]

=== Non-manipulability Properties

#definition[$S$-adjacent][
  $T, T' in cal(T)_n$ are _$S$-adjacent_ where $S subset.eq [n]$ if $i dominates(T) j <=> i dominates(T') j$ for $i neq j in [n] \\ S$. \
  In other words, $T$ and $T'$ are $S$-adjacent if they coincide on every match except possibly those between agents in $S$.
]

When utilities are nontransferable, two agents are willing to collude only if one of them can strictly improve her probability of winning at no cost to the other. Formally, distinct agents $i,j in [n]$ collude from tournament $T$ to tournament $T'$ only if both
$ 
  max &{r_i (T') − r_i (T), r_j (T') − r_j (T)} > 0 "and" \
  min &{r_i (T') − r_i (T), r_j (T') − r_j (T)} >= 0 \.
$
Thus, to incentivize agents against such manipulations, a tournament rule must satisfy the following notion of non-manipulability.

#definition[$2$-Pareto non-manipulability][
  A tournament rule $r$ is _$2$-Pareto non-manipulable_ (2-PNM) if for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$, either
  - $min &{r_i (T') − r_i (T), r_j (T') − r_j (T)} < 0$ or
  - $max &{r_i (T') − r_i (T), r_j (T') − r_j (T)} <= 0 \.$
]

There exists a rule that is monotone, TCC, and 2-PNM.

The barrier to pairwise manipulation is much lower when utilities are completely transferable since two agents only care about the probability that at least one of them wins the tournament. In other words, $i$ and $j$ collude from $T$ to $T'$ only if $r_i (T') + r_j (T') > r_i (T) + r_j (T)$. \
Under this utility model, an agent may be willing to sacrifice and shift a significant portion of her probability to her partner in crime. Thus, tournament rules must satisfy a stronger notion of non-manipulability in this setting.

#definition[2-strong non-manipulability][
  A tournament rule $r$ is _$2$-strongly non-manipulable_ ($2$-SNM) if $r_i (T') + r_j (T') <= r_i (T) + r_j (T)$ for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$.
]

#remark[
  By symmetry, we need to have equality: $r_i (T') + r_j (T') = r_i (T) + r_j (T)$.
]

Prior work has shown that no Condorcet consistent tournament rule is $2$-SNM. \
However, despite this strong impossibility result, instances of collusion are relatively infrequent in the real world, suggesting that settings in which utilities are completely transferable are uncommon. On the other hand, instances of collusion are not unheard of, suggesting that utility is neither always nontransferable.

We consider a third utility model in which utilities are partially transferable: distinct agents $i$ and $j$ collude from tournament $T$ to tournament $T'$ only if
$
  r_i (T') + r_j (T') > r_i (T) + r_j (T) + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')} \.
$
In this model, two agents always collude if both of them improve their chances of winning and never collude if both of their chances decrease. The interesting case is when one agent improves her chances at the expense of the other. One interpretation of this necessary condition is that agents would rather win the tournament themselves but are still willing to collude if the gain in probability is significantly larger than each agent’s loss. \
Here, $lambda$ is a parameter that measures how transferable utility is. Note that when $lambda$ is low, utilities are more transferable. We will later see how $lambda$ can be interpreted as agents’ level of selfishness. \
We now define a notion of non-manipulability for this model.

#definition[$2$-non-manipulability for $lambda$][
  A tournament rule $r$ is _$2$-non-manipulable for $lambda >= 0$_ ($2\-"NM"_lambda$) if 
  $
    r_i (T') + r_j (T') <= r_i (T) + r_j (T) + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
  $
  for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$. \
  We say $r$ is $2\-"NM"_oo$ if 
  $
    r_i (T') + r_j (T') <= r_i (T) + r_j (T) + lim_(lambda -> oo) lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
  $
  (where the limit is taken in the extended reals).
]

Observe that when $lambda = 0$, our notion of non-manipulability coincides with strong non-manipulability. Moreover, we show that our notion coincides with Pareto non-manipulability when $lambda = +oo$. \
We remark that we do not interpret $2\-"NM"_λ$ as an approximation to $2$-SNM. Unlike approximation algorithms, a tournament designer who finds herself faced with e.g., agents who value their opponents chances of winning as much as their own (completely transferable utility) may not find it in her best interest to use a $2\-"NM"_λ$ tournament rule for some $lambda > 1$. Rather, $lambda$ is meant to model the behavior of the agents.

#proposition[
  A tournament rule is $2$-PNM if and only if it is $2\-"NM"_oo$.
]
#proof[
  Suppose tournament rule $r$ is not $2$-PNM. Then, there exist distinct agents $i,j in [n]$ and a pair of ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$ such that WLOG $r_i (T') − r_i (T) > 0$ and $r_j (T') − r_j (T) >= 0$. Thus,
  $
    r_i (T') + r_j (T') − r_i (T) − r_j (T) 
    > 0 >= 
    lim_(lambda -> oo) lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
  $
  so $r$ is not $2\-"NM"_oo$.

  Conversely, take $r$ to be $2$-PNM, so for all distinct agents $i,j in [n]$ and ${i,j}$-adjacent $T neq T' in cal(T)_n$, either
  #set enum(numbering: "(1)")
  + WLOG $r_i (T') − r_i (T) < 0$, in which case
    $
      r_i (T') + r_j (T') − r_i (T) − r_j (T) 
      < +oo = 
      lim_(lambda -> oo) lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
    $
  + or $max {r_i (T') − r_i (T), r_j (T') − r_j (T)} <= 0$, in which case
    $
      r_i (T') + r_j (T') − r_i (T) − r_j (T) 
      <= 0 <= 
      lim_(lambda -> oo) lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
    $
  Thus, $r$ is $2\-"NM"_oo$.
]

We are interested in approximately non-manipulable tournament rules; that is, rules under which no two agents can collude to gain in joint probability more than $alpha$ more than each agent’s loss (weighted by $lambda$). \
We will see later that there is a range of $lambda$ for which fair and non-manipulable tournament rules do not exist. For $lambda$ in this range, it may be better to design approximately non-manipulable tournament rules tailored to $lambda$ than use a $2\-"NM"_lambda'$ tournament rule for some $lambda' > lambda$.

#definition[$2$-non-manipulability up to $alpha$ for $lambda$][
  A tournament rule $r$ is _$2$-non-manipulable up to $alpha$ for $lambda >= 0$_ ($2\-"NM"_lambda\-alpha$) if 
  $
    r_i (T') + r_j (T') <= r_i (T) + r_j (T) + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')} + alpha
  $
  for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$.
]

In addition to being robust against pairwise manipulations, a tournament rule should be robust to the intentional throwing of matches.

#definition[Monotonicity][
  A tournament rule is _monotone_ if $r_i (T) >= r_i (T')$ for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$ such that $i dominates(T) j$.
]

Intuitively, monotonicity says that no agent should be able to improve her chances of winning by deliberately losing one of her matches. Thus, agents have an incentive to win each of their matches under monotone rules. Violations of this property should be seen as quite severe.

#proposition[
  Let $r$ be a $2\-"NM"_lambda$ tournament rule for some $lambda > 0$, then the following two statements are equivalent.
  + $r$ is monotone
  + For all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$ such that $i dominated(T) j$
    $
      r_i (T') - r_i (T) <= (lambda + 1) (r_j (T) - r_j (T'))
    $
]
#proof[
  Let $T neq T' in cal(T)_n$ be ${i,j}$-adjacent tournaments such that $i dominated(T) j$ (and thus $i dominates(T') j$), and suppose $r$ is monotone. \
  Then, by monotonicity, $r_i (T') >= r_i (T)$ and $r_j (T) >= r_j (T')$; \
  in other words $r_i (T) - r_i (T') <= 0 <= r_j (T) - r_j (T')$, so 
  $
    r_i (T') - r_i (T) 
    &<= r_j (T) - r_j (T') + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')} \
    &= (lambda + 1) (r_j (T) - r_j (T'))
  $
  where the inequality follows from the fact that $r$ is $2\-"NM"_lambda$.

  Now, suppose the second statement holds. Applying the second statement twice yields
  $
    r_i (T') - r_i (T) <= (lambda + 1) (r_j (T) - r_j (T')) \
    r_j (T) - r_j (T') <= (lambda + 1) (r_i (T') - r_i (T))
  $
  Multiplying the second inequality by $lambda + 1$, adding the result to the first inequality, and simplifying yields
  $
    lambda (lambda + 2) (r_i (T') - r_i (T)) >= 0
  $
  Since $r$ is $2\-"NM"_lambda$ for $lambda > 0$, this inequality implies $r_i (T') >= r_i (T)$.
]

This proposition offers a natural interpretation of the parameter $lambda$ and the $2\-"NM"_lambda$ property for monotone tournament rules: $lambda$ is how much each agent weighs her own probability of winning over others’ probabilities of winning and, if a tournament rule is $2\-"NM"_lambda$, then switching the outcome of a match does not increase the probability of winning for the new winner by more than a $lambda + 1$ factor over the loss of the new loser. Note that the proposition does not hold for $lambda = 0$. Indeed, monotonicity and $2$-SNM are independent properties: neither implies the other.

=== Tournament Rules

+ The *Iterative Condorcet Rule* (ICR) chooses the undefeated agent if one exists. Otherwise, eliminate an agent uniformly at random and repeat.
+ The *Randomized Voting Caterpillar* rule (RVC) begins by choosing a permutation of the agents uniformly at random. In the first iteration, RVC eliminates the loser between the first and second agents in the permutation. In each subsequent iteration until only one agent remains, RVC eliminates the loser between the previous winner and the next agent in the permutation.
+ The *Top Cycle Rule* (TCR) chooses an agent uniformly at random from the top cycle and declares her the winner.
+ A _single elimination bracket_ is a complete binary tree whose leaves are labeled by a permutation of the agents. Each node is labeled by the winner of the match between its two children. The winner of the bracket is the agent labeling the root node. \
  The *Randomized Single Elimination Bracket* rule (RSEB) introduces $2^ceil(log n) − n$ dummy agents who lose to the existing agents, chooses a bracket uniformly at random, and declares the winner of this bracket the winner of the tournament.
+ The *Randomized King of the Hill* rule (RKotH) chooses the undefeated agent if one exists. Otherwise, choose an agent uniformly at random, eliminate her and the agents she dominates, and repeat.
+ The *Randomized Death Match* rule (RDM) chooses a pair of agents uniformly at random, eliminates the loser, and repeats.
+ The *PageRank* (PR) (*with Self-Loops* (PRSL)) rule chooses agent $i$ as the winner with probability
  #let pr = $op("pr")$
  $
    r_i (T) = cases(
      pr_i (T|_(T C (T)))\, quad &i in T C (T),
      0\,                        &i in.not T C (T)
    )
  $
  where for a strongly connected (sub)tournament $S$, $pr(S)$ is the unique solution to the following linear system of equations:
  $
    &forall i, half pr_i (S) = sum_(j : i dominates(S) j) vfrac(1, card({k : j dominated(S) k}) + bb(1)("PRSL")) pr_j (S)
  \
    inline(
      &sum_i pr_i (S) = 1
    )
  $
  Note that both PR and PRSL are well-defined since the top cycle is strongly connected, so the stationary distribution is indeed unique. PageRank’s recursive definition is natural for tournaments: an agent has high PageRank if she beats many other agents with high PageRank.

#theorem[
  - RSEB satisfies TCC but neither DSTC nor cover consistency.
  - ICR, RVC, TCR, RDM, PR and PRSL satisfy DSTC but not cover consistency.
  - RKotH satisfies both DSTC and cover consistency.
  - ICR, RVC, TCR, RSEB, RKotH, and RDM are monotone.
]
#proof[
  #highlight(fill: orange)[To do.]
]


== Lower Bounds

It was shown that no Condorcet consistent tournament rule is $2\-"NM"_0\-alpha$ for $alpha < 1/3$. \
The same lower bound construction yields:

#theorem[
  No CC tournament rule is $2\-"NM"_lambda\-alpha$ for $lambda < 1 - 3 alpha$.
]
#proof[
  Suppose tournament rule $r$ is CC and $2\-"NM"_lambda\-alpha$, and consider any tournament $T$ on $[n]$ in which $1$ dominates $2$, $2$ dominates $3$, and $3$ in turn dominates $1$; all the others lose to $1,2,3$. Note that any two agents among ${1,2,3}$ can collude so that one of them becomes undefeated. \
  Consider the ${1,2}$-adjacent tournament $T'$ where $1 dominated(T') 2$. Since $2$ is the Condorcet winner, by CC we have $r_2 (T') = 1$ and $r_1 (T') = 0$. By $2\-"NM"_lambda\-alpha$ we have
  $
    r_1 (T') + r_2 (T') - r_1 (T) - r_2 (T) <= lambda max {r_1 (T) − r_1 (T'), r_2 (T) − r_2 (T')} + alpha
  $
  But $r_1 (T) − r_1 (T') = r_1 (T) >= 0$ and $r_2 (T) − r_2 (T') = r_2 (T) - 1 <= 0$, so the condition becomes
  $
    1 - r_1 (T) - r_2 (T) <= lambda r_1 (T) + alpha
  $
  Analogously for the other manipulations,
  $
    1 - r_2 (T) <= (lambda + 1) r_1 (T) + alpha \
    1 - r_3 (T) <= (lambda + 1) r_2 (T) + alpha \
    1 - r_1 (T) <= (lambda + 1) r_3 (T) + alpha \
  $
  Adding these three inequalities together and isolating $lambda$ yields
  $
    3 - [r_1 (T) + r_2 (T) + r_3 (T)] <= (lambda + 1) [r_1 (T) + r_2 (T) + r_3 (T)] + 3 alpha
  \
    3 - 3 alpha <= (lambda + 2) [r_1 (T) + r_2 (T) + r_3 (T)]
  \
    vfrac(3(1-alpha), r_1 (T) + r_2 (T) + r_3 (T)) - 2 <= lambda
  $
  Since $r_1 (T) + r_2 (T) + r_3 (T) <= 1$, this inequality implies that $lambda >= 1 - 3 alpha$.
]

#corollary[
  No Condorcet consistent tournament rule is $2\-"NM"_lambda$ for $lambda < 1$.
]

#conjecture[
  There exists a tournament rule that is monotone, Condorcet consistent, and $2\-"NM"_1$.
]

We now consider several tournament rules and examine their trade-offs between $alpha$ and $lambda$. Interestingly, the superman-kryptonite tournament (and its variants) is responsible for all our lower bounds, suggesting that it is especially problematic.

#definition[Superman-kryptonite tournament][
  The _superman kryptonite tournament_ on $[n]$ has $i dominates(T) j$ whenever $i < j$, except $n dominates(T) 1$. In particular, superman $1$ dominates all agents but kryptonite $n$, and $n$ is dominated by all agents except $1$.
]

#theorem[
  Assume the following rules to satisfy $2\-"NM"_lambda\-alpha$ for some $lambda >= 0$.
  - RSEB, then $alpha >= Omega(1/n)$.
  - RKotH or PR, then $alpha >= Omega(1)$.
  That is, RSEB, RKotH and PR are always pairwise manipulable regardless of $lambda$.
]
#proof[
  #highlight(fill: orange)[To do.]
]

#theorem[
  Assume the following rules to satisfy $2\-"NM"_lambda\-alpha$ for some $lambda >= 0$.
  - ICR, then $lambda >= (1 - O(alpha)) Omega(n^2)$.
  - RDM, then $lambda >= (1 - O(n alpha)) Omega(n)$.
  - RVC, TCR or PRSL, then $lambda >= (1 - O(alpha)) Omega(n)$.
]
#proof[
  #highlight(fill: orange)[To do.]
]


== Reductions

#highlight(fill: red)[Omitted.]