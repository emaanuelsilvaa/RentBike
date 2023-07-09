MACHINE 
    rent_bike

INCLUDES 
    User, Bike
    
PROMOTES 
    create_user, add_credit, get_credits, get_helth, get_fidelity
    
CONSTANTS
    rent_value, max_discount
    
PROPERTIES
    rent_value : NAT1
    & max_discount : NAT1
        
VARIABLES 
    rentedBikes, bikeDiscounts
    
INVARIANT
    rentedBikes : users >+> bikes
    & bikeDiscounts : bikes --> 0..max_discount
    
INITIALISATION 
    rentedBikes := {} 
    || bikeDiscounts := {}
    
OPERATIONS
    remove_user(uu) =
        PRE uu : users & uu /: dom(rentedBikes)
        THEN delete_user(uu)
        END;

    add_bike(bb) =
        PRE bb : BIKES 
            & bb /: bikes 
            & bb /: dom(bikesHelth)
            & bb /: dom(bikeDiscounts)
        THEN create_bike(bb) 
            || bikeDiscounts := bikeDiscounts \/ {bb |-> 0}
        END;

    remove_bike(bb) =
        PRE bb : BIKES
            & bb : bikes 
            & bb /: ran(rentedBikes)
        THEN 
            delete_bike(bb)
            || bikeDiscounts := {bb} <<| bikeDiscounts
        END;
    
    rentBike(uu, bb) = 
        PRE uu : users 
            & bb : bikes
            & uu : dom(credits)
            & uu : dom(fidelities)
            & uu /: dom(rentedBikes)
            & bb /: ran(rentedBikes)
        THEN
            IF fidelities(uu) < max_fidelity
               & bb /: dom(bikeDiscounts)
               & credits(uu) >= 2 * rent_value // so deve ser possivel alugar alguma coisa se tiver 2x o rent_value
            THEN 
                rentedBikes := rentedBikes \/ {uu |-> bb} 
                || rent(uu, rent_value)
            ELSIF 
                fidelities(uu) < max_fidelity
                
                & bb : dom(bikeDiscounts)
                & credits(uu) + bikeDiscounts(bb) >= rent_value // TODO: Ajustar essa condicional para respeitar invariant de User
            THEN 
                rentedBikes := rentedBikes \/ {uu |-> bb} 
                || rent(uu, rent_value - bikeDiscounts(bb)) 
            ELSIF 
                fidelities(uu) = max_fidelity
                & bb /: dom(bikeDiscounts)
            THEN
                rentedBikes := rentedBikes \/ {uu |-> bb} 
                || reset_fidelity(uu)
            END
        END;
    
    return_bike(uu, bb) =
        PRE uu : users
            & bb : bikes
            & (uu, bb) : rentedBikes
            & bb : dom(bikesHelth)
            & uu : dom(credits)
            & credits(uu) > rent_value
        THEN 
            IF bikesHelth(bb) < minimun_helth
            THEN 
                rentedBikes := rentedBikes - {uu |-> bb}
                || reset_helth(bb)
                || remove_credit(uu, rent_value)
            ELSE
                rentedBikes := rentedBikes - {uu |-> bb}
                || reset_helth(bb)
            END
        END;

    evaluate_bike(bb, dm) =
        PRE bb : bikes
            & bb : dom(bikesHelth)
            & bb : ran(rentedBikes)
            & dm : 0..max_helth
        THEN
            set_damage(bb, dm)
        END;

    createDiscount(bb, disc) =
        PRE bb : bikes
            & disc : 1..max_discount
            & bb : dom(bikeDiscounts)
            & bb /: ran(rentedBikes)
        THEN 
            bikeDiscounts(bb) := disc
        END;
     
     rb <-- get_rented_bike(uu) =
         PRE uu : users
             & uu : dom(rentedBikes)
         THEN
             rb := rentedBikes(uu)
         END
         
END


