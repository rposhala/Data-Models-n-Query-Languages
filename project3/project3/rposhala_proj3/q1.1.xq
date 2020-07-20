let $b:=doc("db/books.xml")/biblio

(:Getting books whose author is Jeff:)
let $jeffbooknames:= distinct-values(for $a in $b/author
where $a/name='Jeff' 
return $a/book/title)

(:Getting books whose author is not Jeff:)
let $coauthorname:= distinct-values(for $a in $jeffbooknames, $f in $b/author
where ($f/book/title = $a and $f/name != 'Jeff')
return $f/name)

(:Getting books whose author is Jeff and some other co-author:)
let $commonbooks:= (for $i in $coauthorname, $f in $b/author,$j in $jeffbooknames
where ($f/name = $i and $j = $f/book/title)
return $j
)

(:Output in required format:)
for $a in $commonbooks, $f in $b/author
where ($f/book/title = $a)
group by $a
return (<book><title>{$a}</title>{$f/name}</book>)