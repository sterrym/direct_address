CountrySelect = Class.create({
	initialize : function(args){
		this.country_select = $(args['country_select_id']);
		this.region_select = $(args['region_select_id']);
		this.country_select.observe('change', this.update_regions.bind(this));
	},
	update_regions : function(event){
		this.region_select.selectedIndex = -1;
		var country_id = this.selected_country()[0];
		new Ajax.Request('/regions.json?country_id=' + country_id, {method : 'get', onComplete : function(transport){
			var regions = transport.responseJSON;
			this.populate_regions(regions);
		}.bind(this)});
	},
	selected_country : function(){
		var elem = this.country_select.childElements()[this.country_select.selectedIndex];
		return [elem.value, elem.innerHTML]
	},
	populate_regions : function(regions){
		var html = ['<option value="">Select a Region</option>', regions.collect(function(region){ 
			return '<option value="' + region.id + '">' + region.name + '</option>';
		})].flatten().join('');
		this.region_select.update(html);
		if(regions.length == 0)
			this.region_select.hide();
		else
			this.region_select.show();
	}
});