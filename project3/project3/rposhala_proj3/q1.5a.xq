let $b:=doc("db/books.xml")/biblio

(:Getting distinct category values:)
let $c:=distinct-values($b//category)

(:Getting books with minimum price:)
let $minvalbooks:= (for $each in $c let $aa := min($b/author/book[category=$each]/price) return( 
<title>{distinct-values($b/author/book[category=$each and price=$aa]/title)[1]}</title>,
<price>{$aa}</price>,
<category>{$each}</category>)
)

(:output:)
return $minvalbooks