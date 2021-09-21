% uureport.cls
%
% Copyright 2021, J. Korbmacher (j.korbmacher@uu.nl)
%
% DISCLAIMER
%
% The UU-house style is protected by copyright, with Utrecht University having
% the right of use. This is why the house style cannot be used and/or applied by
% third parties without permission granted in advance.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uureport}[2021/09/08 v1.0]

% Some conditionals for later options

\newif\if@dutch
\newif\if@opensans
\newif\if@merriweather

% Initialize labels for language options

\newcommand{\@versionlabel}{}
\newcommand{\@contentslabel}{}
\newcommand{\@uuname}{}
\newcommand{\@logopath}{}

% Set labels according to language

\DeclareOption{english}{%
  \@dutchfalse
  \renewcommand{\@logopath}{UU_logo_2021_EN_RGB.png}
  \renewcommand{\@versionlabel}{Version}
  \renewcommand{\@contentslabel}{Table of Contents}
  \renewcommand{\@uuname}{Utrecht University}}
\DeclareOption{dutch}{%
  \@dutchtrue
  \renewcommand{\@logopath}{UU_logo_2021_NL_RGB.png}
  \renewcommand{\@versionlabel}{Versie}
  \renewcommand{\@contentslabel}{Inhoudsopgave}
  \renewcommand{\@uuname}{Universiteit Utrecht}}

%% We pass most options through to `report`.
%% We don't support non-European formats.

\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{report}}

% TODO Implement the following formats

%\DeclareOption{a5paper}      {\PassOptionsToClass{\CurrentOption}{report}}
%\DeclareOption{landscape}    {\PassOptionsToClass{\CurrentOption}{report}}

