Save a distance walking/running sample.

A quantity sample type that measures the distance the user has moved by walking or running during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the movement occured.

`saveDistanceWalkingRunning` accepts an options object containing required *`unit: ['meter', 'inch', 'foot', 'yard', 'mile']`*, *`value: number`*, *`startDate: ISO8601Timestamp`*, and *`endDate: ISO8601Timestamp`*.

if *`unit`* is not provided, the default *`mile`* will be used.

```javascript
// startDate and endDate are 60 minutes apart.
// this means the movement occurred within those 60 minutes.
let options = {
  unit: "meter",
  value: 3000,
  startDate: (new Date(2016,6,2,6,0,0)).toISOString(),
  endDate: (new Date(2016,6,2,7,0,0)).toISOString()
};
```

```javascript
AppleHealthKit.saveDistanceWalkingRunning(options, (err, res) => {
  if (err) {
    return;
  }
  // walking/running distance sample successfully saved.
});
```