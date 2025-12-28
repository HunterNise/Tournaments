#import "/template/template.typ": *
#show: rules


= Condorcet-Consistent and Approximately Strategyproof Tournament Rules

== Introduction

[...] Olympic Badminton (like many other sports) conducts a two-phase tournament. In the first stage, groups of four play a round-robin tournament, with the top two teams advancing. In the second stage, the advancing teams participate in a single elimination tournament, seeded according to their performance in the group stage. An upset in one group left one of the world’s top teams with a low seed, so many teams actually preferred to receive a lower seed coming out of the group stage to face the tougher opponent as late as possible.

Specifically, the two-phase tournament lacks the basic property of #highlight(fill: aqua)[_monotonicity_], where no competitor can unilaterally improve their chances of winning by throwing a match that they otherwise could have won. Thus, recent work has addressed the question of whether tournament structures exist that are both #highlight(fill: lime)[fair], in that they select some notion of a qualified winner, and #highlight(fill: lime)[strategyproof], in that teams have no incentive to do anything but play their best in each match.

One minimal notion of fairness studied is #highlight(fill: aqua)[Condorcet-consistence], which just guarantees that whenever one competitor wins all of their matches (and is what’s called a Condorcet winner), they win the event with probability 1. \
Designing Condorcet-consistent, monotone rules is simple: any single elimination bracket suffices. Popular voting rules such as the Copeland Rule or the Random Condorcet Removal Rule are also Condorcet-consistent and monotone, but #highlight(fill: yellow)[two-phase tournaments with an initial group play aren’t].

Still, monotonicity only guarantees that no team wishes to unilaterally throw a match to improve their chances of winning, whereas one might also hope to guarantee that no two teams could fix the outcome of their match in order to improve the probability that one of them wins.

Motivated by match-based applications such as sporting events, where the outcome of pair-wise matches is explicitly learned and used to select a winner, we consider instead the design of tournament rules that are exactly Condorcet-consistent, but only #highlight(fill: aqua)[approximately 2-SNM]. Specifically, we say that a tournament rule is 2-SNM-$alpha$ if it is never possible for two teams $i$ and $j$ to fix their match such that the probability that the winner is in ${i,j}$ improves by at least $alpha$. \
The idea behind this relaxation is that whatever motivates $j$ to throw the match (perhaps $j$ and $i$ are teammates, perhaps $i$ is paying $j$ some monetary bribe, etc.), the potential gains scale with $alpha$. So it is easier to disincentivize manipulation (either through investigations and punishments, reputation, or just feeling morally lousy) in tournaments that are less manipulable.

=== Our Results

Our main result is a matching upper and lower bound of $1/3$ on attainable values of $alpha$ for Condorcet-consistent $2$-SNM-$alpha$ tournament rules. The optimal rule that attains this upper bound is actually quite simple: a random single elimination bracket. Specifically, each competitor is randomly placed into one of $2^ceil(log_2 n)$ seeds, along with $2^ceil(log_2 n) - n$ byes~#fmark, and then a single elimination tournament is played.
#ftext[
  automatic advancement of teams to the next round due to $n$ not being a power of $2$
]

Proving a lower bound of $1/3$ is straight-forward: imagine a tournament with three players, $A$, $B$ and $C$, where $A$ beats $B$, $B$ beats $C$, and $C$ beats $A$. Then some pair must win with combined probability at most $2/3$. Yet, any pair could create a Condorcet winner by colluding, who necessarily wins with probability $1$ in any Condorcet-consistent rule. Embedding this within examples for arbitrary $n$ is also easy: just have $A$, $B$, and $C$ each beat all of the remaining $n−3$ competitors.

We also show that the Copeland rule, a popular rule that chooses the team with the most wins, is asymptotically $2$-SNM-$1$, the worst possible. Essentially, the problem is that if all teams have the same number of wins, then any two can collude to guarantee that one of them wins, no matter the tie-breaking rule. We further show that numerous other formats, (the Random Voting Caterpillar, the Iterative Condorcet Rule, and the Top Cycle Rule) are all at best $2$-SNM-$1/2$. The same example is bad for all three formats: there is one superman who beats $n − 2$ of the remaining players, and one kryptonite, who beats only the superman (but loses to the other $n−2$ players).

