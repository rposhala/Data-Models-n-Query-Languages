let $b:=doc("db/books.xml")/biblio
let $books:=distinct-values($b//title)
let $authors:=distinct-values($b//name)

(:Getting books which has atleast 2 authors:)
let $finalresult:=(for $eachtitle in $books,$eachauthor in $b/author
where $eachtitle = $eachauthor/book/title
group by $eachtitle return
if(count($eachauthor/name) ge 2)
then
<output>
<name>
{for $everyauthor in $eachauthor/name where (count($eachauthor/name) ge 2 ) return
(distinct-values($everyauthor))
}
</name>
<book year="{distinct-values($eachauthor/book[title=$eachtitle]/@year)}"> 
<title>{$eachtitle}</title>
<category>{distinct-values($eachauthor/book[title=$eachtitle]/category)}</category>
<rating>{distinct-values($eachauthor/book[title=$eachtitle]/rating)}</rating>
<price>{distinct-values($eachauthor/book[title=$eachtitle]/price)}</price>
</book>
</output>
else()
)

(:Getting books which has same co-authors:)
let $values:=$finalresult//name
let $distinctvaluesr := distinct-values($finalresult//name)
let $nonunique := for $value in $distinctvaluesr return if (count(index-of($values, $value)) > 1) then $value else ()
let $bookswithrequiredcondition:=distinct-values(for $rer in $finalresult where(fn:exists($rer/name) and $rer/name = $nonunique) return $rer/book/title)

(:Output in required format:)
let $lastresult:=(
for $ew in $bookswithrequiredcondition return 
<output> 
{for $te in $b/author where ($te/book/title=$ew) return $te/name}
<book year="{distinct-values($b/author/book[title=$ew]/@year)}"> 
<title>{$ew}</title>
<category>{distinct-values($b/author/book[title=$ew]/category)}</category>
<rating>{distinct-values($b/author/book[title=$ew]/rating)}</rating>
<price>{distinct-values($b/author/book[title=$ew]/price)}</price>
</book>
</output>)

(:Adding coauthor tag to the output:)
return <coauthor>{$lastresult}</coauthor>