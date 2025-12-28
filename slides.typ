#import "@preview/touying:0.6.1": *
#import themes.simple: *
#show: simple-theme.with(
  aspect-ratio: "16-9",
  header: []
)

#import "/template/template.typ": *
#show: rules

// hack for disabling counters
#let c = none
#let definition = definition.with(counter: c)
#let theorem = theorem.with(counter: c)
#let proposition = proposition.with(counter: c)
#let lemma = lemma.with(counter: c)
#let corollary = corollary.with(counter: c)



= Fair and Strategy-proof \ Tournament Rules Design

== Tournament

#slide[
  A _tournament_ is $T = (A, dominates(T))$

  #set list(marker: [], spacing: 1em)
  - $A$ : (finite) set of _agents/alternatives/participants/players_
  - $dominates(T)$ : complete asymmetric binary relation over $A$, describes match outcomes

  #v(1em)

  Can be represented as a complete oriented graph.
][
  #figure(
    image("figures/tournament.png", width: 100%),
  )
]

#slide[
  === Notation

  $cal(T)(A)$ : set of tournaments on $A$ \
  $cal(T)_n$ #h(1.3em) : set of tournaments on $[n]$

  $card(A) = n quad => quad A tilde.equiv [n] $

  #pause

  === Goal

  how to choose a winner in a way that is both #highlight(fill: lime)[fair] and #highlight(fill: lime)[non-manipulable]?

  _fair_ : selects a meritable alternative \
  _non-manipulable_ : alternatives do not benefit from match-fixing
]

== Applications

#slide[
  - sports ranking/seeding
  - voting (social choice theory)
  - decision making
  - argumentation theory
  - multi-agent systems
    - mixture of experts
    - compare models
]


= Deterministic Rules

#slide[
  === Tournament rule
  
  A _(deterministic) tournament rule_ is a map $r : cal(T)(A) -> A$.

  #pause

  === Fairness

  *Idea*: win every match $->$ win the tournament

  $x in A$ is _Condorcet winner_ in $T$ if $x dominates(T) y$ for all $y in A \\ {x}$.

  A rule is _Condorcet consistent_ if it selects the Condorcet winner \ (if it exists).
]

== Non-manipulability

#slide[
  Manipulations:
  - one player loses on purpose / reverse outgoing edges
  - two or more players reverse the outcomes of matches in the coalition

  #pause #v(2em)

  Two tournaments are _$S$-adjacent_ if they differ only on edges in $S$.
]

#slide[
  === Monotonicity

  Manipulation 1 is successful if a losing player becomes the winner after reversing an outgoing edge.

  #pause

  A rule is _monotone_ if a player cannot do this: \
  he must win/lose in all ${x,y}$-adjacent tournaments to $T$ where $x dominates(T) y$.

  #pause
  #v(1em)

  #example[
    _Copeland rule_ : wins who has maximum outdegree
  ]
]

#slide[
  === Pairwise non-manipulability

  Manipulation 2 is successful if one of the player becomes the winner after reversing the outcome of their match.

  #pause

  A rule is _pairwise non-manipulable_ if $r (T) in {x,y} iff r (T') in {x,y}$ for every $T, T'$ which are ${x,y}$-adjacent.
]

== Impossibility result

#slide[
  #theorem[
    Any pairwise non-manipulable rule is not Condorcet consistent.
  ]
  
  #pause
  
  #proof[
    #grid(columns: (60%, 50%))[
      //#figure(
        #image("figures/PNM CC.png", width: 100%)
      //)
    ][
      #v(1em)
      WLOG #half $r(T) in.not {a,b}$
      
      $b dominates(T') a quad => quad b "Condorcet winner"$
      
      $r (T') = b quad #absurd$
    ]
  ]
]

== Non-imposition

#slide[
  A rule is _non-imposing_ if every player has a chance to win: \
  for every $x in A$ there exists a tournament $T$ such that $r (T) = x$.
]

#slide[
  #theorem[
    If $card(A) = 3$, then every PNM rule is not non-imposing.
  ]
  
  #pause
  
  #proof[
    //#figure(
      #image("figures/3 PNM NNI - Copia.png", height: 63%)
    //)
  ]
]

#slide[
  #theorem[
    If $card(A) neq 3$, then there exists a tournament rule that is monotone, PNM and non-imposing.
  ]
]


= Probabilistic Rules

