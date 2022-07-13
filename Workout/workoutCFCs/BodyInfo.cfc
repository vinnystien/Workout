<cfcomponent>
	<cfscript>
		ds = 'Workout';
	</cfscript>
	
	<cffunction name="insert" access="public" returnType="void">
		<cfargument name="PersonID" type="guid" required="true" >
		<cfargument name="weight" type="numeric" required="true" >
	
		<cfquery name="insert" datasource="#ds#">
			INSERT INTO bodyInfo ( PersonId, BodyWeight )
			VALUES( <cfqueryparam value="#arguments.PersonID#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.weight#" cfsqltype="cf_sql_decimal"> )
		</cfquery>
	</cffunction>
	
	<cffunction name="delete" access="public" returnType="void">
		<cfargument name="BodyWeightID" type="guid" required="true" >
	
		<cfquery name="delete" datasource="#ds#">
			DELETE FROM bodyInfo 
			WHERE BodyWeightID = <cfqueryparam value="#arguments.BodyWeightID#" cfsqltype="cf_sql_varchar" > 
		</cfquery>
	</cffunction>
	
	<cffunction name="update" access="public" returnType="void">
		<cfargument name="BodyWeightID" type="guid" required="true" >
		<cfargument name="weight" type="numeric" required="true" >
	
		<cfquery name="updatePerson" datasource="#ds#">
			UPDATE bodyInfo
			SET BodyWeight = <cfqueryparam value="#arguments.weight#" cfsqltype="cf_sql_decimal">
			WHERE BodyWeightID = <cfqueryparam value="#arguments.BodyWeightID#" cfsqltype="cf_sql_varchar"> 
		</cfquery>
	</cffunction>
	
</cfcomponent>