#include "lexer.h"

lxState *lxMakeState(char *buffer) {
  lxState *lx_state = malloc(sizeof(lxState));

  // Calculating number of characters
  uint c = 0;
  while (buffer[c] != '\0')
    c++;
  lx_state->pos = 0;
  lx_state->max_pos = c;

  // Copying buffer
  lx_state->buffer = malloc(sizeof(char) * (c + 1));
  for (uint i = 0; i < c + 1; i++)
    lx_state->buffer[i] = buffer[i];

  return lx_state;
}

void lxDeleteState(lxState *state) {
  free(state->buffer);
  free(state);
}

lxToken *lxMakeToken(uint max_text_size) {
  lxToken *token = malloc(sizeof(lxToken));
  token->buffer = malloc(sizeof(char) * max_text_size);
  token->max_size = max_text_size;
  token->size = 0;
  return token;
}

void lxDeleteToken(lxToken *token) {
  free(token->buffer);
  free(token);
}

static void lxGetNextTextBlock(lxToken *token, lxState *state) {
  // Finding out the next block of contiguous text.
  token->size = 0;
  if (state->pos == state->max_pos) {
    token->buffer[token->size] = '\0';
    return;
  }

  // Checking for spaces, tabs, and newlines
  while (state->buffer[state->pos] == ' ' ||
         state->buffer[state->pos] == '\t' || state->buffer[state->pos] == '\n')
    state->pos++;

  for (;
       state->buffer[state->pos] != ' ' && state->buffer[state->pos] != '\n' &&
       state->buffer[state->pos] != '\t' && state->pos <= state->max_pos;
       state->pos++) {
    token->buffer[token->size++] = state->buffer[state->pos];
  }

  state->pos++; // Skipping the spaces, newlines, and tabs.
  token->buffer[token->size] =
      '\0'; // Terminating buffer string with null character.
}

void lxGetNextToken(lxToken *token, lxState *state) {

  // Checking if no more tokens are present in the buffer via a
  // size comparison.
  if (state->pos == state->max_pos) {
    token->type = TK_EOF;
    return;
  }

BAD_IDEA:
  lxGetNextTextBlock(token, state);

  // Checking what the block of text actually is. (and getting rid of it if it
  // is a comment.)
  if (utStrmatch(token->buffer, "$(")) {
    // Token starts a comment
    while (!utStrmatch(token->buffer, "$)")) {
      lxGetNextTextBlock(token, state);
    }

    goto BAD_IDEA;
  }

  if (utStrmatch(token->buffer, "$c")) {
    token->type = TK_C_STATEMENT;
  } else if (utStrmatch(token->buffer, "$v")) {
    token->type = TK_V_STATEMENT;
  } else if (utStrmatch(token->buffer, "$f")) {
    token->type = TK_F_STATEMENT;
  } else if (utStrmatch(token->buffer, "$e")) {
    token->type = TK_E_STATEMENT;
  } else if (utStrmatch(token->buffer, "$a")) {
    token->type = TK_A_STATEMENT;
  } else if (utStrmatch(token->buffer, "$d")) {
    token->type = TK_D_STATEMENT;
  } else if (utStrmatch(token->buffer, "$p")) {
    token->type = TK_P_STATEMENT;
  } else if (utStrmatch(token->buffer, "$=")) {
    token->type = TK_PE_STATEMENT;
  } else if (utStrmatch(token->buffer, "${")) {
    token->type = TK_SCOPE_START;
  } else if (utStrmatch(token->buffer, "$}")) {
    token->type = TK_SCOPE_END;
  } else if (utStrmatch(token->buffer, "$.")) {
    token->type = TK_DOT_STATEMENT;
  } else if (utStrmatch(token->buffer, "$[")) {
    printf("File Imports not Supported (found at position %u).\n", state->pos);
    exit(-1);
  } else if (token->buffer[0] == '\0') { // EOF
    token->type = TK_EOF;
  } else {
    token->type = TK_EXPR;
  }
}
