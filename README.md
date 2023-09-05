# uucls - LaTeX classes for the UU house style

This is a library of latex classes for creating documents according to the
[Utrecht University style guide](https://www.uu.nl/en/organisation/corporate-identity). 
Currently, the package contains: 

+ `lib/classes/uuletter2.cls` - a letter class that implements the [UU template](https://www.uu.nl/en/organisation/corporate-identity/downloads/letter)
+ `lib/classes/uureport.cls` - a wrapper around the standard report class that
typesets a [UU report](https://www.uu.nl/en/organisation/corporate-identity/downloads/word-document)
+ `lib/classes/beamerthemeuubeamer.sty` - a beamer template that implements the
[UU Powerpoint/Keynote templates](https://www.uu.nl/en/organisation/corporate-identity/downloads/powerpoint-keynote).
This depends on the files `lib/classes/beamerouterthemeuubeamer.sty`,
`lib/classes/beamerinnerthemeuubeamer.sty`,
`lib/classes/beamerfontthemeuubeamer.sty`, and
`lib/classes/beamercolorthemeuubeamer.sty` (see the documentation on `beamer`
themes).

I plan to implement at least one more class, `uuarticle.cls`, but there's no
timeline yet.

Under `lib/examples` you can find some templates/code examples that illustrate
the use of the classes. They should compile once you've
[installed](#installation) the classes. Currently, there is no further
documentation.

## Installation

I assume that if you're here, you already know how to use a custom latex class.
Please note the following things: 

+ The packages assume that the UU logos (found in `lib/resources`) are somewhere
where latex can find them (ideally somewhere in the [TeX Directory Structure (TDS)](https://en.wikipedia.org/wiki/TeX_Directory_Structure)). 
+ Dependencies are kept to a minimum but you need to have the following
packages installed:

  - `opensans` and `merrieweather` for the fonts - `babel` (with Dutch language
  support) for localization - `graphicx` for the logos and signatures
   
The easiest way to install the packages is to use `git clone` somewhere in your
TDS. You can also download the
[source](https://github.com/UtrechtUniversity/uucls/archive/refs/heads/main.zip)
and copy it manually where it needs to be. If you're on MacOS/Linux, you can use
the shell script included in the project to install the project by typing the
following into your command line (requires a working internet connection):

``` shell

/usr/bin/env bash <(curl -fsSL https://raw.githubusercontent.com/UtrechtUniversity/uucls/main/lib/scripts/uucls.sh) install 

```

Before you do this, please inspect the script under `lib/script/uucls.sh` (as a
matter of principle, don't just run scripts from the internet). It assumes that
you have `git` and either MacTeX or TeXlive installed. The script will `git
clone` the package into your TDS and install itself as a command line utility
for updating and uninstalling the script. After having installed the package,
you can use `uucls` in the command line to manage the package.

## Contributing

Initially, I created these classes for my personal use. I'm sharing them here in
the hope that this perhaps saves some of you the work creating your own files.
I'm very happy about PRs and/or comments, but you'll need to be OK with the
CC0/public domain dedication (see below).  Ideally, raise an issue or just get
in touch via my UU email.

## (Un)License

This software was originally written by Johannes Korbmacher
([j.korbmacher@uu.nl](mailto:j.korbmacher@uu.nl)) and contains contributions
from Ty Mees ([t.d.mees@uu.nl](mailto:t.d.mees@uu.nl)) and Kevin Quach.

To the extent possible under law, the authors have dedicated all copyright and
related and neighboring rights to this software to the public domain worldwide.
This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along with
this software (```LICENSE```). If not, see
[http://creativecommons.org/publicdomain/zero/1.0/].

Of course, this applies only to the software written by us, and, in particular,
not the branding (see below).

## Disclaimer

The UU branding is protected by copyright, with Utrecht University having the
right of use. This is why the corporate style and the content of this repository
cannot be used and/or applied by third parties without permission granted in
advance.
