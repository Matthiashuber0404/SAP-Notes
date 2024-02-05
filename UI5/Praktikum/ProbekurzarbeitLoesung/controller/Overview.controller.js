/* eslint-disable no-console */
sap.ui.define([
	"sap/ui/core/mvc/Controller", "sap/m/MessageBox", "sap/m/MessageToast"
], function (Controller, MessageBox, MessageToast) {
	"use strict";

	return Controller.extend("routing.template.controller.Overview", {

		onInit: function () {
			MessageToast.show("gestartet");
		},
		onGenericTilePress: function(oEvent){
			let oOrt = oEvent.getSource().getBindingContext("event").getObject()
			const oRouter = this.getOwnerComponent().getRouter()			
			oRouter.navTo("DetailRoute", { detailPath: oOrt.Oid });
		},
		onInfoButtonPress: function(){
			let anzahl = this.getView().getModel("event").getData().Events.length
			MessageBox.information("Aktuell haben wir "+ anzahl + " Events im Angebot!")
		}

	});

});