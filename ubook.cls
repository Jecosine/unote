%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright @jecosine <jecosine@gmail.com>
% available at https://github.com/jecosine/unote
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ubook}[2023/07/30 v1.0 UStyle document class for book]

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
% \SetupKeyvalOptions{family=ubook, prefix=ubook@, setkeys=\kvsetkeys}
% \ProvidesPackage{ubook}
% typeface and math
\RequirePackage{utopia}
\RequirePackage{amsmath, amssymb, mathtools}

%% Theme declaration
% HTML Color
\DeclareStringOption[141D29]{primarytext}
\DeclareStringOption[962239]{secondarytext}
\DeclareStringOption[457B9D]{emphasistext}
\DeclareStringOption[77ABBD]{disabledtext}
\DeclareStringOption[457B9D]{linktext}
\DeclareStringOption[457B9D]{mathtext}
\DeclareStringOption[1D3557]{eqlinktext}

\DeclareBoolOption{single}
\DeclareBoolOption[true]{dropcap}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*\relax
\LoadClass[a4paper]{article}
% color 
\definecolor{primarytext}{HTML}{\ubook@primarytext}%
\definecolor{secondarytext}{HTML}{\ubook@secondarytext}%
\definecolor{linktext}{HTML}{\ubook@linktext}%
\definecolor{emphasistext}{HTML}{\ubook@emphasistext}%
\definecolor{disabledtext}{HTML}{\ubook@disabledtext}%
\definecolor{mathtext}{HTML}{\ubook@mathtext}%
\definecolor{eqlinktext}{HTML}{\ubook@eqlinktext}%