Our results extend to settings where the winner of each pairwise match is not deterministically known, but randomized (i.e. all participants know that $i$ will beat $j$ with probability $p_(i j)$). Specifically, we show that any rule that is $2$-SNM-$alpha$ when all $p_(i j) in {0,1}$ is also $2$-SNM-$alpha$ for arbitrary $p_(i j)$. \
Clearly, any lower bound using integral $p_(i j)$ also provides a lower bound for arbitrary $p_(i j)$, so as far as upper/lower bounds are concerned the models are equivalent. Of course, the randomized model is much more realistic, so it is convenient that we can prove theorems in this setting by only studying the deterministic setting, which is mathematically much simpler.

Finally, we consider manipulations among coalitions of $k > 2$ participants. We say that a rule is $k$-SNM-$alpha$ if no set $S$ of size $<= k$ can ever manipulate the outcomes of matches between players in $S$ to improve the probability that the winner is in $S$ by more than $alpha$. We prove a simple lower bound of $alpha = vfrac(k−1, 2k-1)$ on all Condorcet-consistent rules, and conjecture that this is tight.

=== Related works

#highlight(fill: red)[Omitted.]

=== Conclusions and Future Work

#highlight(fill: red)[Omitted.]


== Preliminaries and Notation

#definition[tournament][
  A (round-robin) _tournament_ $T$ on $n$ players is the set of outcomes of the $binom(n,2)$ games played between all pairs of distinct players. We write $T_(i j) = 1$ if player $i$ beats player $j$ and $T_(i j) = −1$ otherwise. We also let $cal(T)_n$ denote the set of tournaments on $n$ players.
]

#definition[adjacent tournaments][
  For a subset $S subset.eq [n]$ of players, two tournaments $T$ and $T'$ are _$S$-adjacent_ if they only differ on the outcomes of some subset of games played between members of $S$. \
  In particular, two tournaments $T$ and $T'$ are ${i,j}$ adjacent if they only differ in the result of the game played between player $i$ and player $j$.
]

#definition[tournament rule][
  A _tournament rule_ (or _winner determination rule_) $r : cal(T)_n -> Delta([n])$ is a mapping from the set of tournaments on $n$ players to probability distributions over these $n$ players (representing the probability we choose a given player to be the winner). We will write $r_i (T) = Pr[r(T) = i]$ to denote the probability that player $i$ wins tournament $T$ under rule $r$.
]

#definition[Condorcet-consistency][
  Player $i$ is a _Condorcet winner_ in tournament $T$ if player $i$ wins their match against all the other $n - 1$ players.
  
  A tournament rule $r$ is _Condorcet-consistent_ if $r_i (T) = 1$ whenever $i$ is a Condorcet winner in $T$.
]

#definition[monotonicity][
  A tournament rule $r$ is _monotone_ if, for all $i$, $r_i (T)$ does not increase when $i$ loses a game it wins in $T$. That is, if $i$ beats $j$ in $T$ and $T$ and $T'$ are ${i,j}$ adjacent, then if $r$ is monotone, $r_i (T) >= r_i (T')$.
]

Intuitively, this first criterion requires us to award the prize to the winner in the case of a clear winner (hence making the tournament a contest of skill), and the second criterion makes it so that players have an incentive to win their games.

In this paper, we consider the scenario where certain coalitions of players attempt to increase the overall chance of one of them winning by manipulating the outcomes of matches within players of the coalition. The simplest case of this is in the case of coalitions of size $2$, where player $j$ might throw their match to player $i$. If $T$ is the original tournament and $T'$ is the manipulated tournament where $j$ loses to $i$, then player $i$ gains $r_i (T') − r_i (T)$ from the manipulation, and player $j$ loses $r_j (T) − r_j (T')$ (in terms of probability of winning). Therefore, as long as $r_i (T') − r_i (T) > r_j (T) − r_j (T')$, it will be in the players’ interest to manipulate. \
Equivalently, if $r_i (T') + r_j (T') > r_i (T) + r_j (T)$ (i.e., the probability either player $i$ or $j$ wins increases upon throwing the match), there is incentive for $i$ and $j$ to manipulate.

Ideally, we would like to choose a tournament rule so that, regardless of the tournament, there will be no incentive to perform manipulations of the above sort.

#definition[Strong non-manipulability][
  A tournament rule $r$ is _$2$-strongly non-manipulable_ ($2$-SNM) if, for all pairs of ${i,j}$-adjacent tournaments $T$ and $T'$, $r_i (T) + r_j (T) = r_i (T') + r_j (T')$.
]

