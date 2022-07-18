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
	
	<cffunction name="getPersonAndInfoByIDorName" access="public" returnType="query">
		<cfargument name="personID" type="guid" required="false" default="00000000-0000-0000-0000-000000000000">
		<cfargument name="searchName" type="string" required="false" default="">
		
		<cfquery name="qry" datasource="#ds#">
			SELECT p.personID AS pid, bi.heightInInches AS hInches, *
			FROM Person p
				LEFT JOIN BodyInfo bi ON bi.personID = p.PersonID
			WHERE 1 = 1
			
			<cfif arguments.PersonID NEQ '00000000-0000-0000-0000-000000000000'>
				AND p.personID = '#arguments.PersonID#'
			</cfif>
			
			<cfif len(arguments.searchName)>
				AND p.FirstName LIKE '%#arguments.searchName#%'
					OR p.LastName LIKE '%#arguments.searchName#%'
			</cfif>
			
			ORDER BY bi.Date Desc
		</cfquery>
	
		<cfreturn qry>
	</cffunction>

</cfcomponent>