MACHINE 
    User
    
CONSTANTS
    credit_limit,
    max_fidelity,
    fidelity_increment
    
PROPERTIES
    credit_limit : NAT    
    & max_fidelity : NAT
    & fidelity_increment : NAT
    
SETS
    USERS
        
VARIABLES 
    users, credits, fidelities
    
INVARIANT
    users <: USERS
    & credits : USERS +-> 0..credit_limit
    & fidelities : USERS +-> 0..max_fidelity
    
INITIALISATION 
    users := {}
    || credits := {}
    || fidelities := {}

OPERATIONS
    create_user(uu) = 
        PRE uu : USERS 
            & uu /: users 
            & uu /: dom(fidelities)
            & uu /: dom(credits)
        THEN users := users \/ {uu} 
            || fidelities := fidelities \/ {uu |-> 0} 
            || credits := credits \/ {uu |-> 0}
        END;

    delete_user(uu) = 
        PRE 
            uu : users
        THEN 
            users := users - {uu} 
            || fidelities := {uu} <<| fidelities
            || credits := {uu} <<| credits
        END;

    add_credit(uu, cc) =
        PRE uu : USERS
            & uu : users 
            & cc : 1..credit_limit
        THEN
            IF uu : dom(credits) & cc + credits(uu) <= credit_limit
            THEN credits := credits  <+ {uu |-> cc + credits(uu)}
            ELSIF uu /: dom(credits)
            THEN credits := credits \/ {uu |-> cc}
            END
        END;

    remove_credit(uu, cc) =
        PRE uu : users
            & uu : dom(credits)
            & cc : 1..credit_limit
            & credits(uu) - cc >= 0 
        THEN credits(uu) := credits(uu) - cc
        END;

    rent(uu, cc) =
        PRE uu : users
            & uu : dom(credits)
            & cc : 1..credit_limit
            & credits(uu) - cc >= 0 
            & uu : dom(fidelities)
            & fidelities(uu) + fidelity_increment <= max_fidelity
        THEN credits(uu) := credits(uu) - cc
            || fidelities(uu) := fidelities(uu) + fidelity_increment
        END;
        
    cc <-- get_credits(uu) =
        PRE uu : users 
            & uu : dom(credits)
        THEN cc := credits(uu)
        END;
        
    increment_fidelify(uu) =
        PRE uu : users 
            & uu : dom(fidelities)
            & fidelities(uu) + fidelity_increment <= max_fidelity
        THEN fidelities(uu) := fidelities(uu) + fidelity_increment
        END;
        
    reset_fidelity(uu) =
        PRE uu : users & uu : dom(fidelities)
        THEN fidelities(uu) := 0
        END
    
END