Unfortunately, no tournament rules exist that are simultaneously Condorcet-consistent and $2$-strongly non-manipulable. \
As tournament designers, one way around this obstacle is to discourage manipulation. This discouragement can take many forms, both explicit (if players are caught fixing matches, they are disqualified/fined) and implicit (it is logistically hard to fix matches, it is unsportsmanlike). \
So the focus of this paper is to quantify how manipulable certain tournament formats are (i.e. how much can teams possibly gain by fixing matches), the idea being that it is easier to discourage manipulation in tournaments that are less manipulable.

#definition[
  A tournament rule $r$ is _$2$-strongly non-manipulable at probability $alpha$_ ($2$-SNM-$alpha$) if, for all $i$ and $j$ and pairs of ${i,j}$-adjacent tournaments $T$ and $T'$, $r_i (T') + r_j (T') − r_i (T) − r_j (T) <= alpha$.
]

#definition[
  A tournament rule $r$ is _$k$-strongly non-manipulable at probability $alpha$_ ($k$-SNM-$alpha$) if, for all subsets $S$ of players of size at most $k$, for all pairs of $S$-adjacent tournaments $T$ and $T'$, $sum_(i in S) r_i (T') − sum_(i in S) r_i (T) <= alpha$.
]

=== The Random Single-Elimination Bracket Rule

#definition[
  A _single-elimination bracket_ (or _bracket_, for short) $B$ on $n = 2^h$ players is a complete binary tree of height $h$ whose leaves are labelled with some permutation of the $n$ players. The outcome of a bracket $B$ under a tournament $T$ is the labelling of internal nodes of $B$ where each node is labelled by the winner of its two children under $T$. The winner of $B$ under $T$ is the label of the root of $B$ under this labelling.
]

#definition[
  The _random single-elimination bracket rule_ $r$ is a tournament rule on $n = 2^h$ players where $r_i (T)$ is the probability player $i$ is the winner of $B$ under $T$ when $B$ is chosen uniformly at random from the set of $n!$ possible brackets. \
  If $n$ is not a power of $2$, we define the random single-elimination bracket rule on $n$ players by introducing $2^ceil(log_2 n) - n$ dummy players who lose to all of the existing $n$ players.
]

It is straightforward to check that the random single-elimination bracket rule is both Condorcet-consistent and monotone. Our main result (@Thm-3.3) shows that in addition to these properties, the random single-elimination bracket rule is $2$-SNM-$1/3$ (which is the best possible, by @Thm-3.1).


== Results

=== Lower bounds for $k$-SNM-$alpha$

#theorem(label: "Thm-3.1")[
  There is no Condorcet-consistent tournament rule on $n$ players (for $n >= 3$) that is $2$-SNM-$alpha$ for $alpha < vfrac(1,3)$.
]
#proof[
  Consider the tournament $T$ on three players $A$, $B$, and $C$ where $A$ beats $B$, $B$ beats $C$, and $C$ beats $A$. 
  Note that, while this tournament has no Condorcet winner, changing the result of any of the three games results in a Condorcet winner. For example, if $A$ bribes $C$ to lose to $A$, then $A$ becomes the Condorcet winner.

  If we have a tournament rule $r$ that is $2$-SNM-$alpha$, then combining this with the above fact gives rise to the following three inequalities.
  $
    r_A (T) + r_B (T) >= 1 - alpha \
    r_B (T) + r_C (T) >= 1 - alpha \
    r_C (T) + r_A (T) >= 1 - alpha \
  $
  Together these imply $r_A (T) + r_B (T) + r_C (T) >= vfrac(3,2) (1−alpha)$. \
  But $r_A (T) + r_B (T) + r_C (T) = 1$; it follows that $alpha >= vfrac(1,3)$, as desired.
  
  We can extend this counterexample to $n > 3$ players by introducing $n − 3$ dummy players who all lose to $A$, $B$, and $C$; the argument above continues to hold, since $r_A (T) + r_B (T) + r_C (T) <= 1$.
]

