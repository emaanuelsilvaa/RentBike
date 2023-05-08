MACHINE rent_bike
SETS
	USER;
	BIKE

VARIABLES 
	/* USER */ 
	users, superusers,
	/* BIKE */ 
	bikes
	
INVARIANT
	/* USER */ 
 	superusers <: USER & users <:  USER &
	/* BIKE */ 
	bikes <: BIKE

INITIALISATION 
	/* USER */
	users := {} ||
	superusers := {} ||
	bikes := {}
	

OPERATIONS
  /*========== USER ============== */ 
  addNewUser(uu) = PRE uu: USER & uu /: users THEN users := users \/ {uu} END;
  
  addNewSuperUser(suu) = PRE suu : USER & suu /: superusers THEN superusers := superusers \/ {suu} END;
  
  removeUser(ud) = 
	PRE ud : USER
	THEN 
		IF ud :users 
		THEN users := users - {ud} 
		ELSIF ud : superusers 
		THEN superusers := superusers - {ud} 
		END 
	END;

 /*========== BIKE ============== */ 
  addNewBike(bb) = PRE bb: BIKE & bb /: bikes THEN bikes := bikes \/ {bb} END;

  removeBike(rbb) = PRE rbb: BIKE & rbb : bikes THEN bikes := bikes - {rbb} END


 /*========== RENT BIKE ============== */ 


END

