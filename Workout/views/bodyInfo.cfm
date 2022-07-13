<cfscript>
	person = createObject("component" , "WorkoutCFC.Person");
	mgrPBI = createObject("component" , "WorkoutCFC.MgrPersonBodyInfo");
	
	param name = "bodyWeightID" default = "";
	param name = "personID" default = "";
	param name = "weight" default = ""; 
	param name = "dateTime" default = "";
	param name = "firstName" default = ""; 
	param name = "lastName" default = "";
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
     
		case "insert":
			bodyInfo.insert( '#personID#', '#weight#' );
			view = 'list';
		break;
     
		case "update":
			bodyInfo.update( '#personID#', '#weight#' );
			view = 'list';
		break;
		
		default: 
			view = "list";
		break;
	}

	if( view == 'list' )
	{
		allPeople = person.getAllPeople();
		counter = 1;
	}
</cfscript>

<cfinclude template="header.cfm" >

<cfswitch expression="#view#">
	<cfcase value="list">
		<table style="width:500px; border:medium;" border="5">
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
				<cfoutput query="allPeople">
					<tr style="border-color:##ffff; border-width:thick;">
						<td style="border-color:##ffff;">
							<strong>#firstName# #lastName#</strong>
							<div class="personInfo" id="personInfo#counter#">
								<span class="spanBold">First Name:</span> #firstName#<br>
								<span class="spanBold">Last Name:</span> #lastName#<br>
								<span class="spanBold">Email:</span> #email#
							</div>
						</td>
						<td style="vertical-align:top; text-align:right;">
							<span class="showHide spanStyle" id="#counter#">more</span> | 
							<a href="index.cfm?action=edit&personID=#personID#">edit</a> |
							<a href="index.cfm?action=delete&personID=#personID#" onclick="return confirm('Are you sure you want to delete this Person?');">delete</a>
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
    		eInfo = $(this).attr('id');
    		$('#personInfo' + eInfo).toggle();
    		$(this).text($(this).text() == 'less' ? 'more' : 'less');
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
