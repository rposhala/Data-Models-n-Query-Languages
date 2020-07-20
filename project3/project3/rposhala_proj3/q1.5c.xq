let $b:=doc("db/books.xml")/biblio

(:Getting distinct title values:)
let $books:=distinct-values($b//title)

(:Getting distinct category values:)
let $c:=distinct-values($b//category)

(:Getting books of DB category:)
let $DB:= distinct-values(for $dd in $b/author return distinct-values($b/author/book[category='DB']/title) )

(:Getting books of PL category:)
let $PC:=distinct-values(for $dd in $b/author return distinct-values($b/author/book[category='PL']/title) )

(:Getting books of Science category:)
let $Science:=distinct-values(for $dd in $b/author return distinct-values($b/author/book[category='Science']/title) )

(:Getting books of Others category:)
let $Others:=distinct-values(for $dd in $b/author return distinct-values($b/author/book[category='Others']/title) )

(:looping through all the combinations between all the categories which satisfies $1800 value price:)
let $quarterresult:=(
for $w in $DB
for $e in $PC
for $r in $Science
for $t in $Others
return if(((data(distinct-values($b/author/book[title=$w]/price)))+(data(distinct-values($b/author/book[title=$e]/price)))+(data(distinct-values($b/author/book[title=$r]/price)))+(data(distinct-values($b/author/book[title=$t]/price))))= 1800) then 
<combination>
<title>{$w}</title>
<rating>{distinct-values($b/author/book[title=$w]/rating)}</rating>
<price>{distinct-values($b/author/book[title=$w]/price)}</price>
<title>{$e}</title>
<rating>{distinct-values($b/author/book[title=$e]/rating)}</rating>
<price>{distinct-values($b/author/book[title=$e]/price)}</price>
<title>{$r}</title>
<rating>{distinct-values($b/author/book[title=$r]/rating)}</rating>
<price>{distinct-values($b/author/book[title=$r]/price)}</price>
<title>{$t}</title>
<rating>{distinct-values($b/author/book[title=$t]/rating)}</rating>
<price>{distinct-values($b/author/book[title=$t]/price)}</price>
</combination> 
else()
)
let $midres:=<bib>{$quarterresult}</bib>
let $rtr:=(for $ee in $midres return $ee/combination)

(:Getting best rating books combination formed from all the combinations that satisfy $1800 price:)
let $maxrating:=max(for $asa in $rtr return avg($asa/rating))

(:output in required format:)
for $tt in $rtr where avg($tt/rating)=$maxrating return $tt