#theorem(label: "Thm-3.2")[
  There is no Condorcet-consistent tournament rule on $n$ players (for $n >= 2k − 1$) that is $k$-SNM-$alpha$ for $alpha < vfrac(k-1, 2k-1)$.
]
#proof[
  Consider the following tournament $T$ on the $2k − 1$ players labelled $1$ through $2k − 1$. Each player $i$ wins their match versus the $k − 1$ players $i + 1, i + 2, ..., i + (k − 1)$, and loses their match versus the $k − 1$ players $i − 1, i − 2, ..., i − (k − 1)$ (indices taken modulo $2k − 1$). \ Note that the coalition of players $S_i = {i, i − 1, ..., i − (k − 1)}$ of size $k$ can cause $i$ to become a Condorcet winner if all players in the coalition agree to lose their games with $i$.
  
  If we have a tournament rule $r$ that is $k$-SNM-$alpha$, then this implies the following $2k − 1$ inequalities (one for each $i in [2k − 1]$):
  $
    sum_(j in S_i) r_j (T) >= 1 - alpha
  $

  Summing these $2k − 1$ inequalities, we obtain
  $
    k sum_(j = 1)^(2k - 1) r_j (T) >= (2k - 1)(1 - alpha)
  $

  Since $sum_(j = 1)^(2k - 1) r_j (T) <= 1$, this implies that $alpha >= vfrac(k-1, 2k-1)$, as desired. 
  
  Again, it is possible to extend this example to any number of players $n >= 2k − 1$ by introducing dummy players who lose to all $2k − 1$ of the above players.
]

=== Random single elimination brackets are $2$-SNM-$1/3$

We now show that the random single elimination bracket rule is optimal against coalitions of size $2$. The proof idea is simple; for every bracket $B$ that contributes to the incentive to manipulate $r_i (T') + r_j (T') − r_i (T) − r_j (T)$ we will show that there are two that do not (in other words, for every scenario where team $i$ benefits from the manipulation, there exist two other scenarios where the manipulation does not benefit either team).

