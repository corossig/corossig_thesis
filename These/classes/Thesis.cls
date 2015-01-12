\ProvidesClass{classes/Thesis}[2014/07/18 v1.0 Thesis class]
%-------------------------- initial code -----------------------
\newif\ifCU@bookmode
\CU@bookmodetrue

\DeclareOption{report}{\CU@bookmodefalse}
\DeclareOption{book}{\CU@bookmodetrue}
\ProcessOptions\relax%

\ifCU@bookmode
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}%
\ProcessOptions\relax%
\ifx\pdfoutput\undefined%
   \LoadClass[dvips, a4paper]{book}%
\else%
   \LoadClass[pdftex, a4paper]{book}%
   \pdfminorversion=4
\fi%
\else
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}%
\ProcessOptions\relax%
\ifx\pdfoutput\undefined%
  \LoadClass[dvips, a4paper]{report}%
\else%
   \LoadClass[pdftex, a4paper]{report}%
\fi%
%\renewcommand{\refname}{References}%
\fi

%\DeclareOption{book}{%
%}%
\usepackage{setspace}
\usepackage{tocbibind}
\usepackage{amssymb}
%\usepackage{graphicx}
\usepackage{fancyhdr}
\usepackage{eucal}
\usepackage[english]{babel}
\usepackage[usenames, dvipsnames]{color}
\usepackage[perpage]{footmisc}
\usepackage[square, sort, comma, numbers]{natbib}
\usepackage{ifthen}
\usepackage{ifpdf}
\usepackage{amsmath}
\usepackage[table]{xcolor}
\usepackage{multirow}
\usepackage{colortbl}   % Provides \rowcolor
\usepackage{calc}       % For doing math with dimensions
\usepackage{tabularx}
\usepackage{xr}  % cross referencing from different files
\usepackage{zref-xr}
\usepackage{bold-extra}
\usepackage{indentfirst}

%Bibliography
%uncomment next line to change bibliography name to references for Book document class
\renewcommand{\bibname}{References}
% note that this doesn't do much if you later define another bibliography style

%Small table of content for each chapters


