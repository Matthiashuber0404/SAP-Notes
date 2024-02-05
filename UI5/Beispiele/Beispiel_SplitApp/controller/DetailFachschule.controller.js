/*  eslint-disable no-console */
sap.ui.define([
	"sap/ui/core/mvc/Controller"
], function (Controller) {
	"use strict";

	return Controller.extend("ch05.chap05_splitapp.controller.DetailFachschule", {

		onInit: function () {
			// var oRouter = new sap.ui.core.UIComponent.getRouterFor(this);
			// oRouter.getRoute("route2").attachPatternMatched(this._onObjectMatched, this);
		},

		// _onObjectMatched: function (oEvent) {
		// 	this.getView().bindElement({
		// 		path: "/SCHOOL/" + oEvent.getParameter("arguments").detailPath
		// 	});
		// }

	});

});