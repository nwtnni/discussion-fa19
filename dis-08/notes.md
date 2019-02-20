# TL;DR for this discussion section

* Specs should be both concise and complete. This can be hard!
  - I personally don't want to read a paragraph for each function
* Sometimes it's nice to have consistent error handling within a module
* When handling malformed input, one can use Options, Exceptions, or say it's Undefined behavior. These all have tradeoffs.
  - Options and Exceptions are explicit, but may be unnecessary if the user is just prototyping a small snippet or is SUPER SURe that their code won't have bad input.
  - Options are nicer to handle than Exceptions, but they only really work when a function can return None. For example, adding an element to a bounded queue that's full wouldn't really make sense with options.
  - Exceptions are dangerous because they can't be caught by the type checker, but in edge cases like adding an element to a full bounded queue it makes sense. Because they can't be caught by the type checker, ALWAYS specify your exceptions.
* For computational code, time complexity and space complexity (performance) are super important to note.
* Minor algorithm details (such as sorting stability) may also be important.
* A big part of CS and engineering is COMMUNICATION
* Designing signatures is hard! Do it with your whole team.
  - This gives everyone a common understanding of the system architecture
  - This also gives everyone a common spec to implement
  - Designing signatures for modules is hard, so having multiple perspectives greatly enhances the quality of the signature. Your groupmates/coworkers will often catch things you may miss.
* Writing docs, signatures, and test cases is a great way to communicate with coworkers.
  - Common signatures and documentation means everyone knows how every module interacts, and people have to worry less about each module's implementation.
  - Writing test cases is another form of communication! It is effectively the "Examples" clause in documentation but more thorough.
  - If your groupmates can read your test cases, they will know the precise intended behavior, and if edge cases are tested, they will also know the intended behavior for weird situations.
  - It's super productive to bite the bullet and write test suites together BEFORE WRITING CODE. (It is hard, and I often push it off on small projects, but big projects testing is really a first-class concern)
