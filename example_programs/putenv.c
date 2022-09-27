/* 
 * putenv.c - just a simple test
 * 
 * Author:	Shawn Ostermann
 * 		Dept. of Computer Sciences
 * 		Purdue University
 * Date:	Sept 27, 2022
 *
 * Copyright (c) 1992 Shawn Ostermann
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


int
main(
    int argc,
    char *argv[])
{
    putenv("FUNCLASS=4420");

    printf("This is a fun class: \n");
    execl("/usr/bin/printenv","printenv","FUNCLASS",0);
}

