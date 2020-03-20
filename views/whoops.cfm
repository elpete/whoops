<cfscript>
    if ( ! structKeyExists( variables, "strLimit" ) ) {
        variables.strLimit = function( str, limit, ending = "..." ) {
            if ( len( str ) <= limit ) {
                return str;
            }
            return mid( str, 1, limit ) & ending;
        };
    }


    function displayScope (scope) {
        var list = '<table class="data-table"><tbody>';
        for( var i in scope ){
            list &= '<tr>';
            list &= '<td>' & i & '</td>';
            if(isSimpleValue(scope[i])){
                list &= '<td>' & (scope[i]) & '</td>';
            } else if (isObject(scope[i])) {
                list &= '<td>' & writeDump( var = scope[i], format= "html", top=2, expand=false) & '</td>';
            } else {
                list &= '<td>' & writeDump( var = scope[i], format= "html", top=2, expand=false) & '</td>';
                //list &= '<td>' & serializeJSON(scope[i]) & '</td>';
            }
            list &= '</tr>';
        }
        list &= '</tbody></table>';
        return list;
    }

    function openInEditorURL( required event, required struct instance ) {
        var editor = event.getController().getUtil().getSystemSetting( "WHOOPS_EDITOR", "" );
        switch( editor ) {
            case "vscode":
                return "vscode://file/#instance.template#:#instance.line#"
            case "vscode-insiders":
                return "vscode-insiders://file/#instance.template#:#instance.line#"
            case "sublime":
                return "subl://open?url=file://#instance.template#&line=#instance.line#";
            case "textmate":
                return "txmt://open?url=file://#instance.template#&line=#instance.line#";
            case "emacs":
                return "emacs://open?url=file://#instance.template#&line=#instance.line#";
            case "macvim":
                return "mvim://open/?url=file://#instance.template#&line=#instance.line#";
            case "idea":
                return "idea://open?file=#instance.template#&line=#instance.line#";
            case "atom":
                return "atom://core/open/file?filename=#instance.template#&line=#instance.line#";
            case "espresso":
                return "x-espresso://open?filepath=#instance.template#&lines=#instance.line#";
            default:
                return "";
        }
    }
</cfscript>

<cfset local.e = oException.getExceptionStruct() />
<cfset stackFrames = arrayLen( local.e.TagContext ) />

<cfoutput>
    <html>
    <head>
        <title>Whoops! An error occurred.</title>
        <script type="text/javascript" src="#event.getModuleRoot( "whoops" )#/includes/js/syntaxhighlighter.js"></script>
        <script type="text/javascript" src="#event.getModuleRoot( "whoops" )#/includes/js/javascript-brush.js"></script>
        <script type="text/javascript" src="#event.getModuleRoot( "whoops" )#/includes/js/coldfusion-brush.js"></script>
        <link type="text/css" rel="stylesheet" href="#event.getModuleRoot( "whoops" )#/includes/css/syntaxhighlighter-theme.css">
        <link type="text/css" rel="stylesheet" href="#event.getModuleRoot( "whoops" )#/includes/css/whoops.css">
        <script type="text/javascript">
            SyntaxHighlighter.defaults['gutter'] = true;
            SyntaxHighlighter.defaults['smart-tabs'] = false;
            SyntaxHighlighter.defaults['tab-size'] =  4;
            SyntaxHighlighter.all();
        </script>
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
                            <!--- <cfdump var="#instance#"> --->
                            <li id="stack#stackFrames - i + 1#" class="stacktrace <cfif i EQ 1>stacktrace--active</cfif>">
                                <span class="badge">#stackFrames - i + 1#</span>
                                <div class="stacktrace__info">
                                    <h3 class="stacktrace__location">
                                        #replace( instance.template, root, "" )#:<span class="stacktrace__line-number">#instance.line#</span>
                                    </h3>
                                    <cfif structKeyExists( instance, "codePrintPlain" )>
                                        <cfset codesnippet = instance.codePrintPlain >
                                        <cfset codesnippet = rereplace(codesnippet,"\n\t"," ","All" )>
                                        <cfset codesnippet = HTMLEditFormat(  codesnippet)>
                                        <cfset codesnippet = rereplace(codesnippet,"([0-9]+:)","#chr(10)#\1","All")>
                                        <cfset splitLines  = listToArray(codesnippet,"#chr(10)#")>
                                        <h4 class="stacktrace__code" style="margin-top:-10px;">
                                            <cfloop array="#splitLines#" index="codeline">
                                                #strLimit( codeline, 40 )# <br>
                                            </cfloop>
                                        </h4>
                                    </cfif>
                                </div>
                                <cfif openInEditorURL( event, instance ) NEQ "">
                                    <a target="_self" rel="noreferrer noopener" href="#openInEditorURL( event, instance )#" class="editorLink__btn">
                                        Open
                                    </a>
                                </cfif>
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
                <div class="request-info data-table-container">
                    <h2 class="details-heading">Environment &amp; details:</h2>
                    <cfoutput>

                    <div class="data-table">
                        <label>RC</label>
                        #displayScope(rc)#
                    </div>
                    <div class="data-table">
                        <label>PRC</label>
                        #displayScope(prc)#
                    </div>
                    <div class="data-table">
                        <label>Headers</label>
                        #displayScope(getHttpRequestData().headers)#
                    </div>
                    <cftry>
                        <cfset thisSession = session />
                        <div class="data-table">
                            <label>Session</label>
                            #displayScope(thisSession)#
                        </div>
                        <cfcatch></cfcatch>
                    </cftry>
                    <div class="data-table">
                        <label>Application</label>
                        #displayScope(application)#
                    </div>
                    <div class="data-table">
                        <label>Cookies</label>
                        #displayScope(cookie)#
                    </div>
                    </cfoutput>
                </div>
            </div>
        </div>
        <cfloop from="1" to="#arrayLen( local.e.TagContext )#" index="i">
            <cfset instance = local.e.TagContext[ i ] />
            <cfset highlighter = "js" />
            <cfif ListLast(instance.template,".") eq "cfm"><cfset highlighter = "cf" /></cfif>
            <pre id="stack#stackFrames - i + 1#-code" data-highlight-line="#instance.line#" style="display: none;">
                <script type="syntaxhighlighter" class="brush: #highlighter#; highlight: [#instance.line#];">
                <![CDATA[<cfloop file="#instance.template#" index="line">
                #line#</cfloop>]]>
                </script>
            </pre>
        </cfloop>
        <script src="#event.getModuleRoot( "whoops" )#/includes/js/whoops.js"></script>
    </body>
    </html>
</cfoutput>
