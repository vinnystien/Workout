<cfcomponent>
	<cfscript>
		ds = 'Workout';
	</cfscript>
	
	<cffunction name="getAllPeopleAndInfo" access="public" returnType="query">
		
		<cfquery name="qry" datasource="#ds#">
			SELECT p.personID as pid, *
			FROM Person p
				LEFT JOIN BodyInfo bi ON bi.personID = p.PersonID
					AND bi.Date = ( SELECT TOP 1 bi2.Date
									FROM BodyInfo bi2 
									WHERE bi2.personID =  bi.personID
									ORDER BY bi2.Date
								) 
			ORDER BY p.FirstName, p.LastName
		</cfquery>
	
		<cfreturn qry>
	</cffunction>
	
	<cffunction name="getPersonAndInfoByID" access="public" returnType="query">
		<cfargument name="personID" type="guid" required="true" >
		
		<cfquery name="qry" datasource="#ds#">
			SELECT p.personID as pid, *
			FROM Person p
				LEFT JOIN BodyInfo bi ON bi.personID = p.PersonID
					AND bi.Date = ( SELECT TOP 1 bi2.Date
									FROM BodyInfo bi2 
									WHERE bi2.personID =  bi.personID
									ORDER BY bi2.Date
								)
			WHERE pid = <cfqueryparam value="#arguments.PersonID#" cfsqltype="cf_sql_varchar" >
			ORDER BY p.FirstName, p.LastName
		</cfquery>
	
		<cfreturn qry>
	</cffunction>
	
	<cffunction name="searchPeopleAndInfoByName" access="public" returnType="query">
		<cfargument name="searchName" type="string" required="true" >
		
		<cfquery name="qry" datasource="#ds#">
			SELECT p.personID as pid, *
			FROM Person p
				LEFT JOIN BodyInfo bi ON bi.personID = p.PersonID
					AND bi.Date = ( SELECT TOP 1 bi2.Date
									FROM BodyInfo bi2 
									WHERE bi2.personID =  bi.personID
									ORDER BY bi2.Date
								)
			WHERE p.FirstName LIKE '%#searchName#%'
				OR p.LastName LIKE '%#searchName#%'
			ORDER BY p.FirstName, p.LastName
		</cfquery>
	
		<cfreturn qry>
	</cffunction>

</cfcomponent>