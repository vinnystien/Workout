<cfscript>
	person = createObject("component" , "workoutCFC.person");
	mgrPBI = createObject("component" , "workoutCFC.mgrPersonBodyInfo");
	bodyInfo = createObject("component" , "workoutCFC.bodyInfo");
	
	param name = "personID" default = "";
	param name = "bodyWeightID" default = "";
	param name = "weight" default = ""; 
	param name = "dateTime" default = "";
	param name = "firstName" default = ""; 
	param name = "lastName" default = "";
	param name = "action" default = ""; 
	
	switch(action) 
	{
		/*case "add":
			view = 'form';
			action = "insert";
		break;
		
		case "edit":
			view ='form';
			action = 'update';
			personQuery = person.getPerson( '#personID#' );
			personID = personQuery.personID;
			firstName = personQuery.firstName;
			lastName = personQuery.lastName;
			email = personQuery.email;
		break;
     
		case "delete":
			bodyInfo.delete( '#personID#' );
			view = 'list';
		break;
     
		
     
		case "update":
			bodyInfo.update( '#personID#', '#weight#' ); 
			view = 'list';
		break;*/
		
		case "insert":
			bodyInfo.insert( personID, height, weight );
			view = 'list';
		break;
		
		default: 
			view = "list";
			action = "insert";
		break;
	}
	
	if( view == 'list' )
	{
		infoQry = mgrPBI.getPersonAndInfoByIDorName( personID='#personID#' );
		inches = int(numberFormat(infoQry.hInches));
		cfwriteAbort(infoQry);
	}

</cfscript>

<cfinclude template="header.cfm" >
<!---
<cf_writeAbort var="#infoQry#" >
<cfdump var="#bodyInfo.ConvertInchesToFeet(73)#" >--->


<cfswitch expression="#view#">
	<cfcase value="list">
		<cfoutput>
		<table border="1" style="width:500px;">
			<tr>
				<td>
					<cfform action="bodyInfo.cfm" method="post" disableButtons="true">
						<cfinput type="hidden" name="action" value="#action#"/>
						<cfinput type="hidden" name="personID" value="#infoQry.pID#"/>
						
						<a href="javascript:history.back()" style="text-decoration:none;"><< Back to list</a><br><br>
						
						Height:
						<cfinput
							type="text"
							name="height"
							id="height"
							label="Height"
							value="#inches#"
							style="width: 50px;"
							required="true"
							message="Please enter a first name."
						/>
						
						Weight:
						<cfinput
							type="text"
							name="weight"
							id="weight"
							label="Weight"
							value=""
							style="width: 50px;"
							required="true"
							message="Please enter a first name."
						/>
						
						&nbsp;&nbsp;&nbsp;
						<cfinput type="submit" name="submitButton" value="Submit" />
					</cfform>
				</td>
			
			</tr>
		</table>
		</cfoutput>
		
		<table border="1" style="width:500px;">
			<cfoutput query="infoQry" group="firstName">
				<tr>
					<td colspan="3">#infoQry.firstName# #infoQry.lastName#</td>
				</tr>
				<tr>
					<td>Height</td>
					<td>Weight</td>
					<td>Date</td>
				</tr>
				<cfoutput>
					<tr>
						<td>#inches# inches / #heightInFeet#</td>
						<td>#weight#</td>
						<td>#dateFormat(date, "short" )#</td>
					</tr>
				</cfoutput>
			</cfoutput>

		</table>
	</cfcase>
<!---
	<cfcase value="form">
		<cfoutput>
			<cfform action="index.cfm" method="post" disableButtons="true">
				<cfinput type="hidden" name="action" value="#action#"/>
				<cfinput type="hidden" name="personID" value="#personID#"/>
				
				<a href="javascript:history.back()" style="text-decoration:none;"><< Back</a><br>
				
				First Name:<br>
				<cfinput
					type="text"
					name="firstName"
					id="firstName"
					label="First name"
					value="#firstName#"
					style="width: 200px;"
					required="true"
					message="Please enter a first name."
				/>
				<br>
				
				Last Name:<br>
				<cfinput
					type="text"
					name="lastName"
					id="lastName"
					label="Last Name"
					value="#lastName#"
					style="width: 200px;"
					required="true"
					message="Please enter a last Name."
				/>
				<br>
				
				Email:<br>
				<cfinput
					type="text"
					name="email"
					id="email"
					label="Email"
					value="#email#"
					style="width: 200px;"
					required="true"
					message="Please enter an email."
				/>
				
				<br><br>
				<cfinput type="submit" name="submitButton" value="Submit & Close" />
				<cfinput type="button" name="cancelButton" value="Cancel" onclick="cancelOut()"/>
			</cfform>
		</cfoutput>
	</cfcase>--->
</cfswitch>

<cfinclude template="footer.cfm" >