let $b:=doc("db/books.xml")/biblio

(:Getting distinct title values:)
let $titles:=distinct-values($b//title)

(:output in required format:)
let $finalresult:=(for $eachtitle in $titles,$eachauthor in $b/author
where $eachtitle = $eachauthor/book/title
group by $eachtitle
return 
<book year="{distinct-values($eachauthor/book[title=$eachtitle]/@year)}"> 
<title>{$eachtitle}</title>
<category>{distinct-values($eachauthor/book[title=$eachtitle]/category)}</category>
<rating>{distinct-values($eachauthor/book[title=$eachtitle]/rating)}</rating>
<price>{distinct-values($eachauthor/book[title=$eachtitle]/price)}</price>
{for $everyauthor in $eachauthor/name return
<author>
{$everyauthor}
</author>}
</book>)
return <biblio> {$finalresult} </biblio>