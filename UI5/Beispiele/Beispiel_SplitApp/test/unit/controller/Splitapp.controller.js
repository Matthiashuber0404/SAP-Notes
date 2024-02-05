/*global QUnit*/

sap.ui.define([
	"ch05/chap05_splitapp/controller/Splitapp.controller"
], function (Controller) {
	"use strict";

	QUnit.module("Splitapp Controller");

	QUnit.test("I should test the Splitapp controller", function (assert) {
		var oAppController = new Controller();
		oAppController.onInit();
		assert.ok(oAppController);
	});

});