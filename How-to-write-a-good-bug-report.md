# How to write a good bug report

## Isolate bug

The first step in in writing a bug report is to identify exactly what the problem is. Saying "something is wrong" is not helpful; saying exactly what is wrong, and how to reproduce it, is. If you can tell exactly what is wrong, and reliably reproduce an example of the problem, you've isolated a bug.

On the command line, you may test the basic functionality of the PKCS#11 module by running `pkcs11-tool --test --login`. The Minidriver used on Windows can be tested with `certutil -scinfo`

## Check if you are using the latest version

Bug reports should be based on [the latest development build](https://github.com/OpenSC/Nightly). If you are using a released version or an out-of-date build, please update to the latest revision and check to see whether or not the bug still exists.

## Check if the bug is known

Please check whether the bug you are experiencing is already documented in the [issue tracker](https://github.com/OpenSC/OpenSC/issues). If it is already documented, you may click "subscribe" to follow any developments. If your bug is different than any others recorded in the issue tracker, "Create a new issue".

## File each issue separately

If you have multiple issues, it is better to file them separately so they can be tracked more easily.

## Create a new issue

[Sign into github.com](https://github.com/login) and go to the [issue tracker](https://github.com/OpenSC/OpenSC/issues). Click on *[Create a new issue](https://github.com/OpenSC/OpenSC/issues/new)*.

There are a number of initial questions that are used for filing a bug report - answers to these allow progress.

### Title

The title should describe the problem as best as possible. Remember that the title is read more often than any other part of the bug report.

*Poor title*: PIN verification not working
This title is not specific enough for someone to look at it a month from now, and remember what the bug report is referring to.

*Good title*: PIN verification results in CKR\_ARGUMENTS\_BAD
This title is an improvement over the previous title, because it specifies the type of error in PKCS#11.

After submitting the issue, it is possible to improve the title.

### Issue details

#### Component

The first question is which component your bug applies to. Is it one of the command line tools, is it the PKCS#11 module, is it the Minidriver used on Windows or the CryptoTokenKit driver on macOS? Which smart card was used (run `opensc-tool --name` on the command line)?

#### Steps to reproduce bug

A bug report requires clear instructions, so that others can consistently reproduce it. Many bugs require some experimentation to find the exact steps that cause the problem you are trying to report. If you aren't able to discover these, try obtaining some help on the mailing list instead.

A good set of instructions includes a numbered list that details each button press, or menu selection.

It can also be helpful to test your own instructions, as though someone else is trying them (as they will).

#### Expected behavior

Describe what should happen if the bug was fixed.

#### Actual behavior

In contrast to the expected behavior, describe what currently happens when the bug is present.

#### Version number

On the command line, run `opensc-tool --version` (results in something like "OpenSC-0.20.0-198-g93b46ca3, rev: 93b46ca3, commit-time: 2020-03-04 23:23:35 +0100").

#### Operating system

Name the operating system and version you are using, such as "Windows 8.1", or "macOS 10.15.1".

#### File attachments

If you can supplement your bug report with an image or debug log that helps others reproduce the issue, attach these files. You may paste a short (!) log into a pre-formatted block by both, prepending and appending, three backticks to your output:

````text
```
Example of Markdown syntax for debug output with triple back ticks
```
````

#### Submit

Check the "Preview" of your bug report if it shows the expected formatting. Click "Submit new issue" to submit your bug report to the issue tracker.

## Following up

Once a developer marks a bug as fixed, it is a good idea to ensure that it is completely fixed. To test, download [the latest nightly build](https://github.com/OpenSC/Nightly).

___

This description is based on the work of [musescore](https://musescore.org/de/handbook/developers-handbook/getting-started/how-write-good-bug-report-step-step-instructions).
