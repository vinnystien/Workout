<cfcomponent>
	<cfscript>
		ds = 'Workout';
	</cfscript>
	
	<cffunction name="insert" access="public" returnType="void">
		<cfargument name="ID" type="guid" required="true" >
		<cfargument name="height" type="numeric" required="true" >
		<cfargument name="weight" type="numeric" required="true" >
		
		<cfset var fHeight = ConvertInchesToFeet(height)>
	
		<cfquery name="insert" datasource="#ds#">
			INSERT INTO bodyInfo ( PersonId, Weight, HeightInInches, HeightInFeet )
			VALUES( <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.weight#" cfsqltype="cf_sql_decimal">,
				<cfqueryparam value="#arguments.height#" cfsqltype="cf_sql_decimal">,
				<cfqueryparam value="#fHeight#" cfsqltype="cf_sql_varchar" > )
		</cfquery>
	</cffunction>
	
	<cffunction name="delete" access="public" returnType="void">
		<cfargument name="ID" type="guid" required="true" >
	
		<cfquery name="delete" datasource="#ds#">
			DELETE FROM bodyInfo 
			WHERE BodyWeightID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_varchar" > 
		</cfquery>
	</cffunction>
	
	<cffunction name="update" access="public" returnType="void">
		<cfargument name="ID" type="guid" required="true" >
		<cfargument name="weight" type="numeric" required="true" >
		<cfargument name="height" type="numeric" required="true" >
	
		<cfquery name="updatePerson" datasource="#ds#">
			UPDATE bodyInfo
			SET Weight = <cfqueryparam value="#arguments.weight#" cfsqltype="cf_sql_decimal">,
				heightInInches = <cfqueryparam value="#arguments.height#" cfsqltype="cf_sql_decimal">,
				heightInInches = <cfqueryparam value="#arguments.height#" cfsqltype="cf_sql_decimal">
			WHERE BodyWeightID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_varchar"> 
		</cfquery>
	</cffunction>
	
	<cffunction name="ConvertInchesToFeet" access="public" returnType="string">
		<cfargument name="height" type="numeric" required="true" >
		<cfscript>
			var num = arguments.height \ 12;
			var num1 = arguments.height mod 12;
			
			return "#num#'#num1#""";
		</cfscript>
	</cffunction>
	
</cfcomponent>