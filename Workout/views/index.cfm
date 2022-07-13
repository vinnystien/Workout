<cfscript>
	person = createObject("component" , "WorkoutCFC.person");
	mgrPBI = createObject("component" , "WorkoutCFC.mgrPersonBodyInfo");
	
	param name = "pid" default = "";
	param name = "firstName" default = ""; 
	param name = "lastName" default = ""; 
	param name = "email" default = ""; 
	param name = "action" default = ""; 
	
	switch(action) 
	{
		case "add":
			view = 'form';
			action = "insert";
		break;
		
		case "edit":
			view ='form';
			action = 'update';
			personQuery = person.getPersonByID( '#pid#' );
			pid = personQuery.personID;
			firstName = personQuery.firstName;
			lastName = personQuery.lastName;
			email = personQuery.email;
		break;
     
		case "delete":
			person.deletePerson( '#pid#' );
			view = 'list';
		break;
     
		case "insert":
			person.insertPerson( '#form#' );
			view = 'list';
		break;
     
		case "update":
			person.updatePerson( '#form#' );
			view = 'list';
		break;
		
		default: 
			view = "list";
		break;
	}

	if( view == 'list' )
	{
		allPeopleInfo = mgrPBI.getAllPeopleAndInfo();
		counter = 1;
	}
</cfscript>

<cfinclude template="header.cfm" >

<cfswitch expression="#view#">
	<cfcase value="list">
		<table style="width:600px; border:medium;" border="5">
			<tr>
				<th style="border:#c0c0c0">
					<div style="float:left; padding:6px;">Search People:</div>
					<div style="float:right; padding:2px;">
						<input type="text" name="searchName" id="searchName" value="">
					</div>
				</th>
				<th style="text-align:right;">
					<a href="index.cfm?action=add" style="text-decoration:none">Create Person >></a>
				</th>
			</tr>
			
			<tbody id="personTable">
				<cfoutput query="allPeopleInfo">
					<tr style="border-color:##ffff; border-width:thick;">
						<td style="border-color:##ffff;">
							<strong>#firstName# #lastName#</strong>
							<div class="personInfo" id="personInfo#counter#">
								<span class="spanBold">Email:</span> #email#<br>
								<table>
									<tr>
										<td>Height</td>
										<td>Weight</td>
									</tr>
									<tr>
										<td><cfif len(heightInches)>#heightInches# / #heightFeet#<cfelse>No Measurement</cfif></td>
										<td><cfif len(weight)>#weight#<cfelse>No Measurement</cfif></td>
									</tr>
								</table>
							</div>
						</td>
						<td style="vertical-align:top; text-align:right;">
							<span class="showHide spanStyle" id="#counter#">More</span> | 
							<a href="index.cfm?action=edit&pid=#pid#">Edit</a> |
							<a href="index.cfm?action=delete&pid=#pid#" onclick="return confirm('Are you sure you want to delete this Person?');">Delete</a> | 
							<a href="bodyInfo.cfm?personID=#pid#">Body Info</a>
						</td>
					</tr>
					<cfset counter++>
				</cfoutput>
			</tbody>
		</table>
	</cfcase>

	<cfcase value="form">
		<cfoutput>
			<cfform action="index.cfm" method="post" disableButtons="true">
				<cfinput type="hidden" name="action" value="#action#"/>
				<cfinput type="hidden" name="personID" value="#pid#"/>
				
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
	</cfcase>
</cfswitch>

<script>
	$(document).ready(function(){
		
		$('#searchName').on('keyup', function() {
			var value = $(this).val().toLowerCase();
			
			$('#personTable tr').filter(function() {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
			});
		});
		
		$('.personInfo').hide();
		
    	$('.showHide').on('click', function () {
    		peepsInfo = $(this).attr('id');
    		$('#personInfo' + peepsInfo).toggle();
    		$(this).text($(this).text() == 'Less' ? 'More' : 'Less');
    	});
	});

	function cancelOut()
	{
		if( confirm("Are you sure that you want to cancel?") )
		{
			window.location = "http://localhost:8500/Apps/Workout/Views/index.cfm";
		}
	}
</script>

<cfinclude template="footer.cfm" >
