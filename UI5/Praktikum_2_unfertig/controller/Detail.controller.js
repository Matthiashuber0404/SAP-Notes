sap.ui.define([
	"sap/ui/core/mvc/Controller", "sap/m/MessageBox", "sap/ui/model/Filter", "sap/ui/model/FilterOperator"
], function (Controller, MessageBox, Filter, FilterOperator) {
	"use strict";

	return Controller.extend("routing.template.controller.Detail", {
		formatPreis: function(sValue){
			return (parseFloat(sValue).toFixed(2))
		},
		onInit: function () {

		},
		onListItem: function (oEvent) {
			let obj = oEvent.getSource().getSelectedItem();
			// Möglichkeit 1
			let oEntry = obj.getBindingContext("food").getObject();
			console.log(oEntry.bezeichnung);
			// Möglichkeit 2
			let speise = obj.getProperty("title").split(", ");
			console.log(speise[0] + " " + speise[1])
		}


	});

});