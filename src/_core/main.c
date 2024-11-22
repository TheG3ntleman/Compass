#include "database.h"
#include "parser.h"
#include "lexer.h"
#include "parser.h"
#include "utils.h"
#include <stdio.h>

int main(int argc, char *argv[]) {

  if (argc != 2) {
    printf("Invalid Arguments.\n Proper Usage: compassDL path_to_file");
  }

  char *file_buffer = utFileToBuffer(argv[1]);
  /*// printf("File is: \n%s\n", file_buffer);
  lxState *lx_state = lxMakeState(file_buffer);
  lxToken *lx_token = lxMakeToken(10000);
  utDeleteBuffer(file_buffer);

  // Making a database.
  Database *database = dbMake();

  for (uint i = 0; lx_token->type != TK_EOF; i++) {
    lxGetNextToken(lx_token, lx_state);
    dbAddToken(lx_token->buffer, DB_TK_LABEL, database);
    printf("Token %3u: '%8s' with type: %1u at pos %6u\n", i + 1,
           lx_token->buffer, (uint)lx_token->type, lx_state->pos);
  }

  dbPrint(database);

  lxDeleteState(lx_state);
  lxDeleteToken(lx_token);
  dbDelete(database);*/

  lxState *lx_state = lxMakeState(file_buffer);
  Database *database = dbMake();
  prState *pr_state = prMake(lx_state, database);
  prParse(pr_state);
  //dbPrint(database);
  prDelete(pr_state);
  lxDeleteState(lx_state);

  return 0;
}