#slide[
  A _(probabilistic/randomized) tournament rule over $A$_ is a map $r : cal(T)(A) -> Delta(A)$, that maps each tournament to a probability distribution over the players.

  #pause

  A _tournament rule on $n$ agents_ is a map $r^((n)) : cal(T)_n -> Delta^n$. \
  A _tournament rule_ $r$ is a family of tournament rules on $n$ players for every $n in NN$: ${r^((n))}_(n=1)^infinity$.

  #notation(style: style.indent.with(
    name_fmt: it => [#text(weight: "bold")[#it]]
  ))[
    $r(T) := r^((n))(T)  wide  r_i (T) := (r(T))_i$
  ]

  #pause

  A rule is _deterministic_ if has values in ${0,1}$.
]

== Fairness

#slide[
  A rule is _anonymous_ if $pi(r(T)) = r(pi(T))$.

  #pause

  A rule is _Condorcet consistent_ if $r_c (T) = 1$ whenever $c$ is a Condorcet winner. Equivalently, $r_z (T) = 0$ for $z$ #underline[not] Condorcet winner.

  #pause

  The _top cycle_ $T C(T)$ is the minimal subset of players that beats all the others outside it. \
  A rule is _top cycle consistent_ if $r_x (T) > 0$ implies $x in T C(T)$. \ Equivalently, if $z in.not T C(T)$ then $r_z (T) = 0$.

  #pause

  #example[
    _Top cycle rule_: #box(baseline: 0.5em)[
      $quad r_i (T) = cases(
        vfrac(1, card(T C(T))) \, quad &i thick in thick T C(T) ,
        0                      \, quad &i thick in.not thick T C(T)
      )$
    ]
  ]
]

== Non-manipulability

#slide[
  === Monotonicity
  
  A rule is _monotone_ if $x dominates(T) y$ implies $r_x (T) >= r_x (T')$ \ for every $T, T'$ which are ${x,y}$-adjacent.
]

#slide[
  === Pareto non-manipulability
  #v(0.5em)

  #highlight(fill: lime)[non-transferable] utility $->$ neither are worse off and one is better off

  A rule is _Pareto non-manipulable for coalitions of size up to $k$_ ($k$-PNM) if for every $S subset.eq A, half card(S) <= k$ and for every $T,T'$ which are $S$-adjacent: 
  
  - $exists x in S : r_x (T') < r_x (T)$ or 
  - $forall x in S : r_x (T') <= r_x (T)$.
]

#slide[
  === Strong non-manipulability
  #v(0.5em)

  #highlight(fill: lime)[transferable] utility $->$ coalition is better off

  A rule is _strongly non-manipulable for coalitions of size up to $k$_ ($k$-SNM) if for every $S subset.eq A, half card(S) <= k$ and for every $T,T'$ which are $S$-adjacent: 
  $
    sum_(x in S) r_x (T) = sum_(x in S) r_x (T')
  $

  #pause
  
  #remark[
    For deterministic rules they are equivalent.
  ]
]

== Results

#slide(repeat: 2, self => [
  #proposition[
    The top cycle rule is monotone and PNM.
  ]
  
  //#pause
  #only("2")[
  #proof[
    #text(weight: "bold")[Monotone.] Losing a match
    - inside the top cycle $->$ may be kicked out
    - outside the top cycle $->$ does not make inside

    //#colbreak()

    #text(weight: "bold")[PNM.] Successful manipulation
    - reduce top cycle size while keeping all manipulators
    - add new manipulator while keeping same size
    
    $=>$ kick a non-manipulator from top cycle \
    needs to remove also all dominated player \
    among them there must be a manipulator #half #absurd
  ]

  //#pause

  #proposition[
    There exist no $2$-SNM Condorcet consistent tournament rules.
  ]
  #proof[
    Same as before.
  ]

  #v(2em)
  
  Need to weaken either non-manipulability or Condorcet consistency.
  ]
])


= Approximate Condorcet Consistency

== Approximate Condorcet consistency

#slide[
  A rule has _Condorcet consistency value_ $gamma in [0,1]$ if \ for a Condorcet winner $c$ we have $r_c (T) >= gamma$.

  #pause

  #proposition[
    There exists a monotone SNM tournament rule which has Condorcet consistency value of $vfrac(2,n)$.
  ]
  #proof[
    Choose two at random, who wins the match is the winner.
    $
      r_x (T) = 2 / n(n-1) dot card({y : x dominates(T) y})
    $
  ]
]

#slide[
  #theorem[
    There exists no $3$-SNM rule with CC value $gamma > vfrac(2,n)$.
  ]

  #pause

  #theorem[
    There exists no 2-SNM rule with CC value $gamma > vfrac(2,3)$.
  ]
  #proof[
    #show math.equation.where(block: true): math.inline
    
    top cycle = ${a,b,c}$
    $
      r_a (T) + r_b (T) > 2/3 , quad
      r_a (T) + r_c (T) > 2/3 , quad
      r_b (T) + r_c (T) > 2/3
    \
      2 [r_a (T) + r_b (T) + r_c (T)] > 3 dot 2/3 = 2 quad absurd
    $
  ]
]


