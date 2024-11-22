#ifndef PARSER_H
#define PARSER_H

#include "lexer.h"
#include "database.h"

#define MAX_E_STMT_PER_BLOCK 100000
#define MAX_F_STMT_PER_BLOCK 100000
#define MAX_BLOCKS_PER_STACK 100000
#define MAX_TOKEN_SIZE 100000
#define MAX_STATEMENT_SIZE 300000
#define MAX_HYPOTHESES_PER_STATEMENT 100000
#define MAX_VARIABLE_PER_BLOCK 100000

// All functions in this module will begin with the prefix "pr"

// Scoping related structs


// Main Parser State struct
typedef struct {
  lxState *lx_state;
  Database *database;

} prState;

prState *prMake(lxState *lx_state, Database *database);
void prDelete(prState *pr_state);

Database *prParse(prState *pr_state);


#endif
