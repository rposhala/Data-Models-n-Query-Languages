let $b:=doc("db/books.xml")/biblio

(:Getting all the distinct category values:)
let $c:=distinct-values($b//category)

(:
let $e:=(for $d in $c return (<category>{$d}</category>,<averageprice>{avg(distinct-values($b/author/book[category=$d]/price))}</averageprice>)) 
(:return $e:)
:)
(:Getting the global average price :)
let $gg:=(for $ss in $c return distinct-values($b/author/book[category=$ss]/price))
let $totalavg:= avg($gg)

(:Getting the categories whose average value is greater than global average:)
let $greaterthanavgcategories:= (for $p in distinct-values($b/author/book//category)
let $a := avg(distinct-values($b/author/book[category=$p]/price))
where $a ge $totalavg 
return $p)

(:Getting most expensive books from those categories whose average is greater than global average:)
let $mostexpensivebooks:= (for $each in $greaterthanavgcategories let $aa := max($b/author/book[category=$each]/price) return distinct-values($b/author/book[category=$each and price=$aa]/title))

(:Output in required format:)
let $result:=(for $eachbook in $mostexpensivebooks
return 
<categories>
<output>
<category>
{distinct-values($b/author/book[title=$eachbook]/category)}
</category>
<title>
{$eachbook}
</title>
<price>
{distinct-values($b/author/book[title=$eachbook]/price)}
</price>
{for $ii in $b/author where $ii/book[title=$eachbook] return

$ii/name}

</output>
</categories>
)
return <result>{$result}</result>