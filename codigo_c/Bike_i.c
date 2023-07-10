/* WARNING if type checker is not performed, translation could contain errors ! */

#include "Bike.h"

/* Clause SEES */
#include "Context.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

/* Array and record constants */
/* Clause CONCRETE_VARIABLES */

static bool Bike__bikes_i[Context__sze+1];
static int32_t Bike__bikesHelth_i[Context__sze+1];
/* Clause INITIALISATION */
void Bike__INITIALISATION(void)
{
    
    {
        int32_t ii;
        
        ii = 0;
        while(((ii) <= (Context__sze)))
        {
            Bike__bikes_i[ii] = false;
            Bike__bikesHelth_i[ii] = 0;
            ii = ii+1;
        }
    }
}

/* Clause OPERATIONS */

void Bike__create_bike(int32_t bb)
{
    Bike__bikes_i[bb] = true;
    Bike__bikesHelth_i[bb] = Context__max_helth;
}

void Bike__delete_bike(int32_t bb)
{
    Bike__bikes_i[bb] = false;
    Bike__bikesHelth_i[bb] = 0;
}

void Bike__reset_helth(int32_t bb)
{
    Bike__bikesHelth_i[bb] = Context__max_helth;
}

void Bike__set_damage(int32_t bb, int32_t dm)
{
    {
        int32_t bh;
        int32_t result;
        
        bh = Bike__bikesHelth_i[bb];
        result = bh-dm;
        if(((result) < (0)))
        {
            Bike__bikesHelth_i[bb] = 0;
        }
        else
        {
            Bike__bikesHelth_i[bb] = result;
        }
    }
}

void Bike__get_helth(int32_t bb, int32_t *qh)
{
    (*qh) = Bike__bikesHelth_i[bb];
}