\everymath{\color{mathtext}}
\newcommand{\globalcolor}[1]{%
  \color{#1}\global\let\default@color\current@color
}
\AtBeginDocument{\globalcolor{primarytext}}
% \preto{\tikzpicture}{\color{HTML}{ff0000}\let\default@color\current@color}
% \everydisplay{\color{primarytext}}

\ifubook@dropcap
  \RequirePackage{lettrine}
\fi
% title
\newcommand{\utitle}[1]{
  {\color{secondarytext}\textbf{\Huge #1}}\\
}

% Geometry
\RequirePackage{geometry}
\ifubook@single
  \geometry{
    a4paper,
    top=2cm, bottom=2cm, inner=1.5cm, outer=5cm, marginparsep=1cm, marginparwidth=3.5cm,
    twoside=false
  }
\else
  \geometry{
    a4paper,
    top=2cm, bottom=2cm, inner=1cm
  }
\fi

% sections

\RequirePackage[center,pagestyles]{titlesec}
\RequirePackage{apptools}
\RequirePackage[toc,page,title,titletoc]{appendix}
% \titleformat{\chapter}[display]{\bfseries}
% {\filcenter\LARGE\enspace\bfseries{\color{secondarytext}\IfAppendix{\appendixname}{\chaptername}\enspace}}{1pt}{\bfseries\color{secondarytext}\LARGE\filcenter}[]

\titleformat{\section}[hang]{\bfseries}{
  \Large\bfseries{\color{secondarytext}\thesection}\enspace}{1pt}{%
  \color{secondarytext}\Large\bfseries\filright}
\titleformat{\subsection}[hang]{\bfseries}{
  \large\bfseries\color{secondarytext}\thesubsection\enspace}{1pt}{%
  \color{secondarytext}\large\bfseries\filright}
\titleformat{\subsubsection}[hang]{\bfseries}{
  \large\bfseries\color{secondarytext}\thesubsubsection\enspace}{1pt}{%
  \color{secondarytext}\large\bfseries\filright}



% stretch
\renewcommand{\baselinestretch}{1.2}
\RequirePackage[skip=10pt plus1pt, indent=0pt]{parskip}
\setlength\parindent{0pt}
% header
\RequirePackage{fancyhdr}
\fancyhf{}
\fancyfoot[c]{\color{mathtext}\scriptsize\thepage}
\if@twoside
  \fancyhead[ER]{\color{mathtext}\normalfont\leftmark}
  \fancyhead[OL]{\color{mathtext}\normalfont\rightmark}
\else
  \fancyhead[R]{\color{mathtext}\normalfont\rightmark}
\fi
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\headrule}{\color{mathtext}\hrule width\textwidth height\headrulewidth\hfill}
\pagestyle{fancy}
\fancypagestyle{plain}{\renewcommand{\headrulewidth}{0pt}\fancyhf{}\renewcommand{\headrule}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\, #1}{} }
% \renewcommand{\chaptermark}[1]{\markboth{\chaptername \, #1\,}{}}
% \renewcommand{\footrulewidth}{2pt}
% hyperref
\RequirePackage{hyperref}
\RequirePackage{url}
\hypersetup{
  breaklinks,
  unicode,
  colorlinks,
  linkcolor=linktext,
  urlcolor=linktext
}

% \RequirePackage{newtxmath}
% \let\Bbbk\relax
% \RequirePackage{esint}
%%% use yhmath pkg, uncomment following code
% \let\oldwidering\widering
% \let\widering\undefined
% \RequirePackage{yhmath}
% \let\widering\oldwidering

%%% use esvect pkg, uncomment following code
% \RequirePackage{esvect}

% \DeclareSymbolFont{CMlargesymbols}{OMX}{cmex}{m}{n}
% \let\sumop\relax\let\prodop\relax
% \DeclareMathSymbol{\sumop}{\mathop}{CMlargesymbols}{"50}
% \DeclareMathSymbol{\prodop}{\mathop}{CMlargesymbols}{"51}

% marginpar
\RequirePackage{tikz}
% \RequirePackage{mparhack}
% \makeatletter
% https://tex.stackexchange.com/a/89337
\patchcmd{\@addmarginpar}%
    {\box \@marbox}%
    {\hbox{%
        \ifmpar@rule@rside
        \hskip-\mparrulefactor\marginparsep\mparrule
        \hskip\mparrulefactor\marginparsep
        \fi
                          \box \@marbox
        \ifmpar@rule@lside
        \hskip\mparrulefactor\marginparsep\mparrule
        \fi}%
     \global\mpar@rule@lsidefalse
     \global\mpar@rule@rsidefalse
    }%
    {\typeout{*** SUCCESS ***}}{\typeout{*** FAIL ***}}

\patchcmd{\@addmarginpar}%
    {\global\setbox\@marbox\box\@currbox}%
    {\global\setbox\@marbox\box\@currbox
     \global\mpar@rule@lsidetrue
     \else
     \global\mpar@rule@rsidetrue
    }%
    {\typeout{*** SUCCESS ***}}{\typeout{*** FAIL ***}}

\newif\ifmpar@rule@lside
\newif\ifmpar@rule@rside
% \marginparrule generates the \vrule but should use no space horizontally
% using color is just for fun ...
\newcommand\mparrule{\textcolor{mathtext}
    {\hskip-6pt\vrule width 3pt\hskip-6pt}}

% placement factor: .5 places the rule midway in the space made available 
% by \marginparsep
\newcommand\mparrulefactor{.4}
% \makeatother
\let\oldmarginpar\marginpar
\renewcommand{\marginpar}[1]{%
  \oldmarginpar{%
  \small\color{eqlinktext}#1
  }%
}

% Environments
%%define the note and proof environment
\RequirePackage{pifont,manfnt,bbding}
\RequirePackage[many]{tcolorbox}
\newcommand\figref[1]{\textbf{Figure}~\ref{#1}}
\newcommand\tabref[1]{\textbf{Table}~\ref{#1}}
\newcommand{\authorname}{\textbf{Author: }}
\newcommand{\institutename}{\textbf{Institute: }}
\newcommand{\datename}{\textbf{Date: }}
\newcommand{\versionname}{\textbf{Version: }}
% \bibliographystyle{\ELEGANT@bibstyle}
\newcommand{\notename}{Note}
\newcommand{\proofname}{Proof}
\newcommand{\problemname}{Problem}
\newcommand{\definitionname}{Definition}
\newcommand{\theoremname}{Theorem}
\newcommand{\axiomname}{Axiom}
\newcommand{\postulatename}{Postulate}
\newcommand{\lemmaname}{Lemma}
\newcommand{\propositionname}{Proposition}
\newcommand{\corollaryname}{Corollary}
\newcommand{\examplename}{Example}
\newcommand{\exercisename}{Exercise}
\newcommand{\remarkname}{Remark}
\newcommand{\assumptionname}{Assumption}
\newcommand{\conclusionname}{Conclusion}
\newcommand{\solutionname}{Solution}
\newcommand{\propertyname}{Property}
\newcommand{\introductionname}{Introduction}
\newcommand{\problemsetname}{Exercise}
% \newcommand\bioinfo[2]{\gdef\@bioinfo{\textbf{#1}: #2}}
\newcommand{\updatename}{Updates:}
\newcommand{\historyname}{Version History}
\tcbset{
    common/.style={
      % empty,
      enhanced,
      blank,
      no shadow,
      no underlay,
      fontupper=\normalfont,
      lower separated=false,
      % no borderline,
      borderline={0pt}{0pt}{white},
      % before upper={\setlength{\parindent}{\normalparindent}},
      coltitle=white,
      % colback=gray!5,
      % toprule=0.2pt,
      fonttitle=\bfseries\sffamily,
      boxrule=0pt,
      breakable,
      top=1.5\baselineskip,
      bottom=10pt,
      left=12pt,
      % before skip=15pt,
     % after skip=20pt,
      attach boxed title to top left={
        yshift=-\baselineskip,
        xshift=0in},
      boxed title style={
        boxrule=0pt,
        % colframe=white,
        arc=0pt,
        outer arc=0pt},
      separator sign={\,},},
    defstyle/.style={
      common,
      colframe=primarytext,  
      colback=primarytext!5,
      colbacktitle=primarytext, 
      overlay unbroken and last={
        \node[anchor=south east, outer sep=0pt] at (\linewidth-width,0) { \textcolor{primarytext}{$\blacksquare$}};}
        },
    thmstyle/.style={
      common,
      % show bounding box,
      boxed title style={colframe=eqlinktext},
      % colframe=eqlinktext,
      borderline north={0.5mm}{0pt}{eqlinktext},
      colback=white,
      colbacktitle=eqlinktext, 
      overlay unbroken and last={
        \node[anchor=south east, outer sep=-4pt] at (\linewidth+width,0) {
          \color{eqlinktext}{$\blacksquare$}};}},
    propstyle/.style={
      common,
      colframe=linktext,  
      colback=linktext!5,
      colbacktitle=linktext, 
      overlay unbroken and last={
        \node[anchor=south east, outer sep=0pt] at (\linewidth-width,0) {
          \textcolor{linktext}{$\blacksquare$}};}},}

\newtcbtheorem[auto counter,]{pro}{Problem}{defstyle}{def}
\newtcbtheorem[auto counter,number within=section]{definition}{\definitionname}{defstyle}{def}
\newtcbtheorem[auto counter,number within=section]{theorem}{\theoremname}{thmstyle}{thm}
\newtcbtheorem[]{solution}{Solution}{thmstyle}{sol}
\newtcbtheorem[auto counter,number within=section]{postulate}{\postulatename}{thmstyle}{pos}
\newtcbtheorem[auto counter,number within=section]{axiom}{\axiomname}{thmstyle}{axi}
\newtcbtheorem[auto counter,number within=section]{proposition}{\propositionname}{propstyle}{pro}
\newtcbtheorem[auto counter,number within=section]{corollary}{\corollaryname}{thmstyle}{cor}
\newtcbtheorem[auto counter,number within=section]{lemma}{\lemmaname}{thmstyle}{lem}


% list item
\RequirePackage{enumerate}
\RequirePackage[shortlabels,inline]{enumitem}
\setlist{nolistsep}
\setlist[itemize,1]{
  font=\color{mathtext}
}
\setlist[enumerate,1]{
  font=\color{mathtext}
}
\RequirePackage[font=small,labelfont={bf,color=mathtext}]{caption} 
\captionsetup[table]{skip=5pt}
\captionsetup[figure]{skip=5pt}