= Approximate Non-Manipulability

== Approximate non-manipulability

#slide[
  A rule is _$2$-strongly non-manipulable at probability $alpha$_ ($2$-SNM-$alpha$) if, \ for all $i$ and $j$ and pairs of ${i,j}$-adjacent tournaments $T$ and $T'$, 
  $
    r_i (T') + r_j (T') − r_i (T) − r_j (T) <= alpha
  $

  #pause

  A rule is _$k$-strongly non-manipulable at probability $alpha$_ ($k$-SNM-$alpha$) if, \ for all subsets $S$ of players of size at most $k$, for all pairs of $S$-adjacent tournaments $T$ and $T'$, 
  $
    sum_(i in S) r_i (T') − sum_(i in S) r_i (T) <= alpha
  $
]

#slide[
  #theorem[
    There is no Condorcet-consistent rule on $n$ players (for $n >= 3$) \ that is $2$-SNM-$alpha$ for $alpha < vfrac(1,3)$.
  ]

  #pause

  #proof[
    #show math.equation.where(block: true): math.inline
    
    top cycle = ${a,b,c}$ 
    #grid(columns: (50%, 50%))[
      $
        1 - sum r_i <= alpha
      \
        r_a (T) + r_b (T) >= 1 - alpha \
        r_a (T) + r_c (T) >= 1 - alpha \
        r_b (T) + r_c (T) >= 1 - alpha
      $
    ][
      $
        r_a (T) + r_b (T) + r_c (T) >= 3/2 (1 - alpha) \
        r_a (T) + r_b (T) + r_c (T) = 1 \
        => half alpha >= 1/3
      $
    ]
  ]
]

#slide[
  #theorem[
    There is no Condorcet-consistent rule on $n$ players \ (for $n >= 2k − 1$) that is $k$-SNM-$alpha$ for $alpha < vfrac(k-1, 2k-1)$.
  ]

  #figure(
    image("figures/art3-1.svg", height: 50%)
  )
]

== Random Single-Elimination Bracket Rule

#slide[
  A _single-elimination bracket_ is binary tree labelled with the players: permutation of all on the leaves, winner of the match on the parent, label of the root $->$ winner of the bracket

  #pause

  _random single-elimination bracket rule_ : \
  $quad r_i$ = fraction of winning brackets

  #pause

  #remark[
    RSEB is CC and monotone.
  ]

  #pause

  #theorem[
    RSEB is $2$-SNM-$1/3$.
  ]
]


= Partially Transferable Utility

== Non-manipulability

#slide[
  non-transferable utility
  $ 
    max &{r_i (T') − r_i (T), r_j (T') − r_j (T)} > 0 "and" \
    min &{r_i (T') − r_i (T), r_j (T') − r_j (T)} >= 0 \.
  $

  #v(1em)

  $2$-Pareto non-manipulable
  - $thin min {r_i (T') − r_i (T), r_j (T') − r_j (T)} < 0$ or
  - $max {r_i (T') − r_i (T), r_j (T') − r_j (T)} <= 0$
]

#slide[
  transferable utility
  $
    r_i (T') + r_j (T') > r_i (T) + r_j (T)
  $

  #v(2em)

  $2$-strongly non-manipulable
  $
    sum_(x in S) r_x (T) = sum_(x in S) r_x (T')
  $
]

#slide[
  #show math.equation.where(block: true): set text(size: 23pt) 
  
  partially transferable utility
  $
    r_i (T') + r_j (T') > r_i (T) + r_j (T) + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
  $

  #pause

  A tournament rule $r$ is _$2$-non-manipulable for $lambda >= 0$_ ($2\-"NM"_lambda$) if 
  $
    r_i (T') + r_j (T') <= r_i (T) + r_j (T) + lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
  $
  We say $r$ is $2\-"NM"_oo$ if 
  $
    r_i (T') + r_j (T') <= r_i (T) + r_j (T) + lim_(lambda -> oo) lambda max {r_i (T) − r_i (T'), r_j (T) − r_j (T')}
  $
]

#slide[
  $
    sum_(i in S) r_i (T') - sum_(i in S) r_i (T) <= lambda max_(i in S) {r_i (T) − r_i (T')}
  $
  
  #remark[
    - For $lambda = 0$, we get back SNM.
    - For $lambda = +oo$, we get back PNM.
  ]

  #pause #v(1em)

  $2\-"NM"_lambda\-alpha$
  $
    sum_(i in S) r_i (T') - sum_(i in S) r_i (T) <= lambda max_(i in S) {r_i (T) − r_i (T')} + alpha
  $
]

