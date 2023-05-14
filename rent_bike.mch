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
   	userCoupom
	
INVARIANT
	/* USER */ 
 	superusers <: USER & users <:  USER &
	/* BIKE */ 
	bikes <: BIKE &
	rentedBikes : USER >+> BIKE &
	/* CREDITS */ 
	credits : USER --> 0..100 &
	/* SALES */ 
	bikesSales : bikes --> 1..4 &
	/* COUPON */
	userCoupom : USER <-> COUPOM
   
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
	userCoupom := {}
	

OPERATIONS
  /*========== USER ============== */ 
  addNewUser(uu) = PRE uu: USER & uu /: users THEN users := users \/ {uu} END;
  
  addNewSuperUser(suu) = PRE suu : USER & suu /: superusers THEN superusers := superusers \/ {suu} END;
  
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
	cc   : 6 .. 100 &
	uu : users or uu : superusers
	THEN
	IF uu : dom(credits)
	THEN  credits := {uu} <<| credits  <+  credits \/ { uu  |-> cc }
	ELSE credits := credits \/ { uu  |-> cc}
	END
	END;
	


 /*========== RENT BIKE ============== */ 
  rentBike(uu,bb) = 
	PRE uu : USER & uu : users 
	& bb : BIKE & bb : bikes 
	& (uu,bb) /: rentedBikes
	& uu /: dom(rentedBikes)
	& bb /: ran(rentedBikes)
	THEN  rentedBikes := rentedBikes \/ { uu  |-> bb}
	END;

 /*========== CREATE SALE ============== */ 
createSale(uu,bb,disc) =
	PRE uu :  superusers
	& bb : bikes
	& disc : 1 .. 4
	& bb /: dom(bikesSales)
	THEN bikesSales := bikesSales  \/ { bb  |-> disc}
	END

/*========== CREATE COUPON ==============*/ 


END


