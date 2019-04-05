
% -------------------
% file: reservoir2.pl
% -------------------

% Index

% Reservoir potential classification      -- reservoir_potential(A,B)
% Facies classification                   -- element_facies(A,B)
% Porosity classification of facies       -- facies_porosity(A,B)
% Permeability classification of facies   -- facies_permeability(A,B)
% Sorting classification of facies        -- facies_sorting(A,B)
% Lateral continuity classification       -- facies_lateral_continuity(A,B)
% Reservoir probablity classification     -- lithology_reservoir_proba(A,B)
% Lithology classification of facies      -- facies_lithology(A,B)
% Grain size trends                       -- element_grain_size_trend(A,B)
% Bed size trends                         -- element_bed_size_trend(A,B)
%
% better than relation                    -- better_than(A,B)
% higher than relation                    -- higher_than(A,B)
% subset relation                         -- subset(A,B)


%%%%%%%%%% begin example

reservoir_has(r1,lobe).
reservoir_has(r2,ch2).
reservoir_has(r3,lobeFringe).

% which reservoir has a good potential
% ?- reservoir_potential(R,good).
%
% which reservoir R has an element whose facies has a very high prorosity
% ?- reservoir_has(R,X), element_facies(X,A), facies_porosity(A,very_high).
%
% has reservoir r3 an element whose facies has a medium permeability
% ?- reservoir_has(r3,X), element_facies(X,A), facies_permeability(A,medium).
%
% has reservoir r2 an element whose facies has a medium permeability
% ?- reservoir_has(r2,X), element_facies(X,A), facies_permeability(A,medium).
%
% which reservoir R has an element whose facies has moderate sorting
% ?- reservoir_has(R,X), element_facies(X,A), facies_sorting(A,moderate).
%
% which permeability P has a facies with very high porosity
% ?- facies_perm facies_porosity(X,very_high).
%
% which potential P has a reservoir that has an element with a facies that
% has high porosity
% ?- reservoir_potential(R,P), reservoir_has(R,Y), element_facies(Y,F),
%    facies_porosity(F,medium).
%
% which sorting S has the facies of an element of a reservoir that has a
% very good potential
% ?- reservoir_potential(R,very_good), reservoir_has(R,Y),
%    element_facies(Y,F), facies_sorting(F,S).
%
% is there a facies F that has low permeability and good lateral continuity
% ?- facies_permeability(F,low), facies_lateral_continuity(good).
%
% is there a facies F that has high permeability and poor lateral continuity
% ?- facies_permeability(F,high), facies_lateral_continuity(poor).
%
% is there a reservoir with better than moderate potential with an elemenet
% whose facies has a coarse sandstone lithology
% ?- reservoir_potential(R,Pot), better_than(Pot,moderate),
%    reservoir_has(R,Y), element_facies(Y,F),
%    facies_lithology(F,[sandstone(coarse)]).
%
% which lithology L has a reservoir that has an element with a facies that
% has a higher porosity than "high"
% ?- reservoir_has(R,Y), element_facies(Y,F), facies_porosity(F,P),
%    higher_than(P,high), facies_lithology(F,L).
%
% is there a rervoir R that has an element with a facies that has a lithology
% of siltstone
% ?- reservoir_has(R,Y), element_facies(Y,F), facies_lithology(F,[siltstone]).
%
% is there a reservoir that has an element with a facies that has a massive
% sandstone lithology
% ?- reservoir_has(R,Y), element_facies(Y,F), facies_lithology(F,L),
%    subset([sandstone(massive)],L).
%
% which reservoirs have an element with thickening upwards bed size trend
% ?- reservoir_potential(R,Pot), reservoir_has(R,Y),
%    element_bed_size_trend(Y,X).
%
% is there a reservoir with an element that has a facies with higher than
% low porosity and a siltstone lithology
% ?- reservoir_has(R,Y), element_facies(Y,F), facies_porosity(F,P),
%    higher_than(P,low), facies_lithology(F,[siltstone]).

%%%%%%%%%% end example


% Reservoir potential classification
% -- reservoir_potential(A,B)
%
% Engl: reservoir A has potential B
% Refs:

reservoir_potential(R,very_good) :- reservoir_has(R,lobe).
reservoir_potential(R,good)      :- reservoir_has(R,ch2).

reservoir_potential(R,moderate)  :- reservoir_has(R,ch2).
reservoir_potential(R,moderate)  :- reservoir_has(R,lobeFringe).
reservoir_potential(R,none)      :- reservoir_has(R,basinPlain).


% Facies classification
% -- element_facies(A,B)
%
% Engl: element A has facies B
% Refs: Mutti & Ricci Lucci, 1972, 1975

