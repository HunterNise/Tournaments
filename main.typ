#import "/template/template.typ": *
#show: rules

#set page(numbering: "1")
#set heading(numbering: "1.")
#show heading.where(level: 2): set heading(numbering: none)

// hack for overwriting math-env counter
#import "@preview/rich-counters:0.2.2": *
#let c = rich-counter(identifier: "math-env", inherited_levels: 1, inherited_from: heading)

#let definition = definition.with(counter: c)
#let theorem = theorem.with(counter: c)
#let proposition = proposition.with(counter: c)
#let lemma = lemma.with(counter: c)
#let corollary = corollary.with(counter: c)

// write articles in the bibliography in the given order
#for k in range(1,4) [
  #cite(label("article" + str(k)), form: none)
]



#text(size: 18pt, weight: "bold")[
  #set align(center)
  Fair and Strategy-proof Tournament Rules Design
]

#v(2em)

#definition(counter: none)[Tournament][
  A _tournament_ $T = (A, dominates(T))$ is a pair where 
  - $A$ is a finite set, whose elements are called _agents/alternatives/participants/players_
  - $dominates(T)$ is a complete asymmetric binary relation over $A$, \
    that describes the outcomes of the $binom(card(A), 2)$ matches played between each pair of distinct agents.
]

#notation[
  For agents $i neq j in A$, we write $i dominates(T) j$ if $i$ _dominates_ $j$ in $T$. \
  Let $cal(T)(A)$ denote the set of tournaments over $A$. \
  If the set of agents is clear we write just $cal(T)$.
  
  Since $A$ is finite we will identify it with $[n] := {1,...,n}$, where $n = card(A)$. \
  Let $cal(T)_n := cal(T)([n])$ denote the set of tournaments on $n$ agents. 
]

#remark[
  A tournament $T in cal(T)(A)$ can also be represented as an oriented graph $G = (V, arrow(E))$, where the set of nodes/vertices $V$ coincide with the set of agents $A$, and the edges are given by the tournament relation: the oriented edge from $i$ to $j$ is in $arrow(E)$ if and only if $i dominates(T) j$. In other words, $G$ is an orientation of the complete graph on $A$.
]

Given a tournament it is natural to consider some criteria, called _tournament rules_ or _choice rules_, that select some kind of winner. The result could be:
- a single alternative (_deterministic rule_)
- a collection of alternatives (_set selection rule_)
- a probability distribution over the set of alternatives (_probabilistic/randomized rule_)

We are interested in designing rules that are both _fair_ (selects a meritable alternative) and _resistant to manipulations_ (alternatives do not benefit from match-fixing).

#v(1em)
#line(length: 100%, stroke: (thickness: 0.2pt))
#v(1em)

Each chapter, except the last, is based on one of the references (in order of appearance). \
For @article3 and @article4 I used the ArXiv version.

//#pagebreak()


#outline(depth: 1)

#pagebreak()


= Deterministic Rules

We start by considering deterministic tournament rules.

#definition[(Deterministic) Tournament Rule][
  A _(deterministic) tournament rule over $A$_ is a map $r : cal(T)(A) -> A$, that maps each tournament to a winner.
]

== Fairness

A fairly intuitive fairness condition is that an alternative which dominates all the others should be the winner.

#definition[Condorcet Winner][
  Alternative $x$ is a _Condorcet winner_ in tournament $T in cal(T)(A)$ if $x dominates(T) y$ for all $y in A \\ {x}$.
]

#remark[
  For a given tournament the Condorcet winner may not exists, \ but if it does then it is unique (for completeness + asymmetry).
]

#definition[Condorcet Consistency][
  A (deterministic) tournament rule $r$ is _Condorcet consistent_ if $r$ always selects the Condorcet winner for every tournament, if one exists.
]

== Non-manipulability

We consider the following kind of manipulations:
- an individual player can lose on purpose a match that it could have won, or in other words, can reverse outgoing edges (but not incoming ones!);
- two or more players can collude to reverse some of the outcomes of the matches between players in the coalition.
Our goal is to prevent such manipulations.

In either case a manipulation involves switching to a second tournament which is similar to the original, but with some edges reversed.

#definition[Adjacent Tournaments][
  Two tournaments $T, T' in cal(T)(A)$ are _$S$-adjacent_ for $S subset.eq A$ if they differ only on edges in $S$, \ that is for all $z,w in.not S$ we have $z dominates(T) w iff z dominates(T') w$.
]

A successful manipulation of the first kind is that in which a losing player can become the winner of the tournament after reversing an outgoing edge.

#definition[Monotonicity][
  A (deterministic) tournament rule $r : cal(T)(A) -> A$ is _monotone_ (or _monotonic_) if \ for all $T in cal(T)(A)$, for all $x in A$ such that $r(T) neq x$, and for all $y in A$ such that $x dominates(T) y$, \ if $T$ and $T'$ are ${x,y}$-adjacent then $r(T') neq x$.
]

#example[
  Consider the rule which selects the alternative with maximum outdegree (also known as _Copeland rule_). Since this may not be unique, we need a tie-breaking mechanism (for example based on lexicographic order or just pick one at random). \
  If an alternative loses on purpose it only decreases its outdegree, hence this rule is monotone.

  On the contrary, the rule which selects the alternative with minimum outdegree is #underline[not] monotone. Indeed, in this case losing matches is rewarded in order to win the tournament.
]

A successful manipulation of the second kind for two players is achieved when one of them becomes the winner of the tournament after reversing the outcome of their match.

#definition(label: "PNM")[Pairwise Non-Manipulability][
  A (deterministic) tournament rule $r : cal(T)(A) -> A$ is _pairwise non-manipulable_ (PNM) if \ for all tournaments $T in cal(T)(A)$ and all alternatives $x,y in A$, \ if $T$ and $T'$ are ${x,y}$-adjacent then $r(T) in {x,y} iff r(T') in {x,y}$.
]

