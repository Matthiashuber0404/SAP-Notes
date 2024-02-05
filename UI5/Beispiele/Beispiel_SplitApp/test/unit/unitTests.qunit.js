/* global QUnit */
QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function () {
	"use strict";

	sap.ui.require([
		"ch05/chap05_splitapp/test/unit/AllTests"
	], function () {
		QUnit.start();
	});
});