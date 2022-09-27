#include <stdio.h>
#include "examples/algorithm/function.h"

/// \file
/// \author Jeff Barbieri
/// \date Jun 30 2019

/// Application overview.
int main()
{
  // Read the input from the user.
  size_t input = 0;
  printf("> ");
  scanf("%zu", &input);

  // Calculate the output.
  size_t output = function(input);

  // Return the output to the user.
  printf("%zu\n", output);
  return output;
}