#remark[
  PNM is incomparable with monotonicity.

  Indeed, monotonicity clearly does not imply PNM. For example, consider Copeland rule (which is monotone) on a $3$-cycle $x dominates(T) y dominates(T) z dominates(T) x$ : since they have all same outdegree, for tie-breaking $x$ would be the winner; but ${y,z}$ can collude to reverse their outcome and let $z$ win.

  In the other direction, let $A = {a,b}$ such that $a dominates(T) b$ and $b dominates(T') a$ in the only two possible tournaments $T$ and $T'$. Set $r(T) = b$ and $r(T') = a$; then $r$ is vacuously PNM, but is not monotone, since $a$ can gain by moving from $T$ to $T'$, and $b$ can gain by moving from $T'$ to $T$. \
  Analogously, for more than two alternatives we declare the winner based only on the edge between $a$ and $b$ in the same way. PNM still holds because no other pair can influence the result by changing their outcome, but this is still not monotone.
]

== Impossibility result

PNM and Condorcet-consistency are mutually exclusive.

#theorem(label: "teo1")[
  Let $A$ such that $card(A) >= 3$. \
  Any PNM (deterministic) tournament rule $r : cal(T)(A) -> A$ is not Condorcet consistent.
]
#proof[
  Let $A = {a,b,c,...}$, and assume for contradiction that $r$ is both PNM and Condorcet consistent; we define a tournament $T in cal(T)(A)$ as follows. We let $C = {a,b,c}$ be a subset of $A$, where $C dominates(T) x$ for all $x in A \\ C$. Moreover, inside $C$ we have that $a dominates(T) b$, $b dominates(T) c$ and $c dominates(T) a$. \
  Now, there must be at least two alternatives (there might be three) from $C$ that are different from $r(T)$; without loss of generality $r(T) in.not {a,b}$. Let $T'$ be an adjacent tournament such that $b dominates(T') a$. Crucially, $b$ is a Condorcet winner in $T'$. Since $r$ is Condorcet consistent, it must hold that $r(T') = b$, in contradiction to PNM.
]

#figure(
  image("/figures/PNM CC.png", width: auto)
)

#pagebreak()

== Non-imposition

It is natural to ask whether we can obtain PNM by relaxing the notion of Condorcet consistency.

#definition[Non-Imposition][
  A tournament rule $r : cal(T)(A) -> A$ is _non-imposing_ if it is onto $A$, \ i.e. for every $x in A$ there exists $T in cal(T)(A)$ such that $r(T) = x$.
]

#remark[
  Clearly Condorcet consistency implies non-imposition. \
  Indeed, given any alternative $x in A$, consider a tournament $T$ where $x$ is a Condorcet winner; then if $r$ is Condorcet consistent, $r(T) = x$.
]

We ask whether there is a tournament rule that is both PNM and non-imposing. Notice that if there is one alternative or two alternatives, there clearly exists such a rule. \
However, it turns out that there is no such rule when there are exactly three alternatives.

#theorem[
  Let $A$ such that $card(A) = 3$. \
  Any PNM tournament rule $r : cal(T)(A) -> A$ is not non-imposing.
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
  By PNM, since the two tournaments are ${a,b}$-adjacent, if the winner in one of these two tournaments is $c$, the winner in the other is $c$ as well, hence it holds that $r(010) = c$, $r(110) = c$. \
  From $r(110) = c$ and PNM it follows that $r(100) in {a,c}$. We already know that $r(100) in {a,b}$, hence $r(100) = a$. \
  Now by PNM $r(101) = a$, in contradiction to our previous conclusion that $r(101) = b$.

  _Case 2_: $r(111) = a$. \
  By PNM we conclude that $r(110) = a$, $r(101) in {a,c}$ and $r(011) in {a,b}$. \
  By non-imposition we must have a tournament where $b$ wins. We have only two options, $100$ and $011$.  \
  If $r(100) = b$, by PNM $r(110) = b$, in contradiction to $r(110) = a$. \
  Symmetrically, if $r(011) = b$, we must have $r(001) = b$, in contradiction to $r(001) = a$.
]

Surprisingly, the above impossibility result is false if $card(A) > 3$. We establish that for any number of alternatives except three there is a tournament rule that satisfies both properties. Moreover, the tournament rule we construct is also monotone.

#theorem[
  Let $A$ such that $card(A) neq 3$. \
  There exists a tournament rule $r : cal(T)(A) -> A$ that is monotone, PNM and non-imposing.
]
#proof[
  #highlight(fill: red)[Omitted.] \
  _Idea_: The construction is inductive; we design a function that switches between the outcomes in ${a,b,c}$ based only on the direction of the edges $(a,b)$ and $(a,c)$. In order to achieve non-imposition, one of the four configurations of the two edges gives us outcomes in $A \\ {a,b,c}$; in order to decide between alternatives in this set, we use the function for $card(A) - 3$ alternatives whose existence is guaranteed by the induction assumption. \
  This technique does not work for three alternatives as the set $A \\ {a,b,c}$ is empty. \
  The main obstacle is using the same technique to obtain a monotone, PNM, non-imposing rule for six alternatives (despite the impossibility result for three).
]

#pagebreak()


= Probabilistic Rules

Instead of requiring a rule to select a winner we can ask for a normalized score for each alternative, which can be interpreted as the probability of winning the tournament or as a way to divide a prize.

Let $Delta^n = {(x_1, ..., x_n) in RR^n_+ : x_1 + ... + x_n = 1}$ and $Delta(X) = Delta^(card(X))$ for $X$ finite set.

#definition[(Probabilistic/Randomized) Tournament Rule][
  A _(probabilistic/randomized) tournament rule over $A$_ is a map $r : cal(T)(A) -> Delta(A)$, that maps each tournament to a probability distribution over the alternatives.

  A _tournament rule on $n$ agents_ is a map $r^((n)) : cal(T)_n -> Delta^n$. \
  A _tournament rule_ $r$ is a family of tournament rules on $n$ agents for every $n in NN$: ${r^((n))}_(n=1)^infinity$.
]

Since we consider only tournaments over finite sets, we may use these definitions interchangeably under the name "tournament rule" (it will be clear from context how to disambiguate).

