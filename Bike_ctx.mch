MACHINE
    Bike_ctx
    
CONCRETE_CONSTANTS
    minimun_helth,
    max_helth,
    sze, BIKES
PROPERTIES
    minimun_helth : NAT
    & max_helth: NAT
    & sze: NAT & sze < MAXINT
    & BIKES = 0 .. sze

END

