#ifndef _rent_bike_h
#define _rent_bike_h

#include <stdint.h>
#include <stdbool.h>
/* Clause SEES */
#include "Context.h"

/* Clause INCLUDES */
#include "User.h"
#include "Bike.h"

/* Clause IMPORTS */
#include "User.h"
#include "Bike.h"
#define rent_bike__get_credits User__get_credits
#define rent_bike__get_helth Bike__get_helth
#define rent_bike__get_fidelity User__get_fidelity

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
#define rent_bike__rent_value 6
#define rent_bike__max_discount 3
/* Array and record constants */



/* Clause CONCRETE_VARIABLES */

extern void rent_bike__INITIALISATION(void);

/* Clause OPERATIONS */

extern void rent_bike__remove_user(int32_t uu);
extern void rent_bike__add_bike(int32_t bb);
extern void rent_bike__remove_bike(int32_t bb);
extern void rent_bike__rentBike(int32_t uu, int32_t bb);
extern void rent_bike__return_bike(int32_t uu, int32_t bb);
extern void rent_bike__evaluate_bike(int32_t bb, int32_t dm);
extern void rent_bike__createDiscount(int32_t bb, int32_t disc);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _rent_bike_h */
