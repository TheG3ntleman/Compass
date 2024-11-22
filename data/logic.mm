$( This is the Metamath database set.mm. $)

$( Metamath is a formal language and associated computer program for
   archiving, verifying, and studying mathematical proofs, created by Norman
   Dwight Megill (1950--2021).  For more information, visit
   https://us.metamath.org and
   https://github.com/metamath/set.mm, and feel free to ask questions at
   https://groups.google.com/g/metamath. $)

$( New users may want to read https://us.metamath.org/mpeuni/conventions.html
   to understand the label naming conventions used in set.mm.  See also the
   Metamath program command "MM> HELP VERIFY MARKUP" for markup conventions. $)

$( To break this file into smaller modules, in the Metamath program type
   "MM> READ set.mm" followed by "MM> WRITE SOURCE set.mm / SPLIT".  To
   recombine, omit "/ SPLIT". $)

$( The database set.mm was created by Norman Megill on 30-Sep-1992 and has
   been continuously enriched since then (list of contributors below). $)


$( !
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
  Metamath source file for logic and set theory
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

                           ~~ PUBLIC DOMAIN ~~
This work is waived of all rights, including copyright, according to the CC0
Public Domain Dedication.  http://creativecommons.org/publicdomain/zero/1.0/

Currently active maintainers: See the list in the CONTRIBUTING.md file of
https://github.com/metamath/set.mm.

Contributor list:

DA  David Abernethy
SA  Stefan Allan
TA  Thierry Arnoux
JA  Juha Arpiainen
JB  Jonathan Ben-Naim
GB  Gregory Bush
MC  Mario Carneiro
FC  Filip Cernatescu
PC  Paul Chapman
DF  Drahflow
GD  Georgy Dunaev
SF  Scott Fenton
GG  Gino Giotto
JGH Jeff Hankins
AH  Anthony Hart
DH  David Harvey
CH  Chen-Pang He
JH  Jeff Hoffman
II  Igor Ieskov
AI  Asger C. Ipsen
JJ  Jerry James
SJ  Szymon Jaroszewicz
BJ  Benoit Jubin
JK  Jim Kingdon
ML  M L
WL  Wolf Lammen
GL  Gerard Lang
BL  Brendan Leahy
LL  Larry Lesyna
RL  Raph Levien
FL  Frederic Line
RFL Roy F. Longton
JPM Jeffrey P. Machado
JM  Jeff Madsen
GM  Giovanni Mascellani
PM  Peter Mazsa
RM  Rodolfo Medina
NM  Norman Megill
DM  David Moews
MM  Mykola Mostovenko
SN  Steven Nguyen
MO  Mel L. O'Cat
OAI OpenAI
SO  Stefan O'Rear
JO  Jason Orendorff
KP  K P
JPP Jon Pennant
RP  Richard Penner
SP  Stanislas Polu
JP  Josh Purinton
RR  Rohan Ridenour
SR  Steve Rodriguez
ATS Andrew Salmon
AS  Alan Sare
ES  Eric Schmidt
GS  Glauco Siliprandi
SS  Saveliy Skresanov
BT  BTernaryTau
JU  Jarvin Udandy
ADH Stijn "Adhemar" Vandamme
AV  Alexander van der Vekens
JV  Jannik Vierling
EW  Emmett Weisz
DAW David A. Wheeler
RW  Roger Witte
KW  Kyle Wyonch
JY  Jonathan Yan
FZ  Fan Zheng
KZ  Kunhao Zheng
RM  Remi

HTML code for accented names:
  BJ Beno&icirc;t Jubin
  GL G&eacute;rard Lang
  FL Fr&eacute;d&eacute;ric Lin&eacute;

$)


$( See "MM> HELP VERIFY MARKUP" for help with modularization tags. $)
$( Begin $[ set-header.mm $] $)
$( !
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Contents of this header
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

* Quick "How To"
* Bibliography
* Metamath syntax summary
* Other notes


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Quick "How To"
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

How to use this file under Windows 95/98/NT/2K/XP/Vista/7/10:

1. Download the Metamath program metamath.exe following the instructions on the
   Metamath home page (https://us.metamath.org) and put it in the same
   directory as this file.
2. In Windows Explorer, double-click on metamath.exe.
3. Type "read set.mm" and press Enter.
4. Type "help" for a list of help topics, and "help demo" for some
   command examples.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Bibliography
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Bibliographical references are made by bracketing an identifier in a theorem's
comment, such as [RussellWhitehead].  These refer to HTML tags on the following
web pages:

  Logic and set theory - see https://us.metamath.org/mpeuni/mmset.html#bib
  Hilbert space - see https://us.metamath.org/mpeuni/mmhil.html#ref

A bracketed reference must be preceded by a theorem number, etc. and followed
by a page number.  See "MM> HELP WRITE BIBLIOGRAPHY" for details.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Metamath syntax summary
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

The HELP LANGUAGE command in the Metamath program will give you a quick
overview of Metamath.  The specification is found on pp. 92--95 of the
Metamath book.  The following syntax summary is provided for convenience
but may omit some details.

A Metamath database (set of one or more ASCII source files) is a sequence of
_tokens_, which are normally separated by spaces or line breaks.  The only
tokens that are built into the Metamath language are those (two-character
sequences) beginning with $, shown in the following. These tokens are called
_keywords_:

          $c ... $. - Constant declaration
          $v ... $. - Variable declaration
          $d ... $. - Disjoint (distinct) variable restriction
  <label> $f ... $. - "Floating" hypothesis (i.e. variable type declaration)
  <label> $e ... $. - "Essential" hypothesis (i.e. a logical assumption for a
                      theorem or axiom)
  <label> $a ... $. - Axiom or definition or syntax construction
  <label> $p ... $= ... $. - Theorem and its proof
          ${ ... $} - Block for defining the scope of the above statements
                      (except $a, $p which are forever active)
$)        $( ... $)
$(                  - Comments (may not be nested); see HELP LANGUAGE
                      for markup features.
          $[ ... $] - Include a file

The above two-character sequences beginning with "$" are the only primitives
built into the Metamath language.  The only "logic" Metamath uses in its proof
verification algorithm is the substitution of expressions for variables while
checking for distinct variable violations.  Everything else, including the
axioms for logic, is defined in this database file.

All other tokens are user-defined, and their names are arbitrary.  There are
two kinds of user-defined tokens, called math symbols (or just symbols) and
labels.  A _symbol_ may contain any non-whitespace printable character except
"$".  A _label_ may contain only alphanumeric characters and the characters "."
(period), "-" (hyphen), and "_" (underscore).  Symbols and labels are
case-sensitive.  All labels (except in proofs) must be distinct.  A label may
not have the same name as a symbol (to simplify the coding of certain parsers
and translators).

Here is some more detail about the syntax:

  $c <symbollist> $.
      <symbollist> is a (whitespace-separated) list of distinct symbols that
      haven't been used before.
  $v <symbollist> $.
      <symbollist> is a list of distinct symbols that haven't been used yet
      in the current scope (see ${ ... $} below).
  $d <symbollist> $.
      <symbollist> is a (whitespace-separated) list of distinct symbols
      previously declared with $v in current scope.  It means that
      substitutions into these symbols may not have variables in common.
  <label> $f <symbollist> $.
      <symbollist> is a list of 2 symbols, the first of which must be
      previously declared with $c in the current scope.
  <label> $e <symbollist> $.
      <symbollist> is a list of 2 or more symbols, the first of which must be
      previously declared with $c in the current scope.
  <label> $a <symbollist> $.
      <symbollist> is a list of 2 or more symbols, the first of which must be
      previously declared with $c in the current scope.
  <label> $p <symbollist> $= <proof> $.
      <symbollist> is a list of 2 or more symbols, the first of which must be
      previously declared with $c in the current scope.  <proof> is either a
      whitespace-delimited sequence of previous labels (created by
      SAVE PROOF <label> /NORMAL) or a compressed proof (created by
      SAVE PROOF <label> /COMPRESSED).  After using SAVE PROOF, use
      WRITE SOURCE to save the database file to disk.
  ${ ... $}
      Block for scoping the above statements (except $a, $p which are forever
      active).  Currently, $c may not occur inside of a block.
$)
  $( <any text> $)
$(    Comment.  Note: <any text> may not contain adjacent "$" and ")"
      characters.  The comment opening and closing delimiters must be
      surrounded by whitespace (space, tab, CR, LF, or FF).
  $[ <filename> $]
      Insert contents of <filename> at this point.  If <filename> is current
      file or has been already been inserted, it will not be inserted again.

Inside of comments, it is recommended that labels be preceded with a tilde (~)
and math symbol tokens be enclosed in grave accents, also known as backticks
(` `). These tildes, tokens, math symbols and backticks should be surrounded by
spaces.  This way the LaTeX and HTML rendition of comments will be accurate,
and tools to globally change labels and math symbols will also change them in
comments.  Note that inside of backticks a pair of backticks is interpreted as
a single backtick.  A special comment containing $ t (with no space after the
dollar sign) defines LaTeX and HTML symbols.  See HELP LANGUAGE and HELP HTML
for other markup features in comments.

The proofs in this file are in "compressed" format for storage efficiency.  The
Metamath program reads the compressed format directly.  This format is
described in Appendix B of the Metamath book.  It is not intended to be read by
humans.  For viewing proofs you should use the various SHOW PROOF commands
described in the Metamath book (or the online HELP).

The Metamath program does not normally affect any content of this file other
than proofs, i.e., the text between "$=" and "$." (and some rewrapping).  All
other content is user-created.  Proofs are created or modified with the PROVE
command.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Other notes
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

1.  It is recommended that you be familiar with Chapters 2 and 4 of the
Metamath book to understand the Metamath language.  Chapters 2, 3 and 5 explain
how to use the Metamath program.  Chapter 3 gives an informal overview of what
this source file is all about.  Appendix A gives the standard mathematical
symbols corresponding to some of the ASCII tokens used in this file.

The ASCII tokens may seem cryptic at first, even if you are familiar with set
theory, but a review of the definition summary in Chapter 3 should quickly
enable you to see the correspondence to standard mathematical notation.  To
easily find the definition of a token, search for the first occurrences of the
token surrounded by spaces.  Some odd-looking ones include "-." for "not", and
"C_" for "is a subset of".  The Metamath program "MM> HELP TEX" command
explains how to obtain a LaTeX output to see the real mathematical symbols.
Let us know if you have better suggestions for naming ASCII tokens.

2.  Theorems can be written in different forms, including "closed form",
"deduction form", and "inference form" (for details, see ~ conventions ).  For
basic theorems, all three forms are generally given, but for more advanced
theorems, we prefer to use the deduction form, since it permits to write proofs
in the "deduction style", and we do not add theorems in inference form unless
there are reasonable grounds for it (for instance, shortening sufficiently many
proofs to counterbalance their addition).

3.  On providing new definitions and theorems, the conventions provided in the
comment of ~ conventions should be obeyed.

4.  For a chronological list of changes to label names and label deletions, see
the changes-set.txt file.  This should help if you have a proof not checked
into the main repository and want to update it for recent changes.

$)

$( End $[ set-header.mm $] $)


$( Begin $[ set-main.mm $] $)
$( Begin $[ set-pred.mm $] $)

$( The following header is the first to appear in the Theorem List contents,
   because higher-level headers suppress all previous same-level or
   lower-level headers in the same comment area between $a and $p statements.
   See "MM> HELP WRITE THEOREM_LIST" for information about headers. $)

$(
###############################################################################
  CLASSICAL FIRST-ORDER LOGIC WITH EQUALITY
###############################################################################

  Logic can be defined as the "study of the principles of correct reasoning"
  (Merrilee H. Salmon's 1991 "Informal Reasoning and Informal Logic" in
  _Informal Reasoning and Education_) or as "a formal system using symbolic
  techniques and mathematical methods to establish truth-values" (the Oxford
  English Dictionary).

  This section formally defines the logic system we will use.  In particular,
  it defines symbols for declaring truthful statements, along with rules for
  deriving truthful statements from other truthful statements.  The system
  defined here is classical first-order logic with equality (the most common
  logic system used by mathematicians).

  We begin with a few housekeeping items in pre-logic, and then introduce
  propositional calculus (both its axioms and important theorems that can be
  derived from them).  Propositional calculus deals with general truths about
  well-formed formulas (wffs) regardless of how they are constructed.  This is
  followed by proofs that other axiomatizations of classical propositional
  calculus can be derived from the axioms we have chosen to use.

  We then define predicate calculus, which adds additional symbols and rules
  useful for discussing objects (beyond simply true or false).  In particular,
  it introduces the symbols ` = ` ("equals"), ` e. ` ("is a member of"), and
  ` A. ` ("for all").  The first two are called "predicates".  A predicate
  specifies a true or false relationship between its two arguments.

$)


$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
  Pre-logic
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

  This section includes a few "housekeeping" mechanisms before we begin
  defining the basics of logic.

$)

  $( Declare the primitive constant symbols for propositional calculus. $)
  $c ( $.  $( Left parenthesis $)
  $c ) $.  $( Right parenthesis $)
  $c -> $.  $( Right arrow (read:  "implies") $)
  $c -. $.  $( Right handle (read:  "not") $)
  $c wff $.  $( Well-formed formula symbol (read:  "the following symbol
                sequence is a wff") $)
  $c |- $.  $( Turnstile (read:  "the following symbol sequence is provable" or
               "a proof exists for") $)

  $( Define the syntax and logical typecodes, and declare that our grammar is
     unambiguous (verifiable using the KLR parser, with compositing depth 5).
     (This $ j comment need not be read by verifiers, but is useful for parsers
     like mmj2.) $)
  $( $j
    syntax 'wff';
    syntax '|-' as 'wff';
    unambiguous 'klr 5';
  $)

  $( Declare typographical constant symbols that are not directly used in the
     formalism but are useful to explain it in comments. $)

  $c & $.  $( Ampersand (read: "and"). $)
  $c => $.  $( Double right arrow (read: "implies"). $)

  $( wff variable sequence:  ph ps ch th ta et ze si rh mu la ka $)
  $( Introduce some variable names we will use to represent well-formed
     formulas (wff's). $)
  $v ph $.  $( Greek phi $)
  $v ps $.  $( Greek psi $)
  $v ch $.  $( Greek chi $)
  $v th $.  $( Greek theta $)
  $v ta $.  $( Greek tau $)
  $v et $.  $( Greek eta $)
  $v ze $.  $( Greek zeta $)
  $v si $.  $( Greek sigma $)
  $v rh $.  $( Greek rho $)
  $v mu $.  $( Greek mu $)
  $v la $.  $( Greek lambda $)
  $v ka $.  $( Greek kappa $)

  $( Specify some variables that we will use to represent wff's.
     The fact that a variable represents a wff is relevant only to a theorem
     referring to that variable, so we may use $f hypotheses.  The symbol
     ` wff ` specifies that the variable that follows it represents a wff. $)
  $( Let variable ` ph ` be a wff. $)
  wph $f wff ph $.
  $( Let variable ` ps ` be a wff. $)
  wps $f wff ps $.
  $( Let variable ` ch ` be a wff. $)
  wch $f wff ch $.
  $( Let variable ` th ` be a wff. $)
  wth $f wff th $.
  $( Let variable ` ta ` be a wff. $)
  wta $f wff ta $.
  $( Let variable ` et ` be a wff. $)
  wet $f wff et $.
  $( Let variable ` ze ` be a wff. $)
  wze $f wff ze $.
  $( Let variable ` si ` be a wff. $)
  wsi $f wff si $.
  $( Let variable ` rh ` be a wff. $)
  wrh $f wff rh $.
  $( Let variable ` mu ` be a wff. $)
  wmu $f wff mu $.
  $( Let variable ` la ` be a wff. $)
  wla $f wff la $.
  $( Let variable ` ka ` be a wff. $)
  wka $f wff ka $.


$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Inferences for assisting proof development
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  The inference rules in this section will normally never appear in a completed
  proof.  They can be ignored if you are using this database to assist learning
  logic - please start with the statement ~ wn instead.

$)

  ${
    idi.1 $e |- ph $.
    $( (_Note_:  This inference rule and the next one, ~ a1ii , will normally
       never appear in a completed proof.  They can be ignored if you are using
       this database to assist learning logic; please start with the statement
       ~ wn instead.)

       This inference says "if ` ph ` is true then ` ph ` is true".  This
       inference requires no axioms for its proof, and is useful as a
       copy-paste mechanism during proof development in mmj2.  It is normally
       not referenced in the final version of a proof, since it is always
       redundant.  You can remove this using the metamath-exe (Metamath
       program) Proof Assistant using the "MM-PA> MINIMIZE__WITH *" command.
       This is the inference associated with ~ id , hence its name.
       (Contributed by Alan Sare, 31-Dec-2011.)
       (Proof modification is discouraged.)  (New usage is discouraged.) $)
    idi $p |- ph $=
      (  ) B $.
  $}

  ${
    a1ii.1 $e |- ph $.
    a1ii.2 $e |- ps $.
    $( (_Note_:  This inference rule and the previous one, ~ idi , will
       normally never appear in a completed proof.)

       This is a technical inference to assist proof development.  It provides
       a temporary way to add an independent subproof to a proof under
       development, for later assignment to a normal proof step.

       The Metamath (Metamath-exe) program Proof Assistant requires proofs to
       be developed backwards from the conclusion with no gaps, and it has no
       mechanism that lets the user work on isolated subproofs.  This inference
       provides a workaround for this limitation.  It can be inserted at any
       point in a proof to allow an independent subproof to be developed on the
       side, for later use as part of the final proof.

       _Instructions_:  (1) Assign this inference to any unknown step in the
       proof.  Typically, the last unknown step is the most convenient, since
       "MM-PA> ASSIGN LAST" can be used.  This step will be replicated in
       hypothesis a1ii.1, from where the development of the main proof can
       continue.  (2) Develop the independent subproof backwards from
       hypothesis a1ii.2.  If desired, use a "MM-PA> LET STEP" command to
       pre-assign the conclusion of the independent subproof to a1ii.2.  (3)
       After the independent subproof is complete, use "MM-PA> IMPROVE ALL" to
       assign it automatically to an unknown step in the main proof that
       matches it.  (4) After the entire proof is complete, use "MM-PA>
       MINIMIZE__WITH *" to clean up (discard) all ~ a1ii references
       automatically.

       This inference was originally designed to assist importing partially
       completed Proof Worksheets from the mmj2 Proof Assistant GUI, but it can
       also be useful on its own.  Interestingly, no axioms are required for
       its proof.  It is the inference associated with ~ a1i .  (Contributed by
       NM, 7-Feb-2006.)  (Proof modification is discouraged.)
       (New usage is discouraged.) $)
    a1ii $p |- ph $=
      (  ) C $.
  $}


$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
  Propositional calculus
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

  Propositional calculus deals with general truths about well-formed formulas
  (wffs) regardless of how they are constructed.  The simplest propositional
  truth is ` ( ph -> ph ) ` , which can be read "if something is true, then it
  is true" - rather trivial and obvious, but nonetheless it must be proved from
  the axioms (see theorem ~ id ).

  Our system of propositional calculus consists of three basic axioms and
  another axiom that defines the modus-ponens inference rule.  It is attributed
  to Jan Lukasiewicz (pronounced woo-kah-SHAY-vitch) and was popularized by
  Alonzo Church, who called it system P2.  (Thanks to Ted Ulrich for this
  information.)  These axioms are ~ ax-1 , ~ ax-2 , ~ ax-3 , and (for modus
  ponens) ~ ax-mp . Some closely followed texts include [Margaris] for the
  axioms and [WhiteheadRussell] for the theorems.

  The propositional calculus used here is the classical system widely used by
  mathematicians.  In particular, this logic system accepts the "law of the
  excluded middle" as proven in ~ exmid , which says that a logical statement
  is either true or not true.  This is an essential distinction of classical
  logic and is not a theorem of intuitionistic logic.

  All 194 axioms, definitions, and theorems for propositional calculus in
  _Principia Mathematica_ (specifically *1.2 through *5.75) are axioms or
  formally proven.  See the Bibliographic Cross-References at ~ mmbiblio.html
  for a complete cross-reference from sources used to its formalization in the
  Metamath Proof Explorer.

$)


$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Recursively define primitive wffs for propositional calculus
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( If ` ph ` is a wff, so is ` -. ph ` or "not ` ph ` ".  Part of the
     recursive definition of a wff (well-formed formula).  In classical logic
     (which is our logic), a wff is interpreted as either true or false.  So if
     ` ph ` is true, then ` -. ph ` is false; if ` ph ` is false, then
     ` -. ph ` is true.  Traditionally, Greek letters are used to represent
     wffs, and we follow this convention.  In propositional calculus, we define
     only wffs built up from other wffs, i.e. there is no starting or "atomic"
     wff.  Later, in predicate calculus, we will extend the basic wff
     definition by including atomic wffs ( ~ weq and ~ wel ). $)
  wn $a wff -. ph $.

  $( Register negation '-.' as a primitive expression (lacking a
     definition). $)
  $( $j primitive 'wn'; $)

  $( If ` ph ` and ` ps ` are wff's, so is ` ( ph -> ps ) ` or " ` ph ` implies
     ` ps ` ".  Part of the recursive definition of a wff.  The resulting wff
     is (interpreted as) false when ` ph ` is true and ` ps ` is false; it is
     true otherwise.  Think of the truth table for an OR gate with input ` ph `
     connected through an inverter.  After we state the axioms of propositional
     calculus ( ~ ax-1 , ~ ax-2 , ~ ax-3 , and ~ ax-mp ) and define the
     biconditional ( ~ df-bi ), the constant true ` T. ` ( ~ df-tru ), and the
     constant false ` F. ` ( ~ df-fal ), we will be able to prove these truth
     table values: ` ( ( T. -> T. ) <-> T. ) ` ( ~ truimtru ),
     ` ( ( T. -> F. ) <-> F. ) ` ( ~ truimfal ), ` ( ( F. -> T. ) <-> T. ) `
     ( ~ falimtru ), and ` ( ( F. -> F. ) <-> T. ) ` ( ~ falimfal ).  These
     have straightforward meanings, for example, ` ( ( T. -> T. ) <-> T. ) `
     just means "the value of ` ( T. -> T. ) ` is ` T. ` ".

     The left-hand wff is called the antecedent, and the right-hand wff is
     called the consequent.  In the case of ` ( ph -> ( ps -> ch ) ) ` , the
     middle ` ps ` may be informally called either an antecedent or part of the
     consequent depending on context.  Contrast with ` <-> ` ( ~ df-bi ),
     ` /\ ` ( ~ df-an ), and ` \/ ` ( ~ df-or ).

     This is called "material implication" and the arrow is usually read as
     "implies".  However, material implication is not identical to the meaning
     of "implies" in natural language.  For example, the word "implies" may
     suggest a causal relationship in natural language.  Material implication
     does not require any causal relationship.  Also, note that in material
     implication, if the consequent is true then the wff is always true (even
     if the antecedent is false).  Thus, if "implies" means material
     implication, it is true that "if the moon is made of green cheese that
     implies that 5=5" (because 5=5).  Similarly, if the antecedent is false,
     the wff is always true.  Thus, it is true that, "if the moon is made of
     green cheese that implies that 5=7" (because the moon is not actually made
     of green cheese).  A contradiction implies anything ( ~ pm2.21i ).  In
     short, material implication has a very specific technical definition, and
     misunderstandings of it are sometimes called "paradoxes of logical
     implication". $)
  wi $a wff ( ph -> ps ) $.

  $( Register implication '->' as a primitive expression (lacking a
     definition). $)
  $( $j primitive 'wi'; $)


$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  The axioms of propositional calculus
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  Propositional calculus (axioms ~ ax-1 through ~ ax-3 and rule ~ ax-mp ) can
  be thought of as asserting formulas that are universally "true" when their
  variables are replaced by any combination of "true" and "false".
  Propositional calculus was first formalized by Frege in 1879, using as his
  axioms (in addition to rule ~ ax-mp ) the wffs ~ ax-1 , ~ ax-2 , ~ pm2.04 ,
  ~ con3 , ~ notnot , and ~ notnotr .  Around 1930, Lukasiewicz simplified the
  system by eliminating the third (which follows from the first two, as you can
  see by looking at the proof of ~ pm2.04 ) and replacing the last three with
  our ~ ax-3 .  (Thanks to Ted Ulrich for this information.)

  The theorems of propositional calculus are also called _tautologies_.
  Tautologies can be proved very simply using truth tables, based on the
  true/false interpretation of propositional calculus.  To do this, we assign
  all possible combinations of true and false to the wff variables and verify
  that the result (using the rules described in ~ wi and ~ wn ) always
  evaluates to true.  This is called the _semantic_ approach.  Our approach is
  called the _syntactic_ approach, in which everything is derived from axioms.
  A metatheorem called the Completeness Theorem for Propositional Calculus
  shows that the two approaches are equivalent and even provides an algorithm
  for automatically generating syntactic proofs from a truth table.  Those
  proofs, however, tend to be long, since truth tables grow exponentially with
  the number of variables, and the much shorter proofs that we show here were
  found manually.

$)

  ${
    $( Minor premise for modus ponens. $)
    min $e |- ph $.
    $( Major premise for modus ponens. $)
    maj $e |- ( ph -> ps ) $.
    $( Rule of Modus Ponens.  The postulated inference rule of propositional
       calculus.  See e.g.  Rule 1 of [Hamilton] p. 73.  The rule says, "if
       ` ph ` is true, and ` ph ` implies ` ps ` , then ` ps ` must also be
       true".  This rule is sometimes called "detachment", since it detaches
       the minor premise from the major premise.  "Modus ponens" is short for
       "modus ponendo ponens", a Latin phrase that means "the mode that by
       affirming affirms" - remark in [Sanford] p. 39.  This rule is similar to
       the rule of modus tollens ~ mto .

       Note:  In some web page displays such as the Statement List, the
       symbols " ` & ` " and " ` => ` " informally indicate the relationship
       between the hypotheses and the assertion (conclusion), abbreviating the
       English words "and" and "implies".  They are not part of the formal
       language.  (Contributed by NM, 30-Sep-1992.) $)
    ax-mp $a |- ps $.
  $}

  $( Axiom _Simp_.  Axiom A1 of [Margaris] p. 49.  One of the 3 axioms of
     propositional calculus.  The 3 axioms are also given as Definition 2.1 of
     [Hamilton] p. 28.  This axiom is called _Simp_ or "the principle of
     simplification" in _Principia Mathematica_ (Theorem *2.02 of
     [WhiteheadRussell] p. 100) because "it enables us to pass from the joint
     assertion of ` ph ` and ` ps ` to the assertion of ` ph ` simply".  It is
     Proposition 1 of [Frege1879] p. 26, its first axiom.  (Contributed by NM,
     30-Sep-1992.) $)
  ax-1 $a |- ( ph -> ( ps -> ph ) ) $.

  $( Axiom _Frege_.  Axiom A2 of [Margaris] p. 49.  One of the 3 axioms of
     propositional calculus.  It "distributes" an antecedent over two
     consequents.  This axiom was part of Frege's original system and is known
     as _Frege_ in the literature; see Proposition 2 of [Frege1879] p. 26.  It
     is also proved as Theorem *2.77 of [WhiteheadRussell] p. 108.  The other
     direction of this axiom also turns out to be true, as demonstrated by
     ~ pm5.41 .  (Contributed by NM, 30-Sep-1992.) $)
  ax-2 $a |- ( ( ph -> ( ps -> ch ) ) -> ( ( ph -> ps ) -> ( ph -> ch ) ) ) $.

  $( Axiom _Transp_.  Axiom A3 of [Margaris] p. 49.  One of the 3 axioms of
     propositional calculus.  It swaps or "transposes" the order of the
     consequents when negation is removed.  An informal example is that the
     statement "if there are no clouds in the sky, it is not raining" implies
     the statement "if it is raining, there are clouds in the sky".  This axiom
     is called _Transp_ or "the principle of transposition" in _Principia
     Mathematica_ (Theorem *2.17 of [WhiteheadRussell] p. 103).  We will also
     use the term "contraposition" for this principle, although the reader is
     advised that in the field of philosophical logic, "contraposition" has a
     different technical meaning.  (Contributed by NM, 30-Sep-1992.)  Use its
     alias ~ con4 instead.  (New usage is discouraged.) $)
  ax-3 $a |- ( ( -. ph -> -. ps ) -> ( ps -> ph ) ) $.



