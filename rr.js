//see my notes at end of this file!!!

module.exports = 
{
	resource_referencer: function()
	{
		this.internal_active_personas = this.internal_active_personas || {};
		
		this.close_resource = function(id)
		{
			delete this.internal_active_personas[id];
		};
		
		this.view_active_ids = function()
		{
			return Object.keys(this.internal_active_personas);
		};
		
		this.view_all_active = function()
		{
			return this.internal_active_personas;
		};
		
		this.internal_lookup_or_create_resource_by_id = function(id)
		{
			if (id == null)
			{
				this.internal_expensive_resource = "";
			}
			else if (Object.keys(this.internal_active_personas).includes(id))
			{
				this.internal_expensive_resource = this.internal_active_personas[id];
			}
			else
			{
				this.internal_active_personas[id] = 
					"I'm a very expensive resource associated with ID " + String(id);
				this.internal_expensive_resource = this.internal_active_personas[id];
			};
			return this.internal_expensive_resource;
		};
		this.get_resource = function(id)
		{
			id = id || null;
			this.internal_persona = {};
			this.internal_persona.persona_id = id;
			this.internal_persona.persona_resource = this.internal_lookup_or_create_resource_by_id(id);
			return this.internal_persona;
		};
	}
}

/*
 TASK SUCCESSFULLY EXECUTED, AND TESTED TO WORK AS DESIRED!!!
 
 I will be producing a video of this--information on accessing video can be found here: http://bit.ly/2AKHPtE
 
 what made this coding test particularly challenging is that a chunk of code 
 was provided without much context as to the specific business process or 
 technical objective this code is intended to support.  
 
 In the absence of such guidance (and I did ask...) I was left to use my 
 imagination as to a possible/plausible use cases for this code and then fill in 
 the gaps as I worked towards building functionality that supports the use case I 
 imagined.
 
 MY IMAGINED USE CASE: 
 
 >>> the "very expensive resource" relates to a relatively costly database query 
	for massive amounts of data records pertaining to a user. 
 
 >>> the different namespaces relate perhaps to different markets (where 
	very similar templates can apply to different cryptocurrency markets)
 
 >>> active references to these "very expensive resource" elements are held in some sort of easier/faster to access cache until they are closed
*/


