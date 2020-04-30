Save a Active Energy Burned sample.

A quantity sample type that measures the amount of active energy the user has burned during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the energy was burned.

`saveActiveEnergyBurned` accepts an options object containing required *`value: number`*, *`startDate: ISO8601Timestamp`*, and *`endDate: ISO8601Timestamp`*.
```javascript
// startDate and endDate are 30 minutes apart.
// this means the energy burn value occurred within those 30 minutes.
let options = {
  value: 100,
  startDate: (new Date(2016,6,2,6,0,0)).toISOString(),
  endDate: (new Date(2016,6,2,6,30,0)).toISOString()
};
```

```javascript
AppleHealthKit.saveActiveEnergyBurned(options, (err, res) => {
  if (err) {
    return;
  }
  // Active Energy Burned sample successfully saved.
});
```