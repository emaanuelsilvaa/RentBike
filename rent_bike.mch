MACHINE rent_bike
SETS
	USER;
	BIKE;
	COUPOM
	
CONSTANTS coupons
    
PROPERTIES coupons : USER <-> COUPOM 
		  & dom(coupons) = USER
		  & ran(coupons) = COUPOM

VARIABLES 
	/* USER */ 
	users, superusers,
	/* BIKE */ 
	bikes, rentedBikes,
	/* CREDITS */ 
	credits,
	/* SALES */
	bikesSales,
	/* COUPON */
	userCoupom,
	/* LOYALTY */
	loyalty
	
INVARIANT
	/* USER */ 
 	superusers <: USER & users <:  USER &
	/* BIKE */ 
	bikes <: BIKE &
	rentedBikes : USER +-> BIKE &
	/* CREDITS */ 
	credits : USER +-> 0..100 &
	/* SALES */ 
	bikesSales : bikes +-> 1..4 &
	/* COUPON */
	userCoupom : USER <-> COUPOM &
	/* LOYALTY */
	loyalty : USER +-> 0..4
   
INITIALISATION 
	/* USER */
	users := {} ||
	superusers := {} ||
	/* BIKE */ 
	bikes := {} ||
	rentedBikes := {} ||
	/* CREDITS */
	credits := {} ||
	/* SALES */ 
	bikesSales := {} ||
	/* COUPON */
	userCoupom := {} ||
	/* LOYALTY */
	loyalty := {}

OPERATIONS
  /*========== USER ============== */ 
  addNewUser(uu) = 
  PRE uu: USER 
      & uu /: users
      & uu /: dom(loyalty)
  THEN users := users \/ {uu} || loyalty := loyalty \/ { uu  |-> 0} END;
  
  addNewSuperUser(suu) = 
  PRE suu : USER 
      & suu /: superusers
      & suu /: dom(loyalty)
  THEN superusers := superusers \/ {suu} || loyalty := loyalty \/ { suu  |-> 0} END;
  
  removeUser(ud) = 
	PRE ud : USER & ( ud :users or ud : superusers)
	THEN 
		IF ud :users 
		THEN users := users - {ud} 
		ELSIF ud : superusers 
		THEN superusers := superusers - {ud} 
		END 
	END;

 /*========== BIKE ============== */ 
  addNewBike(bb,uu) = PRE bb: BIKE & bb /: bikes & uu : superusers THEN bikes := bikes \/ {bb} END;

  removeBike(rbb,uu) = PRE rbb: BIKE & rbb : bikes & uu : superusers & uu : USER & rbb /: ran(rentedBikes)
    THEN 
        IF rbb : dom(bikesSales)
        THEN bikesSales,bikes :=  {rbb} <<| bikesSales, bikes - {rbb}
        ELSE bikes := bikes - {rbb}
        END
    END;

/*========== CREDITS ==============*/ 
addCredits(uu,cc)=
	PRE 
	uu : USER &
	( uu : users or uu : superusers) &
	cc : 6 .. 100 &
	(cc   : 6 .. 6 or cc : 12 .. 12 )
	
	THEN
	IF uu : dom(credits)  &  cc+credits(uu) < 100
	THEN  credits := credits  <+ { uu  |-> cc+credits(uu)}
	ELSIF uu /: dom(credits)
	THEN credits := credits \/ { uu  |-> cc}
	END
	END;

 /*========== RENT BIKE ============== */ 
  rentBike(uu,bb) = 
	PRE uu : USER & ( uu : users or uu : superusers) 
	& uu :  dom(credits) 
	& credits(uu) >= 6
	& bb : BIKE & bb : bikes 
	& (uu,bb) /: rentedBikes
	& bb /: dom(bikesSales)
	& uu /: dom(rentedBikes)
	& bb /: ran(rentedBikes)
	& uu : dom(loyalty) 
	& loyalty(uu) < 4
    THEN  rentedBikes := rentedBikes \/ { uu  |-> bb} || credits := credits  <+ { uu  |-> credits(uu)-6}
    || loyalty := loyalty  <+ { uu  |-> loyalty(uu)+1}
	END;

 /*========== CREATE SALE ============== */ 
createSale(uu,bb,disc) =
	PRE uu :  superusers
	& bb : bikes
	& disc : 1 .. 4
	& bb /: dom(bikesSales)
	& bb /: ran(rentedBikes)
	THEN bikesSales := bikesSales  \/ { bb  |-> disc}
	END;

/*========== CREATE COUPON ==============*/ 
        

/*========== RENT BIKE WITH SALE ==============*/


/*========== RENT BIKE WITH COUPOM ==============*/

/*========== RETURN BIKE ==============*/
returnBike(uu,bb)=
    PRE uu : USER &
        uu : dom(rentedBikes) &
        bb : bikes &
        (uu,bb) : rentedBikes 
    THEN rentedBikes := rentedBikes - {uu |-> bb}
    END;

/*========== RENT WITH LOYALTY ==============*/
rentBikeWithLoyalty(uu,bb)=
    PRE uu : USER
        & uu : dom(loyalty)
        & uu /: dom(rentedBikes)
        & loyalty(uu)= 4
        & bb : BIKE & bb : bikes
        & bb /: ran(rentedBikes)
        & bb /: dom(bikesSales)
    THEN rentedBikes := rentedBikes \/ { uu  |-> bb}
        END

END








