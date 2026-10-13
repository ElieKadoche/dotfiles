# Use lualatex
$pdf_mode = 4;
$lualatex = "lualatex -synctex=1 -file-line-error %O %S";

# Biber is run by latexmk itself
$bibtex_use = 2;

# Run makeglossaries (glossaries and acronyms)
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
sub run_makeglossaries {
    return system("makeglossaries", $_[0]);
}

# Run makeindex for nomenclature
add_cus_dep('nlo', 'nls', 0, 'run_makeindex_nomenclature');
sub run_makeindex_nomenclature {
    return system("makeindex", "$_[0].nlo", "-s", "nomencl.ist", "-o", "$_[0].nls");
}

# Run makeindex for regular indexes
$makeindex = "makeindex %O -o %D %S";