#notation[
  For $T in cal(T)_n$ we write $r(T) := r^((n))(T)$, and for $i in [n]$ we write $r_i (T) := (r(T))_i$ to denote the probability that $i$ wins $T$ under $r$.

  In general we say that a property holds for a tournament rule $r$ if it holds for every element $r^((n))$ of the family.
]

#remark[
  #cite(<article2>, form: "prose") admit the possibility to select no alternative by modelling rules as maps $cal(T)(A) -> Delta(A union epsilon)$; but since we will be studying rules for any number of agents anyway, this does not change the theory.
]

Notice that this definition of probabilistic rule generalizes the previous case:

#definition[Deterministic Tournament Rule][
  A (probabilistic) tournament rule over $A$ is _deterministic_ if for every tournament $T in cal(T)(A)$ \ and for every alternative $a in A$ we have $r_a (T) in {0,1}$.
]

From now on we consider only probabilistic rules, so we update our previous definitions and introduce some new ones.

== Fairness

A simple requirement from a probabilistic tournament rule is to be independent of the names of the alternatives. This requirement is reasonable since ties could always be broken using randomization.

#definition[Anonymity][
  A tournament rule $r$ over $A$ is called _anonymous_ if for every tournament $T in cal(T)(A)$ \ and for every permutation $pi$ of $A$ we have $pi(r(T)) eq.triple r(pi(T))$.
]

We are not really interested in non anonymous rules.

#definition[Condorcet Consistency][
  A tournament rule $r$ over $A$ is _Condorcet consistent_ (CC) if for all tournaments $T in cal(T)(A)$ where $c$ is a Condorcet winner in $T$ we have $r_c (T) = 1$.

  Equivalently, $r_z (T) = 0$ for all $z in A, z neq c$.
]

The intuition behind Condorcet consistency can be extended to any tournament using the concept of a top cycle.

#definition[Top Cycle][
  A subset of alternatives $C subset.eq A$ is the _top cycle_ in tournament $T in cal(T)(A)$ if \ it is the minimal subset of alternatives such that $x dominates(T) y$ for all $x in C, y in A \\ C$. \
  We denote the top cycle of $T$ as $T C(T)$.
]

#remark[
  The top cycle is well-defined (in particular is not empty) since the set of all alternatives $A$ satisfies the condition and the minimal set is unique.
]

Now we can define a condition that requires the winner to be part of the top cycle.

#definition[Top Cycle Consistency][
  A tournament rule $r$ over $A$ is _top cycle consistent_ (TCC) if for every tournament $T in cal(T)(A)$ \ we have that $r_x (T) > 0$ implies $x in T C(T)$.
  
  Equivalently, if $z in.not T C(T)$ then $r_z (T) = 0$.
]

#example[
  The _Top Cycle Rule_ (TCR) simply assigns probability $vfrac( 1, card(T C(T)) )$ for all elements in $T C(T)$ and zero otherwise. \
  This rule is clearly top cycle consistent.
]

#remark[
  If there is a Condorcet winner, then the top cycle is just a singleton (namely the Condorcet winner itself). \
  Thus top cycle consistency implies Condorcet consistency.
]

== Non-manipulability

#definition[Monotonicity][
  A tournament rule $r$ over $A$ is _monotone_ if for all tournaments $T neq T' in cal(T)(A)$ that are \ ${x,y}$-adjacent and $x dominates(T) y$ we have $r_x (T) >= r_x (T')$.
]

When utility is _not transferable_, a manipulation is valid only if neither of the manipulators are worse off and at least one of the manipulators is better off. We call this Pareto manipulation.

#definition[Pareto Non-Manipulability][
  A tournament rule $r$ over $A$ is _Pareto non-manipulable for coalitions of size up to $k$_ ($k$-PNM) if \ for every $S subset.eq A$ such that $card(S) <= k$ and for every tournaments $T,T' in cal(T)(A)$ that are $S$-adjacent we have that $exists x in S : r_x (T) > r_x (T')$ or $forall x in S : r_x (T) >= r_x (T')$. \
  We say that $r$ is PNM~#fmark if it is $k$-PNM for any $k in NN$.
]
#ftext[
  Not to be confused with @PNM.
]

If we assume _transferable_ utility, a much stronger manipulation resistance is required, as the manipulators only care about their combined probability of winning the tournament: that is, a manipulation is valid only if the combined probability of the coalition increases as a result.

#definition[Strong Non-Manipulability][
  A tournament rule $r$ over $A$ is _strongly non-manipulable for coalitions of size up to $k$_ ($k$-SNM) if \ for every $S subset.eq A$ such that $card(S) <= k$ and for every tournaments $T,T' in cal(T)(A)$ that are $S$-adjacent we have $sum_(x in S) r_x (T) = sum_(x in S) r_x (T')$. \
  We say that $r$ is SNM if it is $k$-SNM for any $k in NN$.
]

#remark[
  Note that in the case of deterministic tournament rules the above definitions of non-manipulability are equivalent, and both variants of non-manipulability are extensions of the non-manipulability property for deterministic tournament rules.
]

== Results

#proposition(label: "TCR")[
  TCR satisfies monotonicity and PNM.
]
#proof[
  Notice that reversing an edge may never decrease the size of the top cycle without removing the loser from the top cycle, and may never allow the loser into the top cycle unless it was already in the top cycle. So TCR is monotone.

  To see TCR satisfies PNM, note that a successful manipulation must either reduce the size of the top cycle while all coalition members remain within, or add a new manipulator to the top cycle while keeping the top cycle of the same size. Both cases require the manipulators to remove a non-manipulator from the top cycle. For that to happen, all alternatives directly or indirectly dominated by that non-manipulator must also be removed from the top cycle, and this is only possible if at least one manipulator is removed from the top cycle, in contradiction to PNM.
]

We exhibited a rule which is monotone, Pareto non-manipulable and top cycle consistent (thus Condorcet consistent).

Unfortunately, we cannot do the same for the notion of strong non-manipulability.

#proposition(label: "teo2")[
  There exist no 2-SNM Condorcet consistent tournament rules.
]
#proof[
  Same as @teo1, with the appropriate changes of notation.
]

