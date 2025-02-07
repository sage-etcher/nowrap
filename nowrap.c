
#include <stdio.h>
#include <stdlib.h>


/* VT code magic */
#define WRAP_DISABLE "\033[?7l"
#define WRAP_ENABLE  "\033[?7h"


static void nowrap (void);


int
main (int argc, char **argv)
{
    nowrap ();
    return 0;
}


void
nowrap (void)
{
    ssize_t status = 0;

    char *buffer = NULL;
    size_t buffer_capacity = 0;

    printf ("%s", WRAP_DISABLE);

    status = 0;
    while (status != -1)
    {
        status = getline (&buffer, &buffer_capacity, stdin);
        printf ("%s", buffer);
    }
    
    printf ("%s", WRAP_ENABLE);

    free (buffer);
    buffer = NULL;
    buffer_capacity = 0;
}


/* vim: makeprg=make
 */
/* end of file */
