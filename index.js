'use strict';

let { AppleHealthKit } = require('react-native').NativeModules;

import { Permissions } from './Constants/Permissions';
import { Units } from './Constants/Units';
import { NutritionIntakes } from './Constants/NutritionIntakes';

let HealthKit = Object.assign({}, AppleHealthKit, {
  Constants: {
    NutritionIntakes,
    Permissions: Permissions,
    Units: Units
  }
});

export default HealthKit;
module.exports = HealthKit;
