MACHINE 
    rent_bike

INCLUDES 
    User, Bike
    
PROMOTES 
    create_user, add_credit, get_credits
    
CONSTANTS
    rent_value, max_discount
    
PROPERTIES
    rent_value : NAT1
    & max_discount : NAT1
        
VARIABLES 
    rentedBikes, bikeDiscounts, bikeDamages
    
INVARIANT
    rentedBikes : USERS >+> BIKES
    & bikeDiscounts : bikes --> 0.. max_discount
    
INITIALISATION 
    rentedBikes := {} 
    || bikeDiscounts := {}
    
OPERATIONS
    remove_user(uu) =
        PRE uu : users & uu /: dom(rentedBikes)
        THEN delete_user(uu)
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
    
    return(uu, bb)=
    PRE uu : users
        & bb : bikes
        & (uu, bb) : rentedBikes
        & bb : dom(bikesHelth)
        & uu : dom(credits)
        & credits(uu) > rent_value
    THEN 
        IF bikeDamages(bb) < minimun_helth
        THEN 
            rentedBikes := rentedBikes - {uu |-> bb}
            || bikesHelth := {bb} <<| bikesHelth
            || remove_credit(uu, rent_value)
        ELSE
            rentedBikes := rentedBikes - {uu |-> bb}
            || bikesHelth := {bb} <<| bikesHelth
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
