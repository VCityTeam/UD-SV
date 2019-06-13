### Refrain from cloning the master: fork it instead
If you intend to contribute to any of the (Github) git repositories of the MUTS project (e.g. MEPP V2) it is **strongly advised to refrain from cloning the master**. [Master is for integration, not development](http://www.kdgregory.com/index.php?page=scm.git). Instead, the recommended workflow goes like:
 1. start with a [`fork` of the concerned repository](https://help.github.com/articles/fork-a-repo/)
 1. work on your fork (by first cloning it and then pushing to it)
 1. [create a Pull Request](https://help.github.com/articles/creating-a-pull-request/) (PR)
 1. improve your branch until the associated [Travis CI](https://travis-ci.org/) tests (Linux gcc and clang) is OK (within the Pull Request tab,  assert that the colored dot on the right of your PR is green)
 1. ask the ["well known"](https://github.com/MEPP-team/MEPP2/wiki/Contributors) Windows (currently Vincent Vidal and Martial Tola) and Mac OSX (currently Martial Tola) testing persons to manually test your branch,
 1. kindly request a [benevolent](https://en.wikipedia.org/wiki/Benevolent_dictator_for_life) ["integration czar"](http://www.kdgregory.com/index.php?page=scm.git) to realize the merge with the master or request for changes

Note that the Windows test if often much more changeling than the OSX test but [your mileage may vary](https://en.wiktionary.org/wiki/your_mileage_may_vary).
Also note that volunteers for becoming a Windoze/OSX testing person are welcomed.

If you inadvertently forgot to fork and started with cloning the master (e.g. [MEPP V2](https://github.com/MEPP-team/MEPP2), you should:
 * isolate your wishful changes 
 * still realize the above described forking procedure
 * back port the changes you operated on your original master clone to your newly created fork

When not respecting the above workflow, the [[benevolent|https://en.wikipedia.org/wiki/Benevolent_dictator_for_life]] [["integration czar"|http://www.kdgregory.com/index.php?page=scm.git]] will escalate the enforcement process: frowning upon, chastising, punishment, severe punishment, [cyanide](http://www.ctrl-c.liu.se/~ingvar/asr/lusers.html), banning (only for survivors of previous stage :-)

### Limit the [CI](https://en.wikipedia.org/wiki/Continuous_integration) rebuilds to _really_ useful repository updates
Because the git repository is hooked up with a [CI (Continuous Integration)](https://en.wikipedia.org/wiki/Continuous_integration) tool ([Travis](https://travis-ci.org/)) each commit triggers a rebuild. In order to avoid useless rebuilds (which will delay the useful ones), it is key to **inhibit Travis rebuilds when committing non functionnal changes** (e.g. doxygen or [mardown](https://en.wikipedia.org/wiki/Markdown) based documentation). This is even more important when commiting often...
In order [to do so, simply embed a](https://docs.travis-ci.com/user/customizing-the-build/#Skipping-a-build) `[ci skip]` string anywhere in you commit message.

### Submitting a Pull Request (PR)
When creating a PR, start the discussion with the following template:
```
 - [ ] Unit-test of your feature (ctest)
 - [ ] Doxygen documentation of the code completed (classes, methods, types, members...)
 - [ ] No build warnings raised (Travis, Appveyor)
 - [ ] All continuous integration tests pass (Travis, Appveyor)
 - [ ] Doxygen builds without new warnings
 - [ ] Coding Style(https://github.com/MEPP-team/VCity/wiki/Coding-Style) respected
 - [ ] Changes.md updated
```
Checkbox might have an `N/A` content (in addition to being empty or have an x).

Optionnal entries that you can add (nice to have):
 - [ ] User guide provided (Doxygen module page added or updated)
 - [ ] Design notes provided (as Doxygen module page?)
 - [ ] New entry in the ChangeLog.md added.

Note: links to [Coding Style](https://github.com/MEPP-team/VCity/wiki/Coding-Style), [Changes.md](https://github.com/MEPP-team/VCity/blob/master/Changes.md)...

### Pull Request (PR) acceptance policy
A given Pull Request (PR) is handled over to a PR validator that will evaluate the submission which the following criteria:
 * all the items (**refer above**) of the PR submission template must be checked
 * the number of warnings (prior to the PR and after the PR) shall never increase (refer to list of [known and unavoidable](https://github.com/MEPP-team/VCity/wiki/CodingKnownWarnings))

The PR submitter/validator exchanges will be written on github's PR submission interface. It is nevertheless always encouraged, whenever if possible, to first exchange through informal conversations/discussions prior to leaving some written traces of the work to be done (in the form of short concrete items).

In order to avoid any [possible conflict of interest](https://en.wikipedia.org/wiki/Conflict_of_interest), and for a given PR, the submitter and the validator shall not be the same person.

### Versioning process
Version number incrementation and the associated tagging process (described below) happens in the following conditions
 - every **couple of weeks** (the classic duration of a [sprint](https://en.wikipedia.org/wiki/Scrum_(software_development)#Workflow) the version **sub-minor is incremented**,
 - every **couple of months** (e.g. each semester) the version **minor is incremented**.

Notes: 
 - for the time being the major will be kept to be zero (the code is not yet _perfectly_ mature).
 - the version number can be obtained on the command line 
   - after software installation: launch `3DUSE-config` binary 
   - when in the building tree: `ctest -R TEST_PRINT_CONFIG -V`


Evaluation of the pertinence for making a new version/release is evaluated during the weekly meeting and this task is attributed to the **versioning-person** in charge of following the **versioning process**
 * [As recommended](https://github.com/MEPP-team/VCity/wiki/Coding-Github_Cycle#refrain-from-cloning-the-master-fork-it-instead), place yourself in your forked working repository.
 * Upgrade the version numbers (for the sake of simplicity/clarity of the versioning process you should limit yourself to the two following changes) within:
     - the [main CMakeLists.txt](https://github.com/MEPP-team/VCity/blob/master/CMakeLists.txt#L77) by changing the values of the `PRJ_VERSION_MAJOR`, `PRJ_VERSION_MINOR` and `PRJ_VERSION_PATCH`variables, 
     - [dialogAbout.ui](https://github.com/MEPP-team/VCity/blob/master/ui/dialogAbout.ui#L20) (part of the QT interface, look for string `3D-Use version`).
 * `Commit` and `push` those changes to your origin repository (i.e. your forked repository on github as opposed to your local repository on your desktop computer). Take note of the SHA1 for this push (e.g. d5304fb5c8e for version 0.4.0). In the following we will call VERSION_SHA1 this SHA1. 
 * Submit an associated PR (e.g. the [PR for version 0.4.0](https://github.com/MEPP-team/VCity/pull/184)). Have this [PR accepted and merged](https://github.com/MEPP-team/VCity/wiki/Coding-Github_Cycle#pull-request-pr-acceptance-policy). Once your PR was accepted you should be able to view your VERSION_SHA1 within the lists of commits of the master. For example for version 0.4.0 [here is the VERSION_SHA1 (d5304fb5c8e)](https://github.com/MEPP-team/VCity/commit/d5304fb5c8e847486a798085fc755563d69bd110) that you should distinguish from the [SHA1 of the merge of your commit](https://github.com/MEPP-team/VCity/commit/debce55798ac3c998f681e44b800a0b7d403426c).  
 * From your local repository (the one on your desktop), proceed with the [tagging process at the git level](https://git-scm.com/book/en/v2/Git-Basics-Tagging) 
     - `git remote -v` command describes the situation in which you should now be, which should be similar to
     ```
       origin        https://github.com/<yourGithubLogin>/VCity.git (fetch)
       origin        https://github.com/<yourGithubLogin>/VCity.git (push)
       upstream https://github.com/MEPP-team/VCity.git (fetch)
       upstream	https://github.com/MEPP-team/VCity.git (push)
     ```  
    -  `git log` command will enable you to make sure that your VERSION_SHA1 is indeed present in the log list (it should be the top entry if you didn't do push other commits in between)
   - `git tag -a <version_number> VERSION_SHA1` command tags the version on your local repository (in our example case this gives `git tag -a v0.4.0 d5304fb5c8e`): provide some message when asked (for example use the version number as message).
   -  `git push origin --tags` command pushes the new tag to your forked repository. Note that tags don't get "pushed" with other commits and you do need to push tags separately. You should now see this new tag:
      * with the `git ls-remote --tags` on the command line or
      * on the release entry on your forked repository on github (`releases` appears on the right side of the `commit` button). For example [here it is for version 0.4.0](https://github.com/EricBoix/VCity/releases).
   - `git push upstream --tags`eventually pushes the tag on the master repository which you should be able to assert:
       * `git ls-remote --tags https://github.com/MEPP-team/VCity.git` on the command line
       * on the releases page of the original project on github (e.g. [for version 0.4.0](https://github.com/MEPP-team/VCity/releases))
 * Don't forget to celebrate and to keep the hotline open ;-)    
