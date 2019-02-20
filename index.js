'use strict'

let { AppleHealthKit } = require('react-native').NativeModules;

import { Permissions } from './Constants/Permissions'
import { Units } from './Constants/Units'
import moment from 'moment';

const PERMISSION_TO_RETRIEVAL_FUNCTION_MAP = {
	StepCount: (options) => ({
		retrievalFn: AppleHealthKit.getDailyStepCountSamples,
		params: {
			startDate: options.startDate,
			endDate: options.endDate,
		}
	}),
	FlightsClimbed: (options) => ({
		retrievalFn: AppleHealthKit.getDailyFlightsClimbedSamples,
		params: {
			startDate: options.startDate,
			endDate: options.endDate,
		}
	}),
	DistanceWalkingRunning: (options) => ({
		retrievalFn: AppleHealthKit.getDailyDistanceWalkingRunningSamples,
		params: {
			unit: 'mile',
			startDate: options.startDate,
			endDate: options.endDate,
		}
	}),


}

const promisify = (method, opts, name) => {
	return new Promise((res, rej) => {
		method(opts, (err, result) => {
			if (err) {
				return rej(err);
			}
			return res({ name, result });
		});
	});
}

let HealthKit = Object.assign({}, AppleHealthKit, {
	Constants: {
		Permissions: Permissions,
		Units: Units,
	},
	getDataForPermissions: async (permissions, startDate, endDate) => {
		const hkOptions = { permissions: { read: permissions } };
		await new Promise((resolve, reject) => AppleHealthKit.initHealthKit(hkOptions, (err, results) => {
			if (err) {
				console.log("error initializing Healthkit: ", err);
				return reject(err);
			}
			return resolve(results);
		}));

		const permissionsMap = permissions.reduce((arr, permission) => {
			if (PERMISSION_TO_RETRIEVAL_FUNCTION_MAP[permission])
				arr.push(permission);
			return arr;
		}, []);

		const result = {};

		for (const idx in permissionsMap) {
			const options = {
				startDate: startDate.toISOString(),
				endDate: endDate.toISOString(),
			};

			const permission = permissionsMap[idx];
			const retrievalResult = PERMISSION_TO_RETRIEVAL_FUNCTION_MAP[permission](options);

			result[permission] = 
				await promisify(
					retrievalResult.retrievalFn,
					retrievalResult.params
				).then(({ result }) => result).catch(console.log);
		}
		return result;
	},
});

export default HealthKit
module.exports = HealthKit;