% Nomenclature
\usepackage{nomencl}
\makenomenclature
\renewcommand\nomgroup[1]{%
  \ifthenelse{\equal{#1}{A}}{%
   \item[\textbf{Roman Symbols}] }{%             A - Roman
    \ifthenelse{\equal{#1}{G}}{%
     \item[\textbf{Greek Symbols}]}{%             G - Greek
      \ifthenelse{\equal{#1}{R}}{%
        \item[\textbf{Superscripts}]}{%              R - Superscripts
          \ifthenelse{\equal{#1}{S}}{%
           \item[\textbf{Subscripts}]}{{%             S - Subscripts
            \ifthenelse{\equal{#1}{X}}{%
             \item[\textbf{Other Symbols}]}{{%    X - Other Symbols
            \ifthenelse{\equal{#1}{Z}}{%
             \item[\textbf{Acronyms}]}%              Z - Acronyms
                                {{}}}}}}}}}}

\ifpdf
%-->
%--> Google.com search "hyperref options"
%-->
%--> http://www.ai.mit.edu/lab/sysadmin/latex/documentation/latex/hyperref/manual.pdf
%--> http://www.chemie.unibas.ch/~vogtp/LaTeX2PDFLaTeX.pdf
%--> http://www.uni-giessen.de/partosch/eurotex99/ oberdiek/print/sli4a4col.pdf
%--> http://me.in-berlin.de/~miwie/tex-refs/html/latex-packages.html
%-->

      %% add to get the page back           pagebackref,
    \usepackage[ pdftex, plainpages=false, pdfpagelabels,
                 pdfpagelayout = useoutlines,
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 colorlinks = true,
                 linkcolor = black,
                 urlcolor  = black,
                 citecolor = black,
                 anchorcolor = green,
                 hyperindex = true,
                 hyperfigures,
                 linktoc=all
                 ]{hyperref}
    \usepackage[pdftex]{graphicx}
    %\DeclareGraphicsExtensions{.png, .jpg, .pdf}

    \pdfcompresslevel=1
    %\graphicspath{{ThesisFigs/PNG/}{ThesisFigs/PDF/}{ThesisFigs/}}
\else
    \usepackage[ dvips,
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 colorlinks = true,
                 linkcolor = black,
                 urlcolor  = black,
                 citecolor = black,
                 anchorcolor = black,
                 hyperindex = true,
                 hyperfigures
                 ]{hyperref}

    %\usepackage{epsfig}
    \usepackage[dvips]{graphicx}
    \DeclareGraphicsExtensions{.eps, .ps}
    \graphicspath{{ThesisFigs/EPS/}{ThesisFigs/}}
\fi

\usepackage{tikz}
\usetikzlibrary{shapes,arrows}


%define the page size including an offset for binding
%\setlength{\topmargin}{0.0in}
%\setlength{\oddsidemargin}{0in}
%\setlength{\evensidemargin}{0in}
%\setlength{\textheight}{700pt}
%\setlength{\textwidth}{500pt}


%A4 settings
\ifpdf
   \pdfpageheight=297mm
   \pdfpagewidth=210mm
\else
   \setlength{\paperheight}{297mm}
   \setlength{\paperwidth}{210mm}
\fi

\setlength{\hoffset}{-0.5cm}
%\setlength{\voffset}{0.00cm}

\setlength{\evensidemargin}{0.25cm}
\setlength{\oddsidemargin}{0.25cm}
%\setlength{\topmargin}{1mm}
%\setlength{\headheight}{1.36cm}
%\setlength{\headsep}{1.00cm}
%\setlength{\textheight}{20.84cm}
\setlength{\textwidth}{16.5cm}
%\setlength{\marginparsep}{1mm}
%\setlength{\marginparwidth}{3cm}
%\setlength{\footskip}{2.36cm}


%\pagestyle{fancy}
%\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter. #1 }}{}}
%\renewcommand{\sectionmark}[1]{}
%\fancyhf{}
%\fancyhead[RO]{\bfseries\rightmark}
%\fancyhead[LE]{\bfseries\leftmark}
%\fancyfoot[C]{\thepage}
%\renewcommand{\headrulewidth}{0.5pt}
%\renewcommand{\footrulewidth}{0pt}
%\addtolength{\headheight}{0.5pt}
%\fancypagestyle{plain}{
%  \fancyhead{}
%  \renewcommand{\headrulewidth}{0pt}
%}

\newcommand{\submittedtext}{{A thesis submitted for the degree of}}
%
%
% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

\def\authorFirstName#1{\gdef\@authorFirstName{#1}}
\def\authorLastName#1{\gdef\@authorLastName{#1}}
\def\authorMail#1{\gdef\@authorMail{#1}}

\def\directors#1{\gdef\@directors{#1}}
\def\codirectors#1{\gdef\@codirectors{#1}}
\def\responsables#1{\gdef\@responsables{#1}}

\def\degreeDate#1{\gdef\@degreeDate{#1}}

\def\degree#1{\gdef\@degree{#1}}
\def\degreeSpeciality#1{\gdef\@degreeSpeciality{#1}}

\def\laboratory#1{\gdef\@collegeordept{#1}}
\def\laboratoryURL#1{\gdef\@collegeordeptURL{#1}}

\def\university#1{\gdef\@university{#1}}
\def\universityURL#1{\gdef\@universityURL{#1}}

\def\logo#1{\gdef\@logo{\includegraphics[clip, height=0.15\textwidth]{#1}}}

% These macros define an environment for front matter that is always
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}

%define title page layout
%\renewcommand{\maketitle}{%
%\begin{alwayssingle}
    %\renewcommand{\footnotesize}{\small}
    %\renewcommand{\footnoterule}{\relax}
    %\thispagestyle{empty}
%%\null\vfill
  %\begin{center}
    %{ \Huge {\bfseries {\@title}} \par}
%{\large \vspace*{35mm} {{\@crest} \par} \vspace*{25mm}}
    %{{\Large \@author} \par}
%{\large \vspace*{1ex}
    %{{\@collegeordept} \par}
%\vspace*{1ex}
    %{{\@university} \par}
%\vspace*{25mm}
    %{{\submittedtext} \par}
%\vspace*{1ex}
    %{\it {\@degree} \par}
%\vspace*{2ex}
    %{\@degreedate}}
  %\end{center}
  %\null\vfill
%\end{alwayssingle}}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

\renewcommand*{\maketitle}{
\thispagestyle{empty}

\begin{center}

\vspace{\stretch{2}}
%Espace vertical variable de poids 2.

{\Huge \textsc{\@degree}}

\vspace{\stretch{1}}

{\LARGE Specialit\'e : \@degreeSpeciality}

% Permet de créer un espace vertical de longueur variable (\stretch) et de "poids" 1
\vspace{\stretch{2}}
 {\@logo}

\vspace{\stretch{2}}

{\large present\'ee par}
\vspace{\stretch{1}}

\textbf{{\LARGE {\@authorFirstName} \textsc{{\@authorLastName}}}}

\vspace{\stretch{2}}
\hrule
\vspace{\stretch{1}}
\begin{spacing}{1.5}
{\LARGE \textbf{\@title}}
\end{spacing}
\vspace{\stretch{0.5}}
\hrule
\vspace{\stretch{1}}

\begin{spacing}{1.5}
{
{\Large Directeur de th\`ese : \@directors}

{\Large Co-direction : \@codirectors}

{\Large Encadrant dans l'entreprise (Total SA) : \@responsables}}
\end{spacing}

\vspace{\stretch{5}}

{\Large Soutenue le {\@degreeDate} avec pour jury :}


\vspace{\stretch{2}}
{\Large
\begin{tabular}{lll}
M. ???? \textsc{????} & ???? & Directeur \\
M. ???? \textsc{????} & ???? & Co-Directeur \\
M. ???? \textsc{????} & ???? & Co-Directeur \\
M. ???? \textsc{????} & ???? & Rapporteur \\
M. ???? \textsc{????} & ???? & Rapporteur \\
M. ???? \textsc{????} & ???? & Examinateur \\
M. ???? \textsc{????} & ???? & Examinateur \\
M. ???? \textsc{????} & ???? & Examinateur \\
\end{tabular}
}

\end{center}
}

% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

%\newenvironment{acknowledgements}
%{\pagestyle{empty}
%\begin{alwayssingle}
%\begin{center}
%\vspace*{1.5cm}
%{\Large \bfseries Acknowledgements}
%\end{center}
%\vspace{0.5cm}
%\begin{quote}}
%{\end{quote}\end{alwayssingle}}


%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).

\pagestyle{fancy}
\fancyhf{}
 \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0.0pt}
  \fancyhead[l]{\small{\rightmark}}
  \fancyhead[r]{\thepage}
\fancypagestyle{myheadings}{ %
   \fancyhf{} % remove everything
   \renewcommand{\headrulewidth}{0.0pt} % remove lines as well
   \renewcommand{\footrulewidth}{0.4pt}
   \fancyfoot[l]{\small{\rightmark}}
   \fancyfoot[r]{\thepage}
        }
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\footrulewidth}{0.4pt}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[l]{\small{\rightmark}}
    \fancyfoot[r]{\thepage}
  }


\newenvironment{romanpages}
{\setcounter{page}{1}
  \renewcommand{\thepage}{\roman{page}}}
{\newpage\renewcommand{\thepage}{\arabic{page}}}
%{\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}

% Mes rajouts :_______________________________

\pdfpageheight
\pdfpagewidth
\setlength{\topmargin}{-1.5cm}
\setlength{\textheight}{25.5cm}
\setlength{\footskip}{0.9cm}

\usepackage{titlesec}
\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1ex \hfill \kern \z@}
\def\@makechapterhead#1{%
  {\parindent \z@ \raggedright
    \reset@font
    \hrule
    \vspace*{10\p@}%
    \par
    \Huge \scshape \@chapapp{} \Huge \thechapter
    \par\nobreak
    \vspace*{10\p@}%
    \hrule
    \par
    \vspace*{1\p@}%
    \hrule
    %\vskip 40\p@
    \vspace*{20\p@}
    \Huge \bfseries #1\par\nobreak
    \vskip 30\p@
}}
\makeatother

\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1ex \hfill \kern \z@}
\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedright
    \reset@font
    \hrule
    \vspace*{10\p@}%
    \par
    \Huge \scshape #1
    \par\nobreak
    \vspace*{10\p@}%
    \hrule
    \par
    \vspace*{1\p@}%
    \hrule
    \vspace*{20\p@}
    \vskip 30\p@
}}
\makeatother

\usepackage{blindtext}

\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}
\makeatletter
\renewcommand\theparagraph{\thesubsubsection .\@alph\c@paragraph/}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}

\makeatletter
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\makeatother



% Visualisation du plan en dynamique

\usepackage{float}
\ifpdf
\usepackage{hyperref}
\usepackage{microtype}
\else
\usepackage{hypdvips}
\usepackage{breakurl}
\fi

\usepackage[chapter]{algorithm}
\usepackage{algorithmic}
\usepackage{comment}

\usepackage{minitoc}
\setcounter{minitocdepth}{2}



\makeatletter
\newcommand*{\metadataSetup}{%
\hypersetup{colorlinks,%
  pdfauthor={{\@authorFirstName} {\@authorLastName}},%
  pdftitle={\@title},
  pdfcreator={LaTeX},%
  bookmarks=true
  citecolor=black,%
  filecolor=black,%
  linkcolor=black,%
  urlcolor=black,%
}%
}
\makeatother
