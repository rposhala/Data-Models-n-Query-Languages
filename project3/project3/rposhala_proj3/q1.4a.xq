(:For Price low to high:)
let $b:=doc("db/books.xml")/biblio
let $c:=distinct-values($b//title)

(:Getting title and price:)
let $forprice:= (for $eachbook in $c return 
<book>
<title>{$eachbook}</title>
<price>{distinct-values($b/author/book[title=$eachbook]/price)}</price>
</book>)
let $xxx:= <bib>{$forprice}</bib>

(:ordering by price:)
for $aa in $xxx//book
order by xs:integer($aa/price)

(:Printing output:)
return ($aa/title,$aa/price)