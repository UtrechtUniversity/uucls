% uuletter2.cls
%
% A simple letter class for UU letters.
%
% Copyright 2023, J. Korbmacher (j.korbmacher@uu.nl)
%
% DISCLAIMER
%
% The UU-house style is protected by copyright, with Utrecht University having
% the right of use. This is why the house style cannot be used and/or applied by
% third parties without permission granted in advance.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uuletter2}[2023/06/09 v1.1]
\newif\if@dutch
\newif\if@opensans
\newif\if@merriweather
\newif\if@ragged
\@raggedfalse
\newif\if@signature
\@signaturefalse
\newcommand{\@ptsize}{}
\newcommand{\@referencelabel}{}
\newcommand{\@yourreferencelabel}{}
\newcommand{\@telephonelabel}{}
\newcommand{\@faxlabel}{}
\newcommand{\@emaillabel}{}
\newcommand{\@websitelabel}{}
\newcommand{\@datelabel}{}
\newcommand{\@subjectlabel}{}
\newcommand{\@enclosurelabel}{}
\newcommand{\@rightfooterlabel}[2]{}
\newcommand{\@visitingaddresslabel}{}
\newcommand{\@sigpath}{}
\newcommand{\@logopath}{}
\DeclareOption{english}{%
  \@dutchfalse
  \renewcommand{\@logopath}{UU_logo_2021_EN_RGB.png}
  \renewcommand{\@referencelabel}{Our reference}
  \renewcommand{\@yourreferencelabel}{Your reference}
  \renewcommand{\@telephonelabel}{Telephone}
  \renewcommand{\@faxlabel}{Fax}
  \renewcommand{\@emaillabel}{E-mail}
  \renewcommand{\@websitelabel}{Website}
  \renewcommand{\@datelabel}{Date}
  \renewcommand{\@subjectlabel}{Subject}
  \renewcommand{\@enclosurelabel}{Enclosure}
  \renewcommand{\@rightfooterlabel}[2]{Page {#1} of {#2}}
  \renewcommand{\@visitingaddresslabel}{Visiting address}}
\DeclareOption{dutch}{%
  \@dutchtrue
  \renewcommand{\@logopath}{UU_logo_2021_NL_RGB.png}
  \renewcommand{\@referencelabel}{Ons kenmerk}
  \renewcommand{\@yourreferencelabel}{Uw kenmerk}
  \renewcommand{\@telephonelabel}{Telefoon}
  \renewcommand{\@faxlabel}{Fax}
  \renewcommand{\@emaillabel}{E-mail}
  \renewcommand{\@websitelabel}{Website}
  \renewcommand{\@datelabel}{Datum}
  \renewcommand{\@subjectlabel}{Onderwerp}
  \renewcommand{\@enclosurelabel}{Bijlage}
  \renewcommand{\@rightfooterlabel}[2]{Pagina {#1} van {#2}}
  \renewcommand{\@visitingaddresslabel}{Bezoekadress}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{opensans}{\@opensanstrue}
\DeclareOption{merriweather}{\@merriweathertrue}
\DeclareOption{ragged}{\@raggedtrue}
\DeclareOption*{\ClassWarning{uuletter2}{Option `\CurrentOption'
    unknown.}}
\ExecuteOptions{english,opensans,10pt}
\ProcessOptions\relax
\RequirePackage[T1]{fontenc}
\input{size1\@ptsize.clo}
\newcommand{\@smaller}{\footnotesize}
\if@ragged
  \raggedright
  \setlength{\rightskip}{0pt minus 4em}
\fi
% We need this to get pagerefs right
\RequirePackage[colorlinks=false]{hyperref}
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
% Paper layout
% We assume a4
\setlength{\paperwidth}         {210mm}
\setlength{\paperheight}        {297mm}
\setlength{\voffset}            {-1in}
\setlength{\textwidth}          {170mm}
\setlength{\textheight}         {221mm}
\setlength{\oddsidemargin}      {0\p@}
\setlength{\footskip}           {1cm}
\setcounter{secnumdepth}        {0}
\pagenumbering{arabic}
\setlength{\lineskip}           {1\p@}
\setlength{\normallineskip}     {1\p@}
\renewcommand{\baselinestretch} {}
\setlength{\parskip}            {\baselineskip}
\setlength{\parindent}          {0\p@}
\@lowpenalty 51
\@medpenalty 151
\@highpenalty 301
\setlength{\headheight}         {46mm}
\setlength{\headsep}            {0\p@}
\setlength{\marginparsep}       {0\p@}
\setlength\marginparpush        {0\p@}
\setlength{\topmargin}          {0\p@}
\newcommand*{\startbreaks}{%
  \let\\\@normalcr
  \interlinepenalty 200%
  \def\par{\@@par\penalty 200\relax}}
\DeclareRobustCommand\@nobreakvspace
{\@ifstar\@nobreakvspacex\@nobreakvspacex}
\def\@nobreakvspacex#1{%
  \ifvmode
  \nobreak\vskip #1\relax
  \else
    \@bsphack\vadjust{\nobreak\vskip #1}\@esphack
    \fi}
\def\@nobreakcr{\@ifstar{\@normalcr*}{\@normalcr*}}
\newcommand*{\stopbreaks}{%
  \interlinepenalty\@M
  \def\par{\@@par\nobreak}%
  \let\\\@nobreakcr
  \let\vspace\@nobreakvspace}
\setlength{\leftmargini}        {2.5em}
\setlength{\leftmarginii}       {2.2em}
\setlength{\leftmarginiii}      {1.87em}
\setlength{\leftmarginiv}       {1.7em}
\setlength{\leftmarginv}        {1em}
\setlength{\leftmarginvi}       {1em}
\setlength{\leftmargin}         {\leftmargini}
\setlength{\labelsep}           {5\p@}
\setlength{\labelwidth}         {\leftmargini}
\addtolength{\labelwidth}       {-\labelsep}
\setlength{\partopsep}          {0\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty -\@lowpenalty
\def\@listI{\setlength{\leftmargin} {\leftmargini}%
            \setlength{\parsep}     {0\p@}%
            \setlength{\topsep}     {.4em}%
            \setlength{\itemsep}    {.4em}}
\let\@listi\@listI
\@listi
\def\@listii {\setlength  \leftmargin{\leftmarginii}%
              \setlength  \labelwidth{\leftmarginii}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listiii{\setlength \leftmargin{\leftmarginiii}%
              \setlength \labelwidth{\leftmarginiii}%
              \addtolength\labelwidth{-\labelsep}%
              \setlength \topsep {.2em}%
              \setlength \itemsep {\topsep}}
\def\@listiv {\setlength  \leftmargin{\leftmarginiv}%
              \setlength  \labelwidth{\leftmarginiv}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listv  {\setlength \leftmargin{\leftmarginv}%
              \setlength \labelwidth{\leftmarginv}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listvi {\setlength \leftmargin{\leftmarginvi}%
              \setlength \labelwidth{\leftmarginvi}%
              \addtolength\labelwidth{-\labelsep}}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}     
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
{\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
                    {\endlist}
\newcommand*{\descriptionlabel}[1]{\hspace\labelsep
  \normalfont\bfseries #1}
\newenvironment{quotation}{%
  \list{}{\setlength\listparindent{1.5em}%
  \setlength\itemindent{\listparindent}%
  \setlength\rightmargin{\leftmargin}}%
  \item[]}{%
  \endlist}
\newenvironment{quote}{%
  \list{}{\setlength\rightmargin{\leftmargin}}%
  \item[]}
  {\endlist}
\newcounter{letter}
\def\@oddhead{\hspace*{-1in}\@print@logo}
\def\@oddfoot{%
  \ifx\@reference\empty
  \else
  \@referencelabel\space\@reference
  \fi
  \hfill
  \@rightfooterlabel{\thepage}{\pageref*{lastpage:\theletter}}}
\AtBeginDocument{%
  \def\today{\number\day-\number\month-\number\year}
  \frenchspacing}
\newcommand{\name}[2][]{%
  \def \@name {#2}
  \def \@function {#1}}
\newcommand{\subsender}[1]{\def \@subsender {#1}}
\newcommand{\visitingaddress}[1]{\def \@visitingaddress {#1}}
\newcommand{\telephone}[1]{\def \@telephone {#1}}
\newcommand{\fax}[1]{\def \@fax {#1}}
\newcommand{\email}[1]{\def \@email {#1}}
\newcommand{\website}[1]{\def \@website {#1}}
\newcommand{\toname}[2][]{%
  \def \@toname {#2}
  \def \@toinstitute {#1}}
\newcommand{\toaddress}[1]{\def \@toaddress {#1}}
\newcommand{\pobox}[1]{\def \@pobox {#1}}
\newcommand{\subject}[1]{\def \@subject {#1}}
\newcommand{\reference}[1]{\def \@reference {#1}}
\newcommand{\yourreference}[1]{\def \@yourreference {#1}}
\newcommand{\enclosure}[1]{\def \@enclosure {#1}}
\renewcommand*{\date}[1]{\def \@date {#1}}
\newcommand{\withsignature}[1]{\@signaturetrue \def\@sigpath{#1}}
\name[]{}
\subsender{}
\telephone{}
\fax{}
\email{}
\website{}
\visitingaddress{}
\newcommand{\@clearcaches}{%
  \pobox{}
  \toname[]{}
  \toaddress{}
  \subject{}
  \reference{}
  \yourreference{}
  \enclosure{}
  \date{}
  \@signaturefalse}
\@clearcaches
\newcommand{\@printendline}[1]{%
  \if &#1&
  \else
  {#1}\\
  \fi}
\newcommand{\@printdetailline}[2]{%
  \if &#2&
  \else
  \textbf{\@smaller #1} & #2\\
  \fi}
\newcommand{\@printdate}{%
  \ifx \@date \empty
  \today
  \else
  \@date
  \fi}
\newcommand{\@printemail}{%
  \ifx \@email \empty
  \else
  \@email
  \fi}
\newcommand{\@printwebsite}{%
  \ifx \@website \empty
  \else
  \@website
  \fi}
\providecommand*{\input@path}{}
\newcommand{\IfImageExists}[3]{%
  \begingroup
  \ifdefined\Ginput@path
    \edef\input@path{\input@path\Ginput@path}%
  \fi
  \IfFileExists{#1}{#2}{#3}%
  \endgroup
}
\newcommand{\@printsignature}{%
  \if@signature
  \IfImageExists{\@sigpath}{\includegraphics[width=3.5cm]{\@sigpath}\\}{%
    \fbox{Warning! Signature not found}\\
  \ClassWarning{uuletter2}{You selected \protect\withsignature\space
    but LateX couldn't locate the signature.}}
  \else
  \fi}
\newcommand{\@print@logo}{%
    \IfImageExists{\@logopath}{\includegraphics{\@logopath}}{%
      \fbox{Warning! Logo not found.}
      \ClassWarning{uuletter2}{Couldn't locate the logo file. Put
        it somewhere where LaTeX can find it.}}}
\newcommand{\@makeheader}{%
  \newpage
  \setcounter{page}{1}
  \stepcounter{letter}
  \parbox[t][5.48cm]{10.5cm}{%Based on template
      \strut
      \textbf{\@smaller\@pobox}\\
      
      \vspace{\baselineskip}

      \@printendline{\@toname}
      \@printendline{\@toinstitute}
      \@toaddress
      \strut}
  \parbox[t][5.48cm]{6.5cm}{%
      \strut
      \textbf{\@name}\\
      \@subsender\\

      \vspace{\baselineskip}
      
      \textbf{\@smaller \@visitingaddresslabel}\\
      \@visitingaddress
      \strut}
  \break
  \parbox[t][5.35cm]{10.5cm}{%
    \strut
    \begin{tabular}{@{} p{2.97cm} @{} p{7.53cm} @{}}
      \@printdetailline{\@yourreferencelabel}{\@yourreference}
      \@printdetailline{\@referencelabel}{\@reference}
      \@printdetailline{\@telephonelabel}{\@telephone}
      \@printdetailline{\@faxlabel}{\@fax}
      \@printdetailline{\@emaillabel}{\@printemail}
      \@printdetailline{\@websitelabel}{\@printwebsite}
      \\
      \textbf{\@smaller \@datelabel} & \@printdate\\
      \@printdetailline{\@subjectlabel}{\@subject}
      \@printdetailline{\@enclosurelabel}{\@enclosure}
    \end{tabular}
    \strut}
  \hfill\break}

\newcommand{\opening}[1]{%
  \@makeheader
  #1\par}

\newcommand{\closing}[2][\@name]{%
  \stopbreaks
  \par
  \vspace{\baselineskip}
  #2
  \par
  \@printsignature
  \@printendline{#1}
  \@function
  \label{lastpage:\theletter}
  \startbreaks
  \clearpage
  \@clearcaches}
