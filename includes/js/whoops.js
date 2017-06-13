Element.prototype.documentOffsetTop = function () {
    return this.offsetTop + ( this.offsetParent ? this.offsetParent.documentOffsetTop() : 0 );
};

function scrollToLine( line ) {
    var selectedLine = codeContainer.querySelector( ".line.number" + line );
    var top = selectedLine.documentOffsetTop() - codeWrapper.offsetHeight / 2;
    codeWrapper.scrollTop = top;
}

function toggleActiveClasses( id ) {
    document.querySelector( ".stacktrace--active" ).classList.remove( "stacktrace--active" );
    document.getElementById( id ).classList.add( "stacktrace--active" );
}

function changeCodePanel( id ) {
    toggleActiveClasses( id );
    var code = document.getElementById( id + "-code" );
    var highlightLine = code.getAttribute( "data-highlight-line" );
    codeContainer.innerHTML = code.innerHTML;
    scrollToLine( highlightLine );
}

var codeWrapper = document.querySelector( ".code-preview" );
var codeContainer = document.getElementById( "code-container" );

// remove weird spaces.
Array.from( document.querySelectorAll( ".line.number1 code.spaces" ) )
    .forEach( function( node ) {
        node.remove();
    } );

Array.from( document.querySelectorAll( ".stacktrace" ) )
    .forEach( function( stackTrace ) {
        stackTrace.addEventListener( "click", function( e ) {
            changeCodePanel( stackTrace.id );
        }, false );
    } );

document.addEventListener( "DOMContentLoaded", function() {
    var initialStackTrace = document.querySelector( ".stacktrace__list .stacktrace" );
    changeCodePanel( initialStackTrace.id );
} );