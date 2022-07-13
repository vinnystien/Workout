<cfcomponent>
	<cfscript>
		ds = 'Workout';
	</cfscript>
	
	<cffunction name="insertPerson" access="public" returnType="void">
		<cfargument name="form" type="struct" required="true" >
	
		<cfquery name="insert" datasource="#ds#">
			INSERT INTO Person ( FirstName, LastName, email )
			VALUES( <cfqueryparam value="#arguments.form.FirstName#" cfsqltype="cf_sql_varchar">, 
				<cfqueryparam value="#arguments.form.LastName#" cfsqltype="cf_sql_varchar">, 
				<cfqueryparam value="#arguments.form.email#" cfsqltype="cf_sql_varchar">  )
		</cfquery>
	</cffunction>
	
	<cffunction name="deletePerson" access="public" returnType="void">
		<cfargument name="personID" type="guid" required="true" >
	
		<cfquery name="delete" datasource="#ds#">
			DELETE FROM Person 
			WHERE PersonID = <cfqueryparam value="#arguments.PersonID#" cfsqltype="cf_sql_varchar" > 
		</cfquery>
	</cffunction>
	
	<cffunction name="updatePerson" access="public" returnType="void">
		<cfargument name="form" type="struct" required="true" >
	
		<cfquery name="updatePerson" datasource="#ds#">
			UPDATE Person
			SET firstName = <cfqueryparam value="#arguments.form.firstName#" cfsqltype="cf_sql_varchar">,
				lastName = <cfqueryparam value="#arguments.form.lastName#" cfsqltype="cf_sql_varchar">, 
				email = <cfqueryparam value="#arguments.form.email#" cfsqltype="cf_sql_varchar"> 
			WHERE PersonID = <cfqueryparam value="#arguments.form.PersonID#" cfsqltype="cf_sql_varchar"> 
		</cfquery>
	</cffunction>
	
	<cffunction name="getPersonByID" access="public" returnType="query">
		<cfargument name="PersonID" type="guid" required="true" >
	
		<cfquery name="getPerson" datasource="#ds#">
			SELECT *
			FROM Person
			WHERE PersonID = <cfqueryparam value="#arguments.PersonID#" cfsqltype="cf_sql_varchar" > 
		</cfquery>
	
		<cfreturn getPerson>
	</cffunction>
	
	<cffunction name="getAllPeople" access="public" returnType="query">
	
		<cfquery name="getAll" datasource="#ds#">
			SELECT *
			FROM Person 
			ORDER BY FirstName
		</cfquery>
		
		<cfreturn getAll>
	</cffunction>

</cfcomponent>