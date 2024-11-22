# Intermediate and Final Goals related to the AI solver

## Final Goal 
Given a set of axioms and a theorem (all definitions required to state the theorem are present)
find the proof of the theorem by, making definitions for new objects, generating and proving 
propositions/lemmas to aid in the final proof, add necessary axioms (although discouraged).

## Intermediate Goal - I
Given a set of axioms, definitions, and results relevant to the proof of a theorem
Prove that theorem, given the fact that the theorem is indeed valid and a proof indeed exists.

### Paraphrasing of goal in the context of metamath
Given access to all the context before a $= statement. Predict the labels that come after it with great 
accuracy.

# Versions and Version Objectives of MetamathCompass / MetamathSandbox

## Version 1.0
    - Can verify any metamath file you give it ["supports file imports"]
    - Can generate a metamath database of "truths" from a .mm file. After generation process is over, 
      proof repeated verification on this intermediate state is extremely fast. 
    - Modification of a database is disabled for now.
    - Training task generation
        - Each $= statement is used to generate a training task full with the hypothesis, theorem 
          statement, previous "context" which is exposed to the solver.
        - These training tasks are stored using metadata on the database and are not seperate redundant
        data themselves. As that would be extremely slow.
    - Interactive theorem proving
        - Provides hypothesis, theorem  statement and previous "context" to any solver in a required format.
        - Accepts proof-steps (in the form of previously defined labels) and takes care of the internal proof state (frame stack, ...)
        - Provides feedback on for each proof-label
            - Whether the substitution was successful or not
            - Whether the proof is going in the "correct direction" or not
            - If the substitution fails, then explain why it failed.
            - Must be able to hand go-back tokens 
            - Must provide current "framestack/statement values/proof state" back to the solver algorithm.
            - Must accept termination tokens to check if the proof is complete and provide feedback on whether 
              termination is possible and valid.
    - Internal neural embedding generation support.
    - Python interface for all interactive theorem proving features.

# Timeline for project

17th - Finish Metamath sandbox (including embedding generation)
20th - Finish neural "solver" and have a couple of runs at interactive proving using the neural network.
23rd - Finish training loop for neural architecture for "solver" and embedding generation.


