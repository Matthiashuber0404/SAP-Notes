/* eslint-disable no-console, radix */
sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/core/UIComponent"
], function (Controller, UIComponent) {
	"use strict";

	return Controller.extend("ch05.chap05_splitapp.controller.Master", {

		onInit: function () {
			this._onView1();
		},

		_onView1: function () {
			var oRouter = UIComponent.getRouterFor(this);
			oRouter.navTo("routeStart");
		},
		_onView2: function (number) {
			var oRouter = UIComponent.getRouterFor(this);
			oRouter.navTo("route2", {
				detailPath: number
			});
		},

		onListSelectionChange: function (oEvent) {
			var oList = oEvent.getSource().getSelectedItem();
			var Path = oList.getId();

			console.log("ich bin hier: " + Path);

			var oRouter = UIComponent.getRouterFor(this);
			oRouter.navTo("routeFS", false);
		}
	});

});