This impossibility result requires us to weaken either the non-manipulability or Condorcet consistency requirement.

#v(1em)
== Approximate Condorcet Consistency

We start by weakening the notion of Condorcet consistency: we allow a Condorcet winner to be selected only with high probability.

#definition[Condorcet Consistency Value][
  A tournament rule $r$ on $n$ alternatives has _Condorcet consistency value_ $gamma in [0,1]$ if \ for all $T in cal(T)_n$ such that $c$ is a Condorcet winner in $T$ we have $r_c (T) >= gamma$.

  A tournament rule $r = \{r^((n))\}_(n=1)^oo$ has Condorcet consistency value $gamma : NN -> [0,1]$ if \ the rule on $n$ alternatives $r^((n))$ has Condorcet consistency value $gamma (n)$ for every $n in NN$.
]

The following simple tournament rule provides a lower bound for the Condorcet consistency value of SNM tournament rules.

#proposition[
  There exists a monotone SNM tournament rule which has Condorcet consistency value of $vfrac(2,n)$.
]
#proof[
  The required rule simply selects two alternatives uniformly at random, and then chooses the winner of the pairwise match between them. Equivalently, every alternative is chosen with probability
  $
    r_x (T) = 2 / n(n-1) dot card({y : x dominates(T) y})
  $
  If $x$ is a Condorcet winner, then $card({y : x dominates(T) y}) = n-1$ and $r_x (T) = vfrac(2,n)$.

  The rule is (strictly) monotone, since losing on purpose reduces the number of winning matches. It is also SNM: since we can only reverse edges in $S$, we are just moving the counting of the winning matches from one addend to the other; for example, if we have the tournaments $T, T'$ such that they are ${x,x'}$-adjacent, $x dominates(T) x'$ and $x' dominates(T') x$, then $card({y : x dominates(T) y}) = card({y' : x' dominates(T') y'})$.
]

This lower bound is tight in the case where non-manipulability is required for coalitions of size $3$.

#theorem[
  There exists no tournament rule that is $3$-SNM and has a Condorcet consistency value $gamma > vfrac(2,n)$.
]
#proof[
  Assume for contradiction tournament rule $r$ satisfying the conditions of the theorem. \
  Let $T$ be a tournament of size $n$ where for all $i < j in A$ we have $i dominated(T) j$. In particular alternative $n$ is a Condorcet winner in $T$, and by consistency we have $r_n (T) > vfrac(2,n)$. \
  Consider any three agents $i-1, i, i+1 in A$. Consider the tournament $T'$ which is ${i−1, i+1}$-adjacent to $T$ such that $(i−1) dominates(T') (i+1)$. This manipulation creates a $3$-cycle in the graph: $i dominates(T') (i−1) dominates(T') (i+1) dominates(T') i$, where agents $i−1, i, i+1$ are completely symmetric. 
  Since this is a manipulation by $i−1$ and $i+1$, we have
  $
    r_(i-1) (T') + r_(i+1) (T') = r_(i-1) (T) + r_(i+1) (T)
  $
  and by symmetry 
  $
    r_(i-1) (T') = r_(i+1) (T') = 1/2 [r_(i-1) (T) + r_(i+1) (T)]
  $

  However, this could also be seen as a manipulation by the trio $(i−1, i, i+1)$, hence 
  $
    r_(i-1) (T') + r_i (T') + r_(i+1) (T') = r_(i-1) (T) + r_i (T) + r_(i+1) (T)
  $
  and by symmetry
  $
    r_(i-1) (T') = r_i (T') = r_(i+1) (T') = 1/3 [r_(i-1) (T) + r_i (T) + r_(i+1) (T)]
  $
  
  Equating the two expressions for $r_(i-1) (T')$
  $ 
    1/2 [r_(i-1) (T) + r_(i+1) (T)] = 1/3 [r_(i-1) (T) + r_i (T) + r_(i+1) (T)]
  \
    cancel(3) [r_(i-1) (T) + r_(i+1) (T)] = 2 [cancel(r_(i-1) (T)) + r_i (T) + cancel(r_(i+1) (T))]
  \
    2 r_i (T) = r_(i+1) (T) + r_(i-1) (T)
  $

  This recurrence means the sequence $(r_1 (T), ..., r_n (T))$ is an arithmetic progression:
  $
    cases(
      r_1 (T) = a,
      r_k (T) = a + (k-1) d \, quad k = 1\, ...\, n
    )
  \
    2 [a + (i-1) d] = [a + i d] + [a + (i-2) d]
  $
  Our goal is to find an upper bound on the value of $r_n (T)$.
  
  Combined with conditions $r_k (T) >= 0 half forall k in {1,...,n}$ and $sum_(k=1)^n r_k (T) <= 1$, we get that
  $
    sum_(k=1)^n r_k (T) = a dot n + d dot n(n-1) / 2 <= 1
  $

  #colbreak()
  The maximum value of $a$, given a fixed $d$, is
  $
    a_max = vfrac( 1 - d dot n(n-1) / 2, n )
  $
  and the condition $a_max >= a = r_1 (T) >= 0$ is equivalent to $d <= vfrac(2, n(n-1))$. Plugging in
  $
    r_n (T) &<= a_max + (n-1) d \
            &= 1/n - d dot (n-1)/2 + (n-1) d \
            &= 1/n + d dot (n-1)/2
  $
  Now we maximize by plugging the maximum valued of $d$
  $
    r_n (T) &<= 1/n + d_max dot (n-1)/2 \
            &= 1/n + vfrac(cancel(2), n cancel((n-1))) dot cancel((n-1)) / cancel(2) \
            &= 2/n
  $
  in contradiction to our assumption.
]

For coalitions of size 2, we know the following upper
bound on $gamma$.

#proposition[
  There exist no 2-SNM tournament rules that have Condorcet consistency value $gamma > vfrac(2,3)$.
]
#proof[
  Assume for contradiction a tournament rule $r$ that satisfies the requirements, and consider a tournament $T$ of arbitrary size $n$ with a top cycle of three elements ${a,b,c}$. Any pair of these elements may manipulate to make one of them a Condorcet winner, gaining at least $gamma$. Hence,
  $
    r_a (T) + r_b (T) > 2/3 \
    r_a (T) + r_c (T) > 2/3 \
    r_b (T) + r_c (T) > 2/3
  $
  and therefore, by summing
  $
    2 [r_a (T) + r_b (T) + r_c (T)] > 3 dot 2/3 = 2
  \
    r_a (T) + r_b (T) + r_c (T) > 1
  $
  which is a contradiction.
]

#pagebreak()


= Approximate Non-Manipulability

Motivated by match-based applications such as sporting events, where the outcome of pair-wise matches is explicitly learned and used to select a winner, we consider instead the design of tournament rules that are exactly Condorcet-consistent, but only approximately 2-SNM.

The focus of this chapter is to quantify how much manipulable certain tournament formats are (i.e. how much can teams possibly gain by fixing matches), the idea being that it is easier to discourage manipulation in tournaments that are less manipulable.

#definition[$2$-Strong Non-Manipulability at probability $alpha$][
  A tournament rule $r$ is _$2$-strongly non-manipulable at probability $alpha$_ ($2$-SNM-$alpha$) if, \ for all $i$ and $j$ and pairs of ${i,j}$-adjacent tournaments $T$ and $T'$, $r_i (T') + r_j (T') − r_i (T) − r_j (T) <= alpha$.
]

