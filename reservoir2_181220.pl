
% file: reservoir2.pl
%
% changes:
% 20/12/2018 jeotten: correct/update
/* jeotten: Irina, could you please add a natural sentence to each
      predicate explaining the intended meaning; this would make it
      much easier for me to update/correct the predicates; the first
      "Submarine fan" explanation is very good */

/*Submarine fan has the following components: upperFan, middleFan,
lowerfan and basinPlain. Uppefan contains feederChannel(s),channel
margins, middleFan contains distributaryChannels, overbanks, lowerFan
contains lobes or sheet sand and lobe fringe. Best reservoir potential
have channels, lobes and sheetsand.*/

% jeotten: it is not clear yet to me how the following facts are used;
%          what is the intended meaning
/*irina:  if you see a channel (on seismic or well logs) it means that you are in upper or middle fan; no channel it means lower fan;
 *  upper fan is close to the source of sediments
 *  lower fan is farther into the basin
 it help localized them inside the depositional system*/

submarineFan(sf).
upperFan.
middleFan.
lowerFan.
channel.
feederChannel.
distributaryChannel.
channelMargin.
overbank.
lobe.
lobeFringe.
basinPlain.

/*Facies classiffication, after Mutti & Ricci Lucci, 1972, 1975*/

% jeotten: not clear: e.g., does "lobe" always has facies "c"
%          or is it an instance of a lobe that has facies c
/* irina:lobe has always facies c*/
facies(ch1, a).
facies(ch2, b).
facies(lobe, c).
facies(lobeFringe, d).
facies(overbank, e).
facies(basinPlain, g).
/*or better */

facies([upperFan, middleFan], a).
facies([upperFan, middleFan], b).
facies([middleFan, lowerFan], c).
facies(submarineFan, d).
facies([upperFan, middleFan], e).
facies(basinPlain, f).

/*ReervoirPotentialClassiffication*/
%veryGoodReservoirPotential(facies(c), lobe).
%goodReservoirPotential(facies(b), ch2).
%moderateReservoirPotential(facies([a,d]), [ch1, lobeFringe]).
%minimumReservoirPotential(facies(g), basinPlain).

% jeotten: suggestion (simplified if, e.g., lobe always has facies c, etc):

reservoir_potential(R,very_good) :- reservoir_has(R,lobe).
reservoir_potential(R,good) :- reservoir_has(R,ch2).
reservoir_potential(R,moderate) :-
    ( reservoir_has(R,ch2) ; % "or" ("," in case of "and")
                             reservoir_has(R,lobeFringe) ).
reservoir_potential(R,minimum) :- reservoir_has(R,basinPlain).

reservoir_has(r1,lobe).
reservoir_has(r1,ch2).
reservoir_has(r2,lobeFringe).

% jeotten: if lobe always has facies c, it does not need to be repeated
%          haven't change this yet

goodLateralConectivity(facies(c), lobe).


/*Porosity classiffication*/
%veryGoodPorosity(facies(c), lobe).
%goodPorosity(facies(b), ch2).
%moderatePorosity(facies([a,d]), [ch1,lobeFringe]).
%lowPorosity(facies(g), basinPlain).

% jeotten: I guess proposity only depends on the facies; suggestion:

facies_porosity(c,very_good).
facies_porosity(b,good).
facies_porosity(a,moderate).
facies_porosity(d,moderate).
facies_porosity(g,low).


/*PermeabilityClassiffication*/
%goodPermeability(facies(c), lobe).
%goodPermeability(facies(b), ch2).
%veryGoodPermeability(facies(a), ch1).
%moderatePermeability(facies(d), lobeFringe).
%lowPermeability(facies(g), basinPlain).

% jeotten: I guess permeab. only depends on the facies; suggestion:

facies_permeability(c,good).
facies_permeability(b,good).
facies_permeability(a,very_good).
facies_permeability(d,moderate).
facies_permeability(g,low).


/*Lithology - turbidite facies*/
sandstone.
siltstone.
mudstone.
turbiditeFacies(facies(a), [conglomerate, pebblySandstone, pebblyMudstone]).
turbiditeFacies(facies(b), coarseGrainedSandyTurbidite).
turbiditeFacies(facies(c), mediumGrainedSandyTurbidites:- [ta, tb, tc, td, te]).
turbiditeFacies(facies(d), fineGrainedSandyMuddyTurbidites:- [tb, tc, td, te]).
turbiditeFacies(facies(e), [thinLaminatedSandstone, thinLenticularSandstone, thinMudstone]).
turbiditeFacies(facies(g), mudstone).



/*Bouma Divisions, 1962 - Classic turbidite*/

% jeotten: what is the meaning of this, e.g., "sandstone is massiveGraded"?
%          what is ta, tb, etc.?
/*irina:  yes, the sandstone is massive graded or planar parallel laminated, etc,
ta, tb, and so forth are the standard name for each subdivision of the
Bouma sequence, each sequence has different porosity and different reservoir potential*/

ta(sandstones, massiveGraded).
tb(sandstone,planarParallelLaminae).
tc([sandstone, siltstone], [ripplesLaminae,wavyLaminae, contortedlaminae]).
td(siltsone, upperParallelLaminae).
te(mudstone, [laminated, homogenous]).
/*If  ta^tb^tc^td^te exit  ->CompleteBoumaSequence.<-> facies c
If ta or tb or tc or td or te exist -> InompleteBoumaSequence <->
facies d.*/

/*Lowe Divisions, 1982, Course-Grained Turbidites*/

/*Processes that are responsible for d4eposition of the submarine fan components:
high density tirbidity current - hdtc, low density turbidity current -
ldtc*/

% jeotten: what does this mean?
hdtc.
ldtc.
process(facies([e,f]), ldtc).
process(facies([b, c, d]), hdtc).
/*1 turbidity current-> 1 turbidite; normally thre are many turbidites stacked vertically*/

finning_upwards(facies([a,b])).
coarsening_upwards(facies([c,d])).
thinning_upwards(facies([a,b]), ch).
thickening_upwards(facies([c,d]), lobe).

% jeotten: generalized/corrected, but only works for exact values
facies_porosity_higher(A,B):-
    facies(A,FaciesA),
    facies(B,FaciesB),
    porosity(FaciesA,PA),
    porosity(FaciesB,PB),
    PA > PB.

% jeotten: we already have facies_porosity; I would (for now) either
%          use approx. (high/low/etc) or exact values (20,30,etc)
%          for facies porosity
% irina: let's use high, low, moderate instead of values
%
porosity(c,30).
porosity(d,20).

% jeotten: corrected (higher only between two "elements"; otherwise
%          use it more often)

facies_permeability_higher(A,B):-
    facies(A,FaciesA),
    facies(B,FaciesB),
    permeability(FaciesA,PA),
    permeability(FaciesB,PB),
    PA>PB.

% jeotten: this looks good

permeability(a, 800).
permeability(d, 20).
permeability(b, 350).
permeability(c, 100).

/* This examples with porosity and permeability higher were an exersize for me.
The most important it is to specify that facies c has the highest porosity, facies b has good porosity but lower than gacies c, but facies b has higher permeability that facies c. */