element_facies(ch1,a).
element_facies(ch2,b).
element_facies(lobe,c).
element_facies(lobeFringe,d).
element_facies(overbank,e).
element_facies(basinPlain,g).


% Porosity classification of facies
% -- facies_porosity(A,B)
%
% Engl: facies A has porosity B
%       B element of {low,medium,high,very_high}
% Refs:

facies_porosity(a,medium).
facies_porosity(b,high).
facies_porosity(c,very_high).
facies_porosity(d,medium).
facies_porosity(e,medium).
facies_porosity(g,very_low).


% Permeability classification of facies
% -- facies_permeability(A,B)
%
% Engl: facies A has permeability B
%       B element of {low,medium,high,very_high}
% Refs:

facies_permeability(a,very_high).
facies_permeability(b,high).
facies_permeability(c,high).
facies_permeability(d,medium).
facies_permeability(e,medium).
facies_permeability(g,very_low).


% Sorting classification of facies
% -- facies_sorting(A,B)
%
% Engl: facies A has sorting B
%       B element of {none,poor,moderate,good}
% Refs:

facies_sorting(a,poor).
facies_sorting(b,moderate).
facies_sorting(c,good).
facies_sorting(d,good).
facies_sorting(e,moderate).
facies_sorting(g,none).


% Lateral continuity classification of facies
% -- facies_lateral_continuity(A,B)
%
% Engl: facies A has lateral continuity B
%       B element of {poor,moderate,good}
% Refs:

facies_lateral_continuity(a,poor).
facies_lateral_continuity(b,moderate).
facies_lateral_continuity(c,good).
facies_lateral_continuity(d,good).
facies_lateral_continuity(e,poor).
facies_lateral_continuity(g,good).


% Reservoir probablity classification of lithologies
% -- lithology_reservoir_proba(A,B)
%
% Engl: Lithology A has reservoir probability B
%       B element of {none,low,high}
% Refs:

lithology_reservoir_proba(sandstone(_),high).
lithology_reservoir_proba(siltstone,low).
lithology_reservoir_proba(shale(_),none).
lithology_reservoir_proba(conglomerate,high).


% Lithology classification of facies
% -- facies_lithology(A,B)
%
% Engl: Facies A has lithology B
% Refs:

facies_lithology(a,[sandstone(pebbly),shale(pebbly),conglomerate]).
facies_lithology(b,[sandstone(coarse)]).
facies_lithology(c,[sandstone(medium)]).
facies_lithology(d,[siltstone]).
facies_lithology(e,V) :-
 subset(V,[sandstone(thin_laminated),sandstone(thin_lenticular),shale(thin)]).
facies_lithology(g,[shale]).


% Grain size trends
% -- element_grain_size_trend(A,B)
%
% Engl: Element A has grain size trend B
% Refs:

element_grain_size_trend(ch,finning_upwards).
element_grain_size_trend(lobe,coarsening_upwards).


% Bed size trends
% -- element_bed_size_trend(A,B)
%
% Engl: Element A has bed size trend B
% Refs:

element_bed_size_trend(ch,thinning_upwards).
element_bed_size_trend(lobe,thickening_upwards).
element_bed_size_trend(lobeFringe,thickening_upwards).


% better than relation
% -- better_than(A,B)
%
% Engl: A is better than B
%       A,B element of {very_poor,poor,moderate,good,very_good}

better_than(very_good,good).
better_than(good,moderate).
better_than(moderate,poor).
better_than(poor,very_poor).

better(X,Y) :- better_than(X,Y), !.
better(X,Y) :- better_than(X,Z), better(Z,Y).


% higher than relation
% -- higher_than(A,B)
%
% Engl: A is higher than B
%       A,B element of {very_low,low,medium,high,very_high}

higher_than(very_high,high).
higher_than(high,medium).
higher_than(medium,low).
higher_than(low,vfaciesery_low).

higher(X,Y) :- higher_than(X,Y), !.
higher(X,Y) :- higher_than(X,Z), higher(Z,Y).


% subset relation
% -- subset(A,B)
%
% Engl: A is a subset of B

subset([],_).
subset([H|T],L) :- member(H,L), !, subset(T,L).



/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% OLD or CURRENTLY NOT USED %%%%%%%%%%%%%

% changes:
% 20/12/2018 jeotten: correct/update
% jeotten: Irina, could you please add a natural sentence to each
%   predicate explaining the intended meaning; this would make it
%   much easier for me to update/correct the predicates; the first
%   "Submarine fan" explanation is very good

