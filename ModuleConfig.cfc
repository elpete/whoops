component {
    
    this.name = "whoops";
    this.author = "Eric Peterson";
    this.webUrl = "https://github.com/elpete/whoops";

    function configure() {
        
    }

    function afterConfigurationLoad( event, interceptData, buffer ) {
        controller.setSetting(
            "customErrorTemplate",
            "#moduleMapping#/views/whoops.cfm"
        );
    }

}