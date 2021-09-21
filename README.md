# uucls --- LaTeX classes for the UU house style

This is a library of latex classes for creating documents according to the [Utrecht University style guide](https://www.uu.nl/en/organisation/corporate-identity). 
Currently, the package contains: 

+ `lib/classes/uuletter2.cls` - a letter class that implements the [UU template](https://www.uu.nl/en/organisation/corporate-identity/downloads/letter)
+ `lib/classes/uureport.cls` - a wrapper around the standard report class that typesets a [UU report](https://www.uu.nl/en/organisation/corporate-identity/downloads/word-document)

I plan to implement at least one more class, `uuarticle.cls`, but there's no timeline yet.

Under `lib/examples` you can find some templates/code examples that illustrate the use of the classes.
They should compile once you've [installed](#installation) the classes.
Currently, there is no further documentation.

## Installation

I assume that if you're here, you already know how to use a custom latex class.
Please note the following things: 

+ The packages assume that the UU logos (found in `lib/resources`) are somewhere where latex can find them (ideally somewhere in the [TeX Directory Structure (TDS)](https://en.wikipedia.org/wiki/TeX_Directory_Structure)).
+ Dependencies are kept to a minimum but you need to have the following packages installed:

  - `opensans` and `merrieweather` for the fonts
  - `babel` (with Dutch language support) for localization
  - `graphicx` for the logos and signatures
   
The easiest way to install the packages is to use `git clone` somewhere in your TDS.
If you're on MacOS/Linux, you can use the shell script included in the project to install the project by typing the following into your command line:

``` shell

/bin/bash -c "$(curl -fsSL $URL) install" 

```

Before you do this, please inspect the script under `lib/script/uucls.sh` (as a matter of principle, don't just run scripts from the internet).
It assumes that you have `git` and either MacTeX or TeXlive installed.
The script will `git clone` the package into your TDS and install itself as a command line utility for updating and uninstalling the script.

## Contributing

Initially, I created these classes for my personal use.
I'm sharing them here in the hope that this perhaps saves some of you the work creating your own files.
I'm very happy about PRs and/or comments.
Ideally, raise an issue or just get in touch via my UU email.

## Disclaimer

The UU branding is protected by copyright, with Utrecht University having the right of use. 
This is why the corporate style and the content of this repository cannot be used and/or applied by third parties without permission granted in advance.