#definition[$k$-Strong Non-Manipulability at probability $alpha$][
  A tournament rule $r$ is _$k$-strongly non-manipulable at probability $alpha$_ ($k$-SNM-$alpha$) if, \ for all subsets $S$ of players of size at most $k$, for all pairs of $S$-adjacent tournaments $T$ and $T'$, $sum_(i in S) r_i (T') − sum_(i in S) r_i (T) <= alpha$.
]

== Lower bounds

#theorem(label: "Thm-3.1")[
  There is no Condorcet-consistent tournament rule on $n$ players (for $n >= 3$) \ that is $2$-SNM-$alpha$ for $alpha < vfrac(1,3)$.
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
  There is no Condorcet-consistent tournament rule on $n$ players (for $n >= 2k − 1$) \ that is $k$-SNM-$alpha$ for $alpha < vfrac(k-1, 2k-1)$.
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

== The Random Single-Elimination Bracket Rule

#definition[Single-Elimination Bracket][
  A _single-elimination bracket_ (or _bracket_, for short) $B$ on $n = 2^h$ players is a complete binary tree of height $h$ whose leaves are labelled with some permutation of the $n$ players. The outcome of a bracket $B$ under a tournament $T$ is the labelling of internal nodes of $B$ where each node is labelled by the winner of its two children under $T$. The winner of $B$ under $T$ is the label of the root of $B$ under this labelling.
]

#definition[Random Single-Elimination Bracket Rule][
  The _random single-elimination bracket rule_ $r$ is a tournament rule on $n = 2^h$ players where $r_i (T)$ is the probability player $i$ is the winner of $B$ under $T$ when $B$ is chosen uniformly at random from the set of $n!$ possible brackets. \
  If $n$ is not a power of $2$, we define the random single-elimination bracket rule on $n$ players by introducing $2^ceil(log_2 n) - n$ dummy players who lose to all of the existing $n$ players.
]

It is straightforward to check that the random single-elimination bracket rule is both Condorcet-consistent and monotone. It can be proved that in addition to these properties, it is also $2$-SNM-$1/3$ (which is the best possible, by @Thm-3.1).

#theorem(label: "Thm-3.3")[
  The random single elimination bracket rule is $2$-SNM-$1/3$.
]
#proof[
  #highlight(fill: red)[Omitted.]
]

== Other formats

Finally, there are many other tournament formats that are either used in practice or have been previously studied. In this section we show that many of these formats are more susceptible to manipulation than the random single elimination bracket rule; in particular, all of the following formats are at best $2$-SNM-$1/2$.

By far the most common tournament rule for round robin tournaments is some variant of a ‘scoring’ rule, where the winner is the player who has won the most games (with ties broken in some fashion if multiple players have won the same maximum number of games). In voting theory, this rule is often called Copeland’s rule, or Copeland’s method.

#definition[Copeland Rule][
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

#definition[Superman-Kryptonite Tournament][
  The _superman-kryptonite_ tournament on $n$ players has $i$ beat $j$ whenever $i < j$, except that player $n$ beats player $1$. That is, player $1$ beats everyone except for player $n$, who loses to everyone except for player $1$.
]

#definition[Top Cycle Rule][
  The _top cycle_ of a tournament $T$ is the minimal set of players who beat all other players.
  
  The _top cycle rule_ is a tournament rule which assigns the winner to be a uniformly random element of this set.
]

#theorem[
  The top cycle rule on $n$ players is not $2$-SNM-$alpha$ for any $alpha < 1 - vfrac(2,n)$.
]
#proof[
  Let $T$ be the superman-kryptonite tournament on $n$ players. \
  The top cycle in $T$ contains all the players, so $r_1 (T) + r_n (T) = vfrac(1,n) + vfrac(1,n) = vfrac(2,n)$. \
  However, if player $n$ throws their match to player $1$, player $1$ becomes a Condorcet winner and $r_1 (T') = 1$. It follows that $alpha >= 1 - vfrac(2,n)$.
]

#definition[Iterative Condorcet rule][
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

#definition[Randomized Voting Caterpillar Rule][
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
  image("/figures/art3-2.svg", width: auto),
  caption: [#h(1em) #box(baseline: 14pt)[
    #set align(start)
    Lower bounds for $alpha$ for some $2$-SNM-$alpha$ rules \
    (remember the universal $1/3$ lower bound)
  ]]
)

#pagebreak()


= Partially Transferable Utility

We recall the previous definitions about manipulations and then move to a more general setting.

#definition[$S$-adjacent][
  Tournaments $T, T' in cal(T)_n$ are _$S$-adjacent_ where $S subset.eq [n]$ if $i dominates(T) j <=> i dominates(T') j$ for $i neq j in [n] \\ S$. \
  In other words, $T$ and $T'$ are $S$-adjacent if they coincide on every match except possibly those between agents in $S$.
]

