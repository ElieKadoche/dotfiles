# Use lualatex instead of pdflatex
$pdf_mode = 1;
$pdflatex = "lualatex %O %S";

# Run BibTeX
#add_cus_dep('aux', 'bbl', 0, 'run_bibtex');
#sub run_bibtex {
#    system("bibtex $_[0]");
#}

# Run Biber
 add_cus_dep('bcf', 'bbl', 0, 'run_biber');
 sub run_biber {
     system("biber $_[0]");
 }

# Run makeglossaries
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
sub run_makeglossaries {
    system("makeglossaries $_[0]");
}

# Run makeindex for nomenclature
add_cus_dep('nlo', 'nls', 0, 'run_makeindex_nomenclature');
sub run_makeindex_nomenclature {
    system("makeindex $_[0].nlo -s nomencl.ist -o $_[0].nls");
}

# Ensure multiple runs of lualatex
$latex = "lualatex %O %S";
$bibtex_use = 2;
$makeindex = "makeindex %O -s %S.ist %S";

# Custom dependencies
# push @generated_exts, 'bbl', 'blg', 'glo', 'gls', 'glg', 'ist', 'acn', 'acr', 'alg', 'nlo', 'nls';

# Force multiple passes of lualatex
# $clean_ext .= " nlo nls glg gls glo acr acn alg";