#theorem(label: "Thm-3.3")[
  The random single elimination bracket rule is $2$-SNM-$1/3$.
]
#proof[
  Let $cal(B)$ be the set of $n!$ different possible brackets amongst the $n$ players. For a given tournament $T$ and a given player $i$, write $bb(1) (B,T,i)$ to represent the indicator variable which is $1$ if $i$ wins bracket $B$ under the outcomes in $T$ and $0$ otherwise. Then we can write
  $
    r_i (T) = 1/abs(cal(B)) sum_(B in cal(B)) bb(1) (B,T,i)
  $

  Assume $i$ loses to $j$ in $T$. Then, if we let $T'$ be the tournament that is ${i,j}$ adjacent to $T$, we can write the increase in utility resulting from $j$ throwing to $i$

  #math.equation(
    block: true, 
    numbering: "(1)", 
    $ 1/abs(cal(B)) sum_(B in cal(B)) big(( bb(1) (B,T',i) + bb(1) (B,T',j) - bb(1) (B,T,i) - bb(1) (B,T,j) )) $
  ) <eq3>

  Our goal is to show that this sum is at most $1/3$.
  
  Now, note that if $i$ does not end up playing $j$ in bracket $B$ under $T$, $i$ also does not play $j$ in $B$ under $T'$ (and vice versa). In these brackets, $bb(1) (B,T',i) = bb(1) (B,T,i)$ and $bb(1) (B,T',j) = bb(1) (B,T,j)$, so these brackets contribute nothing to the sum in @eq3. \
  On the other hand, in a bracket $B$ where $i$ does play $j$, we are guaranteed that $bb(1) (B,T,i) = 0$ and $bb(1) (B,T',j) = 0$ (since $i$ loses to $j$ in $T$ and $j$ loses to $i$ in $T'$). \
  Therefore, letting $B_(i j)$ be the subset of $B$ of brackets where $i$ meets $j$, we can rewrite @eq3 as
  $
    1/abs(cal(B)) sum_(B in cal(B)) big(( bb(1) (B,T',i) - bb(1) (B,T,j) ))
  $

  Since $bb(1) (B,T',i) <= 1$, this is at most
  $
    1/abs(cal(B)) sum_(B in cal(B)) big(( 1 - bb(1) (B,T,j) ))
  $

  This final sum counts exactly the number of brackets $B$ where $i$ and $j$ meet (under $T$, so $j$ beats $i$) but $j$ does not win the tournament. Call such brackets _bad_, and call the remaining brackets _good_. \
  We will exhibit two injective mappings $sigma_i$ and $sigma_j$ from bad brackets to good brackets such that the ranges of $sigma_i$ and $sigma_j$ are disjoint. This implies that there are at least twice as many good brackets as bad brackets, and thus that the sum above is at most $1/3$, completing the proof.
  
  #highlight(fill: orange)[To be continued ...]
]

=== Extension to randomized outcomes

#highlight(fill: orange)[To do.]

=== Other tournament formats

Finally, there are many other tournament formats that are either used in practice or have been previously studied. In this section we show that many of these formats are more susceptible to manipulation than the random single elimination bracket rule; in particular, all of the following formats are at best $2$-SNM-$1/2$.

By far the most common tournament rule for round robin tournaments is some variant of a ‘scoring’ rule, where the winner is the player who has won the most games (with ties broken in some fashion if multiple players have won the same maximum number of games). In voting theory, this rule is often called Copeland’s rule, or Copeland’s method.

#definition[Copeland rule][
  A tournament rule $r$ is a _Copeland rule_ if the winner is always selected from the set of players with the maximum number of wins.
]

We begin by showing that no Copeland rule can be $2$-SNM-$alpha$ for any $alpha < 1$ (regardless of how the rule breaks ties).

#theorem[
  There is no Copeland rule on $n$ players that is $2$-SNM-$alpha$ for $alpha < 1 - vfrac(2, n-1)$.
]
#proof[
  Assume to begin that $n = 2k + 1$ is odd, and let $r$ be a Copeland rule on $n$ players. \
  Let $T$ be the tournament where each player $i$ beats the $k$ players ${i + 1, i + 2, ..., i + k}$ but loses to the $k$ players ${i − 1, i − 2, ..., i − k}$, with indices taken modulo $n$ (similar to the tournament in the proof of @Thm-3.2).

  Since $sum_(i=1)^n r_i (T) = 1$, there must be some $i$ such that $r_(i−1) (T) + r_i (T) <= vfrac(2,n)$. On the other hand, if player $i − 1$ throws their match to player $i$, then player $i$ becomes the unique Copeland winner (winning $k + 1$ games) and $r_i (T') = 1$. \
  It follows that, for such a rule, if $r$ is $2$-SNM-$alpha$, then $alpha >= 1 − vfrac(2,n)$.

  If $n$ is even, then we can embed the above example for $n − 1$ by assigning one player to be a dummy player that loses to all teams. This immediately implies $alpha >= 1 − vfrac(2, n-1)$ in this case.
]

Other examples of tournament rules that are Condorcet-consistent and monotone are: \ the top cycle rule, the iterative Condorcet rule, and the randomized voting caterpillar rule. \
The following tournament will provide lower bounds on $alpha$ against all of them.

#definition[superman-kryptonite tournament][
  The _superman-kryptonite_ tournament on $n$ players has $i$ beat $j$ whenever $i < j$, except that player $n$ beats player $1$. That is, player $1$ beats everyone except for player $n$, who loses to everyone except for player $1$.
]

#definition[top cycle rule][
  The _top cycle_ of a tournament $T$ is the minimal set of players who beat all other players.
  
  The _top cycle rule_ is a tournament rule which assigns the winner to be a uniformly random element of this set.
]

