/* WARNING if type checker is not performed, translation could contain errors ! */

#include "User.h"

/* Clause SEES */
#include "Context.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

/* Array and record constants */
/* Clause CONCRETE_VARIABLES */

static bool User__users_i[Context__sze+1];
static int32_t User__credits_i[Context__sze+1];
static int32_t User__fidelities_i[Context__sze+1];
/* Clause INITIALISATION */
void User__INITIALISATION(void)
{
    
    {
        int32_t ii;
        
        ii = 0;
        while(((ii) <= (Context__sze)))
        {
            User__users_i[ii] = false;
            User__credits_i[ii] = 0;
            User__fidelities_i[ii] = 0;
            ii = ii+1;
            printf("inserindo user\n");
        }
    }
     
}

/* Clause OPERATIONS */

void User__create_user(int32_t uu)
{
    User__users_i[uu] = true;
    User__fidelities_i[uu] = 0;
    User__credits_i[uu] = 0;
}

void User__delete_user(int32_t uu)
{
    User__users_i[uu] = false;
    User__fidelities_i[uu] = 0;
    User__credits_i[uu] = 0;
}

void User__add_credit(int32_t uu, int32_t cc)
{
    {
        int32_t nc;
        
        nc = cc+User__credits_i[uu];
        if(((nc) <= (Context__credit_limit)))
        {
            User__credits_i[uu] = nc;
        }
        else
        {
            User__credits_i[uu] = Context__credit_limit;
        }
    }
}

void User__remove_credit(int32_t uu, int32_t cc)
{
    {
        int32_t nc;
        
        nc = User__credits_i[uu];
        User__credits_i[uu] = nc-cc;
    }
}

void User__rent(int32_t uu, int32_t cc)
{
    User__credits_i[uu] = User__credits_i[uu]-cc;
    User__fidelities_i[uu] = User__fidelities_i[uu]+Context__fidelity_increment;
}

void User__get_credits(int32_t uu, int32_t *cc)
{
    (*cc) = User__credits_i[uu];
}

void User__increment_fidelify(int32_t uu)
{
    User__fidelities_i[uu] = User__fidelities_i[uu]+Context__fidelity_increment;
}

void User__reset_fidelity(int32_t uu)
{
    User__fidelities_i[uu] = 0;
}

void User__get_fidelity(int32_t uu, int32_t *ff)
{
    (*ff) = User__fidelities_i[uu];
}

