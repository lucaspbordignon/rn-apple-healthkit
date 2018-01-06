'use strict'

let { AppleHealthKit } = require('react-native').NativeModules;

import { Activities } from './Constants/Activities'
import { Permissions } from './Constants/Permissions'
import { Units } from './Constants/Units'

let HealthKit = Object.assign({}, AppleHealthKit, {
	Constants: {
		Activities: Activities,
		Permissions: Permissions,
		Units: Units,
	}
});

export default HealthKit
module.exports = HealthKit;