When utilities are non-transferable, two agents are willing to collude only if one of them can strictly improve her probability of winning at no cost to the other. Formally, distinct agents $i,j in [n]$ collude from tournament $T$ to tournament $T'$ only if both
$ 
  max &{r_i (T') − r_i (T), r_j (T') − r_j (T)} > 0 "and" \
  min &{r_i (T') − r_i (T), r_j (T') − r_j (T)} >= 0 \.
$
Thus, to incentivize agents against such manipulations, a tournament rule must satisfy the following notion of non-manipulability.

#definition[$2$-Pareto Non-Manipulability][
  A tournament rule $r$ is _$2$-Pareto non-manipulable_ (2-PNM) if for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$, either
  - $thin min {r_i (T') − r_i (T), r_j (T') − r_j (T)} < 0$ or
  - $max {r_i (T') − r_i (T), r_j (T') − r_j (T)} <= 0 \.$
]

There exists a rule that is monotone, TCC, and 2-PNM (see @TCR).

The barrier to pairwise manipulation is much lower when utilities are completely transferable since two agents only care about the probability that at least one of them wins the tournament. In other words, $i$ and $j$ collude from $T$ to $T'$ only if $r_i (T') + r_j (T') > r_i (T) + r_j (T)$. \
Under this utility model, an agent may be willing to sacrifice and shift a significant portion of her probability to her partner in crime. Thus, tournament rules must satisfy a stronger notion of non-manipulability in this setting.

#definition[2-Strong Non-Manipulability][
  A tournament rule $r$ is _$2$-strongly non-manipulable_ ($2$-SNM) if $r_i (T') + r_j (T') <= r_i (T) + r_j (T)$ for all $i neq j in [n]$ and ${i,j}$-adjacent tournaments $T neq T' in cal(T)_n$.
]

#remark[
  By symmetry, we need to have equality: $r_i (T') + r_j (T') = r_i (T) + r_j (T)$.
]

We have seen that no Condorcet consistent tournament rule is $2$-SNM (see @teo2). \
However, despite this strong impossibility result, instances of collusion are relatively infrequent in the real world, suggesting that settings in which utilities are completely transferable are uncommon. On the other hand, instances of collusion are not unheard of, suggesting that utility is neither always non-transferable.

We consider a third utility model in which utilities are partially transferable: distinct agents $i$ and $j$ collude from tournament $T$ to tournament $T'$ only if
$
  r_i (T') + r_j (T') > r_i (T) + r_j (T) + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')} \.
$
In this model, two agents always collude if both of them improve their chances of winning and never collude if both of their chances decrease. The interesting case is when one agent improves her chances at the expense of the other. One interpretation of this necessary condition is that agents would rather win the tournament themselves but are still willing to collude if the gain in probability is significantly larger than each agent’s loss. \
Here, $lambda$ is a parameter that measures how transferable utility is. Note that when $lambda$ is low, utilities are more transferable. We will later see how $lambda$ can be interpreted as agents’ level of selfishness. \
We now define a notion of non-manipulability for this model.

#definition[$2$-Non-Manipulability for $lambda$][
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

#definition[$2$-Non-Manipulability up to $alpha$ for $lambda$][
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

== Lower Bounds

We have seen that no Condorcet consistent tournament rule is $2\-"NM"_0\-alpha$ for $alpha < 1/3$ (see @Thm-3.1). The same lower bound construction yields:

#theorem[
  No Condorcet consistent tournament rule is $2\-"NM"_lambda\-alpha$ for $lambda < 1 - 3 alpha$.
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

== Tournament rules

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

#figure(
  image("figures/performance.png"),
)
#footnote[
  This table is from an alternate version of @article4 available at: \
  #url("https://comsoc-community.org/archive/comsoc-2023/comsoc/papers/paper59.pdf")
]

#pagebreak()


= Beyond Condorcet

#let warning = math-env(
  name: "Warning",
  prefix: "\u{26A0}",
  style: style.plain
)
#warning[
  This is based on original research.
]

At this point it may be clear that Condorcet consistency is a bit problematic. In some ways it is too strong, in that it automatically selects the Condorcet winner even if he may have won all matches by small margins; in others it is too weak, like in the superman-kryptonite example where we may have a clear winner but not being a Condorcet winner prevents it to be chosen.

We need a framework which takes in account not only the matches won, but also by how much.

#definition[Weighted Tournament][
  A _weighted tournament_ is a tournament with pairs of weights for each match: the match between alternatives $i$ and $j$ has weights ${w_(i j), w_(j i)}$ such that $w_(i j), w_(j i) in [0,1]$ and $w_(i j) + w_(j i) = 1$ for every $i neq j in [n]$. \
  It is represented as a complete #underline[directed] weighted graph, with two edges for each pair of nodes which satisfies the above condition.
]

Here the weights could represent the number of points scored in the match or the number of repeated matches won, followed by a normalization.

The definitions of tournament rules and manipulations still apply, but we want to replace Condorcet consistency. Instead of establishing a new fairness criterion (axiomatic way), we present a rule that in some sense is intuitively fair. The idea is that the probability of winning should be proportional to the performance in the tournament (which in our model depends on the weights of the edges).

We use as a proxy of performance an aggregation of the weights, which we can interpret as the number of total points/wins in the tournament.

#definition[Score][
  The _score_ $s_i$ of alternative $i$ is the outdegree of the node in the tournament graph, \ that is $s_i = sum_(j=1)^n w_(i j)$.
]

Now we need to turn these in a probability distribution over the alternatives. We can do this thanks to the softmax function.

#definition[Proportional Score Rule][
  The _proportional score rule_ assigns to alternative $i$ probability of winning $r_i = e^(s_i) / sum_(j=1)^n e^(s_j)$.
]

The properties of the softmax guarantee that this is well posed, \ in particular $r_i in [0,1]$ and $sum_(i=1)^n r_i = 1$.

== Fairness

