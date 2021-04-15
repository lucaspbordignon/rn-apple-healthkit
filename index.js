'use strict'

let { AppleHealthKit } = require('react-native').NativeModules;

import { Permissions } from './Constants/Permissions'
import { Units } from './Constants/Units'
import { Activities } from './Constants/Activities'

let HealthKit = Object.assign({}, AppleHealthKit, {
	Constants: {
		Permissions: Permissions,
		Units: Units,
		Activities: Activities,
	}
});

export default HealthKit
module.exports = HealthKit;
