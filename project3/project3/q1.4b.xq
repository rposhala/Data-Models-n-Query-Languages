(:For Rating from high to low:)
let $b:=doc("db/books.xml")/biblio

(:Getting distinct title values:)
let $c:=distinct-values($b//title)

(:Getting titles with ratings:)
let $forratings:= (for $eachbook in $c return 
<book>
<title>{$eachbook}</title>
<rating>{distinct-values($b/author/book[title=$eachbook]/rating)}</rating>
</book>)

let $yyy:= <bib>{$forratings}</bib>

(:Ordering by price:)
for $bb in $yyy//book
order by $bb/rating descending

(:Printing output:)
return ($bb/title,$bb/rating)