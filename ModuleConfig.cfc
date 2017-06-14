component {
    
    this.name = "whoops";
    this.author = "Eric Peterson";
    this.webUrl = "https://github.com/elpete/whoops";

    function configure() {
        binder.map( "File@CFMLParser" )
            .to( "#moduleMapping#.cfmlparser.File" );
    }

    function afterConfigurationLoad( event, interceptData, buffer ) {
        controller.setSetting(
            "customErrorTemplate",
            "#moduleMapping#/views/whoops.cfm"
        );
    }

}