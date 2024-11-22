#ifndef DATABASE_H
#define DATABASE_H

#define TOKEN_BUFFER_SIZE 5000000
#define STATEMENT_BUFFER_SIZE 1000000

#include "map.h"
#include <stdio.h>
// Prefix to everything here will be db

typedef uint Counter;
typedef uint Id;

typedef enum { DB_TK_CONSTANT, DB_TK_VARIABLE, DB_TK_LABEL } dbTokenType;

typedef enum {
  DB_STMT_F,
  DB_STMT_E,
  DB_STMT_D,
  DB_STMT_A,
  DB_STMT_P,
} dbStatementType;

// DB never stores $ statements as tokens, only variables, constants and labels
// are stored here.
typedef struct {
  dbTokenType type;
} dbToken;

typedef struct {
  dbStatementType type;

  Counter number_of_tokens;
  Counter number_of_hypotheses;

  Id *tokens;
  Id *hypotheses;
} dbStatement;

typedef struct {
  map_uint_t *token_table;
  map_uint_t *statement_table;

  Counter number_of_tokens;
  Counter number_of_statements;

  dbToken *token_array;
  dbStatement *statement_array;
} Database;

Database *dbMake();
void dbDelete(Database *database);

// Constants, Variables and Labels are added using the function below.
Id dbAddToken(char *token, dbTokenType token_type, Database *database);
Id dbGetTokenId(char *token, Database *database);
dbToken *dbGetToken(Id token_id, Database *database);

Id dbAddStatement(char *label, dbStatementType statement_type, Id *token_ids,
                  uint number_of_tokens, Id *hypothesis_ids,
                  uint number_of_hypotheses, Database *database);
Id dbGetStatementId(char *label, Database *database);
dbStatement *dbGetStatement(Id statement_id, Database *database);

// IO
void dbPrint(Database *database);

#endif