% Submarine fan has the following components: upperFan, middleFan,
% lowerfan and basinPlain. Uppefan contains feederChannel(s),channel
% margins, middleFan contains distributaryChannels, overbanks, lowerFan
% contains lobes or sheet sand and lobe fringe. Best reservoir potential
% have channels, lobes and sheetsand.

% jeotten: it is not clear yet to me how the following facts are used;
%          what is the intended meaning
% irina:  if you see a channel (on seismic or well logs) it means that
%         you are in upper or middle fan; no channel it means lower fan;
% *  upper fan is close to the source of sediments
% *  lower fan is farther into the basin
% it help localized them inside the depositional system

%  state if x and y   ( state :- x, y . )

% still needs to be defined

%submarineFan(sf).
%upperFan.
%middleFan.
%lowerFan.
%channel.
%feederChannel.
%distributaryChannel.
%channelMargin.
%overbank.
%lobe.
%lobeFringe.
%basinPlain.

% Facies classiffication, after Mutti & Ricci Lucci, 1972, 1975

% jeotten: not clear: e.g., does "lobe" always has facies "c"
%          or is it an instance of a lobe that has facies c
% facies(A,B) means A has facies B

% irina:lobe has always facies c
facies(ch1, a).
facies(ch2, b).
facies(lobe, c).
facies(lobeFringe, d).
facies(overbank, e).
facies(basinPlain, g).

% maybe later
%facies([upperFan, middleFan], a).
%facies([upperFan, middleFan], b).
%facies([middleFan, lowerFan], c).
%facies(submarineFan, d).
%facies([upperFan, middleFan], e).
%facies(basinPlain, g).

% ReervoirPotentialClassiffication
%veryGoodReservoirPotential(facies(c), lobe).
%goodReservoirPotential(facies(b), ch2).
%moderateReservoirPotential(facies([a,d]), [ch1, lobeFringe]).
%minimumReservoirPotential(facies(g), basinPlain).

% jeotten: suggestion (simplified if, e.g., lobe always has facies c, etc):

reservoir_potential(R,very_good) :- reservoir_has(R,lobe).
reservoir_potential(R,good)      :- reservoir_has(R,ch2).
reservoir_potential(R,moderate)  :- reservoir_has(R,ch2).
reservoir_potential(R,moderate)  :- reservoir_has(R,lobeFringe).
reservoir_potential(R,none)      :- reservoir_has(R,basinPlain).

reservoir_has(r1,lobe).
reservoir_has(r2,ch2).
reservoir_has(r3,lobeFringe).

% Depositional Porosity classiffication
%veryGoodPorosity(facies(c), lobe).
%goodPorosity(facies(b), ch2).
%moderatePorosity(facies([a,d]), [ch1,lobeFringe]).
%lowPorosity(facies(g), basinPlain).

% jeotten: I guess proposity only depends on the facies; suggestion:

facies_porosity(a,moderate).
facies_porosity(b,good).
facies_porosity(c,very_good).
facies_porosity(d,moderate).
facies_porosity(e,moderate).
facies_porosity(g,low).

% PermeabilityClassiffication
%goodPermeability(facies(c), lobe).
%goodPermeability(facies(b), ch2).
%veryGoodPermeability(facies(a), ch1).
%moderatePermeability(facies(d), lobeFringe).
%lowPermeability(facies(g), basinPlain).

% jeotten: I guess permeab. only depends on the facies; suggestion:

facies_permeability(a,very_high).
facies_permeability(b,high).
facies_permeability(c,high).
facies_permeability(d,medium).
facies_permeability(e,medium).
facies_permeability(g,low).

% sorting

facies_sorting(a,poor).
facies_sorting(b,moderate).
facies_sorting(c,good).
facies_sorting(d,good).
facies_sorting(e,moderate).
facies_sorting(g,none).

% LateralContinuity

%goodlateralContinuity(facies(g), basinPlain).
%goodLateralContinuity(facies([d,c]), [lobeFringe, lobe]).
%moderateLateralContinuity(facies(b), ch2).
%poorLateralContinuity(facies(a), ch1).
%poorLateralContinuity(facies(e), overbank).
%
%goodLateralConectivity(facies(c), lobe).

% jeotten: if lobe always has facies c, it does not need to be repeated
%          haven't change this yet

lateral_continuity(a,poor).
lateral_continuity(b,moderate).
lateral_continuity(c,good).
lateral_continuity(d,good).
lateral_continuity(e,poor).
lateral_continuity(g,good).

% Lithology - turbidite facies

%sandstone.
%siltstone.
%mudstone/shale.

probability_of_reservoir(sandstone,high).
probability_of_reservoir(siltstone,low).
probability_of_reservoir(shale,none).
probability_of_reservoir(conglomerate,high).

