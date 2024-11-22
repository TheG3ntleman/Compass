#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <stdlib.h>

char *utFileToBuffer(char *path);
void utDeleteBuffer(char *buffer);

char utStrmatch(char *str1, char *str2);

#endif
