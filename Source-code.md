# Source code

## Version control with Git

OpenSC source code is managed with [Git](http://book.git-scm.com/). The history of OpenSC source code versioning is from None -> CVS -> SVN -> Git. As the transitions have been done with automatic tools (`cvs2svn`, `git-svn`) some "corners" might be incorrect but the overall linear history of source code should be recognized and "git blame" should work as expected.

Master repository is hosted on [Github](http://github.com): [https://github.com/OpenSC/OpenSC/](https://github.com/OpenSC/OpenSC/)

### Getting the source code

```bash
git clone git://github.com/OpenSC/OpenSC.git
cd OpenSC
```

Individual developers also have their own Github trees, [Nightly Builds](OpenSC-Services#nightly-builds) lists ones that you can get binaries from and [Get Involved](Getting-involved-in-OpenSC-development) lists all known active developers.

## Source code style and recommendations

Head to [Development Policy](Development-Policy) for now.

## Providing patches

First, please read [Development Policy](Development-Policy) for tips on how to prepare your patch and the commit message. Be prepared to re-work your patch based on feedback. All patches go through review and you can also help doing code reviews.

* Please open pull requests against `master` branch
* Do NOT send pulls requests containing merge commits (at the moment at least, needs discussion)
