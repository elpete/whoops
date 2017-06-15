<cfscript>
    if ( ! structKeyExists( variables, "strLimit" ) ) {
        function strLimit( str, limit, ending = "..." ) {
            if ( len( str ) <= limit ) {
                return str;
            }
            return mid( str, 1, limit ) & ending;
        }
    }
    
    if ( ! structKeyExists( variables, "isScriptFile" ) ) {
        function isScriptFile( path ) {
            return application.wirebox.getInstance(
                name = "File@CFMLParser",
                initArguments = { path = path }
            ).isScript();
        }
    }
</cfscript>

<cfset local.e = oException.getExceptionStruct() />
<cfset stackFrames = arrayLen( local.e.TagContext ) />

<cfoutput>
    <html>
    <head>
        <title>Whoops! An error occurred.</title>
        <link href="https://fonts.googleapis.com/css?family=Fira+Mono|Lato" rel="stylesheet">
        <script type="text/javascript" src="#event.getModuleRoot( "whoops" )#/includes/js/syntaxhighlighter.js"></script>
        <link type="text/css" rel="stylesheet" href="#event.getModuleRoot( "whoops" )#/includes/css/syntaxhighlighter-theme.css">
        <link type="text/css" rel="stylesheet" href="#event.getModuleRoot( "whoops" )#/includes/css/whoops.css">
    </head>
    <body>
        <div class="whoops">
            <div class="whoops__nav">
                <div class="exception">
                    <h1 class="exception__title">#local.e.type#</h1>
                    <h2 class="exception__message">#local.e.message#</h2>
                </div>
                <div class="whoops_stacktrace_panel_info">
                    Stack Frame(s): #stackFrames#
                </div>
                <div class="whoops__stacktrace_panel">
                    <ul class="stacktrace__list">
                        <cfset root = expandPath( "/" ) />
                        <cfloop from="1" to="#arrayLen( local.e.TagContext )#" index="i">
                            <cfset instance = local.e.TagContext[ i ] />
                            <li id="stack#stackFrames - i + 1#" class="stacktrace <cfif i EQ 1>stacktrace--active</cfif>">
                                <span class="badge">#stackFrames - i + 1#</span>
                                <div class="stacktrace__info">
                                    <h3 class="stacktrace__location">
                                        #replace( instance.template, root, "" )#:<span class="stacktrace__line-number">#instance.line#</span>
                                    </h3>
                                    <cfif structKeyExists( instance, "codePrintPlain" )>
                                        <h4 class="stacktrace__code">
                                            #HTMLEditFormat( strLimit( instance.codePrintPlain, 70 ) )#
                                        </h4>
                                    </cfif>
                                </div>
                            </li>
                        </cfloop>
                    </ul>
                </div>
            </div>
            <div class="whoops__detail">
                <div class="code-preview">
                    <cfset instance = local.e.TagContext[ 1 ] />
                    <div id="code-container"></div>
                </div>
                <div class="request-info">
                    <h1>Request Details</h1>
                    <div>
                        <h2>rc</h2>
                        <cfdump var="#rc#" top="2" expand="false" />
                    </div>
                    <div>
                        <h2>prc</h2>
                        <cfdump var="#prc#" top="2" expand="false" />
                    </div>
                    <div>
                        <h2>Headers</h2>
                        <cfdump var="#getHttpRequestData().headers#" top="2" expand="false" />
                    </div>
                    <cftry>
                        <cfset thisSession = session />
                        <div>
                            <h2>session</h2>
                                <cfdump var="#thisSession#" top="2" expand="false" />
                        </div>
                        <cfcatch></cfcatch>
                    </cftry>
                    <div>
                        <h2>application</h2>
                        <cfdump var="#application#" top="2" expand="false" />
                    </div>
                    <div>
                        <h2>cookies</h2>
                        <cfdump var="#cookie#" top="2" expand="false" />
                    </div>
                </div>
            </div>
        </div>
        <cfloop from="1" to="#arrayLen( local.e.TagContext )#" index="i">
            <cfset instance = local.e.TagContext[ i ] />
            <cfset highlighter = isScriptFile( instance.template ) ? "js" : "cf" />
            <div id="stack#stackFrames - i + 1#-code" data-highlight-line="#instance.line#" style="display: none;">
                <script type="text/syntaxhighlighter" class="brush: #highlighter#; highlight: [#instance.line#]"><![CDATA[#lTrim( fileRead( instance.template ) )#]]></script>
            </div>
        </cfloop>
        <script src="#event.getModuleRoot( "whoops" )#/includes/js/whoops.js"></script>
    </body>
    </html>
</cfoutput>