lithology_facies(a,[sandstone(pebbly),shale(pebbly),conglomerate]).
lithology_facies(b,[sandstone(coarse)]).
lithology_facies(c,[sandstone(medium),sandstone(massive)]).
lithology_facies(d,[siltstone]).
lithology_facies(e,V) :-
 subset(V,[sandstone(thin_laminated),sandstone(thin_lenticular),shale(thin)]).
lithology_facies(g,[shale]).

% do not use it (at the moment)
%turbiditeFacies(facies(a), [conglomerate, pebblySandstone, pebblyMudstone]).
%turbiditeFacies(facies(b), coarseGrainedSandyTurbidite).
%turbiditeFacies(facies(c), mediumGrainedSandyTurbidites:- [ta, tb, tc, td, te]).
%turbiditeFacies(facies(d), fineGrainedSandyMuddyTurbidites:- [tb, tc, td, te]).
%turbiditeFacies(facies(e), [thinLaminatedSandstone, thinLenticularSandstone, thinMudstone]).
%turbiditeFacies(facies(g), mudstone).

% Bouma Divisions, 1962 - Classic turbidite

% jeotten: what is the meaning of this, e.g., "sandstone is massiveGraded"?
%          what is ta, tb, etc.?
% irina:  yes, the sandstone is massive graded or planar parallel laminated,
% etc, ta, tb, and so forth are the standard name for each subdivision of the
% Bouma sequence, each sequence has different porosity and different reservoir
% potential

% comment out (for the moment)
%
%ta(sandstones, massiveGraded).
%tb(sandstone,planarParallelLaminae).
%tc([sandstone, siltstone], [ripplesLaminae,wavyLaminae, contortedlaminae]).
%td(siltsone, upperParallelLaminae).
%te(mudstone, [laminated, homogenous]).
% If  ta^tb^tc^td^te exit  ->CompleteBoumaSequence.<-> facies c
% If ta or tb or tc or td or te exist -> InompleteBoumaSequence <->
% facies d.

% Lowe Divisions, 1982, Course-Grained Turbidites

% Processes that are responsible for deposition of the submarine fan
% components: high density tirbidity current - hdtc, low density turbidity
% current - ldtc

% do not use this
%hdtc.
%ldtc.
%process(facies([e,f]), ldtc).
%process(facies([b, c, d]), hdtc).
% 1 turbidity current-> 1 turbidite

% still needs to be adapted
%
grain_size_trend(ch,finning_upwards).
grain_size_trend(lobe,coarsening_upwards).
bed_size_trend(ch,thinning_upwards).
bed_size_trend(lobe,thickening_upwards).
bed_size_trend(lobeFringe,thickening_upwards).

% jeotten: generalized/corrected, but only works for exact values
%facies_higher_porosity_than(A,B):-
%    facies(A,FaciesA),
%    facies(B,FaciesB),
%    facies_porosity_value(FaciesA,PA),
%    facies_porosity_value(FaciesB,PB),
%    PA > PB.

% jeotten: we already have facies_porosity; I would (for now) either
%          use approx. (high/low/etc) or exact values (20,30,etc)
%          for facies porosity
% irina: let's use high, low, moderate instead of values
%
%facies_porosity_value(c,30).
%facies_porosity_value(d,20).

% jeotten: corrected (higher only between two "elements"

%facies_higher_permeability_than(A,B):-
%    facies(A,FaciesA),
%    facies(B,FaciesB),
%    facies_permeability_value(FaciesA,PA),
%    facies_permeability_value(FaciesB,PB),
%    PA>PB.

% jeotten: this looks good
% we do not use values for permeability
%facies_permeability_value(a, 800).
%facies_permeability_value(d, 20).
%facies_permeability_value(b, 350).
%facies_permeability_value(c, 100).

% This examples with porosity and permeability higher were an exersize for me.
% The most important it is to specify that facies c has the highest porosity,
% facies b has good porosity but lower than gacies c, but facies b has higher
% permeability that facies c.

% Channel stacking is a good indicator for vertical and lateral continuity of
% the reservoir

% very poor, poor, moderate, good, very good

better_than(very_good,good).
better_than(good,moderate).
better_than(moderate,poor).
better_than(poor,very_poor).

better(X,Y) :- better_than(X,Y).
better(X,Y) :- better_than(X,Z), better(Z,Y).

% very low, low, medium, high, very high

higher_than(very_high,high).
higher_than(high,medium).
higher_than(medium,low).
higher_than(low,very_low).

higher(X,Y) :- higher_than(X,Y).
higher(X,Y) :- higher_than(X,Z), higher(Z,Y).

%around(poor,X) :- X=very_poor ; X=poor ; X=moderate.

*/ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

