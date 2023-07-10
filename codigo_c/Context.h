#ifndef _Context_h
#define _Context_h

#include <stdint.h>
#include <stdbool.h>
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
#define Context__minimun_helth 90
#define Context__max_helth 100
#define Context__sze 10
typedef int Context__BIKES;
#define Context__credit_limit 100
#define Context__max_fidelity 4
#define Context__fidelity_increment 1
typedef int Context__USERS;
/* Array and record constants */









/* Clause CONCRETE_VARIABLES */

extern void Context__INITIALISATION(void);


#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Context_h */
