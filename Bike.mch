MACHINE Bike

CONSTANTS
    minimun_helth,
    max_helth

PROPERTIES
    minimun_helth : NAT
    & max_helth: NAT

SETS
    BIKES

VARIABLES 
    bikes, bikesHelth

INVARIANT
    bikes <: BIKES
    & bikesHelth : bikes --> 0..max_helth

INITIALISATION 
    bikes := {} 
    || bikesHelth := {}
    
OPERATIONS
    add_bike(bb) = 
        PRE bb : BIKES & bb /: bikes 
        THEN bikes := bikes \/ {bb}
            || bikesHelth := bikesHelth \/ {bb |-> max_helth}
        END;

    // TODO: atualizar na machine rent o remover
    remove_bike(bb) =
        PRE bb : bikes 
        THEN 
            bikes := bikes - {bb}
            || bikesHelth := {bb} <<| bikesHelth
        END

    // cd <-- checkDamage(bb) =
    // PRE bb : BIKES
    //     & bb : bikes
    //     & bb : ran(rentedBikes)
    // THEN
    //     IF bb : dom(bikeDamages) 
    //     THEN cd := bikeDamages(bb)
    //     ELSE
    //         ANY 
    //             dd 
    //         WHERE 
    //             dd : 0..100
    //         THEN
    //             cd := dd || bikeDamages := bikeDamages \/ {bb |-> dd}
    //         END
    //     END
    // END
        
END
