MACHINE Bike
    
SEES Bike_ctx

VARIABLES 
    bikes, bikesHelth

INVARIANT
    bikes <: BIKES
    & bikes : FIN(bikes)
    & card(bikes) <= sze
    & bikesHelth : bikes --> 0..max_helth

INITIALISATION 
    bikes := {} 
    || bikesHelth := {}
    
OPERATIONS
    create_bike(bb) = 
        PRE bb : BIKES 
            & bb /: bikes 
            & bb /: dom(bikesHelth)
            & card(bikes) < sze
        THEN bikes := bikes \/ {bb}
            || bikesHelth := bikesHelth \/ {bb |-> max_helth}
        END;

    delete_bike(bb) =
        PRE bb : bikes & bb : BIKES 
        THEN bikes := bikes - {bb} 
            || bikesHelth := {bb} <<| bikesHelth
        END;

    reset_helth(bb) =
        PRE bb : bikes
            & bb : dom(bikesHelth)
        THEN bikesHelth(bb) := max_helth
        END;

    set_damage(bb, dm) =
        PRE bb : bikes
            & bb : dom(bikesHelth)
            & dm : 0..max_helth
        THEN 
            IF bikesHelth(bb) - dm < 0
            THEN bikesHelth(bb) := 0
            ELSE bikesHelth(bb) := bikesHelth(bb) - dm
            END
        END;
    
    query_helth <-- get_helth(bb) =
        PRE 
            bb : bikes
            & bb : dom(bikesHelth)
        THEN
            query_helth := bikesHelth(bb)
        END
        
END