#include "database.h"
#include "map.h"
#include <sys/types.h>

Database *dbMake() {

  Database *database = (Database *)malloc(sizeof(Database));

  database->token_table = (map_uint_t *)malloc(sizeof(map_uint_t));
  database->statement_table = (map_uint_t *)malloc(sizeof(map_uint_t));

  database->number_of_tokens = 0;
  database->number_of_statements = 0;

  database->token_array =
      (dbToken *)malloc(sizeof(dbToken) * TOKEN_BUFFER_SIZE);
  database->statement_array =
      (dbStatement *)malloc(sizeof(dbStatement) * STATEMENT_BUFFER_SIZE);

  map_init(database->token_table);
  map_init(database->statement_table);

  return database;
}

void dbDelete(Database *database) {
  map_deinit(database->token_table);
  map_deinit(database->statement_table);

  // TODO: Free token and statement structs PROPERLY HERE.
  // Deleting statement array.
  for (uint i = 0; i < database->number_of_statements; i++) {
    if (database->statement_array[i].number_of_tokens != 0) {
      free(database->statement_array[i].tokens);
    }
    if (database->statement_array[i].number_of_hypotheses != 0) {
      free(database->statement_array[i].hypotheses);
    }
  }

  free(database->token_array);
  free(database->statement_array);
  free(database->token_table);
  free(database->statement_table);
  free(database);
}

Id dbAddToken(char *token_string, dbTokenType token_type, Database *database) {
  // First check if token is already there.
  Id *id = map_get(database->token_table, token_string);

  if (id == NULL) {
    map_set(database->token_table, token_string, database->number_of_tokens);
    database->token_array[database->number_of_tokens].type = token_type;
    return database->number_of_tokens++;
  }

  return *id;
}

Id dbGetTokenId(char *token, Database *database) {
  Id *id = map_get(database->token_table, token);

  if (id != NULL)
    return *id;

  dbPrint(database);
  printf("Attempted to access token that was not added to the DB: %s\n", token);
  exit(-1);
}

dbToken *dbGetToken(Id token_id, Database *database) {
  return database->token_array + token_id;
}

Id dbAddStatement(char *label, dbStatementType statement_type, Id *token_ids,
                  uint number_of_tokens, Id *hypothesis_ids,
                  uint number_of_hypotheses, Database *database) {

  // Checking if statement is already there.
  Id *idp = map_get(database->statement_table, label);
  if (idp != NULL) {
    //printf("Warning attempted to add statement with label %s again.\n", label);
    return *idp;
  }

  // If we are here, it means that the statement is not in the database yet.
  Id id = database->number_of_statements;

  // Adding statement to statement table.
  map_set(database->statement_table, label, id);

  // Setting statement type in statement array.
  database->statement_array[id].type = statement_type;

  // Setting number of tokens and hypotheses in statement array.
  database->statement_array[id].number_of_tokens = number_of_tokens;
  database->statement_array[id].number_of_hypotheses = number_of_hypotheses;

  // Checking for non-null tokens
  if (number_of_tokens != 0 && token_ids == NULL) {
    printf("Warning: Attempted to add statement with null token array and non-zero token count.\n");
    exit(-1);
  }

  // Allocating memory in appropriate statement array element.
  database->statement_array[id].tokens = (Id *)malloc(sizeof(Id) * number_of_tokens);

  // Copying token ids to statement array.
  for (uint i = 0; i < number_of_tokens; i++) {
    database->statement_array[id].tokens[i] = token_ids[i];
  }

  if (statement_type == DB_STMT_A || statement_type == DB_STMT_P) {

    // Checking for non-null hypotheses
    if (number_of_hypotheses != 0 && hypothesis_ids == NULL) {
      printf("Warning: Attempted to add statement with null hypothesis array and non-zero hypothesis count.\n");
      exit(-1);
    }

    // Allocating memory for hypotheses array in appropriate statement array element .
    database->statement_array[id].hypotheses = (Id *)malloc(sizeof(Id) * number_of_hypotheses);
  
    // Copying the token ids to the statement array.
    for (uint i = 0; i < number_of_hypotheses; i++) {
      database->statement_array[id].hypotheses[i] = hypothesis_ids[i];
    }

  }

  return database->number_of_statements++;
}

