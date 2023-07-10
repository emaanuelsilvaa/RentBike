/* WARNING if type checker is not performed, translation could contain errors ! */

#include "rent_bike.h"

/* Clause SEES */
#include "Context.h"

/* Clause IMPORTS */
#include "User.h"
#include "Bike.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

#define rent_bike__rent_value 6
#define rent_bike__max_discount 3
/* Array and record constants */
/* Clause CONCRETE_VARIABLES */

static int32_t rent_bike__rentedBikes_i[Context__sze+1];
static int32_t rent_bike__bikeDiscounts_i[Context__sze+1];
/* Clause INITIALISATION */
void rent_bike__INITIALISATION(void)
{
    
    Bike__INITIALISATION();
    User__INITIALISATION();
    {
        int32_t ii;
        
        ii = 0;
        while(((ii) <= (Context__sze)))
        {
            rent_bike__rentedBikes_i[ii] = 0;
            rent_bike__bikeDiscounts_i[ii] = 0;
            ii = ii+1;
        }
    }
}

/* Clause OPERATIONS */

void rent_bike__remove_user(int32_t uu)
{
    {
        int32_t rent;
        
        rent = rent_bike__rentedBikes_i[uu];
        if(rent == 0)
        {
            User__delete_user(uu);
        }
    }
}

void rent_bike__add_bike(int32_t bb)
{
    Bike__create_bike(bb);
}

void rent_bike__remove_bike(int32_t bb)
{
    Bike__delete_bike(bb);
    rent_bike__bikeDiscounts_i[bb] = 0;
}

void rent_bike__rentBike(int32_t uu, int32_t bb)
{
    {
        int32_t hasFidelity;
        
        User__get_fidelity(uu, &hasFidelity);
        if((hasFidelity) < (Context__max_fidelity))
        {
            {
                int32_t discount;
                int32_t crd;
                int32_t rentv;
                int32_t result;
                
                discount = rent_bike__bikeDiscounts_i[bb];
                User__get_credits(uu, &crd);
                rentv = rent_bike__rent_value;
                result = crd+discount;
                if(discount == 0)
                {
                    rent_bike__rentedBikes_i[uu] = bb;
                    User__rent(uu, rentv);
                }
                else if(((discount) > (0)) &&
                ((result) >= (rentv)))
                {
                    rent_bike__rentedBikes_i[uu] = bb;
                    User__rent(uu, rentv-discount);
                }
                else
                {
                    ;
                }
            }
        }
        else
        {
            rent_bike__rentedBikes_i[uu] = bb;
            User__reset_fidelity(uu);
        }
    }
}

void rent_bike__return_bike(int32_t uu, int32_t bb)
{
    {
        int32_t bh;
        
        Bike__get_helth(bb, &bh);
        if((bh) < (Context__minimun_helth))
        {
            rent_bike__rentedBikes_i[uu] = 0;
            Bike__reset_helth(bb);
            User__remove_credit(uu, rent_bike__rent_value);
        }
        else
        {
            rent_bike__rentedBikes_i[uu] = 0;
            Bike__reset_helth(bb);
        }
    }
}

void rent_bike__evaluate_bike(int32_t bb, int32_t dm)
{
    Bike__set_damage(bb, dm);
}

void rent_bike__createDiscount(int32_t bb, int32_t disc)
{
    rent_bike__bikeDiscounts_i[bb] = disc;
}

