#include "parser.h"
#include "database.h"
#include "lexer.h"



// Parse the input file
prState *prMake(lxState *lx_state, Database *database) {
  prState *pr_state = (prState *)malloc(sizeof(prState));
  if (pr_state == NULL) {
    fprintf(stderr, "Memory allocation failed\n");
    exit(-1);
  }

  // Associating lexer and database
  pr_state->lx_state = lx_state;
  pr_state->database = database;

  return pr_state;
}

void prDelete(prState *pr_state) {
  free(pr_state);
}

// No error checking is done here. It is assumed that the token sequence is a valid for now.
// TODO: Update the parser to handle grammar errors later.

static void pr_C_StatementHandler(lxToken *token, prState *pr_state) {
  // Checking if the token is indeed a C_STATMENT token
  if (token->type != TK_C_STATEMENT) {
    fprintf(stderr, "Expected a C_STMT token, but got %s\n", token->buffer);
    exit(-1);
  }

  // Iterating through tokens until an "$." (TK_DOT_STATEMENT) is encountered.
  for (lxGetNextToken(token, pr_state->lx_state); token->type != TK_DOT_STATEMENT;
       lxGetNextToken(token, pr_state->lx_state)) {
    dbAddToken(token->buffer, DB_TK_CONSTANT, pr_state->database);
  }

}


static void pr_V_StatementHandler(lxToken *token, prState *pr_state) {
  // Checking if the token is indeed a V_STATEMENT token
  if (token->type != TK_V_STATEMENT) {
    fprintf(stderr, "Expected a V_STMT token, but got %s\n", token->buffer);
    exit(-1);
  }

  // Iterating through tokens until an "$." (TK_DOT_STATEMENT) is encountered.
  
  // Checking number of variables in the database.
  uint n_vars = 0;
  for (uint i = 0; i < pr_state->database->number_of_tokens; i++) {
    if (pr_state->database->token_array[i].type == DB_TK_VARIABLE) {
      n_vars++;
    }
  }
  for (lxGetNextToken(token, pr_state->lx_state); token->type != TK_DOT_STATEMENT;
       lxGetNextToken(token, pr_state->lx_state)) {
      
    printf("%u. %s\n", ++n_vars, token->buffer);
    dbAddToken(token->buffer, DB_TK_VARIABLE, pr_state->database);
  }
}

static void pr_D_StatementHandler(lxToken *token, prState *pr_state) {
  // Checking if the token is indeed a D_STATEMENT token
  if (token->type != TK_D_STATEMENT) {
    fprintf(stderr, "Expected a D_STMT token, but got %s\n", token->buffer);
    exit(-1);
  }

  Id tokens[MAX_STATEMENT_SIZE];

  // Iterating through tokens until an "$." (TK_DOT_STATEMENT) is encountered.
  uint number_of_tokens = 0;
  for (lxGetNextToken(token, pr_state->lx_state); token->type != TK_DOT_STATEMENT; number_of_tokens++) {
    tokens[number_of_tokens] = dbGetTokenId(token->buffer, pr_state->database);
    lxGetNextToken(token, pr_state->lx_state);
  }

  dbAddStatement("\0", DB_STMT_D, tokens, number_of_tokens, NULL, 0, pr_state->database);

}

static void pr_F_StatementHandler(lxToken *token, prState *pr_state, char *label) {
  // Checking if the token is indeed a F_STATEMENT token
  if (token->type != TK_F_STATEMENT) {
    fprintf(stderr, "Expected a F_STMT token, but got %s\n", token->buffer);
    exit(-1);
  }

  Id tokens[MAX_STATEMENT_SIZE];

  // Iterating through tokens until an "$." (TK_DOT_STATEMENT) is encountered.
  uint number_of_tokens = 0;
  for (lxGetNextToken(token, pr_state->lx_state); token->type != TK_DOT_STATEMENT; number_of_tokens++) {
    tokens[number_of_tokens] = dbGetTokenId(token->buffer, pr_state->database);
    lxGetNextToken(token, pr_state->lx_state);
  }

  dbAddStatement(label, DB_STMT_F, tokens, number_of_tokens, NULL, 0, pr_state->database);
}

static void pr_E_StatementHandler(lxToken *token, prState *pr_state, char *label) {
  // Checking if the token is indeed a E_STATEMENT token
  if (token->type != TK_E_STATEMENT) {
    fprintf(stderr, "Expected a E_STMT token, but got %s\n", token->buffer);
    exit(-1);
  }

  Id tokens[MAX_STATEMENT_SIZE];

  // Iterating through tokens until an "$." (TK_DOT_STATEMENT) is encountered.
  uint number_of_tokens = 0;
  for (lxGetNextToken(token, pr_state->lx_state); token->type != TK_DOT_STATEMENT; number_of_tokens++) {
    tokens[number_of_tokens] = dbGetTokenId(token->buffer, pr_state->database);
    lxGetNextToken(token, pr_state->lx_state);
  }

  dbAddStatement(label, DB_STMT_E, tokens, number_of_tokens, NULL, 0, pr_state->database);
}

static void pr_A_StatementHandler(lxToken *token, prState *pr_state, char *label) {
  

}

static void pr_P_StatementHandler(lxToken *token, prState *pr_state, char *label) {
  

}

Database *prParse(prState *pr_state) {
  lxToken *token = lxMakeToken(MAX_TOKEN_SIZE);
  char prev_buffer[MAX_TOKEN_SIZE]; // Storing the previous token buffer to check for the label of the statement.

  for (; token->type != TK_EOF; lxGetNextToken(token, pr_state->lx_state)) {
    // Switch case statement to pass control to different handlers.
    switch (token->type) {
    case TK_C_STATEMENT:
      pr_C_StatementHandler(token, pr_state);
      break;
    case TK_V_STATEMENT:
      pr_V_StatementHandler(token, pr_state);
      break;
    case TK_D_STATEMENT:
      pr_D_StatementHandler(token, pr_state);
      break;
    case TK_F_STATEMENT:
      pr_F_StatementHandler(token, pr_state, prev_buffer);
      break;
    case TK_E_STATEMENT:
      pr_E_StatementHandler(token, pr_state, prev_buffer);
      break;
    case TK_A_STATEMENT:  
      pr_A_StatementHandler(token, pr_state, prev_buffer);
      break;
    case TK_P_STATEMENT:  
      pr_P_StatementHandler(token, pr_state, prev_buffer);
      break;
    case TK_SCOPE_START:
      break;
    case TK_SCOPE_END:
      break;
    default:
      break;
    }
    // Copying current token to "prev_buffer" for a one-step lookback.
    strcpy(prev_buffer, token->buffer);
  }

  return pr_state->database;
}