Consider the tournament on $n$ agents where player $1$ is a Condorcet winner with weight $0.5 < a <= 1$ and all the other players have weight $0.5$ among them. Then
$
  &s_1 = a dot (n-1) \
  &s_i = vfrac(1,2) dot (n-2) + (1-a) quad forall i neq 1
$
For small $a$ (close to $0.5$) the score of player $1$ is close to that of the other players, but increasing $a$ the gap grows; this is consistent with the idea that being a Condorcet winner is not enough to win the tournament, but we need big margins to have high probability of winning. \
Moreover increasing the number of players, further increase the gap; indeed, winning more matches against many players by a big margin should give higher probability of winning the tournament. \
In the limit for $n -> oo$ we get that $s_1 = 1$, that is we recover Condorcet consistency.

Now consider the superman-kryptonite tournament: player $1$ wins with weight $a$ against all but player $n$, to which he loses with weight $c$; the other players beat each other with weight $0.5$ and player $n$ with weight $d$. Then
$
  &s_1 = a dot (n-2) + (1-c) \
  &s_n = c + (1-d) dot (n-2) \
  &s_i = vfrac(1,2) dot (n-3) + (1-a) + d, quad forall i neq 1,n
$
As before we can observe a behaviour consistent with our intuition: player $1$ (superman) can get a high score (and so high probability of winning the tournament) despite the existence of player $n$ (kryptonite), if the parameter $a$ is big enough compared to the others, and especially if there are many players.

== Non-manipulability

Now we want to estimate how much manipulable is this tournament rule. \
In this framework a manipulation is a redistribution of the weights among the members of the coalition such that we still have a valid weighted tournament.

#theorem[
  The proportional score rule is $2$-SNM-$tanh(vfrac(1,4))$.
]
#proof[
  Consider the coalition ${1,2}$ and the manipulation that changes the pair $(w_(1 2), w_(2 1))$ from $(omega, 1-omega)$ to $(omega', 1-omega')$, with $omega neq omega' in [0,1]$. \
  We want an upper bound (as tight as possible) on $r'_1 + r'_2 - r_1 - r_2$.
  
  Let $Delta := omega' - omega$; WLOG we can assume $Delta > 0$ (otherwise swap the players). Notice that
  $
    s'_1 = s_1 + Delta , wide s'_2 = s_2 - Delta
  $
  and all the others remain unchanged: $s'_i = s_i , forall i neq 1,2$.
  
  Let $quad A := e^(s_1), quad B := e^(s_2), quad C := sum_(i>=3) e^(s_i)$ so
  $
    R' := r'_1 + r'_2 = vfrac(e^Delta A + e^(-Delta) B, e^Delta A + e^(-Delta) B + C), wide
    R := r_1 + r_2 = vfrac(A + B, A + B + C)
  $

  We perform a change of coordinates: 
  // $
  //   x := C/A >= 0 , wide y := B/A >= 0 , wide t := e^Delta > 1
  // $
  $
    u := A/C >= 0 , wide v := B/C >= 0 , wide t := e^Delta > 1  
  $
  so that we can write
  // $
  //   R' - R &= vfrac(t + t^(-1) y, t + t^(-1) y + x) - vfrac(1 + y, 1 + y + x)
  // $
  // The numerator is 
  // $
  //   &(t + t^(-1) y)(1 + y + x) - (1 + y)(t + t^(-1) y + x) = \
  //   &= cancel((t + t^(-1) y)(1 + y)) + t x + t^(-1) y x - cancel((1 + y)(t + t^(-1) y)) - x - y x \
  //   &= [t + t^(-1) y - 1 - y] x \
  //   &= vfrac(t^2 + y - t - t y, t) thick x half
  //    = half vfrac( (t - 1) (t - y) x, t )
  // $
  // thus
  // $
  //   R' - R = vfrac(
  //              (t - 1) (t - y) x ,
  //              t (t + t^(-1) y + x) (1 + y + x)
  //            )
  //         <= tanh(vfrac(ln t, 4))
  //          = tanh(vfrac(Delta, 4))
  // $
  $
    R' - R = vfrac(t u + t^(-1) v, t u + t^(-1) v + 1) - vfrac(u + v, u + v + 1)
    <= tanh(vfrac(ln t, 4))
     = tanh(vfrac(Delta, 4))
  $
  where we used @bound. Since $Delta <= 1$, we get the result.
]

// #lemma(label: "bound")[
//   Let $t > 1$ and for $x,y >= 0$
//   $
//     g (x,y) = vfrac(
//                 (t - 1) (t - y) x ,
//                 t (t + t^(-1) y + x) (1 + y + x)
//               )
//   $
//   Then $display( sup_(x,y >= 0) abs(g (x,y)) = tanh(vfrac(ln t, 4)) )$.
// ]
// #proof[
//   We compute the derivatives.
//   $
//     vfrac(partial g, partial x) 
//     &= vfrac(
//       (t - 1) (t - y) thick t (t + t^(-1) y + x) (1 + y + x) - 
//       (t - 1) (t - y) x thick t [(1 + y + x) + (t + t^(-1) y + x)],
//       t^2 (t + t^(-1) y + x)^2 (1 + y + x)^2
//     ) \
//     &= vfrac(
//       (t - 1) (t - y) cancel(t) thick [(t + t^(-1) y) (1 + y) + cancel((t + t^(-1) y) x) + cancel(x (1 + y)) + cancel(x^2) - cancel(x (1 + y)) - cancel(x^2) - cancel(x (t + t^(-1) y)) - x^2] ,
//       t^cancel(2) (t + t^(-1) y + x)^2 (1 + y + x)^2
//     ) \
//     &= vfrac(
//       (t - 1) (t - y) [(t^2 + y) (1 + y) - t x^2] ,
//       t^2 (t + t^(-1) y + x)^2 (1 + y + x)^2
//     )
//   $
// ]

