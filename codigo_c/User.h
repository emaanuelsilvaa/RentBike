#ifndef _User_h
#define _User_h

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

extern void User__INITIALISATION(void);

/* Clause OPERATIONS */

extern void User__create_user(int32_t uu);
extern void User__delete_user(int32_t uu);
extern void User__add_credit(int32_t uu, int32_t cc);
extern void User__remove_credit(int32_t uu, int32_t cc);
extern void User__rent(int32_t uu, int32_t cc);
extern void User__get_credits(int32_t uu, int32_t *cc);
extern void User__increment_fidelify(int32_t uu);
extern void User__reset_fidelity(int32_t uu);
extern void User__get_fidelity(int32_t uu, int32_t *ff);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _User_h */