== 

#slide(repeat: 2, self => [
  no Condorcet + $2\-"NM"_0\-alpha$ for $alpha < 1/3$

  #theorem[
    No Condorcet consistent tournament rule is $2\-"NM"_lambda\-alpha$ for $lambda < 1 - 3 alpha$.
  ]

  #only("2-")[
  #proof[
    top cycle: ${1,2,3}$, coalition: ${1,2}$, $2$ is Condorcet in $T'$ \
    CC $half => half$ $r_2 (T') = 1, half r_1 (T') = 0$ ; $wide$
    $2\-"NM"_lambda\-alpha$ $half => half$ 

    #show math.equation: set block(breakable: true)
    #math.equation(block: true)[
      #set text(size: 21pt)
      $
        underbrace(r_1 (T') + r_2 (T'), 1) - r_1 (T) - r_2 (T) <= lambda max \{
          underbrace(r_1 (T) − r_1 (T'), r_1 (T) >= 0), 
          underbrace(r_2 (T) − r_2 (T'), r_2 (T) - 1 <= 0)
        \} + alpha
      \
        1 - r_1 (T) - r_2 (T) <= lambda thin r_1 (T) + alpha
      $
    ]

    #colbreak()
    
    $
      1 - r_2 (T) <= (lambda + 1) r_1 (T) + alpha \
      1 - r_3 (T) <= (lambda + 1) r_2 (T) + alpha \
      1 - r_1 (T) <= (lambda + 1) r_3 (T) + alpha \
    $
    $
      3 - [r_1 (T) + r_2 (T) + r_3 (T)] <= (lambda + 1) [r_1 (T) + r_2 (T) + r_3 (T)] + 3 alpha
    \
      3 - 3 alpha <= (lambda + 2) [r_1 (T) + r_2 (T) + r_3 (T)]
    \
      vfrac(3 - 3 alpha, underbrace(r_1 (T) + r_2 (T) + r_3 (T), <= 1)) - 2 <= lambda
    \
      3 - 3 alpha - 2 <= lambda quad => quad lambda >= 1 - 3 alpha
    $
  ]]
])

#slide[
  #corollary[
    No Condorcet consistent tournament rule is $2\-"NM"_lambda$ for $lambda < 1$.
  ]

  #v(1em)
  
  #conjecture(style: style.plain)[
    There exists a tournament rule that is monotone, Condorcet consistent, and $2\-"NM"_1$.
  ]
][
  #image("figures/art4.svg")
]


= Beyond Condorcet

#slide[
  #grid(
    columns: (auto, auto),
    column-gutter: 25pt
  )[
    Condorcet = bad
    - Condorcet winner may not be so dominant
    - superman-kryptonite
  ][
    #pause
    #set text(font: "Cascadia Mono")
    where are the graphs???
  ]
  
  #pause #v(1em)

  *Solution:* consider _weigthed_ tournaments ! \
  weight = \# points / goals / proportion of wins

  A _weighted tournament_ is a tournament with pairs of weights for each match $w_(i j), w_(j i) in [0,1]$ such that $w_(i j) + w_(j i) = 1$. \
  It is represented as a complete #underline[directed] weighted graph.
]

== Proportional Score Rule

#slide[
  *Idea*: probability should be proportional to the number of matches won

  #pause
  
  #grid(
    columns: (auto, auto)
  )[
    aggregate the weights $wide -> wide$
  ][
    _score_ : outdegree of the node \
    #h(2em) $s_i = sum_(j=1)^n w_(i j)$
  ]  

  #pause #v(0.75em)

  how to turn into probabilities? #pause softmax! #half 
  #box(baseline: 0.8em)[
    $display(r_i = vfrac(e^(s_i) , sum_(j=1)^n e^(s_j)))$
  ]
  $
    (s_1, ..., s_n) arrow.squiggly (r_1, ..., r_n), wide r_i in [0,1], quad sum_(i=1)^n r_i = 1
  $
]

#slide[
  === Fairness
  
  Intuitively fair (see geogebra). NOT Condorcet

  #pause #v(0.5em)

  === Non-manipulability

  #theorem[
    #v(-1em)
    PSR is $2$-SNM-$overbrace(tanh(vfrac(1,4)), approx 0.245)$.
  ]

  #pause

  #theorem[
    PSR is $k$-SNM-$tanh(vfrac(1,4)) thick forall k$ !
  ]
][
  #v(4em)
  #figure(
    image("figures/compare.svg"),
  )
]

== Even further beyond

#slide[
  - margin of win
  - Bradley-Terry model (ELO)
  - network flow
  - hypergraphs
]