#lemma(label: "bound")[
  Let $t > 1$ and for $u,v >= 0$
  $
    g (u,v) = vfrac(t u + t^(-1) v, t u + t^(-1) v + 1) - vfrac(u + v, u + v + 1)
  $
  Then $display( sup_(u,v >= 0) g (u,v) = tanh(vfrac(ln t, 4)) )$.
]
#proof[
  Let $D' := t u + t^(-1) v + 1$ and $D := u + v + 1$ so that
  $
    g = vfrac(t u + t^(-1) v, D') - vfrac(u + v, D)
  $
  We compute the derivatives.
  $
    vfrac(partial g, partial u) 
    &= vfrac( t dot D' - (t u + t^(-1) v) dot t , D'^2 ) &-& 
       vfrac( 1 dot D - (u + v) dot 1 , D^2 )
    = vfrac(t, D'^2) - vfrac(1, D^2)
  \
    vfrac(partial g, partial v) 
    &= vfrac( t^(-1) dot D' - (t u + t^(-1) v) dot t^(-1) , D'^2 ) &-& 
       vfrac( 1 dot D - (u + v) dot 1 , D^2 )
    = vfrac(t^(-1), D'^2) - vfrac(1, D^2)
  $
  
  A stationary point must satisfy
  $
    vfrac(t, D'^2) &= vfrac(1, D^2) quad "and"& quad vfrac(t^(-1), D'^2) &= vfrac(1, D^2)
  \
    t D^2 &= D'^2 quad "and"& quad t^(-1) D^2 &= D'^2
  $
  and subtracting gives
  $
    (t - t^(-1)) D^2 = 0
  $
  For $t > 1$ we have $t - t^(-1) neq 0$, and $D^2 > 0$, so this is impossible. \
  So stationary points must be on the boundary.
  
  We can write
  $
    g (u,v) 
    &= (1 - vfrac(1, t u + t^(-1) v + 1)) + (1 - vfrac(1, u + v + 1)) \
    &= vfrac(1, u + v + 1) - vfrac(1, t u + t^(-1) v + 1)
  $
  which goes to $0$ when $(u,v) -> oo$ along #underline[any] path.

  On $v = 0$ we have
  $
    g (u,0) = vfrac(t u, 1 + t u) - vfrac(u, 1 + u)
    = vfrac((t - 1) u, (1 + t u) (1 + u))
    =: h (u)
  $
  Compute the derivative
  $
    h' (u) 
    &= vfrac(
      (t - 1) dot (1 + t u) (1 + u) - (t - 1) u dot [t dot (1 + u) + (1 + t u) dot 1],
      (1 + t u)^2 (1 + u)^2
    ) \
    &= vfrac(
      (t - 1) [1 + cancel(t u) + cancel(u) + cancel(t u^2) - cancel(t u) - cancel(t u^2) - cancel(u) - t u^2] ,
      (1 + t u)^2 (1 + u)^2
    ) \
    &= vfrac(
      (t - 1) (1 - t u^2) ,
      (1 + t u)^2 (1 + u)^2
    )
  $
  Since $t > 1$, the solution of $h' (u) = 0$ is $u = 1/sqrt(t)$ and
  $
    h(1/sqrt(t)) 
    = vfrac( (t - 1) 1/sqrt(t), (1 + t 1/sqrt(t)) (1 + 1/sqrt(t)) )
    = vfrac( (t - 1), (1 + sqrt(t)) (sqrt(t) + 1) )
    = vfrac( t - 1, (1 + sqrt(t))^2 )
  $

  With analogous computations we can show that on $u = 0$ there is another stationary point $v = sqrt(t)$ which attains the same value but with opposite sign.

  So this quantity is the maximum and we can rewrite it as
  $
    vfrac( t - 1, (1 + sqrt(t))^2 )
    = vfrac( sqrt(t) - 1, sqrt(t) + 1 )
    = vfrac( e^((ln t) / 2) - 1, e^((ln t) / 2) + 1 )
    = tanh ((ln t)/4)
  $
]

Since $tanh(vfrac(1,4)) approx 0.245 < 0.333... = 1/3$, we improved the lower bound of @Thm-3.1.

Surprisingly, the same bound applies for coalitions of arbitrary size, unlike the Condorcet case (see @Thm-3.2)

#theorem[
  The proportional score rule is $k$-SNM-$tanh(vfrac(1,4))$ for every $k >= 2$.
]
#proof[
  Let $S = {1,...,k}$ and
  $
    A = sum_(i in S) e^(s_i) , wide B = sum_(j in.not S) e^(s_j) , wide R = vfrac(A, A+B)
  $
  Inside the coalition define the probability weights
  $
    p_i = vfrac(e^(s_i), A), quad i in S
  $
  so that $sum_(i in S) p_i = 1$. \ 
  After the manipulation we have $s'_i = s_i + Delta_i$ for some $Delta_i in [0,1]$ such that $sum_(i in S) Delta_i = 1$ so
  $
    A' = sum_(i in S) e^(s_i + Delta_i) = A sum_(i in S) p_i e^(Delta_i) = A s , wide
    s := sum_(i in S) p_i e^(Delta_i)
  $
  while $B' = B$ is unchanged. Therefore
  $
    R' = vfrac(A', A' + B) = vfrac(A s, A s + B) = vfrac(alpha s, alpha s + 1) , wide
    alpha := A/B
  $
  and the difference is a function of the scalar $s$ only
  $
    R' - R = vfrac(alpha s, alpha s + 1) - vfrac(alpha, alpha + 1) = vfrac((s - 1) alpha, (1 + s alpha) (1 + alpha))
  $
  Notice this is the function $h (u)$ of @bound with $u = alpha$ and $t = s$.
  
  In particular, if we define $delta := norm(bold(Delta))_oo = max_(i in S) Delta_i$ then
  $
    e^(- delta) &<= e^(Delta_i) <= e^delta , wide forall i in S
  \
    e^(- delta) &<= s = sum_(i in S) p_i e^(Delta_i) <= e^delta
  $
  Hence $abs(ln s) <= delta$ and we get the bound
  $
    R' - R <= tanh ((ln s) / 4) <= tanh (delta/4)
  $
  Since $delta <= 1$, we get the result.
]

#pagebreak()


//#show bibliography: set heading(numbering: none)
//#show heading.where(level: 1): set heading(numbering: none)

#bibliography(
  "/references/ref.bib",
  full: true
)