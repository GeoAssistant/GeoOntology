/*Submarine fan has the following components: upperFan, middleFan,
lowerfan and basinPlain. Uppefan contains feederChannel(s), middleFan
contains distributaryChannels and overbanks, lowerFan contains lobes
or shhet sand. Best reservoir potential have channels, lobes and sheet
sand.*/


submarineFan(sf).
upperFan.
middleFan.
lowerFan.
channel.
feederChannel.
distributaryChannel.
overbank.
lobe.
lobeFringe.
basinPlain.

/*Facies classiffication, after Mutti & Ricci Lucci, 1972, 1975*/
facies(ch1, a).
facies(ch2, b).
facies(lobe, c).
facies(lobeFringe, d).
facies(overbank, e).
facies(basinPlain, g).


/*ReervoirPotentialClassiffication*/
veryGoodReservoirPotential(facies(c), lobe).
goodReservoirPotential(facies(b), ch2).
moderateReservoirPotential(facies([a,d]), [ch1, lobeFringe]).
minimumReservoirPotential(facies(g), basinPlain).

goodLateralConectivity(facies(c), lobe).

/*Porosity classiffication*/
veryGoodPorosity(facies(c), lobe).
goodPorosity(facies(b), ch2).
moderatePorosity(facies([a,d]), [ch1,lobeFringe]).
lowPorosity(facies(g), basinPlain).

/*PermeabilityClassiffication*/
goodPermeability(facies(c), lobe).
goodPermeability(facies(b), ch2).
veryGoodPermeability(facies(a), ch1).
moderatePermeability(facies(d), lobeFringe).
lowPermeability(facies(g), basinPlain).

/*Lithology - turbidite facies*/
sandstone.
siltstone.
mudstone.
turbiditeFacies(facies(a), [conglomerate, pebblySandstone, pebblyMudstone]).
turbiditeFacies(facies(b), coarseGrainedSandyTurbidite).
turbiditeFacies(facies(c), mediumGrainedSandyTurbidites:- [ta, tb, tc, td, te]).
turbiditeFacies(facies(d), fineGrainedSandyMuddyTurbidites:- [tb, tc, td, te]).
turbiditeFacies(facies(e), [laminatedSandstone, lenticularSandstone]).
turbiditeFacies(facies(g), mudstone).



/*Bouma Divisions, 1962 - Classic turbidite*/

ta(sandstones, massiveGraded).
tb(sandstone, planarParallelLaminae).
tc([sandstone, siltstone], [ripplesLaminae, wavyLaminae, contortedlaminae]).
td(siltsone, upperParallelLaminae).
te(mudstone, [laminated, homogenous]).
/*If  ta^tb^tc^td^te exit  ->CompleteBoumaSequence.<-> facies c
If ta or tb or tc or td or te exist -> InompleteBoumaSequence <->
facies d.*/

/*Lowe Divisions, 1982, Course-Grained Turbidites*/

/*Processes*/
/*high density tirbidity current - hdtc, low density turbidity current -
ldtc*/

hdtc. /
ldtc. /
process(facies([e,f]), ldtc).
process(facies([b, c, d]), hdtc).
/*1 turbidity current-> 1 turbidite*/

finning_upwards(facies([a,b])).
coarsening_upwards(facies([c,d])).
thinning_upwards(facies([a,b]), ch).
thickening_upwards(facies([c,d]), lobe).


porosity_higher([A,B]):-
    facies(A,c),
    facies(B,d),
    porosity(c,PA),
    porosity(d,PB),
    PA > PB.
porosity(c,30).
porosity(d,20).


permeability_higher([A,B,C,D]):-
    facies(A, a),
    facies(B, b),
    facies(C, c),
    facies(D, d),
    permeability(a, PA),
    permeability(b, PB),
    permeability(c, PC),
    permeability(d, PD),
    PA>PB,
    PB>PC,
    PC>PD.
permeability(a, 800).
permeability(d, 20).
permeability(b, 350).
permeability(c, 100).
