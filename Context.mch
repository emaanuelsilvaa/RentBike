MACHINE
    Context
    
CONCRETE_CONSTANTS
    minimun_helth,
    max_helth,
    sze, 
    BIKES,
    credit_limit,
    max_fidelity,
    fidelity_increment,
    USERS
    
PROPERTIES
    minimun_helth : NAT
    & max_helth: NAT
    & sze: NAT 
    & sze < MAXINT
    & BIKES = 0..sze,
    & credit_limit : NAT,
    & max_fidelity : NAT,
    & fidelity_increment : NAT,
    & USERS = 0..sze

END

