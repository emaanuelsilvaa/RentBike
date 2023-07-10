#ifndef _Bike_h
#define _Bike_h

#include <stdint.h>
#include <stdbool.h>
/* Clause SEES */
#include "Context.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
/* Array and record constants */

/* Clause CONCRETE_VARIABLES */

extern void Bike__INITIALISATION(void);

/* Clause OPERATIONS */

extern void Bike__create_bike(int32_t bb);
extern void Bike__delete_bike(int32_t bb);
extern void Bike__reset_helth(int32_t bb);
extern void Bike__set_damage(int32_t bb, int32_t dm);
extern void Bike__get_helth(int32_t bb, int32_t *qh);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Bike_h */