#theorem[
  The top cycle rule on $n$ players is not $2$-SNM-$alpha$ for any $alpha < 1 - vfrac(2,n)$.
]
#proof[
  Let $T$ be the superman-kryptonite tournament on $n$ players. \
  The top cycle in $T$ contains all the players, so $r_1 (T) + r_n (T) = vfrac(2,n)$. \
  However, if player $n$ throws their match to player $1$, player $1$ becomes a Condorcet winner and $r_1 (T') = 1$. It follows that $alpha >= 1 - vfrac(2,n)$.
]

#definition[iterative Condorcet rule][
  The _iterative Condorcet rule_ is a tournament rule that uniformly removes players at random until there is a Condorcet winner, and then assigns that player to be the winner.
]

#theorem[
  The iterative Condorcet rule on $n$ players is not $2$-SNM-$alpha$ for any $alpha < vfrac(1,2) - vfrac(1, n(n-1))$.
]
#proof[
  Let $T$ be the superman-kryptonite tournament on $n$ players. \
  Note that no Condorcet winner will appear until either player $1$ is removed, player $n$ is removed, or all other $n − 2$ players are removed.
  
  If all the other $n − 2$ players are removed before players $1$ or $n$ (which occurs with probability $vfrac(2 dot (n-2)!, n!) = vfrac(2, n(n-1))$), then player $n$ wins. \
  If this does not happen and player $n$ is removed before player $1$ (which occurs with probability $vfrac(1,2) (1 - vfrac(2, n(n-1))) = vfrac(1,2) - vfrac(1, n(n-1))$), then player $1$ becomes the Condorcet winner and wins. \
  Otherwise, player $1$ will be removed before player $n$, while some players in $2$ through $n − 1$ remain, and one of them will become the Condorcet winner (the remaining player in ${2, ..., n−1}$ with lowest index). \
  It follows that $r_1 (T) = vfrac(1,2) - vfrac(1, n(n-1))$ and $r_2 (T) = vfrac(2, n(n-1))$, so $r_1 (T) + r_2 (T) = vfrac(1,2) + vfrac(1, n(n-1))$.

  On the other hand, if player $n$ throws their match to player $1$, then again player $1$ becomes a Condorcet winner and $r_1 (T') = 1$. It follows that $alpha >= vfrac(1,2) - vfrac(1, n(n-1))$.
]

#definition[randomized voting caterpillar rule][
   The _randomized voting caterpillar rule_ is a tournament rule which chooses a winner as follows. Choose a random permutation $pi$ of $[n]$. Start by matching $pi (1)$ and $pi (2)$, and choose a winner according to $T$. Then for all $i >= 3$, match $pi (i)$ with the winner of the most recent match. The player that wins the last match (against $pi (n)$) is declared the winner.
]

#theorem[
  The randomized voting caterpillar rule on $n$ players is not $2$-SNM-$alpha$ for any $alpha < vfrac(1,2) - vfrac(n-2, n(n-1))$.
]
#proof[
  Let $T$ be the superman-kryptonite tournament on $n$ players.
  
  The only way player $1$ loses is if either player $n$ occurs later in $pi$ than player $1$ (which happens with probability $vfrac(1,2)$) or if $pi (n) = 1$ and $pi (1) = 2$ and they play in the first round (which happens with probability $vfrac(1, n(n-1))$). \
  The only way player $n$ can win is if $pi (n) = n$ (i.e., they only play the very last game), in which case they will play player $1$ and win (this happens with probability $vfrac(1,n)$). \
  It follows that $r_1 (T) = vfrac(1,2) - vfrac(1, n(n-1))$ and $r_n (T) = vfrac(1,n)$, so $r_1 (T) + r_n (T) = vfrac(1,2) + vfrac(n-2, n(n-1))$.

  On the other hand, if player $n$ throws their match to player $1$, then again player $1$ becomes a Condorcet winner and $r_1 (T') = 1$. It follows that $alpha >= vfrac(1,2) - vfrac(n-2, n(n-1))$.
]


#figure(
  //include "/figures/art3-2.typ",
  image("/figures/art3-2.svg", width: auto),
  caption: [
    Lower bounds for $alpha$ for $2$-SNM-$alpha$ rules \
    (remember the universal $1/3$ lower bound)
  ]
)