<cfscript>

	function strLimit(str, limit, ending="...")
	{
		if(len(str) <= limit)
		{
			return str;
		}
		return mid(str, 1, limit) & ending;
	}
	
	function isScriptFile(path)
	{
		return application.wirebox.getInstance( name="File@CFMLParser", 
												initArguments={path=path}).isScript();
	}
	
</cfscript>