\DeclareOption{10pt}        {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{11pt}        {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{12pt}        {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{oneside}     {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{twoside}     {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{draft}       {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{final}       {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{titlepage}   {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{notitlepage} {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{openright}   {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{openany}     {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{onecolumn}   {\PassOptionsToClass{\CurrentOption}{report}}

% Is this needed?

% \DeclareOption{twocolumn}{\PassOptionsToClass{\CurrentOption}{report}}

\DeclareOption{leqno}       {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{fleqn}       {\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{openbib}     {\PassOptionsToClass{\CurrentOption}{report}}

% Two new options for fonts used by UU

\DeclareOption{merriweather}  {\@merriweathertrue}
\DeclareOption{opensans}      {\@opensanstrue}

% Standard warning

\DeclareOption*{\ClassWarning{uureport}{%
    The option \CurrentOption~is not supported by uureport.}}

% Default options

\ExecuteOptions{english,opensans,a4paper}

\ProcessOptions\relax

% Some useful functions

\def\dividelength#1#2{\divide #1 #2\relax}
\def\multiplylength#1#2{\multiply #1 #2\relax}

% Class definitions

% We wrap around report

\LoadClass{report}

% We need this to include the logo

\RequirePackage{graphicx}

% Routine to set typeface

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\if@merriweather
  \RequirePackage{merriweather}
\else
  \if@opensans
    \RequirePackage[default]{opensans}
  \else
    \relax
  \fi
\fi

% Language selection routine

\if@dutch
  \RequirePackage[dutch]{babel}
\else
  \RequirePackage[english]{babel}
\fi

%%%%% Redo Layout. Ignore compatability and two-columdn.

\newlength    {\@leading}

% Alias for \baselineskip

\setlength    {\@leading}       {\baselineskip}
\newlength    {\@logowidth}
\setlength    {\@logowidth}     {11.413cm}
\newlength    {\@logoheight}
\setlength    {\@logoheight}    {4.504cm}

% Header

\setlength    {\voffset}        {-1in}
\addtolength  {\voffset}        {1cm}
\setlength    {\topmargin}      {\z@}
\setlength    {\headheight}     {\@logoheight}
\addtolength  {\headheight}     {-.5in}
\setlength    {\headsep}        {1em}

%%% Margins and textwidth

\setlength    {\hoffset}        {-0.5in}
\setlength    {\oddsidemargin}  {0.5in}
\setlength    {\evensidemargin} {0.5in}
\setlength    {\marginparwidth} {1in}
\addtolength  {\marginparwidth} {-2em}
\setlength    {\marginparsep}   {1em}
\setlength    {\marginparpush}  {0.5em}
\setlength    {\textwidth}      {\paperwidth}
\addtolength  {\textwidth}      {-2in}

%%% Text height/footer. I want the printed text height to be a
%%% multiple of baselineskip. Here's my solution.

\setlength    {\textheight}     {\paperheight}
\addtolength  {\textheight}     {-1in}
\addtolength  {\textheight}     {-\voffset}
\addtolength  {\textheight}     {-\topmargin}
\addtolength  {\textheight}     {-\headheight}
\addtolength  {\textheight}     {-\headsep}
\addtolength  {\textheight}     {-.75in}%Footer height

% We temporarily save the result for error correction

\setlength   {\@tempdima} {\textheight}

% The following sets the text height as an even multiple of the
% leading

\dividelength   {\textheight} {\baselineskip}
\multiplylength {\textheight} {\baselineskip}

% We now correct for the error

\addtolength {\@tempdima} {-\textheight}
\setlength   {\footskip}  {.5in}
\addtolength {\footskip}  {\@tempdima}
%%% Spacing
\setlength{\lineskip}{1\p@}
\setlength{\normallineskip}{1\p@}

%%% This is a manual parskip package. Maybe it's better to use the
%%% real thing?.
\setlength{\parskip}{\@leading}
\setlength{\parindent}{\z@}
\renewcommand{\baselinestretch}{}

%%% Counters

\pagenumbering{arabic}

%%%%% Custom Pagestyles

\def\ps@uureport@title{%
  \let\@oddfoot\@empty
  \let\@mkboth\@gobbletwo
  \def\@oddhead{\hspace*{-1in}\@print@logo\@print@title}
}
\def\ps@uureport@running{%
  \def\@oddfoot{%
    \rule{0.5\linewidth}{0pt}\parbox[b]{0.5\linewidth}{%
      \thepage\hfill\@date\quad\@print@version}}
  \def\@oddhead{%
    \raisebox{0.5\headheight}{\parbox{\linewidth}{%
        \small\@title\hfill \@uuname, \@subsender}}}
  \if@twoside
    \def\@evenfoot{%
      \parbox[b]{0.5\linewidth}{%
        \@date\quad\@print@version}\hfill\thepage\rule{0.5\linewidth}{0pt}}
    \def\@evenhead{%
      \raisebox{0.5\headheight}{\parbox{\linewidth}{%
          \small \@uuname, \@subsender\hfill\@title}}}
  \else
    \let\@evenfoot\@oddfoot
    \let\@evenhead\@oddhead
  \fi}
\pagestyle{uureport@running}
%%%%% Titeling
%% Redefine \title from Source2e
\DeclareRobustCommand{\title}[2][]{%
  \gdef\@title{#2}
  \gdef\@subtitle{#1}}
\if@titlepage
\renewcommand\maketitle{%
  \newpage
  \thispagestyle{uureport@title}%
  \setcounter{page}\@ne
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \@tempdima\textwidth%
  \addtolength{\@tempdima}{-4cm}%
  \rule{4cm}{\z@}%
  \begin{minipage}{\@tempdima}
  \raggedright  
  {\LARGE \@title \par}%
  {\Large \@subtitle\par}%
  \vspace{2pt}
  {\large
    \lineskip .75em%
    \begin{tabular}[t]{@{} l}%
      \@author
    \end{tabular}\par}%
  \end{minipage}  
  \@thanks
  \vfil\null
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax}
\else
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \thispagestyle{uureport@title}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \@tempdima\textwidth%
  \let \footnote \thanks
  \addtolength{\@tempdima}{-4cm}%
  \rule{4cm}{\z@}%
  \begin{minipage}{\@tempdima}
  \raggedright  
  {\LARGE \@title \par}%
  {\Large \@subtitle\par}%
  \vspace{2pt}
  {\large
    \lineskip .75em%
    \begin{tabular}[t]{@{} l }%
      \@author
    \end{tabular}\par}%
  \end{minipage}
  \par
  \vskip 1.5em}
\fi
%%%%% Sectioning commands
\setcounter{secnumdepth}{3}
\renewcommand\thesection     {\thechapter.\@arabic\c@section.}
\renewcommand\thesubsection   {\thesection\@arabic\c@subsection.}
\renewcommand\thesubsubsection{\thesubsection\@arabic\c@subsubsection.}
\renewcommand\theparagraph    {\thesubsubsection\@arabic\c@paragraph.}
\renewcommand\thesubparagraph {\theparagraph\@arabic\c@subparagraph.}
\renewcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \null\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{\thepart \hspace{1em} #1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  \@tempdima\textwidth%
  \addtolength{\@tempdima}{-6cm}%
  \rule{6cm}{\z@}%
  \begin{minipage}{\@tempdima}
    \raggedright  
    \interlinepenalty \@M
    \normalfont
    \ifnum \c@secnumdepth >-2\relax
    \huge \partname\nobreakspace\thepart
    \par
    \fi
    \Huge #2\par
  \end{minipage}%
  \@endpart}
\def\@spart#1{%
\@tempdima\textwidth%
    \addtolength{\@tempdima}{-6cm}%
    \rule{6cm}{\z@}%
    \begin{minipage}{\@tempdima}
      \raggedright  
      \interlinepenalty \@M
      \normalfont
      \ifnum \c@secnumdepth >-2\relax
      \huge \partname\nobreakspace\thepart
      \par
      \fi
      \Huge #1\par
      \end{minipage}%
      \@endpart
    }
\def\@endpart{      
    \vfil\newpage
    \if@twoside
    \if@openright
    \null
    \newpage
    \fi
    \fi
  }
\renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \global\@topnum\z@
    \@afterindentfalse
    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
  \refstepcounter{chapter}%
  \typeout{\@chapapp\space\thechapter.}%
  \addcontentsline{toc}{part}{\@chapapp\space \thechapter}
  \addcontentsline{toc}{chapter}%
  {#1}%
  \else
  \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}%
  \@afterheading}
\def\@makechapterhead#1{%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \bfseries \@chapapp\space \thechapter
      \par\nobreak
    \fi
    \interlinepenalty\@M
    \LARGE \bfseries #1\par\nobreak
    \vskip \@leading
  }}
\def\@schapter#1{%
  \@makeschapterhead{#1}%
  \@afterheading}
\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \LARGE \bfseries  #1\par\nobreak
    \vskip \@leading
  }}
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-2em  \@plus -0.5em \@minus -0.5em}%
  {1pt}%
  {\normalfont\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-1em  \@plus -0.5em \@minus -0.5em}%
  {1pt}%
  {\normalfont\itshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-1em  \@plus -0.5em \@minus -0.5em}%
  {1pt}%
  {\normalfont\itshape}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\normalfont\normalsize}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
  {3.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\normalsize}}
%%%%% TOC
\renewcommand{\@dotsep}{1000} %No points on the "dotted" line
\setcounter{tocdepth}{3}
\renewcommand\tableofcontents{%
  \if@titlepage
    \if@openright
      \cleardoublepage
    \else
      \clearpage
    \fi
  \else
    \relax  
  \fi
  {\Large \@contentslabel}
  
  \parskip\z@

  \@starttoc{toc}%
}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
    \vskip 0.5\@leading
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \large
      \advance\leftskip\@tempdima
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
    \fi}
\renewcommand*\l@section{\@dottedtocline{1}{2.5em}{4em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{3.5em}{5.5em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{4.5em}{7em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{5.5em}{8.5em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{6.5em}{10em}}
%%% Custom routines at begin and end
\AtBeginDocument{%
  \def\today{\number\day-\number\month-\number\year}
  \frenchspacing}
\AtEndDocument{%
  \immediate\label{@lastpage}}

%%%%% Internal commands to print layout

% \newcommand{\@print@logo}{%
%   \begin{minipage}[b][\@logoheight][t]{\@logowidth}
%   \if@dutch
%     \IfFileExists{UU_logo_2021_NL_RGB}{\includegraphics{UU_logo_2021_NL_RGB}}{%
%       \fbox{Warning! Logo not found.}
%       \ClassWarning{uudoc}{Couldn't locate the Dutch logo file. Put
%         it somewhere where LaTeX can find it.}}
%   \else
%     \IfFileExists{UU_logo_2021_EN_RGB}{\includegraphics{UU_logo_2021_EN_RGB}}{%
%       \fbox{Warning! Logo not found.}
%       \ClassWarning{uudoc}{Couldn't locate the English logo file. Put
%       it somewhere where LaTeX can find it.}}
%   \fi
% \end{minipage}}

\newcommand{\@print@logo}{%
    \IfFileExists{\@logopath}{\includegraphics{\@logopath}}{%
      \fbox{Warning! Logo not found.}
      \ClassWarning{uuletter2}{Couldn't locate the logo file. Put
        it somewhere where LaTeX can find it.}}}

\newcommand{\@print@title}{%
  \@tempdima\linewidth%
  \addtolength{\@tempdima}{1in}%
  \addtolength{\@tempdima}{-\@logowidth}%
  \@tempdimb\headheight%
  \advance\@tempdimb by -5\normalbaselineskip%
  \begin{minipage}[b][\@logoheight][t]{\@tempdima}
    \vspace{\@tempdimb}
    \begin{flushright}
    \raggedleft
    \@print@sender
    \@print@titlepageinfo
    \end{flushright}
  \end{minipage}}

\newcommand{\@print@sender}{%
  \if &\@sender&
    \relax
  \else
    \@sender\\
  \fi}

\newcommand{\@print@titlepageinfo}{%
  \if &\@titlepageinfo&
    \relax
  \else
  \@titlepageinfo
  \fi}

\newcommand{\@print@version}{%
  \if &\@version&
  \relax
  \else
  \@versionlabel~\@version
  \fi}

%%%% Additional commands for UU reports

\newcommand{\imgcaption}[1]{%
  \scriptsize\itshape #1}

% \newcommand{\uupicture}[2][]{
%   \begin{figure}[h]
%     \includegraphics{#2}\newline
%     {\scriptsize\itshape #1}
%   \end{figure}
%   }

\newcommand{\sender}[2][]{%
  \def\@sender{#2}
  \def\@subsender{#1}}

\newcommand{\titlepageinfo}[1]{%
  \def\@titlepageinfo{#1}}

\newcommand{\version}[1]{%
  \def\@version{#1}}

% Initialize the new commands

\sender[]{}
\titlepageinfo{}
\version{}
\title[]{}
