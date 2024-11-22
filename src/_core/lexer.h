#ifndef LEXER_H
#define LEXER_H

#include "utils.h"
#include <stdlib.h>

// All Functions begin with the prefix lx
// All inputs files that are currently being processed are
// completely loaded (not partially)

// This lexer does not work for compressed proofs and file imports.
// It expects input buffer to be "fully expanded".

typedef struct {

  char *buffer;
  uint pos;
  uint max_pos;

} lxState;

typedef enum {
  TK_C_STATEMENT,
  TK_V_STATEMENT,
  TK_D_STATEMENT,
  TK_F_STATEMENT,
  TK_E_STATEMENT,
  TK_A_STATEMENT,
  TK_P_STATEMENT,
  TK_PE_STATEMENT,
  TK_SCOPE_START,
  TK_SCOPE_END,
  TK_DOT_STATEMENT,
  // At the lexer stage every non-keyword token is an expr,
  // But at the parser stage an expr becomes either a constant
  // or a variable.
  TK_EXPR, 
  TK_EOF
} lxTokenType;

typedef struct {
  lxTokenType type;
  char *buffer;
  uint max_size;
  uint size;
} lxToken;

// Memory managment functions
lxState *lxMakeState(char *buffer);
void lxDeleteState(lxState *state);
lxToken *lxMakeToken(uint max_text_size);
void lxDeleteToken(lxToken *token);

// Get next token function.
void lxGetNextToken(lxToken *token, lxState *state);

#endif
