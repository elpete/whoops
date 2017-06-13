component {
    
    this.name = "whoops";
    this.author = "Eric Peterson";
    this.webUrl = "https://github.com/elpete/whoops";

    function configure() {
        settings = {
            targetEnvironments = [ "development" ]
        };

        binder.map( "File@CFMLParser" )
            .to( "#moduleMapping#.cfmlparser.File" );
    }

    function afterConfigurationLoad( event, interceptData, buffer ) {
        if ( isTargetEnvironment() ) {
            controller.setSetting(
                "customErrorTemplate",
                "#moduleMapping#/views/whoops.cfm"
            );
        }
    }

    private function isTargetEnvironment() {
        var currentEnvironment = controller.getSetting(
            name = "environment",
            defaultValue = ""
        );

        var targetEnvs = duplicate( settings.targetEnvironments );
        if ( ! isArray( targetEnvs ) ) {
            targetEnvs = listToArray( targetEnvs );
        }

        var found = false;
        for ( var env in targetEnvs ) {
            if ( compareNoCase( currentEnvironment, env ) == 0 ) {
                found = true;
            }
        }

        return found;
    }

}