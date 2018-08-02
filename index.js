"use strict";

let { AppleHealthKit } = require("react-native").NativeModules;

import { Permissions } from "./Constants/Permissions";
import { Units } from "./Constants/Units";

let HealthKit = AppleHealthKit;

HealthKit.Constants = {
  Permissions,
  Units,
};

export default HealthKit;
module.exports = HealthKit;
