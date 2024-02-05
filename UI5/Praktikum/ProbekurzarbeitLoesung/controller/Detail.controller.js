sap.ui.define([
	"sap/ui/core/mvc/Controller", "sap/m/MessageBox", "sap/ui/model/Filter", "sap/ui/model/FilterOperator"
], function (Controller, MessageBox, Filter, FilterOperator) {
	"use strict";

	return Controller.extend("routing.template.controller.Detail", {

		onInit: function () {
			const oRouter = this.getOwnerComponent().getRouter()
			oRouter.getRoute("DetailRoute").attachPatternMatched(this._onObjectMatched, this);
		},
		_onObjectMatched: function (oEvent) {
			var sId = oEvent.getParameter("arguments").detailPath;
			var aFilter = [];
			if (sId) {
				aFilter.push(new Filter("Ort", FilterOperator.EQ, sId));
			}
			let oObject = this.byId("idEventsTable");
			let oBinding = oObject.getBinding("items");
			oBinding.filter(aFilter);
			
			// let oOrte = this.getView().getModel("event").getData().Orte;
			// let oOrt = oOrte.find(e => e.Oid == oId);
			// console.log(oOrt)

			// this.byId("idVeranstaltungText").setText("Veranstalter " + oId + ":" + oOrt.Ortbez);
			this.byId("idVeranstalterInput").setValue(sId)
		},
		onEventsTableItemPress: function (oEvent) {
			let oObject = oEvent.getParameters().listItem
			let oEntry = oObject.getBindingContext("event").getObject();
			console.log(oEntry)
			let oOrte = this.getView().getModel("event").getData().Orte;
			let oOrt = oOrte.find(e => e.Oid == oEntry.Ort);

			let oPreise = this.getView().getModel("event").getData().Preise;
			let oPreis = oPreise.find(e => e.kat == oEntry.Preiskategorie)

			// MessageBox.success("Sie haben die Veranstaltung '" + oEntry.Bezeichnung + "' gewählt. " +
			//                    "\nDatum: " + oEntry.Datum + 
			// 				   "\nUhrzeit:  " + oEntry.Zeit + " Uhr" +
			// 				   "\nVeranstaltungsort: " + oOrt.Ortbez +
			// 				   "\nPreis: " + oPreis.preis +" Euro" )

			MessageBox.success(`Sie haben die Veranstaltung "${oEntry.Bezeichnung}" gewählt. 
			                   Datum: ${oEntry.Datum} 
							   Uhrzeit:  ${oEntry.Zeit} Uhr 
							   Veranstaltungsort: ${oOrt.Ortbez} 
							   Preis: ${oPreis.preis} Euro` )
		},
		onSucheButtonPress: function(){
			let sId = this.byId("idVeranstalterInput").getValue()
			let sBez = this.byId("idBezeichnungInput").getValue()
			let sZeit = this.byId("idUhrzeitInput").getValue()
			
			var aFilter = [];
			if (sId) {
				aFilter.push(new Filter("Ort", FilterOperator.EQ, sId));
			}
			if (sBez) {
				aFilter.push(new Filter("Bezeichnung", FilterOperator.Contains, sBez));
			}
			if (sZeit) {
				aFilter.push(new Filter("Zeit", FilterOperator.EQ, sZeit));
			}

			let oObject = this.byId("idEventsTable");
			let oBinding = oObject.getBinding("items");
			oBinding.filter(aFilter);
		},
		onFilterLschenButtonPress: function(){
			this.byId("idVeranstalterInput").setValue("")
			this.byId("idBezeichnungInput").setValue("")
			this.byId("idUhrzeitInput").setValue("")
			this.onSucheButtonPress()
		}


	});

});