Id dbGetStatementId(char *label, Database *database) {
  Id *id = map_get(database->statement_table, label);

  if (id != NULL)
    return *id;

  printf("Attempted to access statement that was not added to the DB: %s\n",
         label);
  exit(-1);
}

dbStatement *dbGetStatement(Id statement_id, Database *database) {
  return database->statement_array + statement_id;
}

// IO

static void printMapAndTokenInfo(map_uint_t *map, dbToken *token_array, uint *n_labels, uint *n_variables, uint *n_constants) {
  const char *key;
  map_iter_t iter = map_iter(map);

  uint number_of_labels = 0;
  uint number_of_variables = 0;
  uint number_of_constants = 0;

  while ((key = map_next(map, &iter))) {
    Id id = *map_get(map, key);
    switch (token_array[id].type) {
    case DB_TK_LABEL:
      printf("%8s - %5u - LABEL\n", key, id);
      number_of_labels++;
      break;
    case DB_TK_VARIABLE:
      printf("%8s - %5u - VARIABLE\n", key, id);
      number_of_variables++;
      break;
    case DB_TK_CONSTANT:
      printf("%8s - %5u - CONSTANT\n", key, id);
      number_of_constants++;
      break;
    }
  }

  //printf("\nCounts of the different types of tokens:\n \n\t%u labels, \n\t%u variables \n\t%u constants\n",
  //       number_of_labels, number_of_variables, number_of_constants);

  *n_labels = number_of_labels;
  *n_variables = number_of_variables;
  *n_constants = number_of_constants;
}

static void printStatementInfo(Database *database) {
  printf("\n\nStatement Information:\n\n");
  const char *key;
  map_uint_t *map = database->statement_table;
  map_iter_t iter = map_iter(map);

  uint i = 0;

  while ((key = map_next(map, &iter))) {
    i++;

    Id id = *map_get(map, key);
    printf("%u. Statement Type: ", id);
    switch (database->statement_array[id].type) {
      case DB_STMT_F:
        printf("F");
        break;
      case DB_STMT_E:
        printf("E");
        break;
      case DB_STMT_D:
        printf("D");
        break;
      case DB_STMT_A:
        printf("A");
        break;
      case DB_STMT_P:
        printf("P");
        break;
    }
    printf(", Label: %s\n", key);
    printf("\tTokens: ");
    for (uint j = 0; j < database->statement_array[id].number_of_tokens; j++) {
      printf("%u ", database->statement_array[id].tokens[j]);
    }
    printf("\n");

    // Printing hypotheses if the statement is an A or P statement.
    if (database->statement_array[id].type == DB_STMT_A ||
        database->statement_array[id].type == DB_STMT_P) {
      printf("\tHypotheses: ");
      for (uint j = 0; j < database->statement_array[id].number_of_hypotheses; j++) {
        uint hypothesis_id = database->statement_array[id].hypotheses[j];
        printf("%u ", hypothesis_id);
      }
      printf("\n");
    }
  }
}

void dbPrint(Database *database) {

  uint n_constants, n_variables, n_labels;

  printf("Conversion Table and Token Information:\n\n");
  printMapAndTokenInfo(database->token_table, database->token_array, &n_labels, &n_variables, &n_constants);

  // Printing statement wise information
  printStatementInfo(database);

  printf("\nThe database contains:\n\t%u Tokens\n\t%u Statements\n\t%u Labels\n\t%u Variables\n\t%u Constants\n\n",
         database->number_of_tokens, database->number_of_statements, n_labels, n_variables, n_constants);
}
