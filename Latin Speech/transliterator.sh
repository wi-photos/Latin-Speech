#!/bin/bash
transliterate() {
for arg in $@; do
if [[ $arg =~ ^[0-9]+$ ]]; then
rate=$arg
else
test_string=$arg
fi
done
voice=$(echo "$v"|tr '_' ' ')
echo "$test_string" | sed 's/\(.\{0\}\)/\1 /g' |  tr '[:upper:]' '[:lower:]' | sed  -e 's/ a / ah/g' | sed  -e 's/ e / eh/g'  | sed  -e 's/ i/ ee/g' | sed  -e 's/ o / oh/g' | sed  -e 's/ u / u/g' | sed  -e 's/ ae / oo/g' | sed  -e 's/ oe / eh/g'| sed  -e 's/ au / ah/g' | sed  -e 's/ eu / eh/g'| sed  -e 's/ c / ch/g'| sed  -e 's/ ch / ch/g'| sed  -e 's/ g / ge/g'| sed  -e 's/ g / g/g'| sed  -e 's/ gn / ny/g'| sed  -e 's/ h /  /g'| sed  -e 's/ j / y/g'| sed  -e 's/ r / r/g'| sed  -e 's/ s / s/g'| sed  -e 's/ th / t/g' | sed  -e 's/ ti / tsee/g' | sed  -e 's/ x / ks/g'| sed  -e 's/ xc / ksh/g'| sed  -e 's/ z / dz/g'| sed  -e 's/  /_/g' | sed  -e 's/ //g'| sed  -e 's/_/ /g'

}
transliterate $@
