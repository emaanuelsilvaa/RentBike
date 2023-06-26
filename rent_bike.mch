MACHINE 
    rent_bike
    
CONSTANTS
    credit_limit, rent_value, max_discount, max_fidelity, max_damage
    
PROPERTIES
    credit_limit : NAT 
    & rent_value : NAT1
    & max_discount : NAT1
    & max_fidelity : NAT
    & max_damage : NAT
    
SETS
    USERS;
    BIKES
        
VARIABLES 
    users, bikes, rentedBikes,	credits, bikeDiscounts, fidelity, bikeDamages
    
INVARIANT
    users <: USERS
    & bikes <: BIKES
    & rentedBikes : USERS >+> BIKES
    & credits : USERS +-> 0..100
    & bikeDiscounts : bikes --> 0..4 // substituir por 0..4
    & fidelity : USERS +-> 0..4
    & bikeDamages : bikes --> 0..100
    
INITIALISATION 
    users := {} || 
    bikes := {} ||
    rentedBikes := {} ||
    credits := {} ||
    bikeDiscounts := {} ||
    fidelity := {} ||
    bikeDamages := {}
    
OPERATIONS
    addUser(uu) = 
    PRE uu: USERS 
        & uu /: users 
        & uu /: dom(fidelity)
    THEN users := users \/ {uu} 
        || fidelity := fidelity \/ { uu |-> 0} 
    END;
    
    removeUser(uu) = 
    PRE uu : USERS & uu /: dom(rentedBikes)
    THEN users := users - {uu} 
        || fidelity := {uu} <<| fidelity
    END;
    
    addBike(bb) = 
    PRE bb : BIKES
        & bb /: bikes 
    THEN bikes := bikes \/ {bb}
    END;
    
    removeBike(bb) =
    PRE bb : BIKES
        & bb : bikes 
        & bb /: ran(rentedBikes)
        & bb /: dom(bikeDamages)
        & bb /: dom(bikeDiscounts)
    THEN 
        IF bb : dom(bikeDiscounts) // rever essa checagem
        THEN bikeDiscounts, bikes :=  {bb} <<| bikeDiscounts, bikes - {bb}
        ELSE bikes := bikes - {bb}
        END
    END;
    
    addCredit(uu, cc)=
    PRE uu : USERS
        & uu : users 
        & cc : NAT
        & cc : 1..100
    THEN
        IF uu : dom(credits) & cc + credits(uu) <= credit_limit
        THEN credits := credits  <+ {uu |-> cc + credits(uu)}
        ELSIF uu /: dom(credits)
        THEN credits := credits \/ {uu |-> cc}
        END
    END;
    
    rent(uu, bb) = 
    PRE uu : users
        & uu : dom(credits) 
        & credits(uu) >= 2 * rent_value // so deve ser possivel alugar alguma coisa se tiver 2x o rent_value
        & bb : bikes 
        & (uu, bb) /: rentedBikes
        & bb /: dom(bikeDiscounts)
        & uu /: dom(rentedBikes)
        & bb /: ran(rentedBikes)
        & uu : dom(fidelity) 
        & fidelity(uu) < max_fidelity
    THEN  
        rentedBikes := rentedBikes \/ {uu |-> bb} 
        || credits := credits  <+ {uu |-> credits(uu) - rent_value}
        || fidelity := fidelity  <+ {uu |-> fidelity(uu) + 1}
    END;
    
    rentWithDiscount(uu, bb) =
    PRE uu : users
        & uu : dom(credits)
        & uu : dom(fidelity) 
        & fidelity(uu) < max_fidelity
        & uu /: dom(rentedBikes) 
        & bb : bikes 
        & bb /: ran(rentedBikes)
        & bb : dom(bikeDiscounts) 
        & credits(uu) + bikeDiscounts(bb) >= rent_value
    THEN rentedBikes := rentedBikes \/ {uu |-> bb} 
        || credits := credits <+ {uu |-> credits(uu) - (rent_value - bikeDiscounts(bb))} 
        || fidelity := fidelity <+ {uu |-> fidelity(uu) + 1}
    END;
    
    rentWithFidelity(uu, bb) =
    PRE uu : users
        & uu : dom(fidelity)
        & uu /: dom(rentedBikes)
        & fidelity(uu) = max_fidelity
        & bb : bikes
        & bb /: ran(rentedBikes)
        & bb /: dom(bikeDiscounts)
    THEN 
        rentedBikes := rentedBikes \/ {uu  |-> bb} 
        || fidelity := fidelity <+ {uu |-> 0}
    END;
    
    cd <-- checkDamage(bb) =
    PRE bb : BIKES
        & bb : bikes
        & bb : ran(rentedBikes)
    THEN
        IF bb : dom(bikeDamages) 
        THEN cd := bikeDamages(bb)
        ELSE
            ANY 
                dd 
            WHERE 
                dd : 0..100
            THEN
                cd := dd || bikeDamages := bikeDamages \/ {bb |-> dd}
            END
        END
    END;
    
    return(uu, bb)=
    PRE uu : users
        & bb : bikes
        & (uu, bb) : rentedBikes
        & bb : dom(bikeDamages)
        & uu : dom(credits)
        & credits(uu) > rent_value
    THEN 
        IF bikeDamages(bb) < 90
        THEN 
            rentedBikes := rentedBikes - {uu |-> bb}
            || bikeDamages := {bb} <<| bikeDamages
            || credits := credits <+ {uu |-> credits(uu) - rent_value}
        ELSE
            rentedBikes := rentedBikes - {uu |-> bb}
            || bikeDamages := {bb} <<| bikeDamages
        END
    END;
    
    createDiscount(bb, disc) =
    PRE bb : BIKES
        & bb : bikes
        & disc : 1 .. 4
        & bb /: dom(bikeDiscounts)
        & bb /: ran(rentedBikes)
    THEN 
        bikeDiscounts := bikeDiscounts \/ {bb |-> disc}
    END    
END









