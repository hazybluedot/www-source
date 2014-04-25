~~~~ c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <analytics.h>

/* helper functions, such as print_counted_words */

void usage(int status, FILE *fp, const char* progname) {
    fprintf(fp, "Usage: %s [-h] [-k N]\n", progname);
    exit(status);
}

int main(int argc, char *argv[]) {
    long int nlimit=10;
    int opt;
    /* additional variable declarations */
    
    while ((opt = getopt(argc, argv, "hk:")) != -1) {
        switch(opt) {
        case 'h':
            usage(EXIT_SUCCESS, stdout, argv[0]);
            /* usage never returns, don't need break */
        case 'k':
            nlimit = strtol(optarg, NULL, 10);
            /* TODO: handle conversion errors, see strtol man page */
            break;
        default:
            usage(EXIT_FAILURE, stderr, argv[0]);
        }
    }

    /* remainder of program */
    
    return EXIT_SUCCESS;
}
~~~~
