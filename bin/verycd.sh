for i in $(curl -s -S http://www.verycd.gdajie.com/topics/$1/ | grep detail | sed 's/.*detail.htm.id=\(.*\)\".*/\1/')
do
	open -a aMule $(curl -s -S http://www.verycd.gdajie.com/detail.htm?id=$i | grep ed2k_links |  grep file | sed 's/.*= .\(ed2k.*\/\).;/\1/')
done