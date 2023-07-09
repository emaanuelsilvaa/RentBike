MACHINE 
    rent_bike

INCLUDES User
    
PROMOTES create_user, add_credit, get_credits
    
CONSTANTS
    rent_value, max_discount, max_damage, health_bike
    
PROPERTIES
    rent_value : NAT1
    & max_discount : NAT1
    & max_damage : NAT
    & health_bike: NAT

SETS
    BIKES
        
VARIABLES 
    bikes, rentedBikes, bikeDiscounts, bikeDamages
    
INVARIANT
    bikes <: BIKES
    & rentedBikes : USERS >+> BIKES
    & bikeDiscounts : bikes --> 0.. max_discount
    & bikeDamages : bikes --> 0.. max_damage
    
INITIALISATION 
    bikes := {} ||
    rentedBikes := {} ||
    bikeDiscounts := {} ||
    bikeDamages := {}
    
OPERATIONS
    remove_user(uu) =
        PRE uu : users & uu /: dom(rentedBikes)
        THEN delete_user(uu)
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
    
    rentBike(uu, bb) = 
    PRE uu : users
        & bb : bikes
    THEN
        IF 
            uu : dom(credits)
            & uu : dom(fidelities)
            & fidelities(uu) < max_fidelity
            & uu /: dom(rentedBikes)
            & bb /: ran(rentedBikes)
            & bb /: dom(bikeDiscounts)
            & credits(uu) >= 2 * rent_value // so deve ser possivel alugar alguma coisa se tiver 2x o rent_value
            & (uu, bb) /: rentedBikes
        THEN 
            rentedBikes := rentedBikes \/ {uu |-> bb} 
            || rent(uu, rent_value)
        ELSIF 
            uu : dom(credits)
            & uu : dom(fidelities)
            & fidelities(uu) < max_fidelity
            & uu /: dom(rentedBikes)
            & bb /: ran(rentedBikes)
            & bb : dom(bikeDiscounts)
            & credits(uu) + bikeDiscounts(bb) >= rent_value // TODO: Ajustar essa condicional para respeitar invariant de User
        THEN 
            rentedBikes := rentedBikes \/ {uu |-> bb} 
            || rent(uu, rent_value - bikeDiscounts(bb)) 
        ELSIF 
            uu : dom(fidelities)
            & fidelities(uu) = max_fidelity
            & uu /: dom(rentedBikes)
            & bb /: ran(rentedBikes)
            & bb /: dom(bikeDiscounts)
        THEN
            rentedBikes := rentedBikes \/ {uu  |-> bb} 
            || reset_fidelity(uu)
        END
        
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
        IF bikeDamages(bb) < health_bike
        THEN 
            rentedBikes := rentedBikes - {uu |-> bb}
            || bikeDamages := {bb} <<| bikeDamages
            || remove_credit(uu, rent_value)
        ELSE
            rentedBikes := rentedBikes - {uu |-> bb}
            || bikeDamages := {bb} <<| bikeDamages
        END
    END;
    
    createDiscount(bb, disc) =
    PRE bb : BIKES
        & bb : bikes
        & disc : 1 .. max_discount
        & bb /: dom(bikeDiscounts)
        & bb /: ran(rentedBikes)
    THEN 
        bikeDiscounts := bikeDiscounts \/ {bb |-> disc}
    END
     
END


