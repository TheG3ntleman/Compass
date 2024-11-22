#include "utils.h"

char *utFileToBuffer(char *path) {

  FILE *file = fopen(path, "r");
  if (file == NULL) {
    fprintf(stderr, "Error opening file: %s\n", path);
    return NULL;
  }

  // Determine the file size
  fseek(file, 0, SEEK_END);
  long fileSize = ftell(file);
  fseek(file, 0, SEEK_SET);

  // Allocate memory for the buffer
  char *buffer = (char *)malloc(fileSize + 1); // +1 for null terminator
  if (buffer == NULL) {
    fclose(file);
    fprintf(stderr, "Memory allocation failed\n");
    return NULL;
  }

  // Read file contents into the buffer
  size_t bytesRead = fread(buffer, 1, fileSize, file);
  if (bytesRead != fileSize) {
    fclose(file);
    free(buffer);
    fprintf(stderr, "Error reading file: %s\n", path);
    return NULL;
  }

  // Null-terminate the buffer
  buffer[fileSize] = '\0';

  // Close the file
  fclose(file);

  return buffer;
}

void utDeleteBuffer(char *buffer) { free(buffer); }

char utStrmatch(char *str1, char *str2) {
  uint i = 0;
  for (; str1[i] != '\0' && str2[1] != '\0'; i++) {
    if (str1[i] != str2[i]) {
      return 0;
    }
  }
  if (str1[i] != '\0' || str2[i] != '\0')
    return 0;
  return 1;
}
