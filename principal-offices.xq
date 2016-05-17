xquery version "3.0";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html5";
declare option output:media-type "text/html";

declare variable $local:pocom-col := '/db/apps/principal-officers/data';
declare variable $local:principal-offices-col := $local:pocom-col || '/principal-offices';
declare variable $local:current-offices-col := $local:principal-offices-col || '/current-offices';
declare variable $local:discontinued-positions-col := $local:principal-offices-col || '/discontinued-positions';
declare variable $local:predecessor-offices-col := $local:principal-offices-col || '/predecessor-offices';

declare function local:get-office($office-id as xs:string) {
    collection($local:principal-offices-col)/office[id = $office-id]
};

declare function local:get-predecessors($office-ids as xs:string+) {
    let $offices := $office-ids ! local:get-office(.)
    let $predecessor-ids := $offices/predecessors/predecessor
    return
        if (exists($predecessor-ids)) then
            (
                $predecessor-ids ! 
                (
                    ./string(),
                    local:get-predecessors(.)
                )
            )
        else
            ()
};

<div>
    <p>{count(collection($local:current-offices-col)/office)} current offices.</p>
    <ol>{
        for $office in collection($local:current-offices-col)/office
        order by $office/id
        return
            <li><a href="#{$office/id}">{$office/name/string()}</a></li>
    }</ol>
    {
        for $office in collection($local:current-offices-col)/office
        let $predecessors := local:get-predecessors($office/id)
        order by $office/id
        return
            <div id="{$office/id}">
                <h2>{$office/name/string()}</h2>
                <div>
                    <h3>History of this Office</h3>
                    <ol>
                        {
                            if (exists($predecessors)) then
                                for $predecessor-id in reverse($predecessors)
                                let $predecessor := local:get-office($predecessor-id)
                                return
                                    <li>
                                        <strong>{$predecessor/name/string()}</strong> 
                                        ({
                                            (
                                                if ($predecessor/valid-from castable as xs:date) then 
                                                    format-date($predecessor/valid-from cast as xs:date, '[MNn] [D], [Y]') 
                                                else 
                                                    '[' || $predecessor/valid-from/string() || '?]'
                                            ) 
                                            || '–' || 
                                            (
                                                if ($predecessor/valid-until castable as xs:date) then 
                                                    format-date($predecessor/valid-until cast as xs:date, '[MNn] [D], [Y]') 
                                                else 
                                                    '[' || $predecessor/valid-until/string() || '?]'
                                            )
                                        })
                                        <ul>
                                            <li>{(normalize-space($predecessor/note), <em>[No description]</em>)[1]}</li>
                                        </ul>
                                    </li>
                            else ()
                        }
                        <li><strong>{$office/name/string()}</strong> (since {if ($office/valid-from castable as xs:date) then format-date($office/valid-from cast as xs:date, '[MNn] [D], [Y]') else $office/valid-from/string()})
                            <ul>
                                <li>{(normalize-space($office/note), <em>[No description]</em>)[1]}</li>
                            </ul>
                        </li>
                    </ol>
                </div>
                <div>
                    <h3>Officers</h3>
                    <ol>{
                        for $officer in $office/officers/officer
                        return
                            <li>{
                                $officer/person-id/string(),
                                if ($officer/contemporary-office-id ne $office/id) then 
                                    " (Appointed as " 
                                    || $officer/contemporary-office-id 
                                    || (
                                        if ($officer/mid-service-office-id-change) then 
                                            ("; TITLE CHANGED to " || $officer/mid-service-office-id-change) 
                                        else 
                                            ()
                                        ) 
                                    || ")" 
                                else 
                                    ()
                            }</li>
                    }</ol>
                </div>
                <div>
                    <h3>Other Appointees</h3>
                    {
                        if (exists($office/other-appointees/officer)) then
                            <ol>{
                                for $officer in $office/other-appointees/officer
                                return
                                    <li>{$officer/person-id/string()}</li>
                            }</ol>
                        else
                            <p><em>[None.]</em></p>
                    }
                </div>
                <hr/>
            </div>
    }
</div>
