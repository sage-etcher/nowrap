
#include <stdio.h>
#include <string.h>

#include "help.h"
#include "version.h"

#define HELP_MSG    embeded_help_msg
#define VERSION_MSG embeded_version_msg


static void 
wrapping_disable (void)
{
    const char *VT_WRAP_DISABLE = "\033[?7l";
    printf ("%s", VT_WRAP_DISABLE);
}


static void 
wrapping_enable (void)
{
    const char *VT_WRAP_ENABLE = "\033[?7h";
    printf ("%s", VT_WRAP_ENABLE);
}


static int 
stream_copy (FILE *dest, FILE *src)
{
    int character = 0;

    while (1)
    {
        /* read a character */
        character = fgetc (src);

        /* if character isn't indicitive of an error, print it */
        if (character != EOF)
        {
            (void)fputc (character, dest);
            continue;
        }

        /* otherwise check why the error occured */
        /* if we reach the end of file, exit */
        if (feof (src)) { break; }

        /* otherwise if there really was an error, yell to stderr */
        if (ferror (src))
        {
            (void)fprintf (stderr, "failed to read from stream\n");
            return -1;
        }
    }

    return 0;
}


static void
nowrap (void)
{
    wrapping_disable ();
    (void)stream_copy (stdout, stdin);
    wrapping_enable ();
}


static void
print_help (FILE *dest)
{
    const unsigned char *MSG = HELP_MSG;
    (void)fprintf (dest, "%s", MSG);
}


static void
print_version (FILE *dest)
{
    const unsigned char *MSG = VERSION_MSG;
    (void)fprintf (dest, "%s", MSG);
}


static int
handle_args (int argc, char **argv)
{
    char *arg_iter = argv[1];

    if ((strcmp (arg_iter, "--help") == 0) ||
        (strcmp (arg_iter, "-h") == 0))
    {
        print_help (stdout);
        return 0;
    }

    if ((strcmp (arg_iter, "--version") == 0) ||
        (strcmp (arg_iter, "-V") == 0))
    {
        print_version (stdout);
        return 0;
    }

    (void)fprintf (stderr, "unknown argument: %s\n", arg_iter);
    print_help (stderr);
    return 1;
}



int
main (int argc, char **argv)
{
    if (argc >= 2)
    {
        return handle_args (argc, argv);
    }
    nowrap ();
    return 0;
}


/* end of file */
