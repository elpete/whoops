component extends="coldbox.system.testing.BaseTestCase" {

    function beforeAll() {
        super.beforeAll();
        
        getController().getModuleService()
            .registerAndActivateModule( "whoops", "testingModuleRoot" );
    }

    /**
    * @beforeEach
    */
    function setupIntegrationTest() {
        setup();
    }

}
