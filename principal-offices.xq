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

declare function local:get-predecessors($office-id as xs:string) {
    let $office := local:get-office($office-id)
    let $predecessor-id := $office/predecessors/predecessor
    return
        if ($predecessor-id) then
            (
                $predecessor-id/string(),
                local:get-predecessors($predecessor-id)
            )
        else
            ()
};

<div>{
    for $office in collection($local:current-offices-col)/office
    let $predecessors := local:get-predecessors($office/id)
    return
        <div>
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
                                    ({format-date($predecessor/valid-from, '[MNn] [D], [Y]') || '–' || format-date($predecessor/valid-until, '[MNn] [D], [Y]')})
                                    <ul>
                                        <li>{$predecessor/note/string()}</li>
                                    </ul>
                                </li>
                        else ()
                    }
                    <li><strong>{$office/name/string()}</strong> (since {format-date($office/valid-from, '[MNn] [D], [Y]')})
                        <ul>
                            <li>{$office/note/string()}</li>
                        </ul>
                    </li>
                </ol>
            </div>
            <div>
                <h3>Officers</h3>
                <ol>{
                    for $officer in $office/officers/officer
                    return
                        <li>{$officer/person-id/string()} {if ($officer/contemporary-office-id ne $office/id) then " (Appointed as " || $officer/contemporary-office-id || (if ($officer/mid-service-office-id-change) then ("; TITLE CHANGED to " || $officer/mid-service-office-id-change) else ()) || ")" else ()}</li>
                }</ol>
            </div>
            <div>
                <h3>Other Appointees</h3>
                <ol>{
                    for $officer in $office/other-appointees/officer
                    return
                        <li>{$officer/person-id/string()}</li>
                }</ol>
            </div>
        </div>
}</div>
