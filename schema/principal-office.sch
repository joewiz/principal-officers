<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
    <pattern>
        <rule context="office/id">
            <let name="basename" value="replace(base-uri(.), '^.*/(.*?)$', '$1')"/>
            <assert test="$basename = concat(., '.xml')">The id “<value-of select="."/>” does not
                match filename “<value-of select="$basename"/>”</assert>
            <assert test="matches(., '^[a-z-]+\d*$')">The id “<value-of select="."/>” may contain
                only lower case letters, hyphens, and a trailing number</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="date[. ne ''][parent::*/preceding-sibling::*[1][date ne '']]">
            <assert test=". ge ./parent::*/preceding-sibling::*[date ne ''][1]/date">Date ordering
                problem. expected this date to come after the preceding date.</assert>
            <assert test="(. = '') or matches(., '^\d{4}$') or matches(., '^\d{4}-\d{2}$') or . castable as xs:date">Date should be yyyy-mm-dd, yyyy-mm, or empty</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="person-id">
            <assert test="matches(., '^[a-z-]+\d?$')">The person-id “<value-of select="."/>” should
                only contain lower-case letters and hyphens, with an optional digit as the last
                character</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="contemporary-office-id | mid-term-new-office-id[. ne ''] | predecessor | successor">
            <assert test="doc-available(concat('../data/principal-offices/current-offices/', ., '.xml')) or doc-available(concat('../data/principal-offices/discontinued-positions/', ., '.xml')) or doc-available(concat('../data/principal-offices/predecessor-offices/', ., '.xml'))">No matching office ID found for "<value-of select="."/>" in principal-offices
                folder</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="rank[. ne '']">
            <assert test="doc-available(concat('../data/ranks/', ., '.xml'))">No matching rank ID
                found for "<value-of select="."/>" in ranks folder</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="category[. ne '']">
            <assert test="doc('../data/code-tables/principal-office-category-codes.xml')//value = .">No matching category ID
                found for "<value-of select="."/>" in category code table</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="created-by | last-modified-by">
            <assert test="not(. = '') and not(matches(., '[A-Z]'))">Cannot be left empty; please enter your last name and initials, all lower-case (e.g., jeffersontj)</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="created-date | last-modified-date">
            <assert test=". castable as xs:date">Should be a valid date, yyyy-mm-dd</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="last-modified-date">
            <assert test="xs:date(.) ge xs:date(./preceding-sibling::created-date)">Last updated
                date should come after the created date</assert>
        </rule>
    </pattern>
</schema>