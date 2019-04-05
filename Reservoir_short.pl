reservoir(Gu):-
    has_lithology(Gu, sandstone),
    has_porosity(Gu, [medium, high, very_hugh]),
    has_permeability(Gu, [medium, high, very_high]),
    has_lateral_continuity(Gu, [moderate, good, very_good]).

seal(Gu):-
    has_lithology(Gu, shale),
    has_porosity(Gu, very_low),
    has_permeability(Gu, very_low),
    has_lateral_continuity(Gu, very_good).

has_porosity(Gu, very_low).
has_porosity(Gu, medium).
has_porosity(Gu, high).
has_porosity(Gu, very_high).

has_permeability(Gu, very_low).
has_permeability(Gu, medium).
has_permeability(Gu, high).
has_permeability(Gu, very_high).

has_lithology(Gu, sandstone).
has_lithology(Gu, shale).

has_lateral_continuity(Gu, very_good).
has_lateral_continuity(Gu, good).
has_lateral_continuity(Gu, moderate).
has_lateral_continuity(Gu, very_poor).

migration_through(hc,Gu):-
    reservoir(Gu).
accumulation(hc, Gu):-
    reservoir(Gu).

