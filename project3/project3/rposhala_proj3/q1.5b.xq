let $b:=doc("db/books.xml")/biblio

(:Getting distinct category values:)
let $c:=distinct-values($b//category)

(:Getting max rating books in each category:)
let $maxratingbooks:= (for $each in $c let $aa := max($b/author/book[category=$each]/rating) return( 
<title>{distinct-values($b/author/book[category=$each and rating=$aa]/title)[position()=1]}</title>,
<rating>{$aa}</rating>,
<category>{$each}</category>)
)
return $